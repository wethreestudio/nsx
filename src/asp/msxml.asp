<%
Response.Write("Creating MSXML2.DOMDocument" & VbCrLf)
Set xmlSource = CreateObject("MSXML2.DOMDocument")
Set xmlSource2 = CreateObject("MSXML2.XMLDOMDocument2")

Response.Write("Finished!" & VbCrLf)
%>
