#Create a simulator object
set ns [new Simulator]

#Define different colors for data flows (for NAM)
$ns color 1 Blue

#Open the NAM trace file
set nf [open out.nam w]
$ns namtrace-all $nf

# Open the trace file
set f [open udp-120k.tr w]
$ns trace-all $f

#Define a 'finish' procedure
proc finish {} {
    global ns nf f
    $ns flush-trace
    #Close the NAM trace file
    close $nf
    # Close the trace file
    close $f
    #Execute NAM on the trace file
    exec nam out.nam &
    exit 0
}

#Create three nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]

$n0 label "S"
$n1 label "R"
$n2 label "D"

#Create links between the nodes
$ns duplex-link $n0 $n1 1Mb 50ms DropTail
$ns duplex-link $n1 $n2 100Kb 5ms DropTail

$ns duplex-link-op $n0 $n1 label "Link-1"
$ns duplex-link-op $n1 $n2 label "Link-2"

#Set Queue Size of link (n1-n2) to 10
$ns queue-limit $n1 $n2 10


#Give node position (for NAM)
$ns duplex-link-op $n0 $n1 orient right
$ns duplex-link-op $n1 $n2 orient right

#Monitor the queue for link (n1-n2). (for NAM)
$ns duplex-link-op $n1 $n2 queuePos 0.5

#Setup a UDP connection
set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0

#Setup a Traffic sink
set sink [new Agent/Null]
$ns attach-agent $n2 $sink


#Setup a CBR over UDP connection
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 150
$cbr0 set interval_ 0.01
$cbr0 attach-agent $udp0

$ns connect $udp0 $sink

#Start and stop FTP
$ns at 0.5 "$cbr0 start"
$ns at 10.5 "$cbr0 stop"

#Call the finish procedure after 51 seconds of simulation time
$ns at 11.0 "finish"

#Run the simulation
$ns run

