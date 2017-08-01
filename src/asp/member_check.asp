<!--#INCLUDE FILE="include/sql_functions.asp"-->
<!--#INCLUDE FILE="include/recaptcha.asp"-->
<%

if Request.ServerVariables("HTTPS") = "off" And Application("SSL") = "1" then 
	Response.Write "Error: Must use HTTPS"
	Response.End
end if

ip_address = Request.ServerVariables("HTTP_X_FORWARDED_FOR")
If ip_address = "" Then
	ip_address = Request.ServerVariables("REMOTE_ADDR")
End If


' Populating variables from the HTTP Header and the Server
Session("PASSWORDACCESSDESC") ="Please enter a valid Username &amp Password."
STATUS = Request("STATUS")
USERNAME = SafeSqlParameter(Request("USERNAME"))
PASSWORD = SafeSqlParameter(Request("PASSWORD"))
THISPAGE = "http://" & Request.ServerVariables("HTTP_HOST") & Request.ServerVariables("URL")
ip_address = SafeSqlParameter(ip_address)
	

	
	
' These are the variables you may need to change

'ConnPasswords_RuntimeUserName = "admin"
'ConnPasswords_RuntimePassword = "newcastlesx"
Dim login_attempt_count
Dim redirect_to_captcha_login
Dim conn


Set conn = Server.CreateObject("ADODB.Connection")
conn.Open Application("nsx_ReaderConnectionString")

Set cmd_check_ip = Server.CreateObject("ADODB.Recordset")
SQL = "SELECT * FROM [signin_log] WHERE [ip_address] = '" & ip_address & "' AND [expires_on] >= GETDATE() AND [failed_attempts] >= " & Application("PASSWORD_ATTEMPTS")
cmd_check_ip.Open SQL, conn
If cmd_check_ip.EOF And cmd_check_ip.BOF Then
	redirect_to_captcha_login = false
Else
	redirect_to_captcha_login = true
End If


'Dim SiteRootURL
'Dim ssl


'Response.Write "HTTPS:" & Request.ServerVariables("HTTPS") & "<BR>"
'Response.Write "SSL:" & Application("SSL") & "<BR>"
'Response.End

If Request.ServerVariables("HTTPS") = "on" And Application("SSL") = "1" Then 
	SiteRootURL = Application("nsx_SSLSiteRootURL")
	ssl = "https://"
Else
	SiteRootURL = Application("nsx_SiteRootURL")
	ssl = "http://"
End If

Session("LAST_USERNAME") = USERNAME
using_capform = False

' IF multi-part form (i.e. upload form) then don't check .form variable or an error will occur - Limitation of classic ASP
If Left(LCase(Request.ServerVariables("HTTP_CONTENT_TYPE")),Len("multipart/form")) <> "multipart/form" Then
	using_capform = NOT IsEmpty(Request.Form("capform"))
End If



If redirect_to_captcha_login = true Or using_capform Then ' Check captcha code is correct
	If (server_response <> "" Or newCaptcha) And newCaptcha = False Then
		Session("PASSWORDACCESSDESC") = "Incorrect security code. Please try again."
		Session("PopupMsg") = "Incorrect security code."
		conn.Close
		Set conn = Nothing	
		response.redirect SiteRootURL & "/member_login.asp"
		response.end
	ElseIf redirect_to_captcha_login And NOT using_capform Then ' They're using the wrong form
		Session("PASSWORDACCESSDESC") = "Please enter the a security code."
		Session("PopupMsg") = "Please enter the security code."
		conn.Close
		Set conn = Nothing	
		response.redirect SiteRootURL & "/member_login.asp"
		response.end		
	End If
