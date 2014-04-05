#!/usr/bin/env python
import sys, string, gc

def printSatisfiable(satisfiable):
    sys.stdout.write("SATISFIABLE") if satisfiable else sys.stdout.write("NOT SATISFIABLE")

def sat2():
    """
    Reads from STDIN, and pipes to STOUT if it is satisfiable or not.    
    Line 1 -- N M, Lines 2 through M+1 -- Xi OP Xj
    """
    firstLineString = sys.stdin.readline()
    numberArray =  [int(s) for s in firstLineString.split() if s.isdigit()]
    numberOfVariables = numberArray[0]
    numberOfConstraints = numberArray[1]
    myGraph = Graph()

    for x in range (1, numberOfVariables+1):
        myGraph.addVertex(x)

    unsatisfiableList = []
    isSatisfiable = True

    # Start the graph object here, and read the whole file
    for line in sys.stdin:
        newstr = str.split(line)
        if (newstr[1] == "!="):
            tempTuple = newstr[0][1:], newstr[2][1:]
            unsatisfiableList.append(tempTuple)
        else:
            myGraph.addEdge(int(newstr[0][1:]), int(newstr[2][1:]))

    # Check to see if any unsatisfiable assignment makes this whole thing false
    for tuple in unsatisfiableList:
        path = []
        myGraph.DFS(myGraph, int(tuple[0]), path)        
        if int(tuple[1]) in path:
            isSatisfiable = False
            break

    # Return the output to the program
    printSatisfiable(isSatisfiable)

class Graph:
    def __init__(self):
        self.vertexList = []

    def addVertex(self, key):
        self.vertexList.append([])

    def addEdge(self, fromNode, toNode):
        self.vertexList[fromNode-1].append(toNode)
        self.vertexList[toNode-1].append(fromNode)

    def getSCC(self, node):
        node = int(node)
        return self.vertexList[node-1]

    def DFS(self, graph, start, path):
        if start in path:
            return False

        path.append(start)
        for each in self.getSCC(start):
            if each not in path:
                self.DFS(graph, each, path)

def main(argv):
    argc = len(argv)
    if (argc) > 0 :
        print('Must supply input to program as ./sol < INPUTFILE > OUTPUTFILE')
        return -1
    sat2()
    return 0

if __name__ == "__main__":
    main(sys.argv[1:])
