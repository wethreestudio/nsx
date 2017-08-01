<%
Function StartsWith(string1, string2)
     StartsWith = InStr(1, string1, string2, 1) = 1
End Function
 
ip = Request.ServerVariables("HTTP_X_FORWARDED_FOR")
If ip = "" Then
	ip = Request.ServerVariables("REMOTE_ADDR")
End If

If ip = "213.229.66.60" Then Response.End
If StartsWith(ip,"109.74") Then Response.End ' Sending SQL injection attempts
If StartsWith(ip,"121.204.250") Then Response.End
If StartsWith(ip,"91.220.131.") Then Response.End
If StartsWith(ip,"218.86.50.") Then Response.End ' Sending various hack attempts
If StartsWith(ip,"63.238.28.") Then Response.End ' 63.238.28.114 Sending SQL injection attempts
If StartsWith(ip,"112.152.252.") Then Response.End ' 112.152.252.9 Sending SQL injection attempts
If StartsWith(ip,"67.184.79.222") Then Response.End ' 67.184.79.222 Sending SQL injection attempts

%>