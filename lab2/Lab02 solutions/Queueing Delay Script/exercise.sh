#!/bin/bash
./test.awk udp-120k.tr > abc.txt
./script.awk abc.txt
gnuplot plot.gnu
