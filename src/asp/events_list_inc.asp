<!--#INCLUDE FILE="include/sql_functions.asp"-->
<%
'------------------------------------------
' Adjust textarea box formatting
'str: the string to be adjusted
Function AdjTextArea(str)
	AdjTextArea = trim(Replace(str & " ", vbCrLf, "<BR>"))
	AdjTextArea = trim(Replace(AdjTextArea & " ", "''", "'"))

End Function

Function RemoveHTML( strText )
	Dim RegEx

	Set RegEx = New RegExp

	RegEx.Pattern = "<[^>]*>"
	RegEx.Global = True

	RemoveHTML = RegEx.Replace(strText, "")
End Function
%>


<%

errmsg=""
currentpage = trim(request("currentpage"))
if len(currentpage)=0 then currentpage=1
currentpage=cint(currentpage)
if currentpage<1 then currentpage=1
displayboard = session("region")

Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
 

ConnPasswords.Open Application("nsx_ReaderConnectionString")
SQL = "SELECT TOP 14 id,eventdate,eventtitle,eventprecise  FROM events "
SQL = SQL & " WHERE (recorddatestamp >=dateadd(d,-720, CONVERT(datetime, '" & SafeSqlParameter(FormatSQLDate(date,false)) & "'))) "
if len(displayboard)<>0 then
  SQL = SQL & " AND (eventdisplayboard like '%" & displayboard & "%')"
end if
SQL = SQL & " ORDER BY eventDate DESC"


CmdDD.CacheSize=100
CmdDD.Open SQL, ConnPasswords,1,3

WEOF = CmdDD.EOF

'can only do getrows if there is more than one record.
if not WEOF then 
	alldata = cmddd.getrows
	rc = ubound(alldata,2) 
	else
	rc = -1
end if

CmdDD.Close
Set CmdDD = Nothing

ConnPasswords.Close
Set ConnPasswords = Nothing

rowcount = 0
maxpagesize = 14
maxpages = round(.5 + (rc / maxpagesize),0)
st = (currentpage * maxpagesize ) - maxpagesize
fh = st + maxpagesize - 1
if fh > rc then fh = rc

%>
 
  
<table cellspacing="0" cellpadding="5" width="100%" >
  <%  if WEOF then %>
	
  <tr>
    <td width="100%" class="plaintext">There are no events articles available.</td>
  </tr>
<% else
	
      	  for jj = st to fh
      	  
      	  id = alldata(0,jj)
      	  eventdate = alldata(1,jj) 
      	  eventtitle = trim(left(alldata(2,jj),65) & " ")
      	  eventprecise = alldata(3,jj)
      	  
      	 cl = array("#EEEEEE","#FFFFFF")
	lap = (-lap)+1
				
    %>
  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
       <td width="100%" class="plaintext" >
	<img border="0" src="images/broker_page1_bullet.gif" width="20" height="15"><a href=<%="events_view.asp?ID=" & ID & "&region=" & displayboard & " title=""" & left(removehtml(eventprecise & " "),100) & """"%>><font size="1"><%=adjtextarea(eventTitle)%></font></a></td>
  </tr>
<% NEXT
	end if
	%>
  
</table>
    
  