 <!--#INCLUDE FILE="include_all.asp"--><%
  
  
If Session("feedbackkey") <>  request.form("feedbackkey") Then
  Response.AddHeader "Location", "/"
  Response.Write "Session Expired"
  Response.End
End If 
     
'------------------------------------------
' Adjust textarea box formatting
'str: the string to be adjusted
Function AdjTextArea(str)
	AdjTextArea = trim(Replace(str & " ", vbCrLf, "<BR>"))
	AdjTextArea = trim(Replace(AdjTextArea & " ", "''", "'"))
End Function

messagetype = request.form("messagetype")
subject = request.form("subject")
subjectother = trim(request.form("subjectother") & " ")
comments = adjtextarea(trim(request.form("comments") & " "))
username = request.form("username")
if len(username) = 0 then username = request.form("contactname")
useremail = request.form("useremail")
if len(useremail) = 0 then useremail = request.form("contactemail")
usertel = trim(request.form("usertel") & " ")
contact = trim(request.form("contactrequested") & " ")
additionalcomments = trim(request.form("contactrequested") & " ")

If len(additionalcomments) <> 0 Then 
  errmsg=errmsg & "<li>Unauthorised</li>"
End If
     
errmsg=""
wherefrom= ucase(request.servervariables("HTTP_REFERER"))
title = trim(username & " ")
if title="" THEN errmsg=errmsg & "<li>Name must not be blank</li>"
if (instr(title,".") >0 and instr(title,"@") > 0) then errmsg=errmsg & "<li>Name must not be an email address</li>"
title = trim(useremail & " ")
if title="" THEN errmsg=errmsg & "<li>Email must not be blank</li>"

page_title = "NSX Feedback"
alow_robots = "no"
%>
<!--#INCLUDE FILE="header.asp"-->
<%
if len(errmsg) = 0 then
 ' Send email notification to NSX to tell them its there.

 
Dim MyJMail2
Dim HTML

HTML = "<!DOCTYPE HTML PUBLIC""-//IETF//DTD HTML//EN"">"
HTML = HTML & "<html>"
HTML = HTML & "<head>" 
HTML = HTML & "<title>FEEDBACK for NSX</title>"
HTML = HTML & "</head>"
HTML = HTML & "<body bgcolor=""FFFFFF"" >"
HTML = HTML & "<p><font size =""2"" face=""Arial"" color=navy>"
HTML = HTML & "<b>From: </b> " & username & "  [<a href=mailto:" & useremail & ">" & useremail & "</a>]"
if usertel<>"" then HTML = HTML & "<br><b>Phone:</b> " & usertel 
if contact<>"" then HTML = HTML & "<br><b>Contact:</b> " & contact 

HTML = HTML & "<br><b>Message Type:</b> " & messagetype
HTML = HTML & "<br><b>Subject:</b> " & subject

if subjectother <> "" then HTML = HTML & ", " & subjectother
if comments<>"" then HTML = HTML & "<br><b>Comments:</b> " & "<br>" & comments 

HTML = HTML & "<br><br><b>Message Sent:</b> " & formatdatetime(Now,1) & " " & formatdatetime(now,3) & "<br><br>" & errmsg
HTML = HTML & "<br><br><b>Page:</b> " & wherefrom 
HTML = HTML & "<br><br><b>IP Address:</b> " & Request.ServerVariables("remote_addr") 
HTML = HTML & "</body>"
HTML = HTML & "</html>"

'Response.write HTML
Set MyJMail2 = Server.CreateObject("JMail.SMTPMail")
MyJMail2.ServerAddress = Application("SMTP_Server") & ":" & Application("SMTP_Port")
MyJMail2.Sender= "notices@nsxa.com.au" ' useremail 
MyJMail2.SenderName = username    
MyJMail2.AddRecipientBCC "complaints@nsx.com.au"
'MyJMail2.AddRecipientCC useremail
MyJMail2.Subject="FEEDBACK for NSX"
MyJMail2.ContentType="text/html"
MyJMail2.Priority = 1 'High importance!
MyJMail2.Body=HTML
MyJMail2.Execute
set MyJMail2=nothing
set HTML = nothing

Session("feedbackkey") = ""
'response.write HTML
%>
<%
Server.Execute "side_menu.asp"
%>

<div class="hero-banner subpage">
    <div class="hero-banner-img"></div>
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder subpage">
            <div class="col-sm-12 hero-banner-left">
                <h1>Feedback</h1>
            </div>
        </div>
    </div>
</div><!-- /hero-banner -->

<!--#INCLUDE FILE="content_lower_nav.asp"-->

<div class="container subpage">
    <div class="row">
        <div class="col-sm-12">
            <div class="subpage-center">

				<p>
				Dear <%=username%>,<br><br>
				Your message has been sent to NSX.<br><br>
				We greatly appreciate that you took some time to write to us.<br><br>
				The Staff<br>
				NSX
				</p>

			</div>

<%
else
%>
	<div class="container_cont">
	<h1>Feedback - Problem with your request</h1>
	<p>
	Dear <%=username%>,<br><br>
	Your message has not been sent to NSX.<br><br>
	There was a problem with your request as follows:<br><br>
	<%=errmsg%><br><br>
	Please go back to the form and complete your message.  Thank you.
	</p>

	</div>
	
	<%end if%>
	
	
	</div>
</div>
</div>

<!--#INCLUDE FILE="footer.asp"-->