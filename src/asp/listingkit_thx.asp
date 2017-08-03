<%
Response.Redirect("/")
Response.End

errmsg = "OK"

website=request.form("website")
wherefrom= ucase(request.servervariables("HTTP_REFERER"))
wherefrom=instr(wherefrom,"WHY_LIST.ASP")
if wherefrom=0 then errmsg= "<li>Unauthorised</li>"
whofrom = instr(website,"http://www.88yn.com")
if whofrom > 0 then errmsg="<li>Unauthorised</li>"
whofrom = instr(website,"loroilmondo")
if whofrom > 0 then errmsg="<li>Unauthorised</li>"
whofrom = instr(website,"cheriguardai")
if whofrom > 0 then errmsg="<li>Unauthorised</li>"
whofrom = instr(website,"intesiecerto")
if whofrom > 0 then errmsg="<li>Unauthorised</li>"
whofrom = instr(website,"alcunagloria")
if whofrom > 0 then errmsg="<li>Unauthorised</li>"
whofrom = instr(website,"intesiecerto")
if whofrom > 0 then errmsg="<li>Unauthorised</li>"
whofrom = instr(website,"cheriguardai")
if whofrom > 0 then errmsg="<li>Unauthorised</li>"
whofrom = instr(website,"aliyiyao")
if whofrom > 0 then errmsg="<li>Unauthorised</li>"


comments = adjtextarea(trim(request.form("comments") & " "))
badcomm = instr(comments,"cheriguardai")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(comments,"loroilmondo")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(comments,"cheriguardai")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(comments,"intesiecerto")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(comments,"alcunagloria")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(comments,"intesiecerto")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"

badcomm = instr(comments,"evenniate")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(comments,"perlocammino")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(comments,"giustiziamosse")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(comments,"suoneria")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(comments,"piramidi")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"

badcomm = instr(comments,"toccassealtro")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(comments,"comeanessun")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(comments,"nelmortalcorpo")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(comments,"chemisolea")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"

badcomm = instr(comments,"mossediprima")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(comments,"enonmisi")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(comments,"fulapaura")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(comments,"enonmisi")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(comments,"uscitofuor")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"

badcomm = instr(comments,"ccidnet")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(comments,"chengdujp1")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"

badcomm = instr(comments,"resuttano")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(comments,"sommatino")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(comments,"sicilia")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(comments,"marianopoli")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(request.form("comments"),"bompensiere")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(request.form("comments"),"pagina")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(request.form("comments"),"serradifalco")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(request.form("comments"),"mazzarino")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"

badcomm = instr(request.form("comments"),"usatobasilicata")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(request.form("comments"),"spaziohostingdominio")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(request.form("comments"),"atortoemala")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(request.form("comments"),"ristoranteroccamena")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"

badcomm = instr(request.form("comments"),"emalavoce")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(request.form("comments"),"dandolebiasmo")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(request.form("comments"),"leggesullaffidamentocongiunto")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(request.form("comments"),"fotogratisdonnamatura")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(request.form("comments"),"aliyiyao")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(request.form("comments"),"damaxman")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"

badcomm = instr(request.form("comments"),"cercassero")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(request.form("comments"),"sommesso")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(request.form("comments"),"sensibilmente")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(request.form("comments"),"stendevasi")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(request.form("comments"),"andarono")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(request.form("website"),"0.com")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(request.form("comments"),"prestito-terni")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(request.form("comments"),"crack-utility-patch-gioco")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(request.form("comments"),"personali")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(request.form("comments"),"amigoauto")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(request.form("comments"),"buonopagina")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(request.form("comments"),"buonoauto")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(request.form("comments"),"calciomaster")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(request.form("comments"),"v4fi9ss")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(request.form("comments"),"[/url]")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"
badcomm = instr(request.form("comments"),"http://")
if badcomm > 0 then errmsg="<li>Unauthorised</li>"


badheard = ucase(trim(request.form("heard") & " "))
badheard = instr(badheard,"BUSUNESS")
if badheard > 0 then errmsg="<li>Unauthorised</li>"


badip = request.servervariables("REMOTE_ADDR")
badip = instr(badip,"60.190.240.76")
if badip > 0 then errmsg="<li>Unauthorised</li>"
'------------------------------------------
' Adjust textarea box formatting
'str: the string to be adjusted
Function AdjTextArea(str)
	AdjTextArea = trim(Replace(str & " ", vbCrLf, "<BR>"))
	AdjTextArea = trim(Replace(AdjTextArea & " ", "''", "'"))
