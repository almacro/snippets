'''Class that implements simple cli for bits'''

import argparse
import os
import re
import sys
import logging

from bitwise import bits
from bitwise import __version__

__CMD_DICT__ = {
    'not'       : 'return NOT (complement) of input bits',
    'and'       : 'return result of ANDing two bit inputs together',
    'or'        : 'return result of ORing two bit inputs together',
    'xor'       : 'return result of XORing two bit inputs together',
    'shiftleft' : 'shift the input bits to the left by NUM bits',
    'shiftright': 'shift the input bits to the right by NUM bits',
    'bit'       : 'return true if bit at INDEX is set to VAL, False otherwise',
    'setbit'    : 'set bit at INDEX to VAL',
    'zerobit'   : 'turn off bit at INDEX (set to 0)',
    'listbits'  : 'display all bit values of input as a list'
}

class BitsCLI(object):
    def __init__(self):
        pass

    def cmd_not(self,args):
        logging.debug("I will run NOT")
        logging.info("bitstring = %s" % args.bitstring)
        bitstring = int(args.bitstring, base=2)
        res = bits.NOT(bitstring) & 0xFFFF
        print( bin(res) )

    def cmd_and(self,args):
        logging.debug("I will run AND")
        logging.info("bitstring_1 = %s, bitstring_2 = %s" % (args.bitstring_1,args.bitstring_2))
        bitstring_1 = int (args.bitstring_1, base=2)
        bitstring_2 = int (args.bitstring_2, base=2)
        res = bits.AND(bitstring_1, bitstring_2) & 0xFFFF
        print( bin(res) )

    def cmd_or(self,args):
        logging.debug("I will run OR")
        logging.info("bitstring_1 = %s, bitstring_2 = %s" % (args.bitstring_1,args.bitstring_2))
        bitstring_1 = int (args.bitstring_1, base=2)
        bitstring_2 = int (args.bitstring_2, base=2)
        res = bits.OR(bitstring_1, bitstring_2) & 0xFFFF
        print( bin(res) )

    def cmd_xor(self,args):
        logging.debug("I will run XOR")
        logging.info("bitstring_1 = %s, bitstring_2 = %s" % (args.bitstring_1,args.bitstring_2))
        bitstring_1 = int (args.bitstring_1, base=2)
        bitstring_2 = int (args.bitstring_2, base=2)
        res = bits.XOR(bitstring_1, bitstring_2) & 0xFFFF
        print( bin(res) )

    def cmd_shiftleft(self,args):
        logging.debug("I will run SHIFTLEFT")
        logging.info("bitstring = %s, num = %s" % (args.bitstring,args.num))
        bitstring = int(args.bitstring, base=2)
        num = int(args.num)
        res = bits.shiftleft(bitstring, num)
        print(bin(res))
        
    def cmd_shiftright(self,args):
        logging.debug("I will run SHIFTRIGHT")
        logging.info("bitstring = %s, num = %s" % (args.bitstring,args.num))
        bitstring = int(args.bitstring, base=2)
        num = int(args.num)
        res = bits.shiftright(bitstring, num)
        print(bin(res))

    def cmd_bit(self,args):
        logging.debug("I will run BIT")
        logging.info("bitstring = %s, index = %s" % (args.bitstring,args.num))
        bitstring = int(args.bitstring, base=2)
        num = int(args.num)
        res = bits.bit(bitstring, num)
        print(bin(res))

    def cmd_setbit(self,args):
        logging.debug("I will run SETBIT")
        logging.info("bitstring = %s, index = %s" % (args.bitstring,args.num))
        bitstring = int(args.bitstring, base=2)
        num = int(args.num)
        res = bits.setbit(bitstring, num)
        print(bin(res))

    def cmd_zerobit(self,args):
        logging.debug("I will run ZEROBIT")
        logging.info("bitstring = %s, index = %s" % (args.bitstring,args.num))
        bitstring = int(args.bitstring, base=2)
        num = int(args.num)
        res = bits.zerobit(bitstring, num)
        print(bin(res))

    def cmd_listbits(self,args):
        logging.debug("I will run LISTBITS")
        logging.info("bitstring = %s" % args.bitstring)
        bitstring = int(args.bitstring, base=2)
        res = bits.listbits(bitstring)
        print(res)

class IsBinaryAction(argparse.Action):
    """Check to make sure argument is a binary string"""
    def __call__(self, parser, namespace, values, option_string=None):
        def is_binary_string(s):
            ret = re.match('\A[01]+\Z', s) is not None
            return ret

        if type(values) is list:
            for v in values:
                if not is_binary_string(v):
                    parser.error("%s contains value which is not binary: %s" % (values, v))
        else:
            if not is_binary_string(values):
                    parser.error("%s is not binary" % values)
        setattr(namespace, self.dest, values)

