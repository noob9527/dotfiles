import os
import unittest

import dotfiles

fixture_dir = os.path.join(os.path.dirname(__file__), 'fixture')


# noinspection PyMethodMayBeStatic
class RunnerTest(unittest.TestCase):
    def test_run_task_short_name(self):
        file = fixture_dir + '/nested.yml'
        runner = dotfiles.Runner(file)

        self.assertEqual(runner.run('child1'), 1)
        self.assertEqual(runner.run('child2'), 2)

    def test_run_task_full_name(self):
        file = fixture_dir + '/nested.yml'
        runner = dotfiles.Runner(file)

        self.assertEqual(runner.run('parent.child1'), 1)
        self.assertEqual(runner.run('parent.child2'), 2)

    def test_run_tasks(self):
        file = fixture_dir + '/nested.yml'
        runner = dotfiles.Runner(file)

        self.assertEqual(runner.run('parent'), 1)

    def test_complicated(self):
        file = fixture_dir + '/complicated.yml'
        runner = dotfiles.Runner(file)
        print(runner.tasks)
