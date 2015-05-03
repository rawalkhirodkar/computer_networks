set term postscript eps color

set output 'output/pdr-snr-ex1.eps'

#used to make the fonts appear larger;  makes the figure smaller but keeps the fonts same size
set size 0.6, 0.6
set key right bottom


set xlabel "Signal to Noise ratio (SNR)"
set ylabel "Packet Delivery Ratio (PDR)"

plot \
'data/pdr-snr.txt' using 2:1 t'Case1' with points pt 3

