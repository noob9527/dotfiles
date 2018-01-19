import os
import subprocess
from .color import Color
from .utils import colorful_print


class Runner:
    def __init__(self, config, config_path):
        self._config = config
        self._path = os.path.dirname(config_path)

    def run(self):
        tasks = self._config['tasks']
        total_task = len(tasks)
        succeeded = 0
        failed = 0

        for task in tasks:
            task_name = task['name']
            colorful_print('start to exec task(' + task_name + '):', Color.BLUE)
            res = subprocess.run(
                task['cmd'],
                shell=True,
                cwd=self._path
            )
            if res.returncode:
                colorful_print('some error occurred when execute task(' + task_name + ')', Color.RED)
                failed += 1
            else:
                colorful_print('task(' + task_name + ') was executed successfully', Color.GREEN)
                succeeded += 1
        colorful_print('succeeded: ' + str(succeeded), Color.GREEN)
        colorful_print('failed: ' + str(failed), Color.RED)
        colorful_print('total: ' + str(total_task), Color.BLUE)
