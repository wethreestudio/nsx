<!--#INCLUDE FILE="include/sql_functions.asp"-->
<%
errmsg=""
Session("errmsg")=""
' get form variables
memberid=trim(request.form("memberid"))
Session("memberid")=memberid
	
' validate form
if len(memberid)=0 then
	errmsg = errmsg & "<li>Please state your Username.</li>"
end if
Session("memberid")=memberid
if len(errmsg)>0 then
	Session("errmsg")= errmsg
	response.redirect "member_forgot.asp"
end if
	

' find userid and email address.

Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
ConnPasswords.Open Application("nsx_ReaderConnectionString")   
SQL = "SELECT * FROM subscribers WHERE (username='" & SafeSqlParameter(memberid) & "')"
'response.write SQL
CmdDD.Open SQL, ConnPasswords
if CmdDD.EOF then 
	errmsg = "<li>Not a valid Username.</li>"
	Session("errmsg")= errmsg
	CmdDD.Close
Set CmdDD = Nothing
ConnPasswords.Close
Set ConnPasswords = Nothing
	response.redirect "member_forgot.asp"
end if
email=trim(CmdDD("email"))
hintq=trim(CmdDD("password"))
uname=CmdDD("username")

if len(trim(email))=0 then 
	errmsg = "<li>No Email address supplied.  Please contact support@nsxa.com.au</li>"
	Session("errmsg")= errmsg
	CmdDD.Close
	Set CmdDD = Nothing
	ConnPasswords.Close
	Set ConnPasswords = Nothing
	response.redirect "member_forgot.asp"
end if
if isnull(email) then 
	errmsg = "<li>No Email address supplied.  Please contact support@nsxa.com.au</li>"
	Session("errmsg")= errmsg
	CmdDD.Close
	Set CmdDD = Nothing
	ConnPasswords.Close
	Set ConnPasswords = Nothing
	response.redirect "member_forgot.asp"
end if

CmdDD.Close
Set CmdDD = Nothing
ConnPasswords.Close
Set ConnPasswords = Nothing


' send email 
HR="<hr color=gray>" 
BR = "<BR>"
LT=""
LT = LT & "<font face=arial size=1 color=black><b>Your NSX Password is as follows:</b>" & BR
LT = LT & HR
LT = LT & "<b>Username:</b> " & uname &  BR 
LT = LT & HR
LT = LT & "<b>Password:</b> " & hintq &  BR
LT = LT & HR
LT = LT & "<br>Please come back and visit us soon! " & Application("nsx_SiteRootURL") & "<br></font>"

	Set MyJMail2 = Server.CreateObject("JMail.SMTPMail")
   MyJMail2.ServerAddress = Application("SMTP_Server")
   MyJMail2.Sender= "support@nsxa.com.au"
   MyJMail2.ReplyTo= "support@nsxa.com.au"
   MyJMail2.AddRecipient email
   MyJMail2.AddRecipientBCC "scott.evans@nsxa.com.au"
   MyJMail2.Subject="Your NSX Password:" 
   MyJMail2.Priority = 1 'High importance!
   MyJMail2.Body=LT
   MyJMail2.ContentType="text/html"
   MyJMail2.Execute
   set MyJMail2=nothing
   set LT = nothing



' if everything OK then redirect.
response.redirect("member_thx.asp")
%>
