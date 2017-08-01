<%@ LANGUAGE="VBSCRIPT" %>
<!--#INCLUDE FILE="include_all.asp"-->
<%Server.ScriptTimeout=2000%>
<% CHECKFOR = "UPL" 

Response.Expires = -1
Response.CacheControl = "no-cache" 
%>
<!--#INCLUDE FILE="member_check.asp"-->
<!--#INCLUDE FILE="admin/merchtools.asp"-->

<%

' day light saving
' check annrel, announce/anndelayed2.asp, resupoload3.asp change march/october each year

daylightsaving=0
if application("nsx_daylight_saving")=true then
	daylightsaving = 1/24
	else
	daylightsaving = 0
end if


username=session("username")

Function InsertAp(str)
If str <> "" Then
      If Instr(str,"'")<>0 Then
         InsertAp = Replace(str,"'","''")
      Else
         InsertAp = str
      End If
   End If
End Function

' Set upl = Server.CreateObject("SoftArtisans.FileUp")
Set objUpload = New clsUpload

session("err") = ""
tt = 0

' anncopycodes & anncopy variables used to fan out announcements for underlying codes.
' only fan out/copy once released.  see admin/annrel.asp
anncopycodes = ucase(objUpload("anncopycodes")) 
anncopy = objUpload("anncopy")
if anncopy = "Yes" then
	anncopy = "1"
	else
	anncopy = "0"
end if
codetails = ucase(objUpload("tradingcode"))
if instr(codetails,"{") > 0 then
	tradingcode = trim(mid(codetails,1,instr(codetails,"{")-1))
	coname = trim(mid(codetails,instr(codetails,"{")+1,instr(codetails,"}")-1))
	acn = trim(mid(codetails,instr(codetails,"}")+1,len(codetails)))
	nsxcode = left(tradingcode,3)
else
	session("err") = session("err") & " - Invalid Code Selected"
end if

category=objUpload("category")
if (left(tradingcode,6) = "SELECT") then tt=1
if trim(tradingcode & " ") = "" then tt=1
if tt = 1 then 
	session("err") = session("err") & "<b>Please select a SECURITY code to report</b>"	
end if
if instr(category,"***") > 0 then 
	session("err") = session("err") & "<br><b>Please select a CATEGORY code to report</b>"	
end if

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
<meta http-equiv="Expiry" content="-1">
<meta http-equiv="expires" content="-1">
<meta name="description" content="The National Stock Exchange of Australia - Operates a Stock Exchange in Australia focussing on small to medium and high technology companies.">
<meta name="keywords" content="small, medium, company, companies, companys, australia, Australia, Newcastle, enterprises, high technology, stock, exchange, stock exchange, Australian, NSX, nsx">
<link rel="stylesheet" href="newsx2.css" type="text/css">



<meta name="Microsoft Border" content="none">
<link rel="shortcut icon" href="favicon.ico" ></head>

<body >

<!--#INCLUDE FILE="header.asp"-->
<div align="center">
<table border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr>
    <td width="200" valign="top" rowspan="3" bgcolor="#FFFFFF"><!--#INCLUDE FILE="company_lmenu.asp"--></td>
  </tr>
  <tr>
    <td class="textheader" bgcolor="#FFFFFF">
	
		<h1><b><font face="Arial" color="#FFFFFF">&nbsp;</font><font face="Arial">&nbsp;LISTED 
		COMPANY SERVICES</font></b></h1>
	
	</td>
  </tr>
  <tr>
  
    <td class="plaintext" valign="top" bgcolor="#FFFFFF" style="line-height: 150%">   



<%
if session("err")="" then
      
'Response.write "<p>Uploading File ... this may take some time depending on your file size.  Please be patient.</p>"

tm = Now()+daylightsaving
dy = day(tm)
if dy < 10 then dy = "0" & dy
my = month(tm)
if my < 10 then my = "0" & my
hr = hour(tm)
if hr < 10 then hr = "0" & hr
mn = minute(tm)
if mn < 10 then mn = "0" & mn
sc = second(tm)
if sc < 10 then sc = "0" & sc

