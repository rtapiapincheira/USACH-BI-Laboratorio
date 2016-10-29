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

def convert_price_file(iofile):
    if not os.path.isfile(iofile):
        print 'the file %s does not exist' % iofile
        return

    def maybe_convert(value):
        value = value.strip()
        if value.startswith('$ '):
            return value[2:].replace(',', '.')
        if value.count(',') == 1 and value.replace(',','').isdigit():
            return str(float(value.replace(',', '.')))
        return value

    lines = [l.strip() for l in open(iofile).readlines()]

    data = [d.split(';') for d in lines]

    data2 = [[maybe_convert(d) for d in row] for row in data]

    new_lines = [';'.join(row) for row in data2]

    h = open(iofile, 'w')
    h.write('\n'.join(new_lines))
    h.close()

def print_help():
    print 'python cleaner.py clean <input file> <output file>'
    print 'python cleaner.py convert_price <iofile>'

if __name__ == '__main__':
    if len(sys.argv[1:]) == 3 and sys.argv[1] == 'clean':
        clean_file(sys.argv[2], sys.argv[3])
    elif len(sys.argv[1:]) == 2 and sys.argv[1] == 'convert_price':
        convert_price_file(sys.argv[2])
    else:
        print_help()