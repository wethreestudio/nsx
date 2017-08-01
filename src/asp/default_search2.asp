<%@ LANGUAGE="VBSCRIPT" %>
<%Server.ScriptTimeout=360%>
<!--#INCLUDE FILE="functions.asp"--><!--#INCLUDE FILE="include/db_connect.asp"--><!--#INCLUDE FILE="include/sql_functions.asp"--><%
' Demo Page: http://jquery.bassistance.de/autocomplete/demo/search.php?q=blue&limit=10&timestamp=1329261118275
Response.ContentType = "text/plain"
Response.charset="charset=utf-8" ' sfe added 25/8/14 to make sure unicode compatable
query = SafeSqlParameter(Request.QueryString("q"))
rt = SafeSqlParameter(Request.QueryString("rt"))

t = LCase(SafeSqlParameter(Request.QueryString("t")))
SQL = ""
If Len(query) > 0 Then
  If Len(rt) > 0 AND rt = "waivers" Then
    SQL = "SELECT RequestedForSecurities FROM waivers "
    Dim seca 
    waiverRows = GetRows(SQL)
    waiverRowsCount = 0
    If Not IsNull(waiverRows) AND Not IsEmpty(waiverRows) Then
      If VarType(waiverRows) <> 0 Then waiverRowsCount = UBound(waiverRows,2)
      If waiverRowsCount >= 0 Then
        For i = 0 To  waiverRowsCount
          sec = waiverRows(0,i)
          seca = Split(sec,",")
          ' initems = "'" & ImpolodeCollection(seca,"','") & "'"
        Next
      End If
    End If 
    For Each s In seca
      If Trim(LCase(s)) = Trim(LCase(query)) Then
      
      End If 
		  ret = ret & element & joiner
    Next 
    SQL = "SELECT  nsxcode,issuedescription,tradingcode FROM coIssues "
    SQL = SQL & " WHERE (coIssues.iNewFloat=0) AND (coIssues.Issuestatus ='Delisted') AND (tradingcode LIKE '%" & query & "%' OR issuedescription LIKE '%" & query & "%')"
    SQL = SQL & " ORDER BY coIssues.TradingCode"    
  ElseIf Len(rt) > 0 AND rt = "delst" Then
    SQL = "SELECT  nsxcode,issuedescription,tradingcode FROM coIssues "
    SQL = SQL & " WHERE (coIssues.iNewFloat=0) AND (coIssues.Issuestatus ='Delisted') AND (tradingcode LIKE '%" & query & "%' OR issuedescription LIKE '%" & query & "%')"
    SQL = SQL & " ORDER BY coIssues.TradingCode"
  Else
	' Check if exact match on issue
	SQL_ISSUE = "SELECT [iid], [tradingcode], [IssueDescription] FROM [nsx].[dbo].[coIssues] WHERE [tradingcode] = '" & query & "' "
	Set conn = GetReaderConn()
	Set rs = conn.Execute(SQL_ISSUE)
	If rs.EOF Then 
		If Len(t) > 0 Then
		  SQL = "SELECT id, id_type, s1, s2, s3 FROM Search WHERE id_type='" & t & "' AND (s1 LIKE '%" & query & "%' OR s2 LIKE '%" & query & "%' OR s3 LIKE '%" & query & "%') ORDER BY s1 , s2, s3, id"
		Else
		  SQL = "SELECT id, id_type, s1, s2, s3 FROM Search WHERE s1 LIKE '%" & query & "%' OR s2 LIKE '%" & query & "%' OR s3 LIKE '%" & query & "%' ORDER BY s1 , s2, s3, id"
		End If
	Else
		SQL = ""
		While Not rs.EOF
			Response.Write rs("IssueDescription") & " - " & rs("tradingcode") & "|" & rs("tradingcode") & ";issue" & vbCrLf 
			rs.MoveNext 
		Wend
		Response.End
	End If
	rs.Close()
	Set rs = Nothing
  End If
End If

If Len(t) > 0 Then
  If t <> "broker" And t <> "company" And t <> "adviser" Then
    Response.Write ""
    Response.End
  End If
End If
If Len(query) > 0 Then
  SearchRows = GetRows(SQL)
  SearchRowsCount = 0
  If Not IsNull(SearchRows) AND Not IsEmpty(SearchRows) Then
    If VarType(SearchRows) <> 0 Then SearchRowsCount = UBound(SearchRows,2)
    If SearchRowsCount >= 0 Then
      For i = 0 To  SearchRowsCount
        If Len(rt) > 0 AND rt = "delst" OR rt = "waivers" Then
           Response.Write SearchRows(1,i) & " - " & SearchRows(0,i) & "|" & SearchRows(0,i) & ";company" & vbCrLf 
        Else
          Response.Write SearchRows(2,i) & " - " & SearchRows(3,i) & "|" & SearchRows(0,i) & ";" & SearchRows(1,i) & vbCrLf 
        End If 
      Next
    End If
  End If
End If
%>