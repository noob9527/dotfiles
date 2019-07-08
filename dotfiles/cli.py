import logging
import os
import sys
from argparse import ArgumentParser

from .runner import Runner

logger = logging.getLogger(__name__)

cwd = os.path.realpath(sys.argv[0])
default_conf = os.path.abspath(os.path.join(cwd, '../..', 'config', 'config.yml'))


def get_options():
    parser = ArgumentParser()
    parser.add_argument('-c', '--config',
                        dest='config_file',
                        default=default_conf,
                        help='run commands given in CONFIG FILE',
                        metavar='CONFIG FILE')
    parser.add_argument("-n", "--name",
                        default='ALL',
                        help="run the specified task")
    parser.add_argument("-v", "--verbose",
                        help="increase output verbosity",
                        action="store_true")
    return parser.parse_args()


def main():
    options = get_options()
    logger.debug('option: %s', options)

    if options.verbose:
        logging.basicConfig(level=logging.DEBUG)

    runner = Runner(options.config_file)
    runner.run(options.name)
