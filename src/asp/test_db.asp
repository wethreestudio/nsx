<html>
<head>
</head>
<body>
<h1>Test SQL Server DB Connection</h1>
<%
Set ObjConn = Server.CreateObject("ADODB.Connection")
 
ObjConn.Open "Driver={SQL Server Native Client 10.0};Server=localhost;Database=nsx;Uid=nsx_user;Pwd=nsx_pass;"   
Set objRS = Server.CreateObject("ADODB.Recordset")
'objRS.Open "SELECT * FROM [nsx].[dbo].[advisers]", objConn, adOpenKeyset, adLockOptimistic, adCmdText
objRS.Open "SELECT * FROM [nsx].[dbo].[advisers]", objConn
items = objRS.RecordCount
While Not objRS.EOF
  response.write(objRS("adName") & "<br>")
  objRS.MoveNext
Wend
objRS.Close
%>
</body>
</html>