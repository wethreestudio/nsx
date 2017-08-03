<!--#INCLUDE FILE="include_all.asp"-->
<%
id = Trim(SafeSqlParameter(request.querystring("id")))
t = Trim(SafeSqlParameter(request.querystring("t")))
q = Trim(SafeSqlParameter(request.querystring("q")))
st = Trim(SafeSqlParameter(request.querystring("st")))

query = LCase(SafeSqlParameter(Request.QueryString("q")))

' Check if exact match on issue
SQL_ISSUE = "SELECT [iid], [tradingcode], [IssueDescription] FROM [nsx].[dbo].[coIssues] WHERE [tradingcode] = '" & query & "' AND IssueStatus='Active'"
Set conn = GetReaderConn()
Set rs = conn.Execute(SQL_ISSUE)
tradingcode = ""
If Not rs.EOF Then 
	tradingcode = rs("tradingcode")
End If
rs.Close()
conn.Close()
Set rs = Nothing
Set conn = Nothing

If Len(tradingcode) > 0 Then
    Response.Redirect "/summary/" & tradingcode
    Response.End 
End If



If Len(id) > 0 And ( t = "broker" Or t = "company" Or t = "adviser" Or t = "issue" ) Then
  If t = "broker" Then
    Response.Redirect "/broker_profile.asp?region=&id=" & id
    Response.End  
  End If
  If t = "adviser" Then
    Response.Redirect "/adviser_profile.asp?id=" & id
    Response.End  
  End If
  If t = "issue" Then
    Response.Redirect "/summary/" & id
    Response.End 
  End If
  If t = "company" Then
    If st = "ann" Then
      Response.Redirect "/marketdata/search_by_company?nsxcode=" & id
      Response.End  
    End If
    If st = "delst" Then
      Response.Redirect "/marketdata/delisted?nsxcode=" & id
      Response.End      
    End If
    If st = "waivers" Then
      Response.Redirect "/companies_listed/waivers?nsxcode=" & id
      Response.End      
    End If    
    Response.Redirect "/company_details.asp?nsxcode=" & id
    Response.End  
  End If  
End If

page_title = UCase(security_code) & "NSX Search Page"
alow_robots = "no"

objJsIncludes.Add "tablesorter", "/js/jquery.tablesorter.min.js"
objJsIncludes.Add "tablesorterp", "/js/addons/pager/jquery.tablesorter.pager.js"

objCssIncludes.Add "tablesorterpcss", "/js/addons/pager/jquery.tablesorter.pager.css"

%>
<!--#INCLUDE FILE="header.asp"-->

<div class="container_cont">

<h1>Search Results</h1>


<table id="myTable" class="tablesorter" width="99%"> 
<thead> 
<tr> 
    <th>Code</th>
    <th>Type</th>  
    <th>Description</th>   
</tr> 
</thead> 
<tbody>
<%

sql = "SELECT id, id_type, s1, s2, s3 FROM Search WHERE (s1 LIKE '%" & query & "%' OR s2 LIKE '%" & query & "%' OR s3 LIKE '%" & query & "%') AND (id_type='company' OR id_type='issue') ORDER BY s1 , s2, s3, id"
'response.write sql
Set conn = GetReaderConn()
Set rs = conn.Execute(sql)
If rs.EOF Then
  %><tr><td colspan="4" align="center">No matches found. Please search again.</td></tr><%
Else
  i = 0
  While Not rs.EOF
    code = rs("id")
    company = rs("s1")
    id_type = rs("id_type")
    c = " class=""odd"""
    If i Mod 2 = 0 Then c = ""
    If id_type = "issue" Then
%>
  <tr<%=c%>> 
      <td width="80px"><a href="/summary/<%=UCase(code)%>"><b><%=UCase(code)%></b></a></td>
      <td>Trading Code - View trading information.</td> 
      <td><%=Server.HTMLEncode(company)%></td>  
  </tr> 
<% 
    ElseIf id_type = "company" Then
%>
  <tr<%=c%>> 
      <td width="80px"><a href="/company_details.asp?nsxcode=<%=UCase(code)%>"><b><%=UCase(code)%></b></a></td>
      <td>Company Details</td>
      <td><%=Server.HTMLEncode(company)%></td>  
  </tr> 
<%     
    End If   
    
    
    rs.MoveNext 
    i = i + 1
  Wend  
End If
%>
</tbody>
</table>







</div>


<!--#INCLUDE FILE="footer.asp"-->