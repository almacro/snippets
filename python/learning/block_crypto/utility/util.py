import binascii

def flatten(l):
    """Flatten a list of lists into a one-dimensional list.

    Also could use `itertools.chain(*its)` instead."""
    return [x for y in l for x in y]


def to_ascii(bintext):
    return binascii.hexlify(bintext).decode('ascii')


def ascii_key(key):
    return to_ascii(key.exportKey(format='DER'))


def to_binary(asciitext):
    return binascii.unhexlify(asciitext)
