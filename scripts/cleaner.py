import re
import sys
import os

def clean_file(inputfile, outputfile):
    print 'Reading from %s' % inputfile
    print 'Writing to %s' % outputfile

    if not os.path.isfile(inputfile):
        print 'the file %s doesnt exist' % inputfile
        return

    memfile = open(inputfile).read()

    while ';\n' in memfile:
        memfile = memfile.replace(';\n', ';""\n')
    

    L = [l.replace('\n',' ').strip() for l in memfile.split('"\n')]
    
    def clean_delimiters(s):
        return s.strip(' \t\n\r\b"')

    header = [clean_delimiters(e) for e in L[0].split(';')]

    del(L[0])
    
    LS = [[clean_delimiters(e) for e in k.split(';')] for k in L]

    h = open(outputfile, 'w')
    h.write(';'.join(header))
    for l in LS:
    	h.write('\n')
    	h.write(';'.join(l))
    h.close()


def print_help():
    print 'python cleaner.py <input file> <output file>'

if __name__ == '__main__':
    if len(sys.argv[1:]) == 2:
        clean_file(sys.argv[1], sys.argv[2])
    else:
        print_help()