import logging
from argparse import ArgumentParser

from .runner import Runner
from .utils import read_config

logger = logging.getLogger(__name__)


def add_options(parser):
    parser.add_argument('-c', '--config',
                        dest='config_file',
                        required=True,
                        help='run commands given in CONFIG FILE',
                        metavar='CONFIG FILE')
    parser.add_argument("-v", "--verbose",
                        help="increase output verbosity",
                        action="store_true")


def main():
    parser = ArgumentParser()
    add_options(parser)
    options = parser.parse_args()

    if options.verbose:
        logging.basicConfig(level=logging.DEBUG)

    # config
    config = read_config(options.config_file)
    logger.debug('config: %s', config)

    runner = Runner(config, options.config_file)
    runner.run()
