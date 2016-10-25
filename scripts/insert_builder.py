import re
import sys
import os

def build_insert(inputfile, outputfile, mappingsfile, tablename):
    print 'Reading from %s' % inputfile
    print 'Writing to %s' % outputfile
    print 'Using mappings file %s' % mappingsfile

    if not os.path.isfile(inputfile):
        print 'the file %s doesnt exist' % inputfile
        return

    if not os.path.isfile(mappingsfile):
        print 'the file %s doesnt exist' % mappingsfile
        return

    mapping = eval(open(mappingsfile).read())[tablename]
    lines = [l.strip() for l in open(inputfile).readlines()]

    headers = lines[0].split(';')
    del(lines[0])

    newHeaders = [mapping[s] for s in headers]
    newLines = [[s.replace("'", "\\'") for s in line.split(';')] for line in lines]
    insertLines = ["('%s')" % "','".join(s) for s in newLines] 

    h = open(outputfile, 'w')
    h.write('insert into(%s) values\n  ' % ','.join(newHeaders))
    h.write(',\n  '.join(insertLines))
    h.write('\n;')
    h.close()

    

def print_help():
    print 'python insert_builder.py <input file> <output file> <mappings file> <table name>'

if __name__ == '__main__':
    if len(sys.argv[1:]) == 4:
        build_insert(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4])
    else:
        print_help()