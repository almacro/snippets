
def flatten(l):
    """Flatten a list of lists into a one-dimensional list.

    Also could use `itertools.chain(*its)` instead."""
    return [x for y in l for x in y]