newday=Dy&My&year(tm)&hr&mn&sc
'upl.progressid = request.querystring("progressid")
'upl.MaxBytes = 0 
'newsdir = "..\announce\_annfiles"
'newsdir2 = "../announce/_annfiles/"
'newsdir3 = "announce/_annfiles/"
newsdir = "ftp\news"
newsdir2 = "ftp/news/"
newsdir3 = "ftp/news/"


' upl.Path = Server.Mappath (newsdir) & "\" 

uplpath = Server.MapPath(newsdir) & "\" 


' upload the file if browser ok
' create random file name with same .ext
' check i f no file name or no extension


if len(trim(objUpload("f1").Name)) = 0 or instr(objUpload("f1").Name,".") = 0 then
	oldext = ""
else
	oldext = trim(mid(objUpload("f1").Name,instrrev(objUpload("f1").Name,"."),len(objUpload("f1").Name)-1+instrrev(objUpload("f1").Name,".")) & " ")
end if

newfile = nsxcode & newday & oldext
'start upload of document
'upl.Form("f1").SaveAs upl.path & newfile
'Response.Write upl.path & newfile
'Response.write Server.Mappath(newfile)
	' check if valid file to upload
	
	
	
	
	TotalBytes = 0
	if oldext <> "" then
	Select Case UCase(oldext) 
	Case ".PDF" 
	  objUpload("f1").SaveAs newsdir2 & newfile
	  
		upl.Form("f1").SaveInVirtual  newsdir2 & newfile
		TotalBytes = upl.Form("f1").TotalBytes

	
	Case Else
		upl.delete
		Response.Write  "<p>You are not allowed to upload files of type " & upl.UserFilename & ".<br>Click the BACK button to try again."
		Response.End 
	End Select


	
	end if
