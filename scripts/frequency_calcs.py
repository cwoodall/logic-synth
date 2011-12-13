from math import *

frequencies = {'C4': 261.626, 'Cs4': 277.183, 'D4': 293.665, 'Ds4': 311.127,
			   'E4': 329.628, 'F4': 349.228, 'Fs4': 369.994, 'G4': 391.995,
			   'Gs4': 415.305, 'A4': 440, 'As4': 466.164, 'B4': 493.883, 'C5': 523.251}


for note in sorted(frequencies.keys()):
	freq = frequencies[note]
	clk_freq = 50000000
	print "parameter %s = %i; // %.3f Hz" % (note, clk_freq/(freq * 1023), freq)
