<html>
<head>
</head>
<body>
<h1>Test Folder Permissions</h1>
<%
 ' <p><b>User:</b>  request.servervariables("LOGON_USER") </p>


sub TestWrite(path)
	folderName = Server.MapPath(path) & "\"
	Response.Write "<b>Testing:</b> " & folderName & " ... "
	filename = folderName & "testfile.txt"
	dim fs,tfile
	set fs=Server.CreateObject("Scripting.FileSystemObject")
	set tfile=fs.CreateTextFile(filename)
	tfile.WriteLine(folderName)
	tfile.close
	set tfile=nothing
	fs.DeleteFile(filename)
	set fs=nothing
	Response.Write "OK<br>"
End sub

TestWrite("/ftp")
TestWrite("/images")
TestWrite("/vendor")
TestWrite("/announce")

%>
</body>
</html>