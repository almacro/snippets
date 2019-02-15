import hashlib
import json

def hash_string_256(string):
    return hashlib.sha256(string).hexdigest()

def hash_block(block):
    """Combine the block elements into a single hash value.

    For now this just concatenates the block values into a string."""
    return hash_string_256(json.dumps(block, sort_keys=True).encode()) 
