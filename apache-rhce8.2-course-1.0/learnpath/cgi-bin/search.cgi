#!/bin/bash

echo "Content-type: text/html"
echo ""

echo "REQUEST_URI: $REQUEST_URI<br>"
USER=$(echo $REQUEST_URI | awk -F "=|&" '{print $2}')
PASSWD=$(echo $REQUEST_URI | awk -F "=|&" '{print $4}')

echo "User account: $USER<br>"
echo "User password: $PASSWD<br>"

echo "<br>"
echo "========== Apache Environment Variable List ==========<br>"

/bin/cat << EOF
<html>
	<head>
		<title>CGI test result page</title>
	</head>
	<body text="#090909">
		<p>
			<font size="5">
			<pre>
EOF

/bin/env

CAT << EOF
			</pre>
			</font>
		<p>
	</body>
</html>
EOF
