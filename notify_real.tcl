# This script sends notification email when test is done
set msg {From: BP@testing.criticalpathsecurity.com}
append msg \n "To: " [join jared.haviland@criticalpathsecurity.com]
append msg \n "To: " [join patrick.kelley@criticalpathsecurity.com]
append msg \n "Subject: RW Test is Finished"
append msg \n\n "Real World test is complete."

exec /usr/lib/sendmail -oi -t << $msg
