<!-- #INCLUDE file="../fckeditor-800282/fckeditor.asp" --><%
response.codepage = 65001   //unicode
response.charset = "UTF-8"
cms_edit_id = Request.QueryString("cms_edit_id") ' Can only edit one section at a time

Function SafeSqlParameter(Param)
  Param = Replace(Param, "'", "''")
  SafeSqlParameter = Param
End Function

' Checks if the user can edit content
Function UserCanEdit()
  UserCanEdit = false
  If LCase(Session("PASSWORDACCESS")) = "yes" And (LCase(Session("ADMIN")) = "true" Or LCase(Session("nsx")) = "true") Then 
    UserCanEdit = true
  End If  
End Function

Function GetContent(id, showEmptyMessage)
	Set conn = GetReaderConn()
	Set rs = Server.CreateObject("ADODB.Recordset")
  SQL = "SELECT html_content FROM cms_content WHERE id='" & SafeSqlParameter(id) & "'"
  rs.Open SQL, conn
  
  If Not rs.EOF Then 
    p = rs.GetRows(1,0)
    GetContent = p(0,0)
  End If
  If Len(GetContent) <= 0 And showEmptyMessage Then
    GetContent = "<p>This section does not yet have content. Please click on the edit icon at the bottom right of this text to add content.</p>"
  End If
  rs.Close
	Set rs = Nothing
End Function

Function UpdateContent(id, content)
	Set conn = GetWriterConn()
	Dim rs_eof

	Set rs = Server.CreateObject("ADODB.Recordset")
  SQL = "SELECT html_content FROM cms_content WHERE id='" & SafeSqlParameter(id) & "'"
  Dim qs
  for each key in Request.Querystring
    if key <> "cms_edit_id" then
      qs = qs & key & "=" & Request.Querystring(key) & "&amp;"
    end if
  next
  rs.Open SQL, conn
  If rs.EOF Then
    rs_eof = true
  Else
    rs_eof = false
  End If
  rs.Close
  Set rs = Nothing
  
  If rs_eof Then 
    SQL = "INSERT INTO cms_content (id,html_content,page_name, last_updated_by, last_updated_on, query_string) VALUES ('" & SafeSqlParameter(id) & "',N'" & SafeSqlParameter(content) & "','" & SafeSqlParameter(request.ServerVariables("SCRIPT_NAME"))  & "', '" & SafeSqlParameter(Session("USERNAME")) & "', GETDATE(),'" & SafeSqlParameter(qs) & "')"
    conn.Execute SQL 
  Else
    SQL = "UPDATE cms_content SET html_content=N'" & SafeSqlParameter(content) & "', page_name='" & SafeSqlParameter(request.ServerVariables("SCRIPT_NAME"))  & "', last_updated_by='" & SafeSqlParameter(Session("USERNAME")) & "', last_updated_on=GETDATE(), query_string='" & SafeSqlParameter(qs) & "' WHERE id='" & SafeSqlParameter(id) & "'"
    conn.Execute SQL
  End If
  ''''''''''''''''''''''''''''''''''
  ' Record a log of cms changes
  '''''''''''''''''''''''''''''''''' 
  Dim UserIPAddress
  UserIPAddress = Request.ServerVariables("HTTP_X_FORWARDED_FOR")
  If UserIPAddress = "" Then
  UserIPAddress = Request.ServerVariables("REMOTE_ADDR")
  End If
  SQL = "INSERT INTO cms_content_log (id,html_content,page_name, last_updated_by, last_updated_on, query_string, ip_address) VALUES ('" & SafeSqlParameter(id) & "',N'" & SafeSqlParameter(content) & "','" & SafeSqlParameter(request.ServerVariables("SCRIPT_NAME"))  & "', '" & SafeSqlParameter(Session("USERNAME")) & "', GETDATE(),'" & SafeSqlParameter(qs) & "','" & SafeSqlParameter(UserIPAddress) & "')"
  conn.Execute SQL  
	
End Function


Function RenderInEditMode(id,content)
  Dim qs
  for each key in Request.Querystring
    if key <> "cms_edit_id" then
      qs = qs & key & "=" & Request.Querystring(key) & "&amp;"
    end if
  next
  qs = qs & "cms_edit_id=" & id
