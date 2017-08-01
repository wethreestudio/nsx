<!--#INCLUDE FILE="include_all.asp"--><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <title>Fix Links</title>
  </head>
  <body>
<%
sql = "SELECT * FROM cms_content"
Set conn = GetReaderConn()
Set connw = GetWriterConn()
Set rs = conn.Execute(sql)
If rs.EOF Then
  %><p style="color:red;">No Records</p><%
Else
  i = 0
  While Not rs.EOF ' AND i < 5
    id = rs("id")
    content = rs("html_content")
    content = Replace(content, "http://61.8.13.170:8888", "")
    content = Replace(content, "http://www.nsxa.com.au", "")
    content = Replace(content, "http://nsxa.com.au", "")
	content = Replace(content, "http://staging.nsxa.com.au", "")

    Response.Write"<hr><div>Updated:" & id & "</div>"
    
    update_sql = "UPDATE cms_content SET [html_content]='" & SafeSqlParameter(content) & "' WHERE id='" & SafeSqlParameter(id) & "'"
    'response.write update_sql & "<br>" & vbCrLf
	connw.Execute(update_sql)
    rs.MoveNext
    i = i + 1	
  Wend  
End If


%>
  </body>
</html>
<%
DBDisconnect()
%>