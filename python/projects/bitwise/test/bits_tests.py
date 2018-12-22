from nose.tools import *
from bitwise import bits

def test_NOT_int():
    i = bits.NOT(0b0101)
    assert_equals(i, -6)

def test_NOT_bin():
    b = bin(bits.NOT(0b0101))
    assert_equals(b, '-0b110')

def test_NOT_binmask():
    b = bin(bits.NOT(0b0101) & 0xF)
    assert_equals(b, '0b1010')

def test_AND_binmask_1():
    b = bin(bits.AND(0b0101, 0b0011) & 0xF)
    assert_equals(b, '0b1')

def test_AND_binmask_2():
    b = bin(bits.AND(0b0101, 0b0100) & 0xF)
    assert_equals(b, '0b100')

def test_OR_binmask_1():
    b = bin(bits.OR(0b0101, 0b0100) & 0xF)
    assert_equals(b, '0b101')

def test_OR_binmask_2():
    b = bin(bits.OR(0b0101, 0b0011) & 0xF)
    assert_equals(b, '0b111')

def test_XOR_binmask_1():
    b = bin(bits.XOR(0b0101, 0b11) & 0xF)
    assert_equals(b, '0b110')

def test_XOR_binmask_2():
    b = bin(bits.XOR(0b0101, 0b0101) & 0xF)
    assert_equals(b, '0b0')

def test_shiftleft_by1():
    b = bin(bits.shiftleft(0b10, 1))
    assert_equals(b, '0b100')

def test_shiftleft_by4():
    b = bin(bits.shiftleft(0b10, 4))
    assert_equals(b,  '0b100000')

def test_shiftright_by2():
    b = bin(bits.shiftright (0b1000,2))
    assert_equals(b, '0b10')

def test_shiftright_by6():
    b = bin(bits.shiftright (0b10000,6))
    assert_equals(b, '0b0')

def test_bit_true():
    is_set = bits.bit(0b0101,0)
    assert_true(is_set)

def test_bit_false():
    is_set = bits.bit(0b0101,1)
    assert_false(is_set)

def test_setbit():
    to_set = bin(bits.setbit(0b1000, 1))
    assert_equals(to_set, '0b1010')

def test_zerobit():
    to_zero = bin(bits.zerobit(0b1010, 1))
    assert_equal(to_zero, '0b1000')

def test_listbits():
    bit_list = bits.listbits(0b10111)
    assert_equal(bit_list, [1,0,1,1,1])
