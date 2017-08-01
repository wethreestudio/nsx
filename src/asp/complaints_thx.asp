<html>

<head>
 <%
     
'------------------------------------------
' Adjust textarea box formatting
'str: the string to be adjusted
Function AdjTextArea(str)
	AdjTextArea = trim(Replace(str & " ", vbCrLf, "<BR>"))
	AdjTextArea = trim(Replace(AdjTextArea & " ", "''", "'"))
End Function
     
     
     ' Send email notification to NSX to tell them its there.
     
     subject = "NSX - Complaint Submitted"
     
     postal = adjtextarea(trim(request.form("postal") & " "))
     username = trim(request.form("username"))
     useremail = trim(request.form("useremail"))
     usertel = trim(request.form("usertel") & " ")
     company = trim(request.form("company") & " ")
     comments = adjtextarea(trim(request.form("comments") & " "))

     
    Dim MyJMail2
    Dim HTML
    
    HTML = "<!DOCTYPE HTML PUBLIC""-//IETF//DTD HTML//EN"">"
    HTML = HTML & "<html>"
    HTML = HTML & "<head>" 
    HTML = HTML & "<title>NSX COMPLAINT</title>"
    HTML = HTML & "</head>"
    HTML = HTML & "<body bgcolor=""FFFFFF"" >"
    HTML = HTML & "<p><font size =""2"" face=""Arial"" color=navy>"
    
    HTML = HTML & "<b>From: </b> " & username & "  [<a href=mailto:" & useremail & ">" & useremail & "</a>]"
	 if company<>"" then HTML = HTML & "<br><b>Company or Security:</b> " & company
	 if usertel<>"" then HTML = HTML & "<br><b>Phone:</b> " & usertel 
	 if postal<>"" then HTML = HTML & "<br><b>Postal:</b> " & "<BR>" & postal 
	 if comments<>"" then HTML = HTML & "<br><b>Camplaint Details:</b> " & "<BR>" & comments 

    
    
    
    HTML = HTML & "<br><br><b>Message Sent:</b> " & formatdatetime(Now,1) & " " & formatdatetime(now,3)
    HTML = HTML & "</body>"
    HTML = HTML & "</html>"
    
    'Response.write HTML
    Set MyJMail2 = Server.CreateObject("JMail.SMTPMail")
    MyJMail2.ServerAddress = Application("SMTP_Server") & ":" & Application("SMTP_Port")
    MyJMail2.Sender= useremail 
	MyJMail2.SenderName = username    
    MyJMail2.AddRecipientBCC "scott.evans@nsxa.com.au"
    MyJMail2.AddRecipientCC useremail
    MyJMail2.AddRecipient "complaints@nsxa.com.au"
    MyJMail2.Subject=subject
    MyJMail2.ContentType="text/html"
    MyJMail2.Priority = 1 'High importance!
    MyJMail2.Body=HTML
    MyJMail2.Execute
    set MyJMail2=nothing
    set HTML = nothing
    %>   

<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 6.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>NSX National Stock Exchange of Australia</title>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="ROBOTS" content="INDEX">
<meta http-equiv="Expiry" content="0">
<meta http-equiv="expires" content="0">
<meta name="description" content="The National Stock Exchange of Australia - Operates a Stock Exchange in Australia focussing on small to medium and high technology companies.">
<meta name="keywords" content="small, medium, company, companies, companys, australia, Australia, Newcastle, Hamilton, Steven Pritchard,
enterprises, high technology, stock, exchange, stock exchange, Australian, NSX, nsx">
<link rel=stylesheet href="newsx2.css" type="text/css">



<meta name="Microsoft Border" content="none">
<link rel="shortcut icon" href="favicon.ico" ></head>

<body >

<!--#INCLUDE FILE="header.asp"-->
<div align="center">
<table border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" rowspan="5" bgcolor="#FFFFFF"><!--#INCLUDE FILE="lmenu.asp"--></td>
  </tr>
  <tr>
    <td width="980" class="textheader" bgcolor="#FFFFFF" >
	<h1><b><font face="Arial">COMPLAINT 
    SUBMITTED</font></b></h1>
	</td>
  </tr>
  <tr>
    <td width="100%" class="textheader" bgcolor="#FFFFFF" height="30">THANK
      YOU</td>
  </tr>
  <tr>
    <td width="345" class="plaintext" valign="top" bgcolor="#FFFFFF">
    
    

	<p align="left">&nbsp;Dear, <%=username%>, </p>
	<p align="left">we greatly appreciate that you took some&nbsp; time to tell us 
about your complaint.&nbsp;</p>
	<p align="left"><b>The Staff&nbsp;<br></b>NSX</p>


<p>&nbsp;</p>



<p align="left">&nbsp;</p>



    </td>
  </tr>
  <tr>
    <td width="600" class="plaintext" valign="top" bgcolor="#FFFFFF">
    
    
<p>&nbsp;
    </td>
  </tr>
</table>
</div>
<!--#INCLUDE FILE="footer.asp"-->
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </p>
<p>&nbsp;&nbsp; </p>

        
    
        
</body>

</html>