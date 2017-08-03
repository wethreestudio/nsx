<!--#INCLUDE FILE="include_all.asp"--><%
'------------------------------------------
' Adjust textarea box formatting
'str: the string to be adjusted
Function AdjTextArea(str)
	AdjTextArea = trim(Replace(str & " ", vbCrLf, "<BR>"))
	AdjTextArea = trim(Replace(AdjTextArea & " ", "''", "'"))

End Function
%>
<!--#INCLUDE FILE="header.asp"-->
<div class="container_cont">
<div class="table-responsive"><table border="0" width="797" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" rowspan="3" bgcolor="#FFFFFF"><!--#INCLUDE FILE="lmenu.asp"--></td>
  </tr>
  <tr>
    <td class="textheader" bgcolor="#FFFFFF" >
	<blockquote><h1>ASIC NSX Memorandum of Understanding</h1>
</blockquote>
	</td>
  </tr>
  <tr>
    <td class="plaintext" valign="top" bgcolor="#FFFFFF">
    
    &nbsp;
	<div align="center"><!--#INCLUDE FILE="header_tables.asp"-->
<div class="table-responsive"><table width="720" cellpadding="5" style="border-bottom:1px solid #666666; " cellspacing="0">


<%

currentpage = trim(request("currentpage"))
if len(currentpage)=0 then currentpage=1
currentpage=cint(currentpage)
if currentpage<1 then currentpage=1


id = CInt(request("id"))
Set ConnPasswords = GetReaderConn()
Set CmdDD = Server.CreateObject("ADODB.Recordset")
SQL = "SELECT * FROM news WHERE (id=" & CLng(SafeSqlParameter(id)) & ")"
CmdDD.Open SQL, ConnPasswords,1,3

 
    lap = 1
    cl = array("#FFFFFF","#EEEEEE")
  
  if CmdDD.EOF then 
  %>
	
  <tr>
    <td  height="20" class="plaintext">No Article Available.</td>
  </tr>
<% else
	while not CMDdd.EOF
%>
    <tr>
      <td  class=plaintext  bgcolor=<%=cl(lap)%>><b><font size="3"><%=adjtextarea(CmdDD("NewsTitle") & " ") %><br>
        </font></b><font size="1"><%=formatdatetime(CmdDD("newsDate"),1)%></font></td>
    </tr>
    <%lap = (-lap)+1%>
<tr>
      <td  class=plaintext  bgcolor=<%=cl(lap)%>><%=adjtextarea(CmdDD("NewsText") & " " )%></td>
    </tr>
    <%lap = (-lap)+1%>
        
<%if trim(cmddd("NewsAuthor") & " ") <> "" then%>
<tr>
      <td class=textlabel width=80 valign="top" bgcolor=<%=cl(lap)%>>Author: <%=adjtextarea(CmdDD("NewsAuthor") & " ")%></td>
    </tr>
    <%lap = (-lap)+1%>
    <%end if%>
        <%if trim(cmddd("newssource") & " ") <> "" then%>
		<tr>
      <td class=textlabel width=80 bgcolor=<%=cl(lap)%>>Source: <%=adjtextarea(CmdDD("NewsSource") & " ") %></td>
    	</tr>
    	<%lap = (-lap)+1%>
    	<%end if%>
      <%if trim(cmddd("newsurl") & " ") <> "" then%>
		<tr>
      <td class=textlabel bgcolor=<%=cl(lap)%>>Attachments:<br>
        <%=adjtextarea(CmdDD("NewsURL") & " ") %></td>
    	</tr>
   <%lap = (-lap)+1%>
    <%end if%>

    
    
<% Cmddd.MoveNext
	WEND
	end if
	%>



  
</table></div>
    
    
	</div>
    
    
<p align="left">&nbsp;</p>



<p align="center">&nbsp;</p>
    </td>
  </tr>
</table></div>
</div>
<!--#INCLUDE FILE="footer.asp"-->