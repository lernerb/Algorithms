#!/usr/bin/env python
import sys, io, time, string

def printSatisfiable(satisfiable):
    sys.stdout.write("SATISFIABLE") if satisfiable else sys.stdout.write("NOT SATISFIABLE")

def sat2():
    """
    Reads from STDIN, and pipes to STOUT if it is satisfiable or not.    
    Line 1 -- N M, Lines 2 through M+1 -- Xi OP Xj
    """
    firstLineString = sys.stdin.readline()
    myGraph = Graph()
    unsatisfiableList = []
    isSatisfiable = True

    # Start the graph object here, and read the whole file
    for line in sys.stdin:
        newstr = str.split(line)
        if (newstr[1] == "!="):
            tempTuple = newstr[0], newstr[2]
            unsatisfiableList.append(tempTuple)
        else:
            myGraph.addVertex(newstr[0])
            myGraph.addVertex(newstr[2])
            myGraph.addEdge(newstr[0], newstr[2])

    # Check to see if any unsatisfiable assignment makes this whole thing false
    for tuple in unsatisfiableList:
        if (myGraph.isSCC(tuple[0],tuple[1])):
            isSatisfiable = False
            break

    # Return the output to the program
    printSatisfiable(isSatisfiable)

class Vertex:
    def __init__(self, key):
        self.id = key
        self.neighbors = []

    def addNeighbor(self, nbr):
        if nbr not in self.neighbors:
            self.neighbors.append(nbr)

    def getNeighbors(self):
        return self.neighbors

class Graph:
    def __init__(self):
        self.vertexKeys = []
        self.vertexList = []

    def addVertex(self, key):
        if key not in self.vertexKeys:
            self.vertexKeys.append(key)
            self.vertexList.insert(self.vertexKeys.index(key), Vertex(key))

    def addEdge(self, fromNode, toNode):
        self.vertexList[self.vertexKeys.index(fromNode)].addNeighbor(toNode)
        self.vertexList[self.vertexKeys.index(toNode)].addNeighbor(fromNode)

    def getSCC(self, node):
        if node not in self.vertexKeys:
            return []
        else:
            return self.vertexList[self.vertexKeys.index(node)].getNeighbors()

    def isSCC(self, node1, node2):
        scclist = self.getSCC(node1)
        for nodething in scclist:
            newlist = self.getSCC(nodething)
            newlistRemoveDuplicates = []
            for node in newlist:
                if node not in scclist:
                    newlistRemoveDuplicates.append(node)
            scclist = newlistRemoveDuplicates
        if node2 in scclist:
            return True
        else:
            return False

def main(argv):
    argc = len(argv)
    if (argc) > 0 :
        printError('Must supply input to program as ./sol < INPUTFILE > OUTPUTFILE')
        return -1
    sat2()
    return 0

if __name__ == "__main__":
    main(sys.argv[1:])
