#!/usr/bin/env python3

import sys

import numpy as np

from fasta import readFASTA

# Command line input will be: script name (0), FASTA file (1), scoring matrix (2), gap penalty (3), output filepath (4)
input_sequences = readFASTA(open(sys.argv[1]))

seq1_id, sequence1 = input_sequences[0]
seq2_id, sequence2 = input_sequences[1]

# print(sequence2)

gap_penalty = int(sys.argv[3])
out_file = sys.argv[4]

# print(sequence1)

# The scoring matrix is assumed to be named "sigma_file" and the 
# output filename is assumed to be named "out_file" in later code


# Read the scoring matrix into a dictionary
fs = open(sys.argv[2])
sigma = {}
alphabet = fs.readline().strip().split()
for line in fs:
	line = line.rstrip().split()
	for i in range(1, len(line)):
		sigma[(alphabet[i - 1], line[0])] = float(line[i])
fs.close()

# print(sigma)


#=====================#
# Initialize and Populate F and Traceback Matrices #
#=====================#
f_matrix = np.zeros((len(sequence1)+1,len(sequence2)+1),dtype = int)
traceback_matrix = np.zeros((len(sequence1)+1,len(sequence2)+1),dtype = 'U1')

## First row and first column
for j in range(1,len(sequence2)+1):
	f_matrix[0,j] = f_matrix[0, j-1] + gap_penalty
	traceback_matrix[0,j] = "h_score"

for i in range(1,len(sequence1)+1):
	f_matrix[i,0] = f_matrix[i-1,0] + gap_penalty
	traceback_matrix[i,0] = "v_score"

f_move_dict = {
	"v_score": 0,
	"h_score": 0,
	"d_score": 0
}

## Goes through each remaining element of the two matrices and assigns the f_matrix value and traceback direction
## I've used a dictionary as a format to store the three possible score values because it is as easy to
## take the maximum f_matrix value (as compared to the live-coding example from class) while also easily
## printing the key associated with each matrix element's maximum value, which encodes the traceback information
for i in range(1,len(sequence1)+1):
	for j in range(1,len(sequence2)+1):
		# print(sequence1[i-1])
		# print(sequence2[j-1]) # sequence[] index must be i-1 or j-1 because of the leading gap in the matrix
		f_move_dict["v_score"] = gap_penalty + f_matrix[i-1,j]
		f_move_dict["h_score"] = gap_penalty + f_matrix[i,j-1]
		f_move_dict["d_score"] = sigma[(sequence1[i-1],sequence2[j-1])] + f_matrix[i-1,j-1]
		# print(f_move_dict)
		f_matrix[i,j] = max(f_move_dict.values())
		traceback_matrix[i,j] = max(f_move_dict, key=f_move_dict.get) ## NEED TO IMPLEMENT TIEBREAK CONDITION
		
		# break
		
	# break

# print(f_matrix)
# print(traceback_matrix)


#========================================#
# Follow traceback to generate alignment #
#========================================#

sequence1_alignment = ""
sequence2_alignment = ""

traceback_i = len(sequence1)
traceback_j = len(sequence2)

alignment_score = 0

while traceback_i >= 0 and traceback_j >= 0:
	# print((traceback_i,traceback_j))
	# print(f_matrix[traceback_i,traceback_j])
	alignment_score = alignment_score + f_matrix[traceback_i,traceback_j]
	step_direction = traceback_matrix[traceback_i,traceback_j]
	if step_direction.startswith("d"):
		# Adds letters to each alignment
		sequence1_alignment = sequence1_alignment + sequence1[traceback_i-1]
		sequence2_alignment = sequence2_alignment + sequence2[traceback_j-1]
		# Move i and j indices, a diagonal move in the traceback matrix
		traceback_i = traceback_i - 1
		traceback_j = traceback_j - 1
		continue
	if step_direction.startswith("h"):
		# Adds letter to seq2 and gap to seq1
		sequence1_alignment = sequence1_alignment + "-"
		sequence2_alignment = sequence2_alignment + sequence2[traceback_j-1]
		# Decrease j by one, a leftward move in the traceback matrix
		traceback_j = traceback_j - 1
		continue
	if step_direction.startswith("v"):
		# Adds letter to seq1 and gap to seq2
		sequence1_alignment = sequence1_alignment + sequence1[traceback_i-1]
		sequence2_alignment = sequence2_alignment + "-"
		# Decrease i by one, an upward move in the traceback matrix
		traceback_i = traceback_i - 1
		continue
	else:
		if traceback_i == 0 and traceback_j == 0:
			traceback_i = traceback_i - 1
			traceback_j = traceback_j - 1
			continue


## These sequences are in reverse order from how they appear in the FASTA file, by virtue of tracing from the bottom right of the matrix
## The lines below reverse the order of each
sequence1_alignment = sequence1_alignment[::-1]
sequence2_alignment = sequence2_alignment[::-1]


#=================================#
# Generate the identity alignment #
#=================================#

# This is just the bit between the two aligned sequences that
# denotes whether the two sequences have perfect identity
# at each position (a | symbol) or not.

identity_alignment = ''
for i in range(len(sequence1_alignment)):
	if sequence1_alignment[i] == sequence2_alignment[i]:
		identity_alignment += '|'
	else:
		identity_alignment += ' '


#===========================#
# Write alignment to output #
#===========================#

# Certainly not necessary, but this writes 100 positions at
# a time to the output, rather than all of it at once.

output = open(out_file, 'w')

for i in range(0, len(identity_alignment), 100):
	output.write(sequence1_alignment[i:i+100] + '\n')
	output.write(identity_alignment[i:i+100] + '\n')
	output.write(sequence2_alignment[i:i+100] + '\n\n\n')



## We need to output:
# Number of gaps in each sequence. This is the same as the number of "-" in each sequence alignment
seq1_gaps = sequence1_alignment.count("-")
# print(seq1_gaps)
seq2_gaps = sequence2_alignment.count("-")
# print(seq2_gaps)

# Identity of each Sequence --> I calculated this using the number of perfect matches (appearances of '|' in the identity
# string) as the numerator and the length of each sequence (not including gaps as the denominator
num_matches = identity_alignment.count("|")
seq1_identity = num_matches/len(sequence1)
seq2_identity = num_matches/len(sequence2)

# Alignment score was calculated in the traceback while() loop and previously stored

#======================#
# Print alignment info #
#======================#

print(f"Number of Gaps in Sequence 1: {seq1_gaps}\nNumber of Gaps in Sequence 2: {seq2_gaps}\nSequence Identity of Seq 1: {seq1_identity}\nSequence Identity of Seq 2: {seq2_identity}\nAlignment Score: {alignment_score}")

