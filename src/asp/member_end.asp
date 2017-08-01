<%

' The member_end.php script will clean up ALL cookies. 
' Some of the httponly cookies can't be removed by classic ASP

SiteRootURL = "http://" & Request.ServerVariables("SERVER_NAME")



Sub Redirect1(url)	
	response.redirect "member_end.php?return=" & Server.URLEncode(url)
End Sub


Session.Contents.RemoveAll()
Session("PASSWORDACCESS") = "No" 
Session("PASSWORDACCESSDESC") = "Logon Expired. Please logon on."
Session.Abandon
Redirect1(SiteRootURL)


%>