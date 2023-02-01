class Tape:
    def __init__(self, name, tape, head):
        self.name = name
        self.tape = tape
        self.head = head
        self.moves = { 'L' : self.left, 'R' : self.right, 'S' : self.stay }

    def move(self, moveTo):
        if moveTo in self.moves:
            self.moves.get(moveTo)()

    def stay(self):
#        print('stay')
        return

    def left(self):
#        print('links')  ## this is more like right
        self.head += 1
        if self.head == len(self.tape):
            self.tape.append('_')

    def right(self):
#        print('rechts')
        if self.head == 0:
            self.tape.insert(0, '_')
        else:
            self.head -= 1

    def write(self, val):
        if '-' != val:
            self.tape[self.head] = val

    def read(self):
        return(self.tape[self.head])

    def print(self): #sends the full tape lenght
        if self.head == len(self.tape) - 1:
            return [''.join(self.tape[:self.head]), self.tape[self.head], '']
        return [''.join(self.tape[:self.head]), self.tape[self.head], ''.join(self.tape[self.head+1:])]

    # def print(self): #sends right/left 100 digits of the tape
    #     if self.head == len(self.tape) - 1:
    #         return [''.join(self.tape[self.head-100:self.head]), self.tape[self.head], '']
    #     return [''.join(self.tape[self.head-100:self.head]), self.tape[self.head], ''.join(self.tape[self.head+1:self.head+100])]


    def hasName(self, name):
        return self.name == name

    def getHead(self):
        return self.head