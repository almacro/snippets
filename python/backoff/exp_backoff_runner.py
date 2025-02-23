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
import traceback
from time import sleep

VERSION = '0.1'

logging.basicConfig(
    level=logging.DEBUG,
    format="%(asctime)s %(levelname)-8s %(message)s",
    datefmt="%Y-%m-%d %H:%M:%S")
LOG = logging.getLogger("exp_backoff_runner")

wait = [ 15,  30,  45,  60,  75,  90,  105, 120, 135, 150, 165, 180,
         195, 210, 225, 240, 255, 270, 285, 300, 315, 330, 345, 360,
         375, 390, 405, 420, 435, 450, 465, 480, 495, 510, 525, 540,
         555, 570, 585, 600, 615, 630, 645, 660, 675, 690, 705, 720,
         735, 750, 765, 780, 795, 810, 825, 840, 855, 870, 885, 900 ]

def limit_type(arg):
    """Type function for argparse - an int greater than zero and less than or equal to 60"""
    min_val=1
    max_val=60

    try:
        limit = int(arg)
    except ValueError as exc:
        raise argparse.ArgumentTypeError("Must be a positive integer up to 60") from exc
    if limit < min_val or limit > max_val:
        raise argparse.ArgumentTypeError(f"Argument must be > 0 and <= {max_val}") from exc
    return limit


def get_parser():
    '''Provide a configured ArgumentParser'''
    parser = argparse.ArgumentParser(description='argument parser for exponential backoff runner')

    parser.add_argument('--verbose', '-v', action='count', default=0,
                        help='increase output verbosity')

    parser.add_argument('--version', '-V', action='version', version=VERSION)
    parser.add_argument('--limit', '-L', type=limit_type,
                        help='reduce max iterations limit (default=60)')

    parser.add_argument('command', help='command to run with exponential backoff')

    return parser


def setup_logger(verbose=None):
    '''Set up logger'''
    if verbose is None or verbose == 0:
        loglevel = logging.ERROR
    elif verbose == 1:
        loglevel = logging.WARNING
    elif verbose == 2:
        loglevel = logging.INFO
    elif verbose == 3:
        loglevel = logging.DEBUG

    LOG.setLevel(loglevel)
    LOG.debug('loglevel is %s', logging.getLevelName(LOG.getEffectiveLevel()))


def run_with_backoff(command, limit=len(wait)):
    '''Run COMMAND, retrying at most LIMIT times'''
    done = False

    for i in range(limit):
        if done:
            break

        try:
            run = 'running' if i == 0 else 'retrying'
            LOG.debug('%s command: %s', run, command)

            with subprocess.Popen(shlex.split(command),
                                       stderr=subprocess.STDOUT,
                                       stdout=subprocess.PIPE
            ) as process:
                out = process.communicate()[0]
                out = out.decode('utf-8') if out is not None else ''
                return_code = process.returncode

                if re.search('goaway', out) is None:
                    if return_code == 0:
                        LOG.info('command successful')
                    else:
                        LOG.info('command failed')

                    LOG.debug('exit status: %d', return_code)
                    LOG.debug('command output:\n%s', out)
                    done = True
                else:
                    wait_secs = wait[i]
                    LOG.info('command failed due to rate-limit, sleeping for %d seconds', wait_secs)
                    LOG.debug('command output:\n%s', out)
                    sleep(wait_secs)

        except OSError as exc:
            LOG.info(repr(traceback.format_exception(exc)))
            LOG.debug(repr(traceback.format_tb(exc)))

    LOG.debug('did %d tries', (i+1))
    if i+1 == limit:
        LOG.info('command did not succeed after maximum of %d iterations',  limit)


def main(argv=None):
    '''main entry point'''
    if argv is None:
        argv = sys.argv

    parser = get_parser()

    args = parser.parse_args(argv[1:])
    setup_logger(args.verbose)

    LOG.info('verbosity = %d', args.verbose)
    if args.limit is None:
        args.limit = len(wait)
    LOG.info('limit = %d', args.limit)

    LOG.debug('got args => %s', args)

    if 'version' in vars(args):
        parser.exit(args.version)

    if args.command is None:
        parser.error('no command given')

    LOG.debug('you selected command: %s', args.command)

    run_with_backoff(args.command, args.limit)


if __name__ == '__main__':
    sys.exit(main(sys.argv))
