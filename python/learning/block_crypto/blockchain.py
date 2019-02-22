import functools
import hashlib
import json
import pickle

from utility.hash_util import hash_block
from utility.util import flatten
from utility.verification import Verification as verifier

from block import Block
from transaction import Transaction
from wallet import Wallet

# The reward given to miners (for creating a new block)
MINING_REWARD = 10

class Blockchain():
    def __init__(self, host_node_id):
        # The starting block for the blockchain
        genesis_block = Block(0, '', [], 100, 0)
        # Initialize the blockchain list
        self.__chain = [genesis_block]
        # Unhandled transactions
        self.__open_transactions = []
        self.__host_node = host_node_id
        self.load_data()


    def get_chain(self):
        return self.__chain[:]


    def get_open_transactions(self):
        return self.__open_transactions[:]


    # load as json
    def load_data(self):
        try:
            with open('blockchain.txt', mode='r') as f:
                data = f.readlines()
                self.__chain = json.loads(data[0][:-1])
                updated_blockchain = []
                for block in self.__chain:
                    block_txns = [Transaction(tx['sender'], tx['recipient'], tx['signature'], tx['amount'])
                                  for tx in block['transactions']]
                    updated_block = Block(block['index'], block['previous_hash'], block_txns, block['proof'], block['timestamp'])
                    updated_blockchain.append(updated_block)

                self.__chain = updated_blockchain
                self.__open_transactions = json.loads(data[1])
                self.__open_transactions = [Transaction(tx['sender'], tx['recipient'], tx['signature'], tx['amount'])
                                              for tx in self.__open_transactions]
        except (IOError, IndexError):
            pass


    # save as json
    def save_data(self):
        try:
            with open('blockchain.txt', mode='w') as f:
                saveable_chain = [block.__dict__ for block in [Block(block_el.index, block_el.previous_hash, [tx.__dict__ for tx in block_el.transactions], block_el.proof, block_el.timestamp) for block_el in self.__chain]]
                f.write(json.dumps(saveable_chain))
                f.write('\n')
                saveable_otxns = [tx.__dict__ for tx in self.__open_transactions]
                f.write(json.dumps(saveable_otxns))
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


    def get_balance(self, participant):
        """Calculate and return the balance for a participant.

        Arguments:
            :participant: The person for whom to calculate the balance
        """
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


    def add_transaction(self, recipient, sender, signature, amount=1.0):
        """Append a new value as well as the last blockchain value
        to the blockchain.

        Arguments:
            :sender: The sender of the coins
            :recipient: The recipient of the coins
            :amount: The amount of coins sent with the transaction (default = 1.0)
        """
        if self.__host_node == None:
            return False

        transaction = Transaction(sender, recipient, signature, amount)
        if verifier.verify_transaction(transaction, self.get_balance):
            self.__open_transactions.append(transaction)
            self.save_data()
            return True
        return False


    def mine_block(self):
        """Mine the outstanding, pending transactions and commit them to a new block.

        Add the mining reward as a new pending transaction.
        """
        if self.__host_node == None:
            return False

        last_block = self.__chain[-1]
        hashed_block = hash_block(last_block)
        proof = self.proof_of_work()
        reward_transaction = Transaction('MINING', self.__host_node, '', MINING_REWARD)
        copied_transactions = self.__open_transactions[:]
        for tx in copied_transactions:
            if not Wallet.verify_transaction(tx):
                return False
        copied_transactions.append(reward_transaction)
        block = Block(len(self.__chain), hashed_block, copied_transactions, proof)
        self.__chain.append(block)
        self.__open_transactions = []
        self.save_data()
        return True