%><div style="width:100%;border:1px dashed #cccccc">
<form action="<%=request.ServerVariables("SCRIPT_NAME") & "?" & qs %>" method="post">
    <input type="hidden" name="cms_edit_id" value="id"><%
  Dim oFCKeditor
  Set oFCKeditor = New FCKeditor
  oFCKeditor.BasePath	= "/fckeditor-800282/" 'sBasePath
  oFCKeditor.Value	= content
  oFCKeditor.Create "content"
%><br/>
    <input type="Submit" name="save" value="Save">&nbsp;<input type="Submit" name="cancel" value="Cancel">&nbsp;
    
    
    
<%
  SQL = "SELECT TOP 10 log_id, id, last_updated_by, last_updated_on FROM cms_content_log WHERE id='" & SafeSqlParameter(id) & "' ORDER BY last_updated_on DESC"
  'Response.Write SQL
  'Response.End
  
  histrows = GetRows(SQL)
  histrowscount = 0
  If VarType(histrows) <> 0 Then 
    histrowscount = UBound(histrows,2)
  End If
  If histrowscount > 0 Then
  Response.Write "&nbsp;Revert To:&nbsp;<select id=""log_id"" name=""log_id"">"
  Response.Write "  <option selected=""selected"" value="""">Select</option>"
  For i = 0 To  histrowscount
    log_id = histrows(0,i)
    last_updated_by = histrows(2,i)
    last_updated_on = histrows(3,i)
  %>  <option value="<%=log_id%>"><%=last_updated_by & " - " & last_updated_on %></option>
  <%
  Next  
  Response.Write "</select>&nbsp;<input type=""Submit"" name=""save"" value=""Revert"">"
  End If
%>   
    
  </form>
  </div>
  

  
  
  <%  
End Function

Function RenderInViewMode(id,content, viewClass)
  If UserCanEdit() Then 
    Dim qs
    for each key in Request.Querystring
      if key <> "cms_edit_id" then
        qs = qs & key & "=" & Request.Querystring(key) & "&amp;"
      end if
    next
    qs = qs & "cms_edit_id=" & id
    Response.Write "<div class=""editarea"" style=""border:1px dashed #cccccc;position:relative"">"
    Response.Write "<div style=""position:absolute;bottom:2px;right:-21px;opacity:0.6;""><a href=""" & request.ServerVariables("SCRIPT_NAME") & "?" & qs & """><img src=""/images/gtk-edit.png"" alt=""Edit this section""/></a></div>"
  Else
    Response.Write "<div class=""" & viewClass & """>"   
  End If

  Response.Write content
  Response.Write "</div>"
End Function


Function RenderContent(id, viewClass)
  content = GetContent(id, true)
  content_original = GetContent(id, false)
  If Request.QueryString("cms_edit_id") = id And UserCanEdit() And Request.ServerVariables("REQUEST_METHOD") = "GET" Then
    RenderInEditMode id, content_original
  ElseIf Request("cms_edit_id") = id And UserCanEdit() And Request.ServerVariables("REQUEST_METHOD") = "POST" Then
    content = Request("content")
    actionBtn = Request("save")
    If LCase(actionBtn) = "save" Then
      UpdateContent id, content
	  content = GetContent(id, true)
      RenderInViewMode id, content, viewClass
    ElseIf LCase(actionBtn) = "revert" Then  
      logId = Request("log_id")
      If IsNumeric(logId) Then
        Set conn = GetWriterConn()
        SQL = "UPDATE cms_content SET html_content=(SELECT l.html_content FROM cms_content_log l WHERE l.log_id=" & SafeSqlParameter(logId) & ") WHERE id='" & SafeSqlParameter(id) & "'"
        conn.Execute SQL
      End If
      content = GetContent(id, true)
      RenderInViewMode id, content, viewClass 
    Else
      RenderInViewMode id, content, viewClass 
    End If   
  Else
    RenderInViewMode id, content_original, viewClass  
  End If
End Function

%>