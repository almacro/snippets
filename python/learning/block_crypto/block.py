"""
This module defines the Block type used to store blocks in the blockchain.
"""

from time import time
from utility.printable import Printable

class Block(Printable):
    """
    This class stores a list of transactions and proof of work as a
    blockchain block.
    """

    def __init__(self, index, previous_hash, transactions, proof, time=time()):
        self.index = index
        self.previous_hash = previous_hash
        self.timestamp = time
        self.transactions = transactions
        self.proof = proof
