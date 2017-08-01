<%@ LANGUAGE="VBSCRIPT" %>
<%Server.ScriptTimeout=2000

Response.Expires = -1
Response.CacheControl = "no-cache" 
%>
<!--#INCLUDE FILE="company_check_exchid_v2.asp"-->
<%  CHECKFOR = "UPL" %>
<!--#INCLUDE FILE="member_check_v2.asp"-->
<!--#INCLUDE FILE="admin/merchtools.asp"-->
<!--#INCLUDE FILE="include/sql_functions.asp"-->
<%

' day light saving
daylightsaving=0
if application("nsx_daylight_saving")=true then
	daylightsaving = 1/24
	else
	daylightsaving = 0
end if


username=session("username")

Function InsertAp(str)
If len(str) <> 0 Then
      If Instr(str,"'")<>0 Then
         InsertAp = Replace(str,"'","''")
      Else
         InsertAp = str
      End If
   End If
End Function

Set upl = Server.CreateObject("SoftArtisans.FileUp")

session("err") = ""
tt = 0

' anncopycodes & anncopy variables used to fan out announcements for underlying codes.
' only fan out/copy once released.  see admin/annrel.asp
anncopycodes = ucase(upl.form("anncopycodes"))
anncopy = upl.Form("anncopy")
if anncopy = "Yes" then
	anncopy = true
	else
	anncopy = false
end if
codetails = ucase(upl.Form("tradingcode"))
if instr(codetails,"}") > 0 then

	detailspl = split(codetails,"}")
	tradingcode = detailspl(0)
	coname = detailspl(1)
	acn = detailspl(2)
	displayboard = detailspl(3)
	exchid = displayboard

	'tradingcode = trim(mid(codetails,1,instr(codetails,"{")-1))
	'coname = trim(mid(codetails,instr(codetails,"{")+1,instr(codetails,"}")-1))
	'acn = trim(mid(codetails,instr(codetails,"}")+1,len(codetails)))
	nsxcode = left(tradingcode,3)
else
	session("err") = session("err") & " - Invalid Code Selected "
end if

category=upl.form("category")
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
<%select case exchid
	case "NSX"
	%>
	<link rel=stylesheet href="newsx2.css" type="text/css">
<% case "SIMV"%>
	<!--#file = "include/common/stylesheets.asp" -->
	<link rel=stylesheet href="<%= Application("nsx_SiteRootURL") %>/newsx2.css" type="text/css">
<% case else %>
	<link rel=stylesheet href="<%= Application("nsx_SiteRootURL") %>/newsx2.css" type="text/css">
<% end select%>



<meta name="Microsoft Border" content="none">
<link rel="shortcut icon" href="favicon.ico" ></head>

<body >

<% if len(exchid)<>0 then server.execute "company_header_v2_" & exchid & ".asp"%>
<div align="center">
<table border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr>
    <td width="200" valign="top" rowspan="3" bgcolor="#FFFFFF"><%if len(exchid)<>0 then server.execute "company_lmenu_v2_" & exchid & ".asp"%></td>
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
upl.MaxBytes = 0 
'newsdir = "..\announce\_annfiles"
'newsdir2 = "../announce/_annfiles/"
'newsdir3 = "announce/_annfiles/"
newsdir = "ftp\news"
newsdir2 = "ftp/news/"
newsdir3 = "ftp/news/"


upl.Path = Server.Mappath (newsdir) & "\" 

	if upl.ContentDisposition <>"form-data" then 
      response.write "Your browser does not support file uploads!  "
	  response.write "You will require the latest version of your browser available."
 
	else 
		' upload the file if browser ok
		' create random file name with same .ext
		' check i f no file name or no extension

		if len(trim(upl.UserFilename)) = 0 or instr(upl.UserFilename,".") = 0 then
			oldext = ""
			else
			oldext = trim(mid(upl.UserFilename,instrrev(upl.UserFilename,"."),len(upl.UserFilename)-1+instrrev(upl.UserFilename,".")) & " ")
		end if
	
		newfile = nsxcode & newday & oldext
		'start upload of document
		'upl.Form("f1").SaveAs upl.path & newfile
		'Response.Write upl.path & newfile
		'Response.write Server.Mappath(newfile)
  		' check if valid file to upload
  		TotalBytes = 0
		
		'TotalBytes = upl.Form("f1").Length
  		if oldext <> "" then
			Select Case UCase(oldext) 
			Case ".PDF" 
				upl.Form("f1").SaveInVirtual  newsdir2 & newfile
				' TotalBytes = upl.Form("f1").TotalBytes
				Dim fs,f
				Set fs=Server.CreateObject("Scripting.FileSystemObject")
				Set f=fs.GetFile(Server.MapPath(newsdir2 & newfile))
				TotalBytes = CLng(f.Size)
				set f=nothing
				set fs=nothing
			
			Case Else
				upl.delete
				Response.Write  "<p>You are not allowed to upload files of type " & upl.UserFilename & ".<br>Click the BACK button to try again."
				Response.End 
			End Select
	

  	else 
  			' no file to upload therefore fake file length
  			TotalBytes = 0
  			session("err") = session("err") & "<br><b>Please attach an announcement file.</b>"
  	end if

	
	end if
	
