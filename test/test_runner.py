import os
import unittest
import dotfiles

fixture_dir = os.path.join(os.path.dirname(__file__), './fixture')


class RunnerTest(unittest.TestCase):
    def test_nested(self):
        file = fixture_dir + '/nested.yml'
        config = dotfiles.read_config(file)
        runner = dotfiles.Runner(config, file)

        self.assertEqual(runner.run('child1'), 0)
        self.assertEqual(runner.run('child2'), 1)

    # def test_qualified(self):
    #     file = fixture_dir + '/qualified.yml'
    #     config = dotfiles.read_config(file)
    #     runner = dotfiles.Runner(config, file)
    #
    #     self.assertEqual(runner.run('child1'), 0)
    #     self.assertEqual(runner.run('child2'), 1)
