<%@ LANGUAGE="VBSCRIPT" %>
<% ID = session("subid") 

CHECKFOR = "USR" 
on error resume next
MerchID = Session("MerchID")
if len(MerchID)=0 then
	MerchID = request("MerchID")
end if
if len(MerchID)=0 then 
	Session("errmsg")="Logon Expired. Please logon on."
	response.redirect "default.asp"
end if
%>
<!--#INCLUDE FILE="member_check.asp"-->

<%
' send a test email and mobile message
email=trim(Session("email") & " ")
email=replace(email," ","")
mobiles=trim(Session("mobile") & " ")
mobiles=replace(mobiles," ","")
username=session("username")
password=session("password")
'if len(mobile)<>0 then
'	mobile="+61" & right(mobile,len(mobile)-1)
'end if
cr = vbCRLF




pssword = trim(request("pss"))
errmsg="OK"

'Response.Write email & ";" & mobiles & ";" & username & ";" & password & ";" & pssword
'Response.End

' must have a mobile
if pssword="nsxa" and (len(mobiles)<>0) then

	'toNumber is an array of phone numbers 
	toNumber = mobiles 
	dim fromNumber 
	fromNumber ="+61412433570" 
	dim pusername 
	pusername = "sms@nsxa.com.au" 
	dim ppassword 
	ppassword = "smspassword" 
	dim messageText 
	messageText = session("fname") & " " & "NSX Welcomes you to the portfolio service!" & cr
	messageText = messageText & "Your username is: " & username & cr
	messageText = messageText & "Your password is: " & password & cr
	messageText = trim(left(messageText ,160) & " ")

	
	Set MyJMail7 = Server.CreateObject("JMail.SMTPMail")
    MyJMail7.ServerAddress = Application("SMTP_Server") & ":" & Application("SMTP_Port")
    MyJMail7.Sender= "sms@nsxa.com.au"
    MyJMail7.ReplyTo = "sms@nsxa.com.au"
    MyJMail7.SenderName = "NSX"
    MyJMail7.Subject="NSX Alert Service Text Message"
    MyJMail7.Priority = 1 'High importance!
	' send off email for  sms several at a time
	MyJMail7.Body=MessageText

		mobi = trim(tonumber & " ")
		mobi = replace(mobi & " "," ","")	

		if left(mobi,2)="04" then mobi = "61" & mid(mobi,2,len(mobi))

		MyJMail7.AddRecipient mobi & "@email.smsglobal.com"
		MyJMail7.AddRecipientBCC "sms@nsxa.com.au"
		MyJMail7.Execute
	
	set MyJMail7=nothing
	errmsg = errmsg & " SMS to " & session("mobile") & " sent. " 

	'Response.Write(test) 
	else
	errmsg="test failed: no mobile number set. " & session("mobile")
end if


if len(email)<>0 and pssword="nsxa" then

	eml = session("fname") & " " & "NSX Welcomes you to the portfolio service!" & cr
	eml = eml & "Your username is: " & username & cr
	eml = eml & "Your password is: " & password & cr

    Set MyJMail6 = Server.CreateObject("JMail.SMTPMail")
    MyJMail6.ServerAddress = Application("SMTP_Server") & ":" & Application("SMTP_Port")
    MyJMail6.Sender= "sms@nsxa.com.au"
    MyJMail6.ReplyTo = "sms@nsxa.com.au"
    MyJMail6.SenderName = "NSX"
    MyJMail6.AddRecipient email
	MyJMail6.AddRecipientBCC "sms@nsxa.com.au"
    MyJMail6.Subject="NSX Alert Service Test Message"
    MyJMail6.Priority = 1 'High importance!
    MyJMail6.Body=eml
    MyJMail6.Execute
    set MyJMail6=nothing
   	set eml = nothing 
   	
   	errmsg = errmsg & " Email to " & session("email") & " sent. "
   	   	
   	else
	errmsg=errmsg & " test failed: no email address set. " & session("email")
end if
session("errmsg") = errmsg
If Len(Request.QueryString("return")) <= 0 Then
  response.redirect "user_market_summaries.asp"
Else
  response.redirect Request.QueryString("return")
End If


%> 

