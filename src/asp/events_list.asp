<!--#INCLUDE FILE="include_all.asp"-->
<%
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
<table border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" rowspan="3" bgcolor="#FFFFFF"><!--#INCLUDE FILE="lmenu.asp"--></td>
  </tr>
  <tr>
    <td class="textheader" bgcolor="#FFFFFF" >
	<h1><b>&nbsp;<font color="#FFFFFF">&nbsp;&nbsp;&nbsp;
      <font face="Arial">&nbsp;</font></font><font face="Arial">&nbsp;</font></b><font face="Arial">INTERESTING 
	EVENTS</h1>
	</td>
  </tr>
  <tr>
    <td class="plaintext" valign="top" bgcolor="#FFFFFF">
    
    <div align="center">
<table width="100%" cellspacing="0" cellpadding="5">


<%

errmsg=""
currentpage = trim(request("currentpage"))
if len(currentpage)=0 then currentpage=1
currentpage=cint(currentpage)
if currentpage<1 then currentpage=1


Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
 

ConnPasswords.Open Application("nsx_ReaderConnectionString")
SQL = "SELECT id,eventdate,eventtitle,eventprecise,eventauthor  FROM events "
SQL = SQL & " WHERE recorddatestamp >=dateadd(d,-720, CONVERT(datetime, '" & SafeSqlParameter(FormatSQLDate(date,false)) & "'))"
SQL = SQL & " ORDER BY eventDate DESC"
'dateadd(d,-30,GETDATE())

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
maxpagesize = 30
maxpages = round(.5 + (rc / maxpagesize),0)
st = (currentpage * maxpagesize ) - maxpagesize
fh = st + maxpagesize - 1
if fh > rc then fh = rc

%>
   





  <tr>
    <td width="100%" class="plaintext" colspan="2" align="right"><%if currentpage > 1 then %>
                <font face="Arial">
	<a href="announcements_status.asp?nsxcode=<%=nsxcodes%>&currentpage=<%=currentpage-1%>">
	&lt;&lt;</a> </font><a href="events_list.asp?currentpage=<%=currentpage-1%>">Previous <%=maxpagesize%></a> | 
            <%end if%>
            
            <%
      for ii = 1 to maxpages
            	if ii = currentpage then 
      		response.write "<b>" & ii & "</b> | "
      	else
      %>
      <a href="events_list.asp?currentpage=<%=ii%>" ><%=ii%></a> | 

      <%
      	end if
      next
      
      
    
      %>
      <%if maxpages > CurrentPage then %>
              
             <a href="events_list.asp?currentpage=<%=currentpage+1%>">Next <%=maxpagesize%> </a>
	<font face="Arial">
	<a href="announcements_status.asp?nsxcode=<%=nsxcodes%>&currentpage=<%=currentpage-1%>">
	&gt;&gt;</a></font>
      <%end if%>
</td>
  </tr>
</table>
</div>
	<div align="center">
<table width="100%" cellspacing="0" cellpadding="5" style="border-bottom:1px solid #666666; ">
  <tr>
    <td width="10%" class="plaintext" bgcolor="#666666"><font color="#FFFFFF"><b>Date/Place</b></font></td>
    <td width="90%" class="plaintext" bgcolor="#666666"><font color="#FFFFFF">
	<b>Event</b></font></td>
  </tr>
<%  if WEOF then %>
	
  <tr>
    <td width="20%" class="plaintext">&nbsp;</td>
    <td width="80%" height="20" class="plaintext">There are no events articles available.</td>
  </tr>
<% else
	
      	  for jj = st to fh
      	  
      	  id = alldata(0,jj)
      	  eventdate = alldata(1,jj) 
      	  eventtitle = alldata(2,jj)
      	  eventprecise = alldata(3,jj)
      	  eventauthor = alldata(4,jj)
      	  
      	 cl = array("#EEEEEE","#FFFFFF")
	lap = (-lap)+1
				
    %>
  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
       <td width="20%" class="plaintext" valign="top" >
	<font size="1"><%=eventauthor%></font></td>
    <td width="80%" height="20" class="plaintext" ><b><%=adjtextarea(eventTitle)%> </b>
    <%=adjtextarea(left(eventPrecise,150)) %>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <a href=<%="events_view.asp?ID=" & ID%>><i>More ...</i></a>
    </td>
  </tr>
<% NEXT
	end if
	%>



  
</table>
    
    
    	
			<p align="left">NSX does warrant the content of these events.&nbsp; 
			Details are provided for information purposes only.&nbsp; NSX 
			reserves the right to refuse the display of an event.
	</div>
    
    
    </td>
  </tr>
</table>
</div>
<!--#INCLUDE FILE="footer.asp"-->