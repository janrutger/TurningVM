from cpu import opcodelibrary as ol

class Opcodes:
    def __init__(self):
        self.opcodelibrary = ol.Opcodelibrary()
      
    def get_tapelist(self, opcode):
        tapelist = self.opcodelibrary.get_all_rules(opcode) # All rulles of one opcode
        tapelist = dict(tapelist[0][1])                     # Tapevalue from the first rule 
        tapelist = list(tapelist.keys())                    # make a list of the tape names
        return(tapelist)                                    # return tapelist
    
    def get_turingrule(self, opcode, tapevalues, state):
        allrules = self.opcodelibrary.get_all_rules(opcode)
        for rule in allrules:
            rulestate   = rule[0]
            rulevalues  = rule[1]
            turingrule  = rule[2]
            if rulestate == state and rulevalues == tapevalues:
                return(turingrule)
        else:
            print("NOT FOUND", "<",opcode,">", "(",state,",", tapevalues,",","( ))")
            return(-1)
        