' asic cannot accept files greater than 10 megabytes
if (TotalBytes > 0) and (totalbytes<10000000) then 
	response.write "<br>Thank you for submitting your announcement.<br>"
	response.write "Your announcement number is: " & newfile & "<br>"
	qu = """"

	' now register the file in the database
	b = nsxcode
	c = insertAP(replace(upl.form("category"),"}"," - ") & upl.Form("title"))
	c = replace(c,qu,"`")
	d = insertAp(upl.Form("Description"))
	' replace any double quotes with single quotes
	d = replace(d,qu,"`")
	e = insertAp(upl.Form("Person"))
	f = insertAp(upl.Form("Phone"))
	g = insertAp(upl.Form("email"))
	contactemail = g
	h = newfile
	i = username
	if len(i)=0 then i = " " 
	j = TotalBytes
	k = tradingcode
	m = upl.form("annPriceSensitive")
	if m="No" then
  		m = False
	  	else
	  	m = True
	end if
	' make sure date for annupload is in english format
	n = Now() + daylightsaving


	template2 = upl.form("cattemplate")
  

	z = z & "INSERT INTO coAnn ("  
	z = z & "nsxcode,annTitle,annPrecise,annSubmitter,annPhone,annEmail,annFile,annUsername,annFileSize,tradingcode,annPriceSensitive,annupload,anncopy,anncopycodes)"
	z = z & " VALUES ('" & SafeSqlParameter(b) & "','" 
	z = z & SafeSqlParameter(c) & "','" & SafeSqlParameter(d) & "','" & SafeSqlParameter(e) & "','" & SafeSqlParameter(f) & "','" & SafeSqlParameter(g) & "','" 
	z = z & SafeSqlParameter(h) & "','" & SafeSqlParameter(i) & "','" & SafeSqlParameter(j) & "','" & SafeSqlParameter(k) & "'," & SafeSqlParameter(m) & ",'" & SafeSqlDate(n) & "'"
	z = z & "," & SafeSqlParameter(anncopy) 
	z = z & ",'" & SafeSqlParameter(anncopycodes) & "'"
	z = z & ")"

	'--- This opens database connection
  	DBPath=Server.MapPath("newsxdb\newsxdb.mdb")
  	Dim con	
  	Set con = Server.CreateObject("ADODB.Connection")
  	con.Open Application("nsx_WriterConnectionString") ' "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & DBPath
	'Response.write z  & "<br><br>"
	con.Execute z
	con.close
	set con=nothing

	' Send email notification to NSX to tell them its there.
    Dim MyJMail2
    Dim HTML
    
    crr = vbCRLF
    
    HTML = HTML & "This is an RNS announcement receipt notification" & crr & crr
      
    HTML = HTML & "NSXCODE: " & k & crr
    HTML = HTML & "Title: " & replace(c,"''","'") & crr & crr
    HTML = HTML & "Price Sensitive? " & m & crr
    HTML = HTML & "Description: " & adjtextarea(d) & crr
    HTML = HTML & "Submitter: " & e & crr
    HTML = HTML & "Phone: " & f & crr
    HTML = HTML & "Email: mailto:" & g  & crr
    if oldext <> "" then
    	HTML = HTML & "FileName: " & Application("nsx_SiteRootURL") & "/" & newsdir3 &  h & crr
    	HTML = HTML & "FileSize: " & j & " bytes" & crr
    	else
    	HTML = HTML & "No attachment was sent." & crr
    end if
    
    HTML = HTML & "Date/Time: " & formatdatetime(tm,1) & " " & formatdatetime(tm,3) & crr
    
    
    Set MyJMail2 = Server.CreateObject("JMail.SMTPMail")
    MyJMail2.ServerAddress = Application("SMTP_Server") & ":" & Application("SMTP_Port")
   
    MyJMail2.Sender= "rns@nsxa.com.au"
    MyJMail2.ReplyTo = "mail@nsxa.com.au"
    MyJMail2.AddRecipient "trading@nsxa.com.au"
    MyJMail2.AddRecipient contactemail

    
    MyJMail2.Subject=b & " announcement has arrived"
    'MyJMail2.ContentType="text/html"
    MyJMail2.Priority = 1 'High importance!
    
    category=replace(upl.form("category"),"}","")
    title=upl.Form("title")
    template2 = replace(template2,"[date]",formatdatetime(date,1))
    template2 = replace(template2,"[tradingcode]",k)
    template2 = replace(template2,"[coname]",coname)
    template2 = replace(template2,"[acn]",acn)
    template2 = replace(template2,"[subcode]",category)
    template2 = replace(template2,"[title]",title)
    template2 = replace(template2,"[precise]",adjtextarea(d))
    'MyJMail2.addcustomattachment (b & ".htm"),template2
    
    MyJMail2.Body=HTML
    
    MyJMail2.Execute
    set MyJMail2=nothing
    

set  b = nothing
set  c = nothing
set  d = nothing
set  e = nothing
set  f = nothing
set  g = nothing
set  h = nothing
set  i = nothing
set j = nothing

response.write "Date & Time submission completed was (AEST): <br><b>" & formatdatetime(date,1) & " " & formatdatetime(now,3) & "</b><br>"
response.write replace(HTML,vbCRLF,"<BR>")


else %>
<font color=red><b>THERE IS A PROBLEM WITH YOUR ANNOUNCEMENT: Your file did not upload correctly or your file name was incorrect or there was no document attached.  Please specify the correct document name or attach a valid document and try again.  Due to ASIC restrictions files cannot be larger than 10 megabytes (your file: <%=totalbytes/1000000%>mb.)<br>
	<br>NO ANNOUNCEMENT HAS BEEN SENT TO THE NSX. Click the back button to return to the upload form.
</b></font><br><br>If you would like help in submitting an announcement please <a href=contacts.asp>contact</a> Scott Evans +61 (02) 4929 6377.
	<br><br>
<%end if%>
<br>Total Bytes Written: <%=TotalBytes%>
<%set upl=nothing%>
<%Server.ScriptTimeout=90%>

<%
else
response.write session("err")
Session("err") = ""
end if

%>

    
    

    
    </td>
      
    

</table>
</div>
<!--#INCLUDE FILE="footer.asp"-->
<p>&nbsp;&nbsp;</p>

</body>

</html>