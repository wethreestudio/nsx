<%@ LANGUAGE="VBSCRIPT" %>
<% Response.Buffer = "True" %>
 <!--#INCLUDE FILE="include/sql_functions.asp"-->
 <!--#INCLUDE FILE="functions.asp"-->
 <!--#INCLUDE FILE="include/db_connect.asp"-->
<% 
Session("PASSWORDACCESSDESC") = ""

errmsg=false
USERNAME = Request.Form("username")
FNAME = Request.Form("fname")
LNAME = Request.Form("lname")
MOBILE = Request.Form("mobile")
EMAIL = Request.Form("email")
PASSWORD = Request.Form("password")
confirmpassword = Request.Form("confirmpassword")
USERNAME = Request.Form("username")

Session("username") = username
Session("password") = password
Session("fname") = fname
Session("lname") = lname
Session("mobile") = mobile
Session("email") = email


If Len(Session("username")) <= 0 Then
	Session("PASSWORDACCESS") = "No" 
	Session("PASSWORDACCESSDESC") = "User name is required"
  Response.Redirect "user_registration.asp"
  Response.End
End If



If Len(Session("fname")) <= 0 Then
	Session("PASSWORDACCESS") = "No" 
	Session("PASSWORDACCESSDESC") = "First name is required"
  Response.Redirect "user_registration.asp"
  Response.End
End If

If Len(Session("lname")) <= 0 Then
	Session("PASSWORDACCESS") = "No" 
	Session("PASSWORDACCESSDESC") = "Last name is required"
  Response.Redirect "user_registration.asp"
  Response.End
End If

If Len(Session("email")) <= 0 Then
	Session("PASSWORDACCESS") = "No" 
	Session("PASSWORDACCESSDESC") = "Email is required"
  Response.Redirect "user_registration.asp"
  Response.End
End If

If Not isEmailValid(Session("email")) Then
	Session("PASSWORDACCESS") = "No" 
	Session("PASSWORDACCESSDESC") = "Email is not a valid email address"
  Response.Redirect "user_registration.asp"
  Response.End
End If

If Len(Session("mobile")) <= 0 Then
	Session("PASSWORDACCESS") = "No" 
	Session("PASSWORDACCESSDESC") = "Mobile is required"
  Response.Redirect "user_registration.asp"
  Response.End
End If

If Len(Session("password")) <= 0 Then
	Session("PASSWORDACCESS") = "No" 
	Session("PASSWORDACCESSDESC") = "Password is required"
  Response.Redirect "user_registration.asp"
  Response.End
End If

If Session("password") <> confirmpassword Then
	Session("PASSWORDACCESS") = "No" 
	Session("PASSWORDACCESSDESC") = "Passwords do not match"
  Response.Redirect "user_registration.asp"
  Response.End
End If




	
Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdEditUser = Server.CreateObject("ADODB.Recordset")
Set rsFloodControl = Server.CreateObject("ADODB.Recordset")
  
ConnPasswords.Open Application("nsx_WriterConnectionString") 

ip_address = Request.ServerVariables("HTTP_X_FORWARDED_FOR")
If ip_address = "" Then
	ip_address = Request.ServerVariables("REMOTE_ADDR")
End If

' Flood control - Check whether an account was created from same IP within the past 5 minutes
SQL = "SELECT subid FROM usubscribers WHERE [ipaddress] = '" & ip_address & "' AND [created_on] >= DATEADD(MINUTE, -5, GETDATE())"
rsFloodControl.Open SQL, ConnPasswords, 1, 3
If rsFloodControl.EOF Then

	SQL = "SELECT subid FROM usubscribers WHERE username = '" & SafeSqlParameter(username) & "'"
	CmdEditUser.Open SQL, ConnPasswords, 1, 3

	' check if usernme already exists
	If CmdEditUser.EOF Then
		Session("FULL_NAME") = fname & " " & lname 
		SQL = "INSERT INTO usubscribers " 
		SQL = SQL & "([username],[password],[fname],[lname],[mobile],[email],[gsx],[gsxexpiry],[recorddatestamp],[recordchangeuser],[organisation],[ipaddress],[created_on]) VALUES ("
		SQL = SQL & "'" & SafeSqlParameter(username) & "',"
		SQL = SQL & "'" & SafeSqlParameter(password) & "',"
		SQL = SQL & "'" & SafeSqlParameter(fname) & "',"
		SQL = SQL & "'" & SafeSqlParameter(lname) & "',"
		SQL = SQL & "'" & SafeSqlParameter(mobile) & "',"
		SQL = SQL & "'" & SafeSqlParameter(email) & "',"
		SQL = SQL & "1,"
		SQL = SQL & "'" & SafeSqlDate(date + (3*365)) & "',"
		SQL = SQL & "'" & SafeSqlDate(now) & "',"
		SQL = SQL & "'" & SafeSqlParameter(username) & "',"
		SQL = SQL & "'" & "User MyNSX" & "',"
		SQL = SQL & "'" & ip_address & "',"
		SQL = SQL & "GETDATE()"
		SQL = SQL & ")"
		ConnPasswords.Execute SQL		
	Else
		Session("PASSWORDACCESS") = "No" 
		Session("PASSWORDACCESSDESC") = "Username already Exists. Please choose another username."
		errmsg = true
	End If
	CmdEditUser.Close
	Set CmdEditUser = Nothing
Else
	Session("PASSWORDACCESS") = "No" 
	Session("PASSWORDACCESSDESC") = "You have already created an account a few minutes ago."
	errmsg = true
	rsFloodControl.Close
	Set rsFloodControl = Nothing		
End If
	


ConnPasswords.Close
Set ConnPasswords = Nothing

if password<>confirmpassword then
	Session("PASSWORDACCESS") = "No" 
	Session("PASSWORDACCESSDESC") = "Passwords do not match."
	errmsg = true
end if
	

if errmsg then
	Response.Redirect "user_registration.asp"
else
	Session("PASSWORDACCESS") = "Yes" 
	Session("PASSWORDACCESSDESC") = ""
	Session("USR") = True
	Session("merchid") = -5
 	Response.Redirect "user_default.asp"
end if
 %>