End If

	
' checks to see if login form was submitted..if so its runs the validation code
If STATUS = "CHKLOGIN" Then
	'****************************************************************************
	' The following checks for a user and if it finds one it stores all their	 
	' information in session variables that will be available to you at all times
	'****************************************************************************
	If Trim(USERNAME) <> "" AND Trim(PASSWORD) <> "" Then	
		Set CmdCheckUser = Server.CreateObject("ADODB.Recordset")
		SQL = "SELECT subscribers.* FROM subscribers WHERE (USERNAME = '" & USERNAME & "') AND (PASSWORD = '" & PASSWORD & "')" 
		CmdCheckUser.Open SQL, conn
		If CmdCheckUser.EOF And CmdCheckUser.BOF Then

			Session("PASSWORDACCESS") = "No"
			Session("PASSWORDACCESSDESC") ="Please enter a valid Username &amp Password."
			Session("PopupMsg") = "Incorrect username or password."
			Session("LOGIN_USERNAME") = USERNAME		
		
			' Keep an audit of login attempts
			Set conn2 = Server.CreateObject("ADODB.Connection")
			conn2.Open Application("nsx_WriterConnectionString")	

			' Check if this IP has any failed attempts
			ip_exists = false
			Set cmd_check_ip = Server.CreateObject("ADODB.Recordset")
			SQL = "SELECT * FROM [signin_log] WHERE [ip_address] = '" & ip_address & "' AND [expires_on] >= GETDATE()"
			cmd_check_ip.Open SQL, conn2
			If cmd_check_ip.EOF And cmd_check_ip.BOF Then
				ip_exists = false
				SQL = "DELETE FROM [signin_log] WHERE [ip_address] = '" & ip_address & "'"
				set Cmd = Server.CreateObject("ADODB.Command")
				Cmd.ActiveConnection = conn2
				Cmd.CommandText = SQL
				Cmd.Execute()
				SQL = "INSERT INTO [signin_log] ([ip_address],[username],[failed_attempts],[created_on],[updated_on],[expires_on]) VALUES ('" & ip_address & "','" & USERNAME & "',1,GETDATE(), GETDATE(), DATEADD(minute, " & Application("PASSWORD_ATTEMPTS_TIMEOUT") & ", GETDATE()))"
			Else
				ip_exists = true
				SQL = "UPDATE [signin_log] SET [failed_attempts] = [failed_attempts] + 1, [updated_on]=GETDATE(), [expires_on]=DATEADD(minute, " & Application("PASSWORD_ATTEMPTS_TIMEOUT") & ", GETDATE()) WHERE [ip_address]= '" & ip_address & "'"
			End If

			
			
			set Cmd = Server.CreateObject("ADODB.Command")
			Cmd.ActiveConnection = conn2
			Cmd.CommandText = SQL
			Cmd.Execute()
			conn2.Close
			Set conn2 = Nothing			
		

			
			If redirect_to_captcha_login Or using_capform Then
				conn.Close
				Set conn = Nothing	
				response.redirect SiteRootURL & "/member_login.asp"
				response.end
			Else
				If IsEmpty(Session("LOGIN_COUNT")) Then
					Session("LOGIN_COUNT") = 1
					login_attempt_count = 1
				Else
					Session("LOGIN_COUNT") = CInt(Session("LOGIN_COUNT")) + 1
					login_attempt_count = CInt(Session("LOGIN_COUNT"))
				End If
				IF Login_attempt_count >= Application("PASSWORD_ATTEMPTS") Then
					'conn2.Close
					'Set conn2 = Nothing	
					'conn.Close
					Set conn = Nothing	
					response.redirect SiteRootURL & "/member_login.asp"
					response.end					
				End If			
			End If
		Else
			' Clear failed login attempts
			Set conn3 = Server.CreateObject("ADODB.Connection")
			conn3.Open Application("nsx_WriterConnectionString")				
			SQL = "DELETE FROM [signin_log] WHERE [ip_address] = '" & ip_address & "'"
			set Cmd = Server.CreateObject("ADODB.Command")
			Cmd.ActiveConnection = conn3
			Cmd.CommandText = SQL
			Cmd.Execute()
			' Keep a log of this login
			SQL = "INSERT INTO [signin_log2] ([ip_address],[username],[created_on]) VALUES ('" & ip_address & "','" & USERNAME & "',GETDATE())"
			set cmd_log_signin = Server.CreateObject("ADODB.Command")
			cmd_log_signin.ActiveConnection = conn3
			cmd_log_signin.CommandText = SQL
			cmd_log_signin.Execute()
			conn3.Close
			Set conn3 = Nothing				
			
			Session("REDIRECT_CAPTCHA_LOGIN") = 0
			Session("LOGIN_COUNT") = 1
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
		CmdCheckUser2.Open SQL, conn
		If CmdCheckUser2.EOF And CmdCheckUser2.BOF Then
			Session("PASSWORDACCESS") = "No"
			Session("PASSWORDACCESSDESC") ="Please enter a valid Username &amp Password."
		Else
			Session("comments") = CmdCheckUser2("comments")
		End If
		CmdCheckUser2.Close
		Set CmdCheckUser2 = Nothing
		conn.Close
		Set conn = Nothing
	Else
		Session("PASSWORDACCESS") = "No"
		Session("PASSWORDACCESSDESC") ="Please enter your username &amp password."
		Session("PopupMsg") = "Empty username or password."
	End If
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
If SESSION("IP_ADDRESS") <> ip_address And Len(SESSION("IP_ADDRESS") & "") > 0 Then
	Session.Contents.RemoveAll()
	Session("PASSWORDACCESS") = "No" 
	Session("PASSWORDACCESSDESC") = "Your IP address has changed. Please logon on again."		
	response.redirect SiteRootURL & "/default.asp"
	response.end
End If


'**************************************************************
' The following checks to see if a user has been validated yet 
' If not it will show the login screen						   
'**************************************************************	
If Session("PASSWORDACCESS") <> "Yes" Then
	Session("PASSWORDACCESS") = "No"
	Session("PASSWORDACCESSDESC") ="Please enter a valid Username &amp Password."
	response.redirect SiteRootURL & "/default.asp"
	response.end
End If
	
'*********************
' clear out variables	
'*********************
Session("PASSWORDACCESSDESC") = "" 'Nothing

If using_capform And Session("PASSWORDACCESS") = "Yes" Then
	response.redirect SiteRootURL & "/default.asp"
End If

%>