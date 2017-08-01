<!--#INCLUDE FILE="include/sql_functions.asp"--><%
' Populating variables from the HTTP Header and the Server

ip_address = Request.ServerVariables("HTTP_X_FORWARDED_FOR")
If ip_address = "" Then
	ip_address = Request.ServerVariables("REMOTE_ADDR")
End If

Session("PASSWORDACCESSDESC") ="Please enter a valid Username &amp Password."
STATUS = Request("STATUS")
USERNAME = SafeSqlParameter(Request("USERNAME"))
PASSWORD = SafeSqlParameter(Request("PASSWORD"))
THISPAGE = "http://" & Request.ServerVariables("HTTP_HOST") & Request.ServerVariables("URL")
	
' These are the variables you may need to change

ConnPasswords_RuntimeUserName = "admin"
ConnPasswords_RuntimePassword = "newcastlesx"
	
' checks to see if login form was submitted..if so its runs the validation code
If STATUS = "CHKLOGIN" Then
	
	'****************************************************************************
	' The following checks for a user and if it finds one it stores all their	 
	' information in session variables that will be available to you at all times
	'****************************************************************************
	
	
	Set ConnPasswords = Server.CreateObject("ADODB.Connection")
	Set CmdCheckUser = Server.CreateObject("ADODB.Recordset")
 
	ConnPasswords.Open Application("nsx_ReaderConnectionString")
	'SQL = "SELECT fname, fullname, org, username, password, nsx, admin, csx, nsxcode, subid, realstatus, realstatusdesc FROM subscribers WHERE (USERNAME = '" & USERNAME & "') AND (PASSWORD = '" & PASSWORD & "')"
	SQL = "SELECT subscribers.* FROM subscribers WHERE (USERNAME = '" & USERNAME & "') AND (PASSWORD = '" & PASSWORD & "')"
	CmdCheckUser.Open SQL, ConnPasswords
	
	If CmdCheckUser.EOF And CmdCheckUser.BOF Then
		Session("PASSWORDACCESS") = "No"
		Session("PASSWORDACCESSDESC") ="Please enter a valid Username &amp Password."
	Else
		SESSION("IP_ADDRESS") = ip_address
		Session("PASSWORDACCESS") = "Yes"
		Session("ACCESS_LEVEL") = CmdCheckUser("realstatus")
		Session("FULL_NAME") = CmdCheckUser("fullname")
		Session("PASSWORD") = CmdCheckUser("password")
		Session("USERNAME") = CmdCheckUser("username")
		Session("ADMIN") = CmdCheckUser("admin") ' nsx admin
		Session("NSX") = CmdCheckUser("nsx") ' nsx staff
		Session("ORG") = CmdCheckUser("org")
		Session("FNAME") = CmdCheckUser("fname")
		
		Session("CSX") = CmdCheckUser("csxstatus") ' companies
		Session("subid") = CmdCheckUser("subid")
		Session("PASSWORDACCESSDESC") = CmdCheckUser("realstatusdesc")
		Session("BRK") = CmdCheckUser("msxstatus") ' brokers
		Session("ADV") = CmdCheckUser("dsxstatus") ' advisers
		Session("FAC") = CmdCheckUser("facstatus") ' facilitators
		Session("USX") = CmdCheckUser("usx") 	   ' upload access
		Session("USR") = CmdCheckUser("gsx") 	   ' user access
		Session("USREXPIRY") = CmdCheckUser("gsxexpiry") ' user access
		Session("MOBILE") = CmdCheckUser("mobile") 	   ' user access
		Session("PORTFOLIO") = CmdCheckUser("portfolio") 	   ' user access
		Session("PORTFOLIOPARAMETERS") = CmdCheckUser("portfolioparameters") 	   ' user access
		Session("SMSEOD") = CmdCheckUser("smseod") 	   ' user access
		Session("EMAILEOD") = CmdCheckUser("emaileod") 	   ' user access
		Session("SMSINDICES") = CmdCheckUser("smsindices") 	   ' user access
		Session("EMAILINDICES") = CmdCheckUser("emailindices") 	   ' user access
		Session("nsxcode") = ucase(CmdCheckUser("nsxcode")) 
		Session("phone") = CmdCheckUser("phone")
		Session("fax") = CmdCheckUser("fax")
		Session("email") = CmdCheckUser("email")
		Session("subid") = CmdCheckUser("subid")
		'Session("comments") = CmdCheckUser("comments")
		
		Session("FAC") = 1 
		Session("MerchID") = -4
		if Session("CSX") = 1 then Session("MerchID") = -1
		if Session("ADV") = 1 then Session("MerchID") = -2
		if Session("BRK") = 1 then Session("MerchID") = -3
		if Session("USR") = True then Session("MerchID") = -5
		if (Session("admin") = True or Session("nsx") = true) then Session("MerchID") = 0
	End If
	
	CmdCheckUser.Close
	Set CmdCheckUser = Nothing
	
	
	Set CmdCheckUser2 = Server.CreateObject("ADODB.Recordset")
	SQL = "SELECT * FROM usubscribers WHERE (USERNAME = '" & USERNAME & "') AND (PASSWORD = '" & PASSWORD & "')"
	CmdCheckUser2.Open SQL, ConnPasswords

	If CmdCheckUser2.EOF And CmdCheckUser2.BOF Then
		Session("PASSWORDACCESS") = "No"
		Session("PASSWORDACCESSDESC") ="Please enter a valid Username &amp Password."
	Else
		Session("comments") = CmdCheckUser2("comments")
	end if

	CmdCheckUser2.Close
	Set CmdCheckUser2 = Nothing
	ConnPasswords.Close
	Set ConnPasswords = Nothing
	
	'*********************
	'*********************
	
