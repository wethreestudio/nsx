<!--#INCLUDE FILE="include_all.asp"-->
<!--#INCLUDE FILE="admin/merchtools.asp"-->
<%
Function remcrlf(xx)
  remcrlf = replace(xx & " ",vbCRLF,"")
  remcrlf = trim(Replace(remcrlf & " ", "''", "'"))
End Function

is_odd = false

Function trClass()
	if is_odd then
		trClass = " class=""odd"""
	else
		trClass = ""
	end if
	is_odd = Not is_odd
End Function

id = request.querystring("nsxcode")
sql = "SELECT TOP 1 coName FROM coDetails WHERE nsxcode='" & SafeSqlParameter(id) & "'"
Set conn = GetReaderConn()
Set rs = conn.Execute(sql)
coname = rs("coName")



objCssIncludes.Add "table_sort_blue", "/css/table_sort_blue.css"
'coname=ucase(request("coname"))
%>


<!--#INCLUDE FILE="header.asp"-->
<div class="container_cont">
<div class="editarea">

<h1>Issued Capital Details - <%=coname%></h1>



<%
errmsg=""
currentpage = trim(request("currentpage"))
if len(currentpage)=0 then currentpage=1
currentpage=cint(currentpage)
if currentpage<1 then currentpage=1


uptodate = request.querystring("uptodate")
if len(id)=0 then id="pmi"
if len(uptodate)=0 then 
	srch =""
	else
	uptodate = cdate(uptodate)
	srch = " AND capitalexdate<='" & FormatSQLDate(uptodate,false) & "' "
end if

Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
 
ConnPasswords.Open Application("nsx_ReaderConnectionString")
SQL=" SELECT nsxcode,tradingcode,capitalexdate,capitaltype,capitaldescription,capitalchange,capitalannfile,capitalanndate,listedtype"
SQL = SQL & " FROM capital "
SQL = SQl & " WHERE (nsxcode='" & left(id,3) & "') " & srch
SQL = SQL & " ORDER BY tradingcode,capitalexdate,id"

'response.write SQL

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
maxpagesize = 1000
maxpages = round(.5 + (rc / maxpagesize),0)
st = (currentpage * maxpagesize ) - maxpagesize
fh = st + maxpagesize - 1
if fh > rc then fh = rc
 
    lap = 0
    cl = array("#FFFFFF","#EEEEEE")
    
 


%>


<%  if WEOF then %>
	 
   There is no record available.
<% else %>
  
 
<div class="table-responsive"><table id="myTable" class="tablesorter" width="99%">
<thead>
        <tr>
          <th valign="top" align="left">Security</th>
		  <th valign="top" align="center">Event Date</th>
		  <th valign="top" align="left">Type</th>
		  <th valign="top" align="left">Description</th>
		  <th valign="top" align="left">Issued</th>
		  <th valign="top" align="left" nowrap="nowrap">Total Securities</th>
		  <th valign="top" align="left">Reference</th>
		  <th valign="top" align="left">Status</th>
        </tr>
		</thead>
       <tbody> 

  	<%
  	lap=1
      	  listed = 0
      	  unlisted = 0
      	  prvcode=""
      	 for jj = st to fh
      	 	tradingcode=alldata(1,jj)
      	 

if (prvcode<>tradingcode) and prvcode<>"" then
is_odd = false
%>
<tr>
	<td colspan="8" style="background-color:#C1C1C1;color:#fff;font-weight:bold;">
	Total <%=prvcode%> Listed: <%=formatnumber(listed,0)%><br>
	Total <%=prvcode%> Unlisted: <%=formatnumber(unlisted,0)%><br>
	Current <%=prvcode%> Issued Capital: <%=formatnumber(unlisted+listed,0)%>
	</td>
</tr>
<%
lap = 1
listed = 0
unlisted = 0 
end if
 
			nsxcode=alldata( 0,jj)
		
			capitalexdate=alldata(2,jj)
			if isdate(capitalexdate) then capitalexdate = fmtdate(capitalexdate)
			capitaltype=alldata(3,jj)
			capitaldescription=alldata(4,jj)
			capitalchange=formatnumber(alldata(5,jj),0)
			capitalannfile=trim(alldata(6,jj) & " ")
			capitalanndate=alldata(7,jj)
			listedtype=ucase(alldata(8,jj))
			if listedtype="LISTED" then 
				listed = listed + capitalchange
				else
				unlisted = unlisted + capitalchange
			end if
			if isdate(capitalanndate) then capitalanndate = fmtdate(capitalanndate)

			if capitalannfile <> "" then
			
			capurl = "ftp/news/"
			'if (instr(capitalannfile,"BSX"))>0 then capurl = "http://www.bsx.com.au/dataRepository/"
			
			capitalannfile="<a href=" & capurl & capitalannfile & " target=_blank><img src=images/icons/txt.gif border=0></a>"
			else
			capitalannfile=""
			end if
	  


				
    %>
  <tr <%=trClass()%>>
    <td valign="top" ><%=tradingcode%></td>
    <td valign="top" nowrap><%=capitalexdate%></td>
    <td valign="top"><%=capitaltype%></td>
    <td valign="top"><%=capitaldescription%></td>
    <td valign="top" align="right" nowrap><%=capitalchange%></td>
    <td valign="top" align="right" nowrap><%=formatnumber(listed+unlisted,0)%></td>
    <td valign="top" align="center"><%=capitalannfile%></td>
    <td valign="top" align="center"><%=listedtype%></td>
  </tr>
    
<%

prvcode = tradingcode
NEXT %>

<tr>
	<td colspan="8" style="background-color:#C1C1C1;color:#fff;font-weight:bold;">
		Total <%=tradingcode%> Listed: <%=formatnumber(listed,0)%><br>
		Total <%=tradingcode%> Unlisted: <%=formatnumber(unlisted,0)%><br>
		Current <%=tradingcode%> Issued Capital: <%=formatnumber(unlisted+listed,0)%>
	</td>
</tr>

</tbody>
</table></div>


<%
	end if
	%>
 
	

</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->
