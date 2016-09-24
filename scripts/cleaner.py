
import sys
import os

def clean_file(inputfile, outputfile):
	print 'Reading from %s' % inputfile
	print 'Writing to %s' % outputfile

	if not os.path.isfile(inputfile):
		print 'the file %s doesnt exist' % inputfile
		return

	memfile = open(inputfile).read()

	lines = memfile.split('\n');

	def clean_delimiters(s):
		return s.strip(' \t\n\r\b"')

	header = lines[0]
	parts = [clean_delimiters(e) for e in header.split(';')]

	del(lines[0])
	merged = ' '.join([l.strip() for l in lines])
	
	tokens = [clean_delimiters(e) for e in merged.split(';')]

	a = len(tokens)
	b = len(parts)
	if a % b != 0:
		print 'detected a=%d columns, but there are b=%d data fields in the body (a should divide b)' % (b, a)
		exit()

	print parts
	print tokens

def print_help():
	print 'python cleaner.py <input file> <output file>'

if __name__ == '__main__':
	if len(sys.argv[1:]) == 2:
		clean_file(sys.argv[1], sys.argv[2])
	else:
		print_help()