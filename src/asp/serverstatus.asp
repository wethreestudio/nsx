<!--#INCLUDE FILE="include_all.asp"-->
<%

alow_robots = "no"
%>

<!--#INCLUDE FILE="header.asp"-->

<div class="container_cont">
<div class="editarea">



<%

Function RemoveHTML( strText )
	Dim RegEx

	Set RegEx = New RegExp

	RegEx.Pattern = "<[^>]*>"
	RegEx.Global = True

	RemoveHTML = RegEx.Replace(strText, "")
End Function

daylightsaving=0
if application("nsx_daylight_saving")=true then
	daylightsaving = 1/24
	else
	daylightsaving = 0
end if

cr=vbCRLF
'    cr="<br>"
	qu=""""
	tb=","
    eml = ""
    emlflag = false

' Start out declaring our variables.
' You are using Option Explicit aren't you?
Dim objWinHttp
Dim strHTML

' New WinHTTP v5.1 - from MS: 
'
' With version 5.1, WinHTTP is now an operating-system component
' of the following systems:
'  - Microsoft Windows Server 2003 family
'  - Microsoft Windows XP, Service Pack 1
'  - Microsoft Windows 2000, Service Pack 3 (except Datacenter Server)

'Set objWinHttp = Server.CreateObject("WinHttp.WinHttpRequest.5.1")
Set objWinHttp = Server.CreateObject("Msxml2.FreeThreadedDOMDocument.3.0")


' Full Docs:
' http://msdn.microsoft.com/library/en-us/winhttp/http/portal.asp
'
' If you have trouble or are getting connection errors,
' try using the proxycfg.exe tool.

' Here we get the request ready to be sent.
' First 2 parameters indicate method and URL.
' The third is optional and indicates whether or not to
' open the request in asyncronous mode (wait for a response
' or not).  The default is False = syncronous = wait.
' Syntax:
'   .Open(bstrMethod, bstrUrl [, varAsync])
objWinHttp.Load "http://svc031.wic004pa.server-web.com/api_serverstatus.asp"


' Send it on it's merry way.
'objWinHttp.Send

' Print out the request status:
'Response.Write "Status: " & objWinHttp.Status & " " & objWinHttp.StatusText & "<br />"
    If objWinHttp.parseError.errorCode <> 0 Then
       Response.Write "<pre>" & vbCrLf
       Response.Write "<strong>Error:</strong> " & objWinHttp.parseError.reason
       Response.Write "<strong>Line:</strong>  " & objWinHttp.parseError.line & vbCrLf
       Response.Write "<strong>Text:</strong>  " _
          & Server.HTMLEncode(objWinHttp.parseError.srcText) & vbCrLf
       Response.Write "</pre>" & vbCrLf
    End If

' Get the text of the response.
strHTMLNSX1 = objWinHttp.Text
response.write strHTMLNSX1
response.end
' Trash our object now that I'm finished with it.
Set objWinHttp = Nothing

' All that's left to do is display the HTML we just retreived.
' I do it first as plain HTML (which gets interpretted by the
' browser like any other HTML) and then as source (by HTML
' encoding it so the tags display instead of rendering)
' The <h1>s and <div class="table-responsive"><table>s are just for appearence.

' get server 2 status

Set objWinHttp = Server.CreateObject("WinHttp.WinHttpRequest.5.1")
objWinHttp.Open "GET", "http://www.nsxa.com.au/api_serverstatus.asp"
objWinHttp.Send
'Response.Write "Status: " & objWinHttp.Status & " " & objWinHttp.StatusText & "<br />"
strHTMLNSX2 = objWinHttp.ResponseText
Set objWinHttp = Nothing


strHTMLNSX1 = split(strHTMLNSX1,cr)
strHTMLNSX2 = split(strHTMLNSX2,cr)

rc = ubound(strHTMLNSX1)
eml=eml & "<div class="table-responsive"><table bgcolor=#FFFFFF align=center border=0 width=797 cellspacing=0 cellpadding=0>"
eml = eml & "<tr><td colspan=3 class=plaintext><h1>Server Status as at " & now+daylightsaving & "</h1></td><tr>"
eml = eml & "<tr><td class=plaintext align=right><b>Name</b></td><td align=right class=plaintext><b>Size Check</b></td><td align=right class=plaintext><b>Date Check</b></td>"
ii = 0
jj = 0
sizecount = 0
datecount = 0

for ii = 0 to rc-1
	aa1 = split(strHTMLNSX1(ii),",")
	aa2 = split(strHTMLNSX2(ii),",")
		
	rc2 = ubound(aa1)
	
	
	date1 = cdate(replace(aa1(2),"""",""))
	date2 = cdate(replace(aa2(2),"""",""))
	fname = replace(aa1(0),"""","")
	fname = replace(fname,"mdb","")
	fname = replace(fname,"asp","")
	sizecheck = aa1(1) - aa2(1)
	' .0208 of a day = 30 minutes
	datecheck = date1 - date2
	size2 = formatnumber(aa2(1),0)
	if sizecheck = 0 then 
		sizeimg = "<img src=" & Application("nsx_SiteRootURL") & "/images/up.gif border=0>"
		else
		sizeimg = "<img src=" & Application("nsx_SiteRootURL") & "/images/down.gif border=0>"
	end if
	if datecheck = 0 then 
		dateimg = "<img src=" & Application("nsx_SiteRootURL") & "/images/up.gif border=0>"
		else
		dateimg = "<img src=" & Application("nsx_SiteRootURL") & "/images/down.gif border=0>"
	end if
	eml=eml & "<tr><td class=plaintext align=right>" & fname & "</td>"
	eml=eml & "<td class=plaintext align=right>" & formatnumber(sizecheck,4) & " " & sizeimg & "</td>"
	eml=eml & "<td class=plaintext align=right>" & formatdatetime(date2,1) & " " & formatdatetime(date2,3) & " " & formatnumber(datecheck,4) & " " & dateimg & "</td>"
	eml=eml & "</tr>"
	datecount = datecount + datecheck
	sizecount = sizecount + sizecheck
	
NEXT
if datecount > 0.8 or sizecount >0.8 then emlflag = true

eml=eml & "</table></div>"



response.write eml

if emlflag = true then

	flename = "serverstatus.htm"   
    Set MyJMail6 = Server.CreateObject("JMail.SMTPMail")
    MyJMail6.ServerAddress = Application("SMTP_Server") & ":" & Application("SMTP_Port")
    MyJMail6.Sender= "nsxdata@nsxa.com.au"
    MyJMail6.ReplyTo = "scott.evans@nsxa.com.au"
    MyJMail6.SenderName = "NSX Status"
    MyJMail6.AddRecipient "scott.evans@nsxa.com.au"
    MyJMail6.Subject="NSX Server Synch Status Report on " & formatdatetime(date,1) & " " & formatdatetime(time,3)
    MyJMail6.Priority = 1 'High importance!
    MyJMail6.addcustomattachment  flename, eml
    MyJMail6.Body="Serverstatus: http://www.nsxa.com.au/serverstatus.asp | http://www.nsxa.com.au/serverstatus.asp "
    MyJMail6.Execute
    set MyJMail6=nothing
   	set nsxeml = nothing 

end if

%>

</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->
