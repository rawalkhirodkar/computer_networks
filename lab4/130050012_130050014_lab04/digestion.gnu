set term postscript eps color
set output 'my-thr.eps'

#used to make the fonts appear larger;  makes the figure smaller but keeps the fonts same size
set size 1, 1
set key right bottom
set grid

set xlabel "Number of Nodes"
set ylabel "Throughput (kbps)"

set key off
# 1:2 implies 1st column is x and second is y
plot "overall-stats.txt" using 1:2 title "Throughput" with lp
####################################################################################################################
set term postscript eps color
set output 'my-eff.eps'
set grid

#used to make the fonts appear larger;  makes the figure smaller but keeps the fonts same size
set size 1, 1
set key right bottom


set xlabel "Number of Nodes"
set ylabel "System Efficiency (%)"

set key off
# 1:2 implies 1st column is x and second is y
plot "overall-stats.txt" using 1:3 with lp

###################################################################################################################3
set term postscript eps color
set output 'my-drops.eps'
set grid

#used to make the fonts appear larger;  makes the figure smaller but keeps the fonts same size
set size 1, 1
set key right bottom


set xlabel "Number of Nodes"
set ylabel "Drop Percentage (%)"
set yrange [0:50]

set key off
# 1:2 implies 1st column is x and second is y
plot "overall-stats.txt" using 1:4 with lp
