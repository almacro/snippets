"""
This module defines a class with verification methods to verify
blockchain and transaction integrity.

"""

from utility.hash_util import hash_block, hash_string_256
from wallet import Wallet

class Verification:
    """
    This class contains methods to verify transactions and blocks in the blockchain.
    """

    @staticmethod
    def valid_proof(transactions, last_hash, proof):
        """Checks whether proof is valid according to some criteria."""
        guess = (str([tx.to_ordered_dict() for tx in transactions]) +
                 str(last_hash) +
                 str(proof)).encode()
        guess_hash = hash_string_256(guess)
        return guess_hash[0:2] == '00'

    @classmethod
    def verify_chain(cls, blockchain):
        """Verify the current blockchain and return True if it's valid, False otherwise
        """
        for (index, block) in enumerate(blockchain):
            if index == 0:
                continue
            if block.previous_hash != hash_block(blockchain[index - 1]):
                return False
            if not cls.valid_proof(block.transactions[:-1], block.previous_hash, block.proof):
                print('Proof of work is invalid')
                return False
        return True

    @staticmethod
    def verify_transaction(transaction, get_balance, check_funds=True):
        """Verify sender has sufficient balance to allow transaction to be processed"""
        if check_funds:
            sender_balance = get_balance(transaction.sender)
            if sender_balance < transaction.amount:
                print('Transaction amount {} exceeds balance {}'.format(transaction.amount,
                                                                        sender_balance))
                print('Insufficient balance!')
                return False
        if not Wallet.verify_transaction(transaction):
            print('Bad signature => %s' % transaction.signature)
            print('Signature verification failed!')
            return False
        return True

    @classmethod
    def verify_transactions(cls, open_transactions, get_balance):
        """Verify pending transactions can be committed to blockchain"""
        return all([cls.verify_transaction(tx, get_balance, check_funds=False)
                    for tx in open_transactions])
