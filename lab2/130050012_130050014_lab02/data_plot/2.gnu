set term postscript eps color

set output 'offeredLoad_throughput.eps'

#used to make the fonts appear larger;  makes the figure smaller but keeps the fonts same size
set size 0.6, 0.6

set xlabel "Offered Load (kbps)"
set ylabel "Throughput(kbps)"
set key right bottom

plot "p2.data" using 1:2 title 'Point key =' with points pt 3
