import numpy as np

# define Unit Step Function

#this is the activation function
def unitStep(v): #shift with 200
    if v >= 200:
        return 1
    else:
        return 0

# design Perceptron Model


def perceptronModel(x, w, b):
    v = (np.dot(w, x) ) + b 
    print(v)
    y = unitStep(v)
    return y


# testing the Perceptron Model
test1 = np.array([0, 1])
test2 = np.array([1, 1])
test3 = np.array([0, 0])
test4 = np.array([1, 0])
test5 = np.array([0])
test6 = np.array([1])


# AND Logic Function (not scaled)
# w1 = 1, w2 = 1, b = -1.5
def AND_logicFunction(x): #scale the w and b by 10 and shift by 100
    w = np.array([110, 110])
    b = 85
    return perceptronModel(x, w, b)

print("AND({}, {}) = {}".format(0, 1, AND_logicFunction(test1)))
print("AND({}, {}) = {}".format(1, 1, AND_logicFunction(test2)))
print("AND({}, {}) = {}".format(0, 0, AND_logicFunction(test3)))
print("AND({}, {}) = {}".format(1, 0, AND_logicFunction(test4)))


# OR Logic Function (not scaled)
# w1 = 1, w2 = 1, b = -0.5
def OR_logicFunction(x):  # scale the w and b with 10, shift by 100
    w = np.array([110, 110])
    b = 95
    return perceptronModel(x, w, b)

print("OR({}, {}) = {}".format(0, 1, OR_logicFunction(test1)))
print("OR({}, {}) = {}".format(1, 1, OR_logicFunction(test2)))
print("OR({}, {}) = {}".format(0, 0, OR_logicFunction(test3)))
print("OR({}, {}) = {}".format(1, 0, OR_logicFunction(test4)))


# NOT Logic Function
# wNOT = -1, bNOT = 0.5
def NOT_logicFunction(x): # scale 10, shift by 100
    wNOT = np.array([90])
    bNOT = 5
    return perceptronModel(x, wNOT, bNOT)

print("NOT({}) = {}".format(0, NOT_logicFunction(test5)))
print("NOT({}) = {}".format(1, NOT_logicFunction(test6)))


# # NOR Logic Function
# # with OR and NOT
# # function calls in sequence
# def NOR_logicFunction(x):
#     output_OR = OR_logicFunction(x)
#     output_NOT = NOT_logicFunction(output_OR)
#     return output_NOT

# print("NOR({}, {}) = {}".format(0, 1, NOR_logicFunction(test1)))
# print("NOR({}, {}) = {}".format(1, 1, NOR_logicFunction(test2)))
# print("NOR({}, {}) = {}".format(0, 0, NOR_logicFunction(test3)))
# print("NOR({}, {}) = {}".format(1, 0, NOR_logicFunction(test4)))
