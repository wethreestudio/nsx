<%@ LANGUAGE="VBSCRIPT" %>
<%Server.ScriptTimeout=360%>
<!--#INCLUDE FILE="functions.asp"--><!--#INCLUDE FILE="include/db_connect.asp"--><!--#INCLUDE FILE="include/sql_functions.asp"--><%
' Demo Page: http://jquery.bassistance.de/autocomplete/demo/search.php?q=blue&limit=10&timestamp=1329261118275
Response.ContentType = "text/plain"
query = SafeSqlParameter(Request.QueryString("q"))
If Len(query) > 0 Then
  SQL = "SELECT nsxcode,coName FROM coDetails WHERE nsxcode LIKE '" & query & "%' OR coName LIKE '%" & query & "%' ORDER BY case when nsxcode LIKE '" & query & "%' then 1 else 0 end + case when coName LIKE '" & query & "%' then 1 else 0 end DESC , nsxcode ASC"
  SearchRows = GetRows(SQL)
  SearchRowsCount = 0
  If Not IsNull(SearchRows) AND Not IsEmpty(SearchRows) Then
    If VarType(SearchRows) <> 0 Then SearchRowsCount = UBound(SearchRows,2)
    If SearchRowsCount >= 0 Then
      For i = 0 To  SearchRowsCount
        Response.Write SearchRows(0,i) & " - " & SearchRows(1,i) & "|" & SearchRows(0,i) & vbCrLf  
      Next
    End If
  End If
End If
%>