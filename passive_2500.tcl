# Set connection information

set bps_host 10.10.10.20
set bps_username admin
set bps_password p@ssw0rd
set bps_testcase_name breakingpoint_passive_2500
set group 1
set title passive_2500
set sBpsPorts "1 0 1 1 1 2 1 3"
set tdate [clock format [clock seconds] -format %Y%m%d]

#
###############################################################################################################

puts -nonewline "\n=====================================================================\n\n";
puts "\nSTARTING VRT ASSESSMENT...\n\nBPS Test Case: $bps_testcase_name\nBPS Host: $bps_host\nUsername: $bps_username\n"; 

# Clear any existing BPS object
if {[info exists bps]} {itcl::delete object $bps; unset bps;}

# Connect to the BPS
puts -nonewline "=====================================================================\n\n";
puts -nonewline "Connecting to the BreakingPoint device at: $bps_host..."
set bps [bps::connect $bps_host $bps_username $bps_password -onclose exit]
puts "COMPLETED.\n"

# Clear any reservations
puts "Unreserving Ports..."
set c1 [$bps getChassis]
foreach {slot port} $sBpsPorts {
  $c1 unreservePort $slot $port
  puts "Slot $slot Port $port: unreserved\n"
}

 # Reserve ports
 puts "Reserving Ports..."
 foreach {slot port} $sBpsPorts {
   $c1 reservePort $slot $port -group $group
    puts "Slot $slot Port $port: reserved\n"
}

# Create a temporary instance of the test case
puts -nonewline "Searching for test case: $bps_testcase_name ..."
set test [$bps createTest -template $bps_testcase_name -name $bps_testcase_name];
puts "COMPLETED.\n"

# Run the test case and display test progress 
puts -nonewline "======================================================================================\n";
puts -nonewline "Test Case ($bps_testcase_name) ...STARTED\n\n"
$test run -group $group -progress "bps::textprogress stdout"
puts "--------------------------------------------------------------------------------------";
puts "Progress: 100%\t    Compiling Test Results...COMPLETED.";
puts "--------------------------------------------------------------------------------------\n";
puts "Test Case ($bps_testcase_name)...COMPLETED.\n";
puts -nonewline "=====================================================================\n\n";

set timestamp [clock format [clock sec] -format %m.%d.%Y.%H.%M.%S];
puts -nonewline "Exporting Test Case Report...STARTED\n";
# $bps_testcase_name exportReport -file $bps_testcase_name -format csv;

# $test exportReport -file /var/www/bp_reports/Group_1/$title-$timestamp.pdf -format pdf
$test exportReport -file /opt/breakingpoint_prd/passive_results/$title-$timestamp.csv -format csv


# Clear any existing port reservations
puts "Unreserving Ports..."
set c1 [$bps getChassis]
foreach {slot port} $sBpsPorts {
  $c1 unreservePort $slot $port
  puts "Slot $slot Port $port: unreserved\n"
}

itcl::delete object $bps; unset bps;

