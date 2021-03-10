#!/bin/bash

echo "Content-type: text/html"
echo ""
# Note: the previous blank line MUST be added following first line.

echo "Hello World!<br>"
echo "<br>"
# Use <br> to be blank line not "\n".
# netstat -ntl
# Previous command ERROR: Permission denied.

echo "Client agent is: <font color="#FF00FF">$HTTP_USER_AGENT</font>"
# HTTP_USER_AGENT is apache environment variable.
