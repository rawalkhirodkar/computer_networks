set term postscript eps color
set output 'my-fairness.eps'

#used to make the fonts appear larger;  makes the figure smaller but keeps the fonts same size
set size 1, 1
set key right bottom
set grid

set xlabel "Node Number"
set ylabel "Throughput (kbps)"

set key off
# 1:2 implies 1st column is x and second is y
plot "run20-node-stats.txt" using 1:2 title "Throughput" with lp
