<!--#INCLUDE FILE="include_all.asp"-->
<%
id = request("id")
Set regEx = New RegExp 
regEx.Pattern = "^[0-9]+$" 
isCodeValid = regEx.Test(id) 
If Not isCodeValid Then
  Response.Redirect "/"
  Response.End
End If



'------------------------------------------
' Adjust textarea box formatting
'str: the string to be adjusted
Function AdjTextArea(str)
	AdjTextArea = trim(Replace(str & " ", vbCrLf, "<BR>"))
	AdjTextArea = trim(Replace(AdjTextArea & " ", "''", "'"))

End Function

'------------------------------------------
' Adjust textarea box formatting
'str: the string to be adjusted
Function AdjTextAreanobr(str)
	AdjTextAreanobr = trim(Replace(str & " ", "''", "'"))

End Function
%>
<!--#INCLUDE FILE="header.asp"-->
 
<div class="container_cont">
<div class="table-responsive"><table border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" rowspan="3" bgcolor="#FFFFFF"><!--#INCLUDE FILE="lmenu.asp"--></td>
  </tr>
  <tr>
    <td class="textheader" bgcolor="#FFFFFF" >
	<h1><b>&nbsp;<font color="#FFFFFF">&nbsp;&nbsp;&nbsp;
      <font face="Arial">&nbsp;&nbsp;</font></font></b><font face="Arial">VIEW 
	EVENT DETAILS</h1>
	</td>
  </tr>
  <tr>
    <td class="plaintext" valign="top" bgcolor="#FFFFFF">
    
    &nbsp;
	<div align="center">
<div class="table-responsive"><table width="100%" cellpadding="5" style="border-bottom:1px solid #666666; " cellspacing="0">


<%

currentpage = trim(request("currentpage"))
if len(currentpage)=0 then currentpage=1
currentpage=cint(currentpage)
if currentpage<1 then currentpage=1



Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
ConnPasswords.Open Application("nsx_ReaderConnectionString")   
SQL = "SELECT * FROM events WHERE (id=" & CLng(SafeSqlParameter(id)) & ")"
CmdDD.Open SQL, ConnPasswords,1,3

 
    lap = 1
    cl = array("#FFFFFF","#EEEEEE")
  
  if CmdDD.EOF then 
  %>
	
  <tr>
    <td class="plaintext" colspan="2">No Article Available.</td>
  </tr>
<% else
	while not CMDdd.EOF
%>
    <tr>
      <td class=plaintext colspan="2" bgcolor=<%=cl(lap)%> align="left"><b><font size="3"><%=adjtextareanobr(CmdDD("eventTitle") & " ") %></td>
    </tr>
    <%lap = (-lap)+1%>
    <%if trim(cmddd("eventtext") & " ") <> "" then%>
<tr>
      <td class=plaintext colspan="2" bgcolor=<%=cl(lap)%> align="left"><%=adjtextareanobr(CmdDD("eventText") & " " )%></td>
    </tr>
    <%lap = (-lap)+1%>
    <%end if%>
        
<%if trim(cmddd("eventAuthor") & " ") <> "" then%>
<tr>
      <td class=textlabel width=100 valign="top" bgcolor=<%=cl(lap)%>>Date/Place:</td>
      <td class=plaintext align=left bgcolor=<%=cl(lap)%>><p align=left><%=adjtextareanobr(CmdDD("eventAuthor") & " ")%></p></td>
    </tr>
    <%lap = (-lap)+1%>
    <%end if%>
        <%if trim(cmddd("eventsource") & " ") <> "" then%>
		<tr>
      <td class=textlabel align=left width=100 bgcolor=<%=cl(lap)%>>Source:</td>
      <td class=plaintext align=left bgcolor=<%=cl(lap)%>><%=adjtextareanobr(CmdDD("eventSource") & " ") %></td>
    	</tr>
    	<%lap = (-lap)+1%>
    	<%end if%>
      <%if trim(cmddd("eventurl") & " ") <> "" then%>
		<tr>
      <td class=textlabel colspan="2" align=left bgcolor=<%=cl(lap)%>>Link: 
        <%
        
        eventurl=adjtextareanobr(CmdDD("eventURL") & " ") 
        eventurl=replace(eventurl,"<p>","")
        eventurl=replace(eventurl,"</p>","")
        if instr(eventurl,"<a href")>0 then
        	response.write eventurl
        else
			eventurl1 = eventurl
			if Left(eventurl1,Len("http://")) <> "http://" Then
				eventurl1 = "http://" & eventurl
			End If
        	response.write "<a href='" & eventurl1 & "' target=_blank>" & eventurl & "</a>"
        end if
        
        %></td>
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

<%
CmdDD.Close
Set CmdDD = Nothing
ConnPasswords.Close
Set ConnPasswords = Nothing
%>