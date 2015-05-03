set term postscript eps color
set output 'queueingDelay.eps'
set title 'Queueing Delay vs Packet Number'

#used to make the fonts appear larger;  makes the figure smaller but keeps the fonts same size
set size 0.6, 0.6

set xlabel "Packet Number"
set ylabel "Queueing Delay(in sec)"

plot 'abc.txt' using 1:2 t''
