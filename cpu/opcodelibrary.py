from cpu import microcode as mc
import json

class Opcodelibrary:
    def __init__(self):
        self.library = mc.loadlibrary()
    
    
    def get_all_rules(self, opcode):
        return(self.library[opcode])

    def dump_library(self):
        return(json.dumps(self.library, indent=4, sort_keys=True))