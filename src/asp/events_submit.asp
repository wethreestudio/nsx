<!--#INCLUDE FILE="include/sql_functions.asp"-->
<%
'------------------------------------------
' Adjust textarea box formatting
'str: the string to be adjusted
Function AdjTextArea(str)
	AdjTextArea = trim(Replace(str & " ", vbCrLf, "<BR>"))
	AdjTextArea = trim(Replace(AdjTextArea & " ", "''", "'"))

End Function
errmsg=""
wherefrom= ucase(request.servervariables("HTTP_REFERER"))
if wherefrom<>ucase(Application("nsx_SiteRootURL")) & "/EVENTS_NOTIFY2.ASP" then errmsg=errmsg & "<li>Unauthorised</li>"
title = trim(Request.Form("title") & " ")
if title="" THEN errmsg=errmsg & "<li>Title must not be blank</li>"
if (instr(title,".") >0 and instr(title,"@") > 0) then errmsg=errmsg & "<li>Title must not be an email address</li>"
text = trim(Request.Form("text") & " ")
if text="" THEN errmsg=errmsg & "<li>Please enter some details</li>"


badcomm = instr(request.form("text"),"halloween")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(request.form("text"),"alice")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(request.form("text"),"xoomer")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(request.form("text"),"blog")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(request.form("text"),"phentermine")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(request.form("text"),"anyboard")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(request.form("text"),"viagara")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(request.form("text"),"replicawatches")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(request.form("text"),"kostenloses")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(request.form("text"),"soduko")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(request.form("text"),"foren")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"



if errmsg = "" then

	
	Set ConnPasswords = Server.CreateObject("ADODB.Connection")
	Set CmdAdduser = Server.CreateObject("ADODB.Recordset")
	ConnPasswords.Open Application("nsx_WriterConnectionString")
	SQL = "SELECT * FROM events"
	CmdAdduser.Open SQL, ConnPasswords, 1, 3
	CmdAdduser.AddNew
	CmdAdduser.Update
	ID = CmdAdduser("id")
	CmdAdduser.Close
	Set CmdAdduser = Nothing
	ConnPasswords.Close
	Set ConnPasswords = Nothing



	' now save the record details to the database
	errmsg=""
	Set ConnPasswords = Server.CreateObject("ADODB.Connection")
	Set CmdEditUser = Server.CreateObject("ADODB.Recordset")
	ConnPasswords.Open Application("nsx_ReaderConnectionString")
	SQL = "SELECT * FROM events WHERE (id = " & SafeSqlParameter(ID) & ")"
	CmdEditUser.Open SQL, ConnPasswords, 1, 3
 

	CmdEditUser.Fields("EventDate") = Now


	title = trim(Request.Form("title"))
	if title="" THEN
	errmsg = errmsg & "<li>Please enter a Title.</li>"
	Else
	CmdEditUser.Fields("EventTitle") = Title
	END IF


	text = trim(Request.Form("text"))
	if text="" THEN
	CmdEditUser.Fields("eventtext") = NULL
	Else
	CmdEditUser.Fields("eventtext") = text
	END IF


	source = trim(Request.Form("source"))
	if source="" THEN
	CmdEditUser.Fields("eventsource") = NULL
	Else
	CmdEditUser.Fields("eventSource") = source
	END IF
 
	precise = Request.Form("precise")
	if precise="" THEN
	CmdEditUser.Fields("eventprecise") = NULL
	Else
	CmdEditUser.Fields("eventprecise") = precise
	END IF

	' really event date & place
	author = Request.Form("author")
	if author="" THEN
	CmdEditUser.Fields("eventauthor") = NULL
	Else
	CmdEditUser.Fields("eventauthor") = author
	END IF
 
	eventsurl = Request.Form("eventsurl")
	if eventsurl="" THEN
	CmdEditUser.Fields("eventurl") = NULL
	Else
	CmdEditUser.Fields("eventurl") = eventsurl
	END IF

	CmdEditUser.Fields("RecordDateStamp") = Now - ( 3 *365)
	CmdEditUser.Fields("RecordChangeUser") = "NSX Home Page"

	CmdEditUser.Update
	CmdEditUser.Close
	Set CmdEditUser = Nothing
	ConnPasswords.Close
	Set ConnPasswords = Nothing


 
 	' need to email us to see new entry
end if
    cr = vbCRLF & "<BR>"
     HTML = "<!DOCTYPE HTML PUBLIC""-//IETF//DTD HTML//EN"">"
    HTML = HTML & "<html>"
    HTML = HTML & "<head>" 
    HTML = HTML & "<title>NSX EVENT SUBMISSION</title>"
    HTML = HTML & "</head>"
    HTML = HTML & "<body bgcolor=""FFFFFF"" >"
    
    if Request.Form <> "" then  
			HTML = HTML & cr & cr & "FORM VALUES:  " & cr & cr 
				For each x in Request.Form
      			HTML = HTML & ucase(x) & ": " & Request.Form(x) & cr 			
    			next
    			HTML = HTML & cr & cr 
 		end if

    
    
    
   HTML = HTML & "<br><br><b>Message Sent:</b> " & formatdatetime(Now,1) & " " & formatdatetime(now,3)
    	HTML = HTML &  cr & "REFERRER: " & request.servervariables("HTTP_REFERER")
    	HTML = HTML &  cr & "HTTP_USER_AGENT: " & request.servervariables("HTTP_USER_AGENT")
		HTML = HTML &  cr & "HTTP_CONTENT_LENGTH: " & request.servervariables("HTTP_CONTENT_LENGTH")
		HTML = HTML &  cr & "HTTP_CONTENT_TYPE: " & request.servervariables("HTTP_CONTENT_TYPE")
		HTML = HTML &  cr & "REMOTE_HOST: " & request.servervariables("REMOTE_HOST")
		HTML = HTML &  cr & "REMOTE_ADDR: " & request.servervariables("REMOTE_ADDR")
		HTML = HTML &  cr & "Authorisation: " & errmsg

    
    HTML = HTML & "</body>"
    HTML = HTML & "</html>"
    'Response.write HTML 
    Set MyJMail2 = Server.CreateObject("JMail.SMTPMail")
    MyJMail2.ServerAddress = Application("SMTP_Server") & ":" & Application("SMTP_Port")
    MyJMail2.Sender= "events@nsxa.com.au" 
    MyJMail2.SenderName = "NSX Event"  
    MyJMail2.AddRecipient "scott.evans@nsxa.com.au"
    MyJMail2.Subject="NSX Event Submitted"
    MyJMail2.ContentType="text/html"
    MyJMail2.Priority = 1 'High importance!
    MyJMail2.Body=HTML
    MyJMail2.Execute
    set MyJMail2=nothing
    set HTML = nothing




Response.Redirect "events_thx.asp?errmsg=" & errmsg


%>