def get_parser():
    parser = argparse.ArgumentParser(description="argument parser for bits")

    parser.add_argument('--verbose', '-v', action='count')
    parser.add_argument('--version', action='version', version=__version__.version)

    subparsers = parser.add_subparsers(title='commands',
                                       description='bits commands',
                                       dest='command',
                                       help='additional help')

    parser_not = subparsers.add_parser('not',
                                       description='bits complement',
                                       usage='not <bitstring>')
    parser_not.add_argument('bitstring',
                            action=IsBinaryAction,
                            help='the bitstring arg')

    # TODO AND arbitrary number of bitstrings
    parser_and = subparsers.add_parser('and',
                                       description='bitwise AND',
                                       usage='and <bitstring-1> <bitstring-2>') 
    parser_and.add_argument('bitstring_1',
                            action=IsBinaryAction,
                            help='the 1st bitstring arg')
    parser_and.add_argument('bitstring_2',
                            action=IsBinaryAction,
                            help='the 2nd bitstring arg')

    parser_or = subparsers.add_parser('or',
                                       description='bitwise OR',
                                       usage='or <bitstring-1> <bitstring-2>') 
    parser_or.add_argument('bitstring_1',
                            action=IsBinaryAction,
                            help='the 1st bitstring arg')
    parser_or.add_argument('bitstring_2',
                            action=IsBinaryAction,
                            help='the 2nd bitstring arg')

    parser_xor = subparsers.add_parser('xor',
                                       description='bitwise XOR',
                                       usage='xor <bitstring-1> <bitstring-2>') 
    parser_xor.add_argument('bitstring_1',
                            action=IsBinaryAction,
                            help='the 1st bitstring arg')
    parser_xor.add_argument('bitstring_2',
                            action=IsBinaryAction,
                            help='the 2nd bitstring arg')

    parser_shiftleft = subparsers.add_parser('shiftleft',
                                       description='shift bits in bitstring left by NUM bits',
                                       usage='shiftleft <bitstring> <num>') 
    parser_shiftleft.add_argument('bitstring',
                            action=IsBinaryAction,
                            help='the bitstring arg')
    parser_shiftleft.add_argument('num',
                            action='store',
                            type=int,
                            help='the count of bits to shift by')

    parser_shiftright = subparsers.add_parser('shiftright',
                                       description='shift bits in bitstring right by NUM bits',
                                       usage='shiftright <bitstring> <num>') 
    parser_shiftright.add_argument('bitstring',
                            action=IsBinaryAction,
                            help='the bitstring arg')
    parser_shiftright.add_argument('num',
                                   action='store',
                                   type=int,
                                   help='the count of bits to shift by')

    parser_bit = subparsers.add_parser('bit',
                                       description='return True if bit NUM in bitstring is set, False otherwise',
                                       usage='bit <bitstring> <num>') 
    parser_bit.add_argument('bitstring',
                            action=IsBinaryAction,
                            help='the bitstring arg')
    parser_bit.add_argument('num',
                            action='store',
                            type=int,
                            help='the count of bits to shift by')
    
    parser_setbit = subparsers.add_parser('setbit',
                                       description='set bit NUM in bitstring to 1',
                                       usage='setbit <bitstring> <num>') 
    parser_setbit.add_argument('bitstring',
                               action=IsBinaryAction,
                               help='the bitstring arg')
    parser_setbit.add_argument('num',
                               action='store',
                               type=int,
                               help='the count of bits to shift by')
    
    parser_zerobit = subparsers.add_parser('zerobit',
                                       description='set bit NUM in bitstring to 1',
                                       usage='zerobit <bitstring> <num>') 
    parser_zerobit.add_argument('bitstring',
                               action=IsBinaryAction,
                               help='the bitstring arg')
    parser_zerobit.add_argument('num',
                               action='store',
                                type=int,
                               help='the count of bits to shift by')
    
    parser_listbits = subparsers.add_parser('listbits',
                                       description='get ordered list of bits',
                                       usage='listbits <bitstring>')
    parser_listbits.add_argument('bitstring',
                            action=IsBinaryAction,
                            help='the bitstring arg')

    return parser

def setup_logger(verbose=None):
    if verbose is None or verbose == 0:
        loglevel = logging.ERROR
    elif verbose == 1:
        loglevel = logging.WARNING
    elif verbose == 2:
        loglevel = logging.INFO
    elif verbose == 3:
        loglevel = logging.DEBUG

    logging.basicConfig(format='%(levelname)s:%(message)s', level=loglevel)
    global logger
    logger = logging.getLogger()
    logger.debug("loglevel is %s" % loglevel)

def main(argv=None, usage=None):
    if argv is None:
        argv = sys.argv

    parser = get_parser()
    command = argv[0]
    args = parser.parse_args(argv[1:])
    setup_logger(args.verbose)
    logger.info('verbosity = %s' % args.verbose)
    logger.debug('got args => %s' % args)
        
    if args.command is None:
        parser.error('no command given')

    if 'version' in vars(args):
        parser.exit(args.version)

    logger.debug("you selected to run command: %s" % args.command)
    cli = BitsCLI()
    bits_commands = {
        'not'       : cli.cmd_not,
        'and'       : cli.cmd_and,
        'or'        : cli.cmd_or,
        'xor'       : cli.cmd_xor,
        'shiftleft' : cli.cmd_shiftleft,
        'shiftright': cli.cmd_shiftright,
        'bit'       : cli.cmd_bit,
        'setbit'    : cli.cmd_setbit,
        'zerobit'   : cli.cmd_zerobit,
        'listbits'  : cli.cmd_listbits
    }
    bits_commands[args.command](args)
    return 0

if __name__ == '__main__':
    sys.exit(main())
