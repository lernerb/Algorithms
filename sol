#!/usr/bin/env python
import sys, string

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
        myGraph.addVertex("x" + str(x))

    unsatisfiableList = []
    isSatisfiable = True

    # Start the graph object here, and read the whole file
    for line in sys.stdin:
        newstr = str.split(line)
        if (newstr[1] == "!="):
            tempTuple = newstr[0], newstr[2]
            unsatisfiableList.append(tempTuple)
        else:
            myGraph.addEdge(newstr[0], newstr[2])

#    printError(unsatisfiableList)
    # Check to see if any unsatisfiable assignment makes this whole thing false
    for tuple in unsatisfiableList:
        path = []
        myGraph.DFS(myGraph, tuple[0], path)
        #printError("doing a dfs search")
#        printError(path)

        if tuple[1] in path:
            isSatisfiable = False
            break
#        if (myGraph.isSCC(myGraph, tuple[0], tuple[1])):
#            isSatisfiable = False
#            break

    # Return the output to the program
    printSatisfiable(isSatisfiable)

class Vertex:
    def __init__(self, key):
        self.id = key
        self.neighbors = []

    def addNeighbor(self, nbr):
        self.neighbors.append(nbr)

    def getNeighbors(self):
        return self.neighbors

class Graph:
    def __init__(self):
        self.vertexKeys = []
        self.vertexList = []

    def addVertex(self, key):
        self.vertexKeys.append(key)
        self.vertexList.insert(self.vertexKeys.index(key), Vertex(key))
 #       printError("added key" + key)

    def addEdge(self, fromNode, toNode):
        self.vertexList[self.vertexKeys.index(fromNode)].addNeighbor(toNode)
        self.vertexList[self.vertexKeys.index(toNode)].addNeighbor(fromNode)

    def getSCC(self, node):
        return self.vertexList[self.vertexKeys.index(node)].getNeighbors()


    def DFS(self, graph, start, path):
        if start in path:
            return False
        path.append(start)
        for each in self.getSCC(start):
            if each not in path:
                self.DFS(graph, each, path)


    def isSCC(self, graph, node1, node2):
       
        visited = []
        visited.append(node1)

        for vertex in self.getSCC(node1):
            if vertex not in visited:
                visited.append(vertex)

        if node2 in visited:
            return True
        else:
            return False
           
#        seenlist.append(node1)
#        printError("seen"+node1)
#        scclist = self.getSCC(node1)

#        for nodething in scclist:

#            if nodething not in seenlist:
#                seenlist.append(nodething)
#                found = self.isSCC(nodething, node2, seenlist)
#                if found:
#                    return True

#            newlist = self.getSCC(nodething)

#            for node in newlist:
#                if node not in seenlist:
#                    seenlist.append(node)
#                scclist = seenlist

        if node2 in seenlist:
            return True
        else:
            return False


def printError(error):
    """
    Prints errors after appending 'Error: ' to the front of them.
    Arguments: error -- The error string to be printed
    This is for debugging purposes only
    """
    print >> sys.stderr,  error


def main(argv):
    argc = len(argv)
    if (argc) > 0 :
        print('Must supply input to program as ./sol < INPUTFILE > OUTPUTFILE')
        return -1
    sat2()
    return 0

if __name__ == "__main__":
    main(sys.argv[1:])
