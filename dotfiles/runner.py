import os
import subprocess

from .color import Color
from .utils import colorful_print


class Runner:
    def __init__(self, config, config_path):
        self._config = config
        self._path = os.path.dirname(config_path)

        if 'name' not in self._config:
            self._config['name'] = 'ALL'

    def run(self, name=None):
        if name is None:
            name = self._config['name']

        tasks = {}
        self.flatten(self._config, tasks)
        task = tasks[name]

        self.run_task(task)

    # dfs
    def flatten(self, task, res):
        res[task['name']] = task

        if 'tasks' not in task:
            return

        tasks = task['tasks']
        for t in tasks:
            self.flatten(t, res)

    def run_task(self, task):
        name = task['name']
        colorful_print('start to exec task(' + name + '):', Color.BLUE)

        if 'tasks' not in task:
            cmd = task['cmd']
            res = subprocess.run(
                cmd,
                shell=True,
                cwd=self._path
            )

            if res.returncode:
                colorful_print('some error occurred when execute task(' + name + ')', Color.RED)
            else:
                colorful_print('task(' + name + ') was executed successfully', Color.GREEN)
            return

        for task in task['tasks']:
            self.run_task(task)