End If	
	
'**************************************************************
' The following checks for proper Access If Using Access Levels
' You may add your own custom access levels					   
'**************************************************************
' *** Regulatory News access
If CHECKFOR = "RTA" Then
	If Session("ACCESS_LEVEL") = 1 or Session("ADMIN") = "True" or Session("NSX") = "True" Then
	Else
		Session("PASSWORDACCESS") = "No"
	End If
End	IF
' *** company services access
If CHECKFOR = "CSX" Then
	If Session("CSX") = 1 or Session("ADMIN") = "True" or Session("NSX") = "True" Then
	Else
		Session("PASSWORDACCESS") = "No"
	End If
End	IF
' *** broker services access
If CHECKFOR = "BRK" Then
	If Session("BRK") = 1 or Session("ADMIN") = "True" or Session("NSX") = "True" Then
	Else
		Session("PASSWORDACCESS") = "No"
	End If
End	IF
' *** nominated adviser services access
If CHECKFOR = "ADV" Then
	If Session("ADV") = 1 or Session("ADMIN") = "True" or Session("NSX") = "True" Then
	Else
		Session("PASSWORDACCESS") = "No"
	End If
End	IF
' *** nominated facilitator services access
If CHECKFOR = "FAC" Then
	If Session("FAC") = 1 or Session("ADMIN") = "True" or Session("NSX") = "True" Then
	Else
		Session("PASSWORDACCESS") = "No"
	End If
End	IF
	' *** user services access
If CHECKFOR = "USR" Then
	If Session("CSX") = 1 or Session("BRK") = 1 or Session("ADV") = 1 or Session("FAC") = 1 or Session("USR") = True or Session("ADMIN") = "True" or Session("NSX") = "True" Then
	Else
		Session("PASSWORDACCESS") = "No"
	End If
End	IF

' Upload authority.
If CHECKFOR = "UPL" Then
	If Session("USX") = "True" or Session("ADMIN") = "True" or Session("NSX") = "True" Then
	Else
		Session("PASSWORDACCESS") = "No"
	End If
End	IF
' *** nsx staff access
If CHECKFOR = "NSX" Then
	If Session("NSX") = "True" or Session("ADMIN") = "True" Then
	Else
		Session("PASSWORDACCESS") = "No"
	End If
End	IF


' *** nsx administration access
If CHECKFOR = "ADMIN" Then
	If Session("ADMIN") = "False" Then
		Session("PASSWORDACCESS") = "No"
	End If
End	IF

'**************************************************************
' If the user's IP address has changed, log them off						   
'**************************************************************	
If SESSION("IP_ADDRESS") <> ip_address Then
	Dim ret_url
	ret_url = session("returnurl")
	Session.Contents.RemoveAll()
	If Len(ret_url) <= 0 Then ret_url = "/default.asp"
	Session("PASSWORDACCESS") = "No" 
	Session("PASSWORDACCESSDESC") = "IP address has changed. Please logon on again."	
	response.redirect ret_url
	response.end
End If

'**************************************************************
' The following checks to see if a user has been validated yet 
' If not it will show the login screen						   
'**************************************************************
If Session("PASSWORDACCESS") <> "Yes" Then
	Session("PASSWORDACCESS") = "No"
	Session("PASSWORDACCESSDESC") ="Please enter a valid Username &amp Password."
	response.redirect session("returnurl")
	response.end
End If
	
'*********************
' clear out variables	
'*********************
Session("PASSWORDACCESSDESC") = "" 'Nothing

%>