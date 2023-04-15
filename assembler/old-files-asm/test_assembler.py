import unittest
import assembler as asm



class test_opcodes(unittest.TestCase):

    def setUp(self):
        self.assembler = asm.Assembler()


    def test_readASM(self):
        #self.assembler = asm.Assembler()
        #self.assembler.readASM('./demo.asm')
        result = self.assembler.readASM("/home/pi/projects/assembler/test1.asm")
        self.assertEqual(result, ['#'])

    def test_compile(self):
        program = self.assembler.readASM("/home/pi/projects/turing2/assembler/jrk.asm")
        program = self.assembler.compile(program)
        print(program)
        
        

if __name__ == '__main__':
    unittest.main()
