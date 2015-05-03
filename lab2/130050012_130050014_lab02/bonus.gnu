set term postscript eps color

set output 'bonus.eps'

#used to make the fonts appear larger;  makes the figure smaller but keeps the fonts same size
set size 0.6, 0.6
set key right bottom


set xlabel "Packet Number(count unit)"
set ylabel "Queuing Delay(secs)"

plot "plot_queue.data" using 2:1 t'Bonus Plot' with points pt 1

