from nose.tools import *
from bitwise import bits, bitmask

def test_bits():
    b = bin(bits.AND(0b1010,0b1100))
    assert_equals(b, '0b1000')

    b = bin( bits.OR(0b1010,0b1100))
    assert_equals(b, '0b1110')

    b = bin( bits.NOT(0b1010) )
    assert_equals(b, '-0b1011')

    b = bin( bits.NOT(0b1010) & 0xFF )
    assert_equals(b, '0b11110101')

    b = bin( bits.NOT(0b1010) & 0xF )
    assert_equals(b, '0b101')

def test_bitmask():
    bm = bitmask.BitMask(0b1100)
    b = bin(bm)
    assert_equals(b, '0b1100')

    b = bin(bm.AND(0b1110))
    assert_equals(b, '0b1100')

    b = bin(bm.OR(0b1110))
    assert_equals(b, '0b1110')

    assert_equals(bm.listbits(), [1,1,0])
