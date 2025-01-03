#!/usr/bin/env python3
'''
exp_backoff_runner.py

Run a command with exponential backoff

author(s): almacro
date: 2025-01-02
'''

import sys
import re

import argparse
import logging

import shlex
import subprocess
from time import sleep

VERSION = '0.1'

wait = [ 15,  30,  45,  60,  75,  90,  105, 120, 135, 150, 165, 180,
         195, 210, 225, 240, 255, 270, 285, 300, 315, 330, 345, 360,
         375, 390, 405, 420, 435, 450, 465, 480, 495, 510, 525, 540,
         555, 570, 585, 600, 615, 630, 645, 660, 675, 690, 705, 720,
         735, 750, 765, 780, 795, 810, 825, 840, 855, 870, 885, 900 ]

def get_parser():
    parser = argparse.ArgumentParser(description='argument parser for exponential backoff runner')

    parser.add_argument('--verbose', '-v', action='count', default=0,
                        help='increase output verbosity')
    
    parser.add_argument('--version', '-V', action='version', version=VERSION)

    parser.add_argument('command', help='command to run with exponential backoff')
    
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
    logger.debug(f'loglevel is {loglevel}')
    
        
def run_with_backoff(command, limit=len(wait)):

    for i in range(limit):
        try:
            run = 'running' if i == 0 else 'retrying'
            logger.debug(f'{run} command: {command}')
            
            process = subprocess.Popen(shlex.split(command), stderr=subprocess.STDOUT, stdout=subprocess.PIPE)
            out, err = process.communicate()
            out = out.decode('utf-8') if out is not None else ''
            r = process.returncode

            if re.search('goaway', out) is None:
                if r == 0:
                    logger.info('command successful')
                else:
                    logger.info('command failed')
                    
                logger.debug(f'exit status: {r}')
                logger.debug(f'command output:\n{out}')
                break
            else:
                w = wait[i]
                logger.info(f'command failed due to rate-limit, sleeping for {w} seconds')
                logger.debug(f'command output:\n{out}')
                sleep(w)
            
        except OSError as e:
            logger.info(repr(traceback.format_exception(e)))
            logger.debug(repr(traceback.format_tb(e)))

    logger.debug(f'tried command {i+1} times')
    if i+1 == limit:
        logger.info(f'command did not succeed after maximum of {limit} iterations')


def main(argv=None, usage=None):
    if argv is None:
        argv = sys.argv

    parser = get_parser()

    args = parser.parse_args(argv[1:])
    setup_logger(args.verbose)

    logger.info(f'verbosity = {args.verbose}')
    logger.debug(f'got args => {args}')

    if 'version' in vars(args):
        parser.exit(args.version)

    if args.command is None:
        parser.error('no command given')

    logger.debug(f'you selected command: {args.command}')
    
    run_with_backoff(args.command)
    #TESTING: run_with_backoff(args.command, 3)

    
if __name__ == '__main__':
    sys.exit(main(sys.argv))

