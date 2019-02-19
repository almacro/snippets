#from blockchain import Blockchain
from hash_util import hash_block, hash_string_256

class Verification:
    @staticmethod
    def valid_proof(transactions, last_hash, proof):
        """Checks whether proof is valid according to some criteria."""
        guess = (str([tx.to_ordered_dict() for tx in transactions]) + str(last_hash) + str(proof)).encode()
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
            if not cls.valid_proof(block.transactions[:-1], block.previous_hash,  block.proof):
                print('Proof of work is invalid')
                return False
        return True
    
    @staticmethod
    def verify_transaction(transaction, get_balance):
        """Verify sender has sufficient balance to allow transaction to be processed"""
        sender_balance = get_balance(transaction.sender)
        return sender_balance >= transaction.amount    
    
    @classmethod
    def verify_transactions(cls, open_transactions, get_balance):
        """Verify pending transactions can be committed to blockchain"""
        return all([cls.verify_transaction(tx, get_balance) for tx in open_transactions])
