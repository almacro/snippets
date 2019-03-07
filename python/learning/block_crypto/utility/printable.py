"""This module contains a base class that defines behavior for printable objects"""

class Printable:
    """The Printable class defines a common __repr__ method for its derived types"""
    def __repr__(self):
        return str(self.__dict__)
