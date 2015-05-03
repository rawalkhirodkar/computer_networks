set term postscript eps color
set output 'EnqToDeq.eps'

#used to make the fonts appear larger;  makes the figure smaller but keeps the fonts same size
set size 1, 1
set key right bottom
set grid

set xlabel "Packet Number"
set ylabel "EnqToDeq (secs)"

set key off
# 1:2 implies 1st column is x and second is y
plot "run20-delay-stats.txt" using 1:2 title "EnqToDeq" with points pt 1


set term postscript eps color
set output 'DeqToRecv.eps'

#used to make the fonts appear larger;  makes the figure smaller but keeps the fonts same size
set size 1, 1
set key right bottom
set grid

set xlabel "Packet Number"
set ylabel "DeqToRecv (secs)"

set key off
# 1:2 implies 1st column is x and second is y
plot "run20-delay-stats.txt" using 1:3 title "DeqToRecv" with points pt 1
