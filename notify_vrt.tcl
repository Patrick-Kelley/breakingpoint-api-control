# This script sends an email notification when test is complete
set msg {From: BP@testing.criticalpathsecurity.com}
append msg \n "To: " [join jared.haviland@criticalpathsecurity.com]
append msg \n "To: " [join patrick.kelley@criticalpathsecurity.com]
append msg \n "Subject: VRT Test is Finished"
append msg \n\n "VRT Supplement test is complete."

exec /usr/lib/sendmail -oi -t << $msg
