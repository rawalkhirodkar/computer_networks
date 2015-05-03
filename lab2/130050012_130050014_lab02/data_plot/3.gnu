set term postscript eps color

set output 'offeredLoad_averageEndToEndDelay.eps'

#used to make the fonts appear larger;  makes the figure smaller but keeps the fonts same size
set size 0.6, 0.6

set xlabel "Offered Load (kbps)"
set ylabel "Average End to End Delay(secs)"
set key right bottom

plot "p3.data" using 1:2 title 'Point key =' with points pt 3
