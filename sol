#!/usr/bin/env python

import sys



def printError(error):
    """
    Prints errors after appending 'Error: ' to the front of them.

    Arguments:
    error -- The error string to be printed

    Errors are printed to standard error.

    """

    print >> sys.stderr, 'Error: ' + error





def main(argv):
    argc = len(argv)
    if (argc) !=2 :
        PrintError('Must supply one input file and one output file')
        return -1
    PrintError('Horray you are not dumb')
    return 0


if __name__ == "__main__":
    main(sys.argv[1:])
