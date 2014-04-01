#!/usr/bin/env python

import sys, io, time, string

def printError(error):
    """
    Prints errors after appending 'Error: ' to the front of them.
    Arguments: error -- The error string to be printed
    This is for debugging purposes only
    """
    print >> sys.stderr,  error

def printSatisfiable(boolean):
    """
    Prints to stdout if it is satisfiable or not
    Arguments: boolean -- if it is satisfiable
    """
    if (boolean):
        sys.stdout.write("SATISFIABLE")
        printError("satsat")
    else:
        sys.stdout.write("NOT SATISFIABLE")
        printError("not sat")


def sat2():
    """
    Reads from STDIN, and pipes to STOUT if it is satisfiable or not.
    
    Line 1 -- N M
    where N specifies the number of variables, M specifies the number of constraints to follow

    Lines 2 through M+1 -- Xi OP Xj
    Where 1 <= i, j <= N, and OP is an equality operator (==) or an non-equality operator (!=)
    """
    firstLineString = sys.stdin.readline()
#    numberArray =  [int(s) for s in firstLineString.split() if s.isdigit()]
#    numberOfVariables = numberArray[0]
#    numberOfConstraints = numberArray[1]
#    printError('The number of variables is = ' + str(numberOfVariables))
#    printError('The number of constraints is = ' + str(numberOfConstraints))

    myGraph = Graph()
    unsatisfiableList = []
    isSatisfiable = True

    # Start the graph object here, and read the whole file
    for line in sys.stdin:
        newstr = str.split(line)
        if (newstr[1] == "!="):
            tempTuple = newstr[0], newstr[2]
            unsatisfiableList.append(tempTuple)
            printError('notequals')
        else:
            myGraph.addVertex(newstr[0])
            myGraph.addVertex(newstr[2])
            myGraph.addEdge(newstr[0], newstr[2])
            printError('equals')
            
    printError(myGraph)

    # Check to see if any unsatisfiable assignment makes this whole thing false
    for tuple in unsatisfiableList:
        printError(tuple[0])
        printError(tuple[1])
        if (myGraph.isSCC(tuple[0],tuple[1])):
            printError(tuple[0])
            isSatisfiable = False
            printError('totally not satisfiable')
            break


    printSatisfiable(isSatisfiable)

class Vertex:
    def __init__(self,key):
        self.id = key
        self.neighbors = []

    def addNeighbor(self,nbr):
        if nbr not in self.neighbors:
            self.neighbors.append(nbr)

    def __str__(self):
        return str(self.id) + ' connectedTo: ' + str(neighbors)

    def getConnections(self):
        return self.neighbors

    def getId(self):
        return self.id

class Graph:
    def __init__(self):
        self.vertexKeys = []
        self.vertexList = []

    def addVertex(self,key):
        newVertex = Vertex(key)
        if key not in self.vertexKeys:
            self.vertexKeys.append(key)
            self.vertexList.insert(self.vertexKeys.index(key), newVertex)
        return newVertex

    def getVertex(self,n):
        if n in self.vertexKeys:
            return self.vertexList[self.vertexKeys.index(n)]
        else:
            return None

    def addEdge(self,fromNode,toNode):
#        if fromNode not in self.vertexKeys:
#            nv1 = self.addVertex(fromNode)
#            self.vertexList[self.vertexKeys.index(fromNode)].addNeighbor(toNode)
#        if toNode not in self.vertexKeys:
#            nv2 = self.addVertex(toNode)
#            self.vertexList[self.vertexKeys.index(toNode)].addNeighbor(fromNode)       
        self.vertexList[self.vertexKeys.index(fromNode)].addNeighbor(toNode)
        self.vertexList[self.vertexKeys.index(toNode)].addNeighbor(fromNode)

        
    def getVertices(self):
        return self.vertList

    def __iter__(self):
        return iter(self.vertexList.values())

    def __str__(self):
        return  'keys: ' + str(self.vertexKeys) + 'list: ' + str(self.vertexList)

    def getSCC(self, node):
        if node not in self.vertexKeys:
            printError('NOT IN GETSCC')
            return []
        else:
            printError('IN SCC, FIX YOUR SHIT BRANDON')
            return self.vertexList[self.vertexKeys.index(node)].getConnections()

    def isSCC(self, node1, node2):
        printError('checking for isSCC for nodes' + node1 + node2)
        
        scclist = self.getSCC(node1)
        printError(scclist)
        for nodething in scclist:
            self.isSCC(node1, nodething)
            # WE NEED TO ITERATE HERE SOMEHOW????
            printError('this is a match')
        
        if node2 in scclist:
            return True
        else:
            return False

def main(argv):
    argc = len(argv)
    if (argc) > 0 :
        printError('Must supply one input file and one output file as PIPES')
        return -1
    sat2()
    return 0


if __name__ == "__main__":
    main(sys.argv[1:])
