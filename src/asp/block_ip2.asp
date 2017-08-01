<%

Function StartsWith(string1, string2)
     StartsWith = InStr(1, string1, string2, 1) = 1
End Function
 
ip = Request.ServerVariables("HTTP_X_FORWARDED_FOR")
If ip = "" Then
	ip = Request.ServerVariables("REMOTE_ADDR")
End If

If ip = "213.229.66.60" Then Response.End
If StartsWith(ip,"109.74") Then Response.End
If ip = "109.74.3.24" Then Response.End
%>