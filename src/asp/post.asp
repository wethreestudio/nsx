<%
' This sample illustrates doing a behind the scenes
' HTTP POST to a web server.  If you're just looking
' to do a standard GET request or simply want more
' general information about making an HTTP request
' via ASP, please see:
'
' Our WinHTTP v5.x HTTP Request Sample
' http://www.asp101.com/samples/winhttp5.asp
'
' Our Original HTTP Sample (mainly for discussion)
' http://www.asp101.com/samples/http.asp
'
' Now on to the code...

Dim objWinHttp
Dim strResponseStatus
Dim strResponseText

' Create an instance of our HTTP object
Set objWinHttp = Server.CreateObject("WinHttp.WinHttpRequest.5.1")

' Open a connection to the server
'   .Open(bstrMethod, bstrUrl [, varAsync])
objWinHttp.Open "POST", "http://www.asp101.com/samples/http_post_target.asp", False

' Set the content type header of our request to indicate
' the body of our request will contain form data.
'   .SetRequestHeader(bstrHeader, bstrValue)
objWinHttp.SetRequestHeader "Content-Type", "application/x-www-form-urlencoded"

' Send the request to the server.  Form data is sent in
' the body of the request.  Here I'm simply sending a
' name and a date.  You should URLEncode any data that
' contains spaces or special characters.
'   .Send(varBody)
objWinHttp.Send "Name=John&Date=" & Server.URLEncode(Now())

' Get the server's response status
strResponseStatus = objWinHttp.Status & " " & objWinHttp.StatusText

' Get the text of the response
strResponseText = objWinHttp.ResponseText

' Dispose of our object now that we're done with it
Set objWinHttp = Nothing
%>
<p>
<strong>This page made an HTTP post request to:</strong><br />
<code>http://www.asp101.com/samples/http_post_target.asp</code>
</p>

<p>
<strong>It sent two pieces of data:</strong><br />
<code>Name</code> and <code>Date</code>
</p>

<p>
<strong>Response Status:</strong> <code><%= strResponseStatus %></code>
</p>

<p>
<strong>The Response:</strong>
</p>
<table border="1">
<tr><td>
<%= strResponseText %>
</td></tr>
</table>
