"""
This module contains helper functions for generating cryptographic hashes.
"""

import hashlib
import json

def hash_string_256(string):
    """Generates a SHA-256 hash digest of the input"""
    return hashlib.sha256(string).hexdigest()


def hash_block(block):
    """Combine the block elements into a single hash value.

    For now this just concatenates the block values into a string."""
    hashable_block = block.__dict__.copy()
    hashable_block['transactions'] = [tx.to_ordered_dict() for tx in block.transactions]
    return hash_string_256(json.dumps(hashable_block, sort_keys=True).encode())
