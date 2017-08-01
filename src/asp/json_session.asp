<%
Response.ContentType="text/json"
%>
{
<%
    For Each Item In Session.Contents 
		if Item <> "PASSWORD" Then
        Response.Write """" & Item & """ : """ & Session(Item) & """," & vbCrLf     
		End If
    Next 
	Response.Write """END"" : ""END"""
%>
}