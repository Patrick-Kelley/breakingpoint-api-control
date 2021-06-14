set host 10.10.10.10
set user admin
set pass p@ssw0rd
set bps [bps::connect $host $user $pass]
set results_path /opt/breakingpoint_prd/results
set pdf_results_path /opt/breakingpoint_prd/pdf_results

set tdate [clock format [clock seconds] -format %Y%m%d]
set componentname security
$bps configure -name "breakingpoint $componentname" 
set component [$bps createComponent $componentname breakingpoint_${componentname}]
$component setDomain server 1 default
$component setDomain client 2 default
$bps save -force

$bps run -group 1
set result [$component result]
foreach p [$result values] { set v [$result get $p]; puts "$p == $v" }
$bps exportReport -file ${results_path}/${tdate}_breakingpoint_${componentname}_Group1_Result.csv -format csv
$bps exportReport -file ${pdf_results_path}/${tdate}_breakingpoint_${componentname}_Group1_Result.pdf -format pdf
$bps run -group 2

set result [$component result]
foreach p [$result values] { set v [$result get $p]; puts "$p == $v" }
$bps exportReport -file ${results_path}/${tdate}_breakingpoint_${componentname}_Group2_Result.csv -format csv
$bps exportReport -file ${pdf_results_path}/${tdate}_breakingpoint_${componentname}_Group2_Result.pdf -format pdf

$bps run -group 3
set result [$component result]
foreach p [$result values] { set v [$result get $p]; puts "$p == $v" }
$bps exportReport -file ${results_path}/${tdate}_breakingpoint_${componentname}_Group3_Result.csv -format csv
$bps exportReport -file ${pdf_results_path}/${tdate}_breakingpoint_${componentname}_Group3_Result.pdf -format pdf 

$bps run -group 4
set result [$component result]
foreach p [$result values] { set v [$result get $p]; puts "$p == $v" }
$bps exportReport -file ${results_path}/${tdate}_breakingpoint_${componentname}_Group4_Result.csv -format csv
$bps exportReport -file ${pdf_results_path}/${tdate}_breakingpoint_${componentname}_Group4_Result.pdf -format pdf

set msg {From: BP@test.criticalpathsecurity.com}
append msg \n "To: " [join patrick.kelley@criticalpathsecurity.com]
append msg \n "Subject: Test is Finished"
append msg \n\n Complete

exec /usr/lib/sendmail -oi -t << $msg 