End Function
     

     
     ' Send email notification to NSX to tell them its there.
     
     subject = "NSX Listing Kit Request"
     
     postal = adjtextarea(trim(request.form("postal") & " "))
     postal2 = adjtextarea(trim(request.form("postal2") & " "))
     city = adjtextarea(trim(request.form("city") & " "))
     state = adjtextarea(trim(request.form("state") & " "))
     zip = adjtextarea(trim(request.form("zip") & " "))
     country = adjtextarea(trim(request.form("country") & " "))
     username = request.form("username")
     useremail = request.form("useremail")
     usertel = replace(trim(request.form("usertel") & " ")," ","")
     usertel = replace(usertel,"-","")
     fax = replace(request.form("fax"),"-","")
     company = trim(request.form("company") & " ")
     department = trim(request.form("department") & " ")
     position = trim(request.form("position") & " ")

     broker = ucase(trim(request.form("broker") & " "))
     mailinglist = ucase(trim(request.form("mailinglist") & " "))
     heard = ucase(trim(request.form("heard") & " "))
     website = trim(request.form("website") & " ")
     if website = "" then
     	if useremail<>"" then
     		if instr(useremail,"@")>0 then
     			website = "www." & mid(useremail,instr(useremail,"@")+1,len(useremail))
     		end if
     	end if
     end if
     
 'cr = "<br>"
  cr = vbCRLF
     
    Dim MyJMail2
    Dim HTML
    
      
      'HTML = HTML & "Thank you for your request (below).  We have attached an electronic copy of the Guide to this request for your information.  You may receive a call from us in the near future to follow up on your request and to see if there is any further assistance that we can offer.  " & cr & cr
      'HTML = HTML & "Best Regards,  National Stock Exchange of Australia " & cr & cr
      'HTML = HTML & "*************************************************** " & cr & cr
      HTML = HTML & "Yes, please send me an NSX Guide to Listing Kit." & cr & cr
    HTML = HTML & "Name: " & username 
	 if company<>"" then HTML = HTML & cr & "Company: " & company
	 if position<>"" then HTML = HTML & cr & cr & "Job Title: " & ucase(position)
	 if department<>"" then HTML = HTML &  cr & "Department: " & ucase(department)
	 if useremail<>"" then HTML = HTML &   cr & "Email: " & useremail
	 if website<>"" then HTML = HTML &   cr & "Website: " & website
	 if usertel<>"" then HTML = HTML &  cr & "Phone: " & usertel 
	 if fax<>"" then HTML = HTML &  cr & "Fax: " & fax 
	 if postal<>"" then HTML = HTML &  cr & "Address1: " & ucase(postal)
	 if postal2<>"" then HTML = HTML &  cr & "Address2: " & ucase(postal2)
	 if city<>"" then HTML = HTML &  cr & "City: " & ucase(city)
	 if state<>"" then HTML = HTML &  cr & "State: " & ucase(state)
	 if zip<>"" then HTML = HTML &  cr & "Postcode: " & ucase(zip)
	 if country<>"" then HTML = HTML &  cr & "Country: " & ucase(country)    
	 if broker<>"" then HTML = HTML &  cr & "Broker Contact: "  & broker
	 if mailinglist<>"" then HTML = HTML &  cr & "Mailing List: "  & mailinglist 
	 if heard<>"" then HTML = HTML &  cr & "Referred By: " & heard 
	 if comments<>"" then HTML = HTML &  cr & "Comments: " & comments 
	 if comments2<>"" then 
	 	HTML = HTML &  cr & "Comments2: " & comments2
	 	errmsg="<li>Unauthorised</li>"
	 end if
    
  if errmsg <> "OK" then  
    HTML = HTML & cr & cr & "Message Sent: " & formatdatetime(Now,1) & " " & formatdatetime(now,3)
    	HTML = HTML &  cr & "REFERRER: " & request.servervariables("HTTP_REFERER")
    	HTML = HTML &  cr & "HTTP_USER_AGENT: " & request.servervariables("HTTP_USER_AGENT")
		HTML = HTML &  cr & "HTTP_CONTENT_LENGTH: " & request.servervariables("HTTP_CONTENT_LENGTH")
		HTML = HTML &  cr & "HTTP_CONTENT_TYPE: " & request.servervariables("HTTP_CONTENT_TYPE")
		HTML = HTML &  cr & "REMOTE_HOST: " & request.servervariables("REMOTE_HOST")
		HTML = HTML &  cr & "REMOTE_ADDR: " & request.servervariables("REMOTE_ADDR")
		HTML = HTML &  cr & "Authorisation: " & errmsg
	end if
   
    

    'Response.write HTML
    Set MyJMail2 = Server.CreateObject("JMail.SMTPMail")
    MyJMail2.ServerAddress = Application("SMTP_Server") & ":" & Application("SMTP_Port")
    MyJMail2.Sender= useremail 
	MyJMail2.SenderName = username  
 if errmsg =  "OK" then   
 	' send to all and reply with attachment
    ''MyJMail2.AddRecipientCC useremail
    MyJMail2.AddRecipientBCC "ian.craig@nsxa.com.au"
    MyJMail2.AddRecipientBCC "forms@nsxa.com.au"
	MyJMail2.AddRecipientBCC "debi.webber@nsxa.com.au"
	LISTINGGUIDE=Server.Mappath("/documents/pdfs/Guide to listing on the NSX 2009.pdf")
	'MyJMail2.AddAttachment LISTINGGUIDE

 end if
    MyJMail2.AddRecipient "mail@nsxa.com.au"
    MyJMail2.Subject=subject
    'MyJMail2.ContentType="text/html"
    MyJMail2.Priority = 1 'High importance!
    MyJMail2.Body=HTML
    MyJMail2.Execute
    
    
    'if errmsg =  "OK" then   
    'MyJMail2.AddRecipientCC useremail
    ' do 2 executes in case their email address was lousy (webcentral doesn't send)
    'MyJMail2.Execute
    'end if

    
    set MyJMail2=nothing
    set HTML = nothing
 
    %>   
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 6.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>NSX National Stock Exchange of Australia</title>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="ROBOTS" content="INDEX">
<meta http-equiv="Expiry" content="0">
<meta http-equiv="expires" content="0">
<meta name="description" content="The Wollongong Stock Exchange - Operates a Stock Exchange in Australia focussing on small to medium companies.">
<meta name="keywords" content="small, medium, company, companies, companys, australia, Australia, Newcastle, Wollongong, 
enterprises, high technology, stock, exchange, stock exchange, Australian, NSX, nsx">
<link rel="stylesheet" href="newsx2.css" type="text/css">
<meta name="Microsoft Border" content="none">
<link rel="shortcut icon" href="favicon.ico" >
</head>
<body  style="background-color: #DDDDDD">
<!--#INCLUDE FILE="header.asp"-->
<div align="center">
<div class="table-responsive"><table border="0" width="100%" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF">
  <tr>
    <td valign="top" rowspan="3"><!--#INCLUDE FILE="lmenu.asp"--></td>
  </tr>
  <tr>
    <td class="plaintext" valign="top" bgcolor="#FFFFFF">
    
    

  
    <h1 align="left"><b>LISTING KIT REQUEST RECEIVED 
    	</b></h1>
 <% 
 'response.write errmsg &  " " & request.servervariables("HTTP_REFERER") & "<br>"
 if errmsg="OK" then%>
	<p align="left"><b>Dear, <%=username%>, </b></p>
    <p align="left">the Exchange greatly appreciates that you took some time to request a 
Listing Kit.&nbsp;&nbsp;</p>
<%if broker="YES" then%>
    <p align="left">You have requested that a participating organisation can follow up with you to discuss your listing requirements.</p>
<%end if%>
<%if MailingList="YES" then%>
    <p align="left">Thank you for joining our newsletter mailing list.</p>
<%end if%>
    <p align="left">Please refer to the NSX <a href="privacy.asp">Privacy Policy</a> concerning any information that 
the NSX may collect and retain about your organisation.</p>
  


<p>&nbsp;</p>

<%end if%>
<%
'FOR EACH name IN Request.ServerVariables
'Response.write("<B>"&name&"</B>:")
'Response.write(Request.ServerVariables(name))
'Response.write("<BR>")
'NEXT
%>

    </td>
  </tr>
  <tr>
    <td width="600" class="plaintext" valign="top" bgcolor="#FFFFFF">
    
    
<p>&nbsp;
    </td>
  </tr>
</table></div>
</div>
<!--#INCLUDE FILE="footer.asp"-->   
</body>

</html>