import logging
import os
import subprocess
from typing import Dict, Sequence

from .color import Color
from .utils import colorful_print
from .utils import read_config

logger = logging.getLogger(__name__)


class Task:
    short_name: str
    full_name: str
    cmd: Sequence[str] = []
    tasks: Sequence['Task'] = []


class Runner:
    tasks: Dict[str, Task] = {}

    def __init__(self, config_file):
        self.__config_file = config_file
        self.__config_dir = os.path.dirname(config_file)
        self.__config = read_config(config_file)
        logger.debug('config: %s', self.__config)
        self.__config.setdefault('name', '')

        self.__flatten(self.__config, '')
        logger.debug('tasks: %s', self.tasks)

    def run(self, name: str = '') -> int:
        task = self.tasks.get(name) or \
               next((t for t in self.tasks.values() if name == t.short_name), None)

        if not task:
            available = {*self.tasks.keys()}
            raise Exception(f'Cannot find such a task: {name}, available: {available}')

        return self.__run_task(task)

    def __run_task(self, task: Task) -> int:
        name = task.short_name
        colorful_print('start to exec task(' + name + '):', Color.BLUE)

        for task in task.tasks:
            self.__run_task(task)

        cmd = task.cmd
        res = subprocess.run(
            cmd,
            shell=True,
            cwd=self.__config_dir
        )

        if res.returncode:
            colorful_print('some error occurred when execute task(' + name + ')', Color.RED)
        else:
            colorful_print('task(' + name + ') was executed successfully', Color.GREEN)

        return res.returncode

    def __flatten(self, task_obj, namespace: str):
        task = Task()
        task.short_name = task_obj['name']
        task.full_name = namespace + task_obj['name']
        task.cmd = task_obj.get('cmd', [])
        self.tasks[task.full_name] = task

        sub_task_obj = task_obj.get('tasks', [])
        if not sub_task_obj:
            return task

        next_ns = task.full_name + '.' if task.full_name else ''
        task.tasks = [self.__flatten(t, next_ns) for t in sub_task_obj]

        return task
