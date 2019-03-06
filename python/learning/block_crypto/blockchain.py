import functools
import hashlib
import json
import pickle
import requests

from utility.hash_util import hash_block
from utility.util import flatten
from utility.verification import Verification as verifier

from block import Block
from transaction import Transaction
from wallet import Wallet

# The reward given to miners (for creating a new block)
MINING_REWARD = 10

class Blockchain():
    def __init__(self, public_key, node_id):
        # The starting block for the blockchain
        genesis_block = Block(0, '', [], 100, 0)
        # Initialize the blockchain list
        self.__chain = [genesis_block]
        # Unhandled transactions
        self.__open_transactions = []
        self.__public_key = public_key
        self.__node_id = node_id
        self.__peer_nodes = set()
        self.resolve_conflicts = False
        self.load_data()

    @property
    def chain(self):
        return self.__chain[:]

    def get_open_transactions(self):
        return self.__open_transactions[:]

    # load as json
    def load_data(self):
        try:
            with open('blockchain-{}.txt'.format(self.__node_id), mode='r') as f:
                data = f.readlines()
                self.__chain = json.loads(data[0][:-1])
                updated_blockchain = []
                for block in self.__chain:
                    block_txns = [Transaction(tx['sender'], tx['recipient'], tx['signature'], tx['amount'])
                                  for tx in block['transactions']]
                    updated_block = Block(block['index'], block['previous_hash'], block_txns, block['proof'], block['timestamp'])
                    updated_blockchain.append(updated_block)

                self.__chain = updated_blockchain
                self.__open_transactions = json.loads(data[1][:-1])
                self.__open_transactions = [Transaction(tx['sender'], tx['recipient'], tx['signature'], tx['amount'])
                                              for tx in self.__open_transactions]
                peer_nodes = json.loads(data[2])
                self.__peer_nodes = set(peer_nodes)
        except (IOError, IndexError):
            pass


    # save as json
    def save_data(self):
        try:
            with open('blockchain-{}.txt'.format(self.__node_id), mode='w') as f:
                saveable_chain = [block.__dict__ for block in [Block(block_el.index, block_el.previous_hash, [tx.__dict__ for tx in block_el.transactions], block_el.proof, block_el.timestamp) for block_el in self.__chain]]
                f.write(json.dumps(saveable_chain))
                f.write('\n')
                saveable_otxns = [tx.__dict__ for tx in self.__open_transactions]
                f.write(json.dumps(saveable_otxns))
                f.write('\n')
                f.write(json.dumps(list(self.__peer_nodes)))
        except IOError:
            print('Saving blockchain failed!')


    def proof_of_work(self):
        """Generate a proof of work to commit a new block to the blockchain."""
        last_block = self.__chain[-1]
        last_hash = hash_block(last_block)
        proof = 0
        while not verifier.valid_proof(self.__open_transactions, last_hash, proof):
            proof += 1
        return proof


    def get_balance(self, participant=None):
        """Calculate and return the balance for a participant.

        Arguments:
            :participant: The person for whom to calculate the balance
        """
        if participant == None:
            if self.public_key == None:
                return None
            else:
                participant = self.public_key

        tx_sender = [[tx.amount for tx
                      in block.transactions
                      if tx.sender == participant] for block in self.__chain]
        open_tx_sender = [tx.amount for tx
                          in self.__open_transactions
                          if tx.sender == participant]
        tx_sender.append(open_tx_sender)
        amount_sent = functools.reduce(lambda tx_sum, tx_amt: tx_sum + tx_amt, flatten(tx_sender), 0)

        tx_recipient = [[tx.amount for tx
                        in block.transactions
                        if tx.recipient == participant] for block in self.__chain]
        amount_received = functools.reduce(lambda tx_sum, tx_amt: tx_sum + tx_amt, flatten(tx_recipient), 0)

        return amount_received - amount_sent


    def get_last_blockchain_value(self):
        """Returns the last value of the current blockchain.
        """
        if not self.__chain:
            return None
        return self.__chain[-1]


    def add_transaction(self, recipient, sender, signature, amount=1.0, is_receiving=False):
        """Append a new value as well as the last blockchain value
        to the blockchain.

        Arguments:
            :sender: The sender of the coins
            :recipient: The recipient of the coins
            :amount: The amount of coins sent with the transaction (default = 1.0)
        """
        if self.__public_key == None:
            return False

        transaction = Transaction(sender, recipient, signature, amount)
        if verifier.verify_transaction(transaction, self.get_balance):
            self.__open_transactions.append(transaction)
            self.save_data()
            if not is_receiving:
                for node in self.__peer_nodes:
                    url = 'http://{}/broadcast-transaction'.format(node)
                    try:
                        response = requests.post(url, json={
                            'sender': sender,
                            'recipient': recipient,
                            'amount': amount,
                            'signature': signature
                        })
                        if response.status_code == 400 or response.status_code == 500:
                            print('Transaction declined, needs resolving')
                            return False
                    except requests.exceptions.ConnectionError:
                        continue
            return True
        return False


    def mine_block(self):
        """Mine the outstanding, pending transactions and commit them to a new block.

        Add the mining reward as a new pending transaction.
        """
        if self.__public_key == None:
            return None

        last_block = self.__chain[-1]
        hashed_block = hash_block(last_block)
        proof = self.proof_of_work()
        reward_transaction = Transaction('MINING', self.__public_key, '', MINING_REWARD)
        copied_transactions = self.__open_transactions[:]
        for tx in copied_transactions:
            if not Wallet.verify_transaction(tx):
                return None
        copied_transactions.append(reward_transaction)
        block = Block(len(self.__chain), hashed_block, copied_transactions, proof)
        self.__chain.append(block)
        self.__open_transactions = []
        self.save_data()
        for node in self.__peer_nodes:
            url = 'http://{}/broadcast-block'.format(node)
            converted_block = block.__dict__.copy()
            converted_block['transactions'] = [tx.__dict__ for tx in block.transactions]
            try:
                response = requests.post(url, json={
                    'block': converted_block
                })
                if response.status_code == 400 or response.status_code == 500:
                    print('Block declined, needs resolving')
                if response.status_code == 409:
                    self.resolve_conflicts = True
            except requests.exceptions.ConnectionError:
                continue
        return block


    def add_block(self, block):
        transactions = [Transaction(tx['sender'], tx['recipient'], tx['signature'], tx['amount']) for tx in block['transactions']]
        proof_is_valid = verifier.valid_proof(transactions[:-1], block['previous_hash'], block['proof'])
        hashes_match = hash_block(self.chain[-1]) == block['previous_hash']
        if not proof_is_valid or not hashes_match:
            return False
        converted_block = Block(block['index'], block['previous_hash'], transactions, block['proof'], block['timestamp'])
        self.__chain.append(converted_block)
        stored_transactions = self.__open_transactions[:]
        for itx in block['transactions']:
            for opentx in stored_transactions:
                if opentx.sender == itx['sender'] and opentx.recipient == itx['recipient'] and opentx.amount == itx['amount'] and opentx.signature == itx['signature']:
                    try:
                        self.__open_transactions.remove(opentx)
                    except ValueError:
                        print("Item was already removed")
        self.save_data()
        return True

    def resolve(self):
        winner_chain = self.chain
        replace = False
        for node in self.__peer_nodes:
            url = 'http://{}/chain'.format(node)
            try:
                response = requests.get(url)
                node_chain = response.json()
                node_chain = [Block(block['index'],
                                    block['previous_hash'],
                                    [Transaction(tx['sender'], tx['recipient'], tx['signature'], tx['amount'])
                                        for tx in block['transactions']],
                                    block['proof'],
                                    block['timestamp'])
                                for block in node_chain]
                node_chain_length = len(node_chain)
                local_chain_length = len(winner_chain)
                if node_chain_length > local_chain_length and verifier.verify_chain(node_chain):
                    winner_chain = node_chain
                    replace = True
            except requests.exceptions.ConnectionError:
                continue
        self.resolve_conflicts = False
        self.__chain = winner_chain
        if replace:
            self.__open_transactions = []
        self.save_data()
        return replace


    def add_peer_node(self, node):
        """Adds a new node to the peer node set

        Arguments:
            :node: The node URL which should be added.
        """
        self.__peer_nodes.add(node)
        self.save_data()

    def remove_peer_node(self, node):
        """Removes a node from the peer node set

        Arguments:
            :node: The node URL which should be removed.
        """
        self.__peer_nodes.discard(node)
        self.save_data()

    def get_peer_nodes(self):
        """Return a list of all connected nodes"""
        return list(self.__peer_nodes)
