import re
import sys
import os

def clean_file(inputfile, outputfile):
    print 'Reading from %s' % inputfile
    print 'Writing to %s' % outputfile

    if not os.path.isfile(inputfile):
        print 'the file %s doesnt exist' % inputfile
        return

    lines = [l.strip() for l in open(inputfile).readlines()]

    nheader = lines[0].count(';')

    result = []

    buffer = []
    nbuffer = 0
    for l in lines:
        nl = l.count(';')
        if nl == nheader:
            result.append(l)
        else:
            buffer.append(l)
            nbuffer += nl
        if nbuffer == nheader:
            result.append(''.join(buffer))
            buffer = []
            nbuffer = 0
    if len(buffer) > 0:
        result.append(''.join(buffer))

    def clean_string(s):
        parts = s.split(';')
        return ';'.join([r.strip('\t\n\r\b\v" ') for r in parts])

    open(outputfile, 'w').write('\n'.join([ clean_string(s) for s in result]))


def print_help():
    print 'python cleaner.py <input file> <output file>'

if __name__ == '__main__':
    if len(sys.argv[1:]) == 2:
        clean_file(sys.argv[1], sys.argv[2])
    else:
        print_help()