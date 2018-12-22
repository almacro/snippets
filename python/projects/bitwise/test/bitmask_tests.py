from nose.tools import *
from bitwise import bitmask

def test_NOT_noarg():
    bm = bitmask.BitMask()
    b = bin(bm.NOT() & 0xF)
    assert_equals(b, '0b1111')

def test_AND_smallmask():
    bm = bitmask.BitMask(0b10101100)
    b = bin(bm & 0xF)
    assert_equals(b, '0b1100')

def test_AND_bigmask():
    bm = bitmask.BitMask(0b10101100)
    b = bin(bm & 0xFF)
    assert_equals(b, '0b10101100')

def test_AND_twoBitmaps():
    bm1 = bitmask.BitMask()
    bm2 = bitmask.BitMask(0b10101100)
    b = bin( bm1.AND(bm2) )
    assert_equals(b, '0b0')

def test_OR_bms():
    bm1 = bitmask.BitMask()
    bm2 = bitmask.BitMask(0b10101100)
    b = bin( bm1.OR(bm2) )
    assert_equals(b, '0b10101100')

def test_OR_literal():
    bm = bitmask.BitMask()
    b = bin( bm.OR(0b110) )
    assert_equals(b, '0b110')

def test_XOR():
    bm1 = bitmask.BitMask( 0b110 )
    bm2 = bitmask.BitMask( 0b10101100 )
    b = bin( bm1.XOR(bm2) )
    assert_equals(b, '0b10101010')

def test_shiftleft():
    bm = bitmask.BitMask( 0b110 )
    b = bin( bm.shiftleft(3) )
    assert_equals(b, '0b110000')

def test_shiftright():
    bm = bitmask.BitMask( 0b110000 )
    b = bin( bm.shiftright(3) )
    assert_equals(b, '0b110')

def test_listbits():
    bm = bitmask.BitMask(0b11110000)
    assert_equals( bm.listbits(), [1,1,1,1,0,0,0])
    assert_equals( bm.listbits(2,5), [1,1,0])
    assert_equals( bm.listbits(2,-2), [1,1,0,0])
