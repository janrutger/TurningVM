import unittest


class EvalTester:

    def do_it(self):
        return eval("self.execute(10)")

    def execute(self, x):
        return x


class Testing(unittest.TestCase):

    def test_string(self):
        tester = EvalTester()
        x = tester.do_it()
        self.assertEqual(x, 10)