' Response.Write "TotalBytes=" & TotalBytes & " (max 1048576)<BR>" : Response.End
' asic cannot accept files greater than 10 megabytes
if (TotalBytes > 0) and (TotalBytes<10485760) then 

	qu = """"

	' now register the file in the database
	b = nsxcode
	c = insertAP(replace(upl.form("category"),"}"," - ") & upl.Form("title"))
	c = replace(c,qu,"`")
	d = upl.Form("Description")
	' replace any double quotes with single quotes
	d = trim(d & " ")
	if len(d) = 0 then 
		d = insertAP(upl.Form("title"))
		else
		d = insertAP(d)
	end if
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
  		m = "0"
	  	else
	  	m = "1"
	end if
	' make sure date for annupload is in english format
	n = Now() + daylightsaving
	
	
	If UCase(exchid) = "SIMV" And Trim(Left(c,1)) <> "3" Then
		Response.Write "<b>Error:</b> Incorrect announcement code. SIMV announcement codes must start with '3'."
		Response.End
	Else
		response.write "<br>Thank you for submitting your announcement.<br>"
		response.write "Your announcement number is: " & newfile & "<br>"
	End If

	
	template2 = upl.form("cattemplate")
  
	anncopyx = "1"
	if not anncopy then
		anncopyx = "0"
	end if

	z = z & "INSERT INTO coAnn ("  
	z = z & "nsxcode,annTitle,annPrecise,annSubmitter,annPhone,annEmail,annFile,annUsername,annFileSize,tradingcode,annPriceSensitive,annupload,anncopy,anncopycodes,exchid,displayboard)"
	z = z & " VALUES ('" & SafeSqlParameter(b) & "','" 
	z = z & SafeSqlParameter(c) & "','" & SafeSqlParameter(d) & "','" & SafeSqlParameter(e) & "','" & SafeSqlParameter(f) & "','" & SafeSqlParameter(g) & "','" 
	z = z & SafeSqlParameter(h) & "','" & SafeSqlParameter(i) & "','" & SafeSqlParameter(j) & "','" & SafeSqlParameter(k) & "'," & SafeSqlParameter(m) & ",GETDATE()"
	z = z & ",'" & SafeSqlParameter(anncopyx) & "'" 
	z = z & ",'" & SafeSqlParameter(anncopycodes) & "'"
	z = z & ",'" & SafeSqlParameter(exchid) & "'"
	z = z & ",'" & SafeSqlParameter(displayboard) & "'"
	z = z & ")"
'response.write z : response.end
	'--- This opens database connection
  	DBPath=Server.MapPath("newsxdb\newsxdb.mdb")
  	Dim con	
  	Set con = Server.CreateObject("ADODB.Connection")
  	con.Open Application("nsx_WriterConnectionString") ' "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & DBPath
	'Response.write z  & "<br><br>"
	con.Execute z
	con.close
	set con=nothing

	' Send email notification to market operator to tell them its there.
    Dim MyJMail2
    Dim HTML
    
    crr = vbCRLF
    
    HTML = HTML & "This is an RNS announcement receipt notification" & crr & crr
      
  ps = "Yes"
  If m = "0" Then ps = "No"
    HTML = HTML & exchid & " CODE: " & k & crr
    HTML = HTML & "Title: " & replace(c,"''","'") & crr & crr
    HTML = HTML & "Price Sensitive? " & ps & crr
    HTML = HTML & "Description: " & adjtextarea(d) & crr
    HTML = HTML & "Submitter: " & e & crr
    HTML = HTML & "Phone: " & f & crr
    HTML = HTML & "Email: mailto:" & g  & crr
	HTML = HTML & "Exch:" & displayboard  & crr
	HTML = HTML & "Copy to underlying securities:" & anncopy  & crr & crr
    if oldext <> "" then
    	HTML = HTML & "Receipt #: " & Application("nsx_SiteRootURL") & "/" & newsdir3 &  h & crr
    	HTML = HTML & "FileSize: " & formatnumber((j/1048576),3) & " megabytes" & crr
    	else
    	HTML = HTML & "No attachment was sent." & crr
    end if
    
    HTML = HTML & "Receipt Date/Time: " & formatdatetime(tm,1) & " " & formatdatetime(tm,3) & crr
	HTML = HTML & "IP: " & UserIPAddress & crr
	HTML = HTML & "Username: " & Session("username") & crr
	HTML = HTML & "Path Info: " & Request.ServerVariables("PATH_INFO") & crr
    
    Set MyJMail2 = Server.CreateObject("JMail.SMTPMail")
    MyJMail2.ServerAddress = Application("SMTP_Server") & ":" & Application("SMTP_Port")
   
    MyJMail2.Sender= "rns@nsxa.com.au"
	MyJMail2.SenderName= exchlong & " RNS"
    MyJMail2.ReplyTo = "mail@nsxa.com.au"
    MyJMail2.AddRecipient "trading@nsxa.com.au"
    MyJMail2.AddRecipient contactemail

    
    MyJMail2.Subject=b & " announcement has arrived"
    MyJMail2.Priority = 1 'High importance!
     
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


response.write "Date & Time submission completed was (AEST): <br><b>" & formatdatetime(tm,1) & " " & formatdatetime(tm,3) & "</b><br>"
response.write replace(HTML,vbCRLF,"<BR>")


else %>
<font color=red><b>THERE IS A PROBLEM WITH YOUR ANNOUNCEMENT: Your file did not upload correctly or your file name was incorrect or there was no document attached.  Please specify the correct document name or attach a valid document and try again.  Due to 
regulator restrictions files cannot be larger than 10 megabytes (your file: <%=totalbytes/1048576%>mb.)<br>
	<br>NO ANNOUNCEMENT HAS BEEN SENT TO THE EXCHANGE. Click the back button to return to the upload form.
</b></font><br><br>
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
<% if len(exchid)<>0 then server.execute "company_footer_v2_" & exchid & ".asp"%>
<p>&nbsp;&nbsp;</p>

</body>

</html>