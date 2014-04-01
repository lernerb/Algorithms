#!/usr/bin/env python

import sys, io, time, string, re


def printError(error):
    """
    Prints errors after appending 'Error: ' to the front of them.
    Arguments:
    error -- The error string to be printed
    Errors are printed to standard error.
    """

    print >> sys.stderr, 'Error: ' + error



def sat2():
    """
    Reads from STDIN, and pipes to STOUT if it is satisfiable or not.
    
    Line 1 -- N M
    where N specifies the number of variables, M specifies the number of constraints to follow

    Lines 2 through M+1 -- Xi OP Xj
    Where 1 <= i, j <= N, and OP is an equality operator (==) or an non-equality operator (!=)
    """
    firstLineString = sys.stdin.readline()
    numberArray =  [int(s) for s in firstLineString.split() if s.isdigit()]
    numberOfVariables = numberArray[0]
    numberOfConstraints = numberArray[1]
    printError('The number of variables is = ' + str(numberOfVariables))
    printError('The number of constraints is = ' + str(numberOfConstraints))






def main(argv):
    argc = len(argv)
    if (argc) > 0 :
        printError('Must supply one input file and one output file as PIPES')
        return -1
    sat2()
    return 0


if __name__ == "__main__":
    main(sys.argv[1:])
