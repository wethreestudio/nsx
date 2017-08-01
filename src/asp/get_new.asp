<%


Function ProgIDInstalled(progID) 
    On Error Resume Next 
    Dim o : Set o = CreateObject(progID) 
    ProgIDInstalled = Err.Number = 0 
End Function 
 
If ProgIDInstalled("MSXML2.DOMDocument.3.0") Then 
    response.write " MSXML3 is present   <br>"
End If 
 
If ProgIDInstalled("MSXML2.DOMDocument.4.0") Then 
    response.write " MSXML4 is present   <br>"
End If 
 
If ProgIDInstalled("MSXML2.DOMDocument.5.0") Then 
   response.write  ' MSXML5 is present  <br> ' 
End If 
 
If ProgIDInstalled("MSXML2.DOMDocument.6.0") Then 
    response.write " MSXML6 is present  <br> "
End If

If ProgIDInstalled("MSXML2.DOMDocument.7.0") Then 
    response.write " MSXML7 is present  <br> " 
End If

If ProgIDInstalled("Msxml2.ServerXMLHTTP") Then 
    response.write " Msxml2.ServerXMLHTTP is present  <br> " 
End If

Msxml2.ServerXMLHTTP

response.end

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

Set objWinHttp = Server.CreateObject("WinHttp.WinHttpRequest.5.1")

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
'objWinHttp.Open "GET", "http://www.asp101.com/samples/httpsamp.asp"
'objWinHttp.Open "GET", "http://10.2.3.180/samples/httpsamp.asp"
'objWinHttp.open "GET", "http://finance.yahoo.com/d?s=^DJI&f=s0l1t1cn", False
objWinHttp.open "GET", Application("nsx_SiteRootURL") & "/api_prices_current.asp?nsxcode=sug&fmt=xml", False


' Send it on it's merry way.
objWinHttp.Send

' Print out the request status:
Response.Write "Status: " & objWinHttp.Status & " " _
	& objWinHttp.StatusText & "<br />"

' Get the text of the response.
strHTML = objWinHttp.ResponseText

' Trash our object now that I'm finished with it.
Set objWinHttp = Nothing

' All that's left to do is display the HTML we just retreived.
' I do it first as plain HTML (which gets interpretted by the
' browser like any other HTML) and then as source (by HTML
' encoding it so the tags display instead of rendering)
' The <h1>s and <table>s are just for appearence.
%>

<h1>Here's The Page:</h1>
<table border="1">
<tr><td>
<%= strHTML %>
</td></tr>
</table>

<br />

<h1>Here's The Code:</h1>
<table border="1">
<tr><td>
<pre>

<%= Server.HTMLEncode(strHTML) %>
</pre>
</td></tr>
</table>


<h1>Here's The Code:</h1>
<table border="1">
<tr><td>
<pre>
<% aa=split(strHTML,",")
for jj = 0 to ubound(aa)
response.write aa(jj) & "<br>"
next


%>
</pre>
</td></tr>
</table>