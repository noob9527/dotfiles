import yaml
from .color import Color


def read_config(config_file):
    with open(config_file) as file:
        data = yaml.safe_load(file)
    return data


def colorful_print(msg, color=Color.NONE):
    print('%s%s%s' % (color, msg, Color.RESET))
