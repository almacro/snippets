"""
This module contains miscellaneous low-level utilities and helper functions.
"""

import binascii

def flatten(_list):
    """Flattens a list of lists into a one-dimensional list.

    Also could use `itertools.chain(*its)` instead."""
    return [x for y in _list for x in y]


def to_ascii(bintext):
    """Converts binary string to ASCII format."""
    return binascii.hexlify(bintext).decode('ascii')


def ascii_key(key):
    """Converts DER encoded key string to ASCII format."""
    return to_ascii(key.exportKey(format='DER'))


def to_binary(asciitext):
    """Converts ASCII format string to binary format."""
    return binascii.unhexlify(asciitext)
