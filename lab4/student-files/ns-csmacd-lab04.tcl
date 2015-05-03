set opt(bw)	1Mb
set opt(delay)	0ms
set opt(ll)	LL  
set opt(ifq)	Queue/DropTail
set opt(mac)	Mac/802_3
set opt(chan)	Channel
set opt(nn) 5; #number of nodes, LL is link layer type
set opt(seed) 12345;#seed for the experiment
set opt(fin) 10.5;

proc usage {} {
    global argv0
    puts "Usage: $argv0 \[-nn NumberNodes\] \[-seed Seed\] \n"
    exit 1
}

proc getopt {argc argv} {
    global opt
    lappend optlist seed nn
    if {$argc < 4} usage
    for {set i 0} {$i < $argc} {incr i} {
	set arg [lindex $argv $i]
	if {[string range $arg 0 0 ] != "-"} continue
	set name [string range $arg 1 end]
        set opt($name) [lindex $argv [expr $i+1]]
        }
}

getopt $argc $argv

proc create-topology {} {
	global ns opt
	global lan node
        set num $opt(nn)
	for {set i 0} {$i <= $num} {incr i} {
		set node($i) [$ns node]
		lappend nodelist $node($i)		
	}
    
	set lan [$ns make-lan -trace on $nodelist $opt(bw) $opt(delay) $opt(ll) $opt(ifq) $opt(mac) $opt(chan)]
    
    set node6 [$ns node]
    $ns duplex-link $node6 $node(0) 10Mb 2ms DropTail
    $ns duplex-link-op $node6 $node(0) orient right
}


proc create-traffic {} {
    global ns opt
    global lan node
    set num $opt(nn)
    
    for {set i 1} {$i <= $num} {incr i} {
	set udp_($i) [new Agent/UDP]
	$ns attach-agent $node($i) $udp_($i)
	set null_($i) [new Agent/Null]
	$ns attach-agent $node(0) $null_($i)
	
	set cbr_($i) [new Application/Traffic/CBR]
	# packet size is in bytes
	$cbr_($i) set packetSize_ 1000
	# 100kb means 100 kilo bits per sec
	set rate 100Kb
	$cbr_($i) set rate_ $rate
	$cbr_($i) attach-agent $udp_($i)
	$ns connect $udp_($i) $null_($i)
	$ns at 0.5 "$cbr_($i) start"
	$ns at $opt(fin) "$cbr_($i) stop"
}
}

#Define a 'finish' procedure
proc finish {} {

	exec nam out.nam &
        exit 0
}


#Create a simulator object
set ns [new Simulator]
ns-random $opt(seed)

set nf [open out.nam w]
$ns namtrace-all $nf

set tracefd     [open csmacd.tr w]
$ns trace-all   $tracefd

create-topology
create-traffic

$ns at $opt(fin) "finish"

#Run the simulation
$ns run

