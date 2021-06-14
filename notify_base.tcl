# This script sends notification email when base test is done
set msg {From: BP@testing.criticalpathsecurity.com}
append msg \n "To: " [join jared.haviland@criticalpathsecurity.com]
append msg \n "To: " [join patrick.kelley@criticalpathsecurity.com]
append msg \n "Subject: Base Test is Finished"
append msg \n\n "Base Sourcefire test is complete."

exec /usr/lib/sendmail -oi -t << $msg
