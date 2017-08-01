<%
' Start out declaring our variables.
' You are using Option Explicit aren't you?
Dim objXmlHttp
Dim strHTML

' This is the server safe version from MSXML3.
Set objXmlHttp = Server.CreateObject("Msxml2.ServerXMLHTTP")

' If you have trouble and are getting an error on the .open
' line like this:
'
' msxml3.dll error '80070005'
' Access is denied.
'
' Try using the proxycfg.exe tool.  We're not using a proxy
' at all, but it wouldn't work for us until we explicitly
' ran proxycfg telling it the connection is direct:
' 
' proxycfg -d
'
' forum posts: http://www.asp101.com/forum/display_message.asp?mid=51841
'
' This had us really annoyed for a while!  Thanks go out to
' Andrew Stifora and Brian Espey for help on getting that
' straightened out.

' The old not so safe version!
'Set objXmlHttp = Server.CreateObject("Msxml2.XMLHTTP")

' Here we get the request ready to be sent.
' MS's wording: 'Initializes a request and specifies the method,
' URL, and authentication information for the request.
' Syntax:
'   .open(bstrMethod, bstrUrl, bAsync, bstrUser, bstrPassword)
'objXmlHttp.open "GET", "http://www.asp101.com/samples/httpsamp.asp", False
'objXmlHttp.open "GET", "http://finance.yahoo.com/d?s=^DJI&f=s0l1t1cn", False
objXmlHttp.open "GET", "http://www.asx.com.au/asx/research/CompanyInfoSearchResults.jsp?searchBy=asxCode&allinfo=on&asxCode=NSX&companyName=&principalActivity=&industryGroup=NO", False
' Send it on it's merry way.
objXmlHttp.send

' Print out the request status:
Response.Write "Status: " & objXmlHttp.status & " " _
	& objXmlHttp.statusText & "<br />"

' Get the text of the response.
' This object is designed to deal with XML so it also has the
' following properties: responseBody, responseStream, and
' responseXML.  We just want the text so I use:
strHTML = objXmlHttp.responseText

' Trash our object now that I'm finished with it.
Set objXmlHttp = Nothing

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

