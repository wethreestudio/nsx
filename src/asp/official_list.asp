<!--#INCLUDE FILE="include_all.asp"-->
<%
page_title = "Directory"
' meta_description = ""
' alow_robots = "no"
objJsIncludes.Add "cms_page", "/js/cms_page.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"

page = Request.QueryString("page")
If Len(Trim(page)) > 0 Then
	Set regEx = New RegExp 
	regEx.Pattern = "^[\w_\-]+$" 
	isPageValid = regEx.Test(page) 
	If Not isPageValid Then
	  Response.Redirect "/"
	End If
End if

objCssIncludes.Add "tablesortercss", "css/table_sort_blue.css"

Sub RenderSummary(sql, empty_message, right_col, right_col_heading, right_col_decimals, prefix, postfix, c)
  Set conn = GetReaderConn()
  Set rs = conn.Execute(SQL)
  style = ""
  i = 0
  If Len(c) > 0 Then
    style = " style=""color:" & c & """ "
  End If
%>
<div class="table-responsive"><table class="tablesorter">
    <thead> 
        <tr> 
            <th>Code</th>
            <th align="right" width="90">Last</th>
            <th align="right" width="90"><%=right_col_heading%></th>
        </tr> 
    </thead>
    <tbody>
<%
  If rs.EOF Then
%>
<tr>
  <td colspan="3"><%=empty_message%></td>
</tr>
<%
  Else
    While Not rs.EOF
		c = " class=""odd"""
		If i Mod 2 = 0 Then c = ""
%>
            <tr<%=c%>>
              <td><a href="/summary/<%=rs("tradingcode")%>"><%=rs("tradingcode")%></a></td>
              <td align="right">$<%=FormatNumber(rs("last"),3)%></td>
              <td align="right"<%=style%>><%=prefix & FormatNumber(rs(right_col),right_col_decimals) & postfix%></td>
            </tr>
<%
      rs.MoveNext 
	  i=i+1
    Wend  
  End If
%>
</tbody>
</table></div>  

<%
End Sub

%>
<!--#INCLUDE FILE="header.asp"-->
<%
Server.Execute "side_menu.asp"
%>
<div class="hero-banner subpage">
    <div class="hero-banner-img"></div>
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder subpage">
            <div class="col-sm-12 hero-banner-left">
                <h1>Directory</h1>
            </div>
        </div>
    </div>
</div>

<div class="container subpage">
    <div class="row">
        <div class="col-sm-12 official-list">
            <div class="subpage-center">
                <div class="editarea">
                    <!--<h1 style="display:inline-block;float:left">Official List</h1>
                    <br /><br /><br />-->
                    <a style="float:right" class="rss-link" href="<%= Application("nsx_SiteRootURL") %>/ftp/rss/nsx_rss_officiallist.xml">
                        <img class="rss" alt="RSS Official List" src="img/rss.jpg" title="RSS Official List">
                    </a>
<!--#INCLUDE FILE="admin/merchtools.asp"-->
<%

' multiple pages
currentpage = trim(request("currentpage"))
if Not IsNumeric(currentpage) Or len(currentpage) = 0 Then
	currentpage=1
Else
	currentpage=cint(currentpage)
	if currentpage<1 then currentpage=1
End If

srch=""
board=ucase(trim(request("board")))
if len(board)<>0 then srch = srch & " AND (coissues.displayboard LIKE '" & SafeSqlParameter(board) & "') "

' display todays prices
' if multiple codes requested then restrict by that otherwise ALL codes.
		
Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
 
ConnPasswords.Open Application("nsx_ReaderConnectionString")

SQL = "SELECT coDetails.coName, coIssues.nsxcode, coIssues.tradingcode, coIssues.ISIN, coIssues.IssueDescription, coIssues.IssueStatus, codetails.agadvisers, coissues.ibrokers, coissues.issuestarted, coissues.issuetype, codetails.agfacilitators, coissues.[bbgid], coissues.[bbgticker],codetails.[aglisteddate] "
SQL = SQL & " FROM coDetails INNER JOIN coIssues ON (coDetails.nsxcode = coIssues.nsxcode) "
SQL = SQL & " WHERE ((coIssues.iNewFloat=0) and (coIssues.IssueStatus IN('Active','Suspended','SU','TH','Trading Halt'))  AND (coIssues.DisplayBoard<>'SIMV'))" & srch
'SQL = SQL & " ORDER BY coIssues.IssueType,coIssues.tradingcode"
SQL = SQL & " ORDER BY coIssues.tradingcode"

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
maxpagesize = 15
maxpages = round(.5 + (rc / maxpagesize),0)
st = (currentpage * maxpagesize ) - maxpagesize
fh = st + maxpagesize - 1
if fh > rc then fh = rc

row_counter = 0

%>

Number of Listed Securities: <b><%=formatnumber(rc+1,0)%></b>
<a href='ftp/rss/nsx_txt_officiallist.csv' class='blue-link'>Download list</a>

<div class="pagebar" style="padding-bottom:15px;">Pages:&nbsp;
<%if currentpage > 1 then %>
<a href="/marketdata/directory/?currentpage=<%=currentpage-1%>" title="Previous">Previous</a>                 
<%end if%>
            
<%
      for ii = 1 to maxpages
        if ii = currentpage then 
      %>
        <span class="this-page"><%=ii%></span>
      <%
      	else
      %>
      <a href="/marketdata/directory/?currentpage=<%=ii%>" title="Page <%=ii%>"><%=ii%></a>
<%
    end if
      next
%>
      <%if maxpages > CurrentPage then %>
<a href="/marketdata/directory/?currentpage=<%=currentpage+1%>" title="Next">Next</a>                 
      <%end if%>
</div>

<div class="table-responsive">
<div class="table-responsive"><table id="myTable" class="tablesorter1 table">
        <%
		prvcode =""
		lapend = false
    if WEOF then 
    	response.write "<tr><td colspan=12 class=plaintext>No details available.</td></tr>" 
    else
		lapstart = True
       for jj = st to fh

      	  coname = replace(alldata(0,jj) & " ","''","'")
      	  nsxcode = alldata(1,jj) 
      	  tradingcode = alldata(2,jj)
      	  isin = alldata(3,jj)
      	  issuedescription = replace(alldata(4,jj) & " ","''","'")
      	  issuestatus = alldata(5,jj)
      	  advisers = replace(alldata(6,jj) & " ","''","'")
      	  brokers = replace(alldata(7,jj) & " ","''","'")
      	  issuestarted = fmtdate(alldata(8,jj))
      	  issuetype = alldata(9,jj)
      	  facilitators =replace(alldata(10,jj) & " ","''","'")
		  bbgid = replace(alldata(11,jj) & " ","''","'")
		  bbgticker = replace(alldata(12,jj) & " ","''","'")
		  aglisteddate = alldata(13,jj)
		  if trim(agListedDate & " ") = "" then
			aglisteddate =  "To be advised"
		  else
			aglisteddate = fmtdate(agListedDate)
    	  end if
      	  
      cl = array("#EEEEEE","#FFFFFF")
	

	if lapstart then
		lapstart = false
		else
		if prvcode <> nsxcode then
			response.write "  </table></div>" & vbCrLf
      response.write " </td>" & vbCrLf
      response.write "</tr>" & vbCrLf  & vbCrLf
			lap = (-lap)+1
		end if
	end if
		
	
  if prvcode <> nsxcode then
    c = " class=""tr_odd"""
    If row_counter Mod 2 = 0 Then c = " class=""tr_even"""
    row_counter = row_counter + 1
%>
  <tr<%=c%>> 
     <td width=20 class="plaintext" valign="top"><a href="/marketdata/company-directory/<%=nsxcode%>/" title="click for company details"><%=nsxcode %></a></td>
     <td width=700 class="plaintext" valign="top"><a href="/marketdata/company-directory/details/<%=nsxcode%>/" title="click for company details"><%=Server.HTMLEncode(CoName)%></a> (issuer listed on: <%=aglisteddate%>)<br>
		<div class="table-responsive"><table class="ol_inner" border=0 >
	   <tr class="ol_inner">
          <td class="ol_inner" valign="top" width="100" >Code</td>
          <td class="ol_inner" valign="top" width="100" >ISIN</td>
		  <td class="ol_inner" valign="top" width="220" >FIGI</td>
          <td class="ol_inner" valign="top" width="300" >Adviser</td>
		<td  class="ol_inner" valign="top" width="100" >Status</td>
          <td class="ol_inner" valign="top" nowrap align="right">Security Listed On</td>
        </tr>
<%
  end if
%>
	 <tr class="ol_inner" >
	 <td class="ol_inner" valign="top" width="100"><%=tradingcode %></td>
	 <td class="ol_inner" valign="top" width="100"><%=isin%>&nbsp;</td>
	 <td class="ol_inner" valign="top" width="100"><%=bbgid%>&nbsp;</td>
     <td class="ol_inner" valign="top" width="200"><%
		bb =  adjtextarea(advisers) & "<BR>"
		cc = instr(bb,"<BR>")-1
       response.write Server.HTMLEncode(left(bb,cc))

     %>&nbsp;</td>
    
     <td  class="ol_inner" valign="top" width="100"><%
		bb = ucase(adjtextarea(issuestatus))
		if bb = "ACTIVE" then 
			response.write ""
			else
			response.write bb
		end if
	
         %>&nbsp;</td>
    
     <td class="ol_inner" valign="top" nowrap align="right"><%=issuestarted%>&nbsp;</td>
    </tr>
    
	<%
	
prvcode = nsxcode
  
NEXT
		  %>
		  </table></div>
		  <%
		  
end if
    %>
            </td>
        </tr>
    </table></div>
</div>
<div class="pagebar">Pages:&nbsp;
      <%if currentpage > 1 then %>
<a href="/marketdata/directory/?currentpage=<%=currentpage-1%>" title="Previous">Previous</a>                 
            <%end if%>
            
            <%
      for ii = 1 to maxpages
            	if ii = currentpage then 
      %>
        <span class="this-page"><%=ii%></span>
      <%
      	else
      %>
      <a href="/marketdata/directory/?currentpage=<%=ii%>" title="Page <%=ii%>"><%=ii%></a>
      <%
      	end if
      next
      
      %>
      <%if maxpages > CurrentPage then %>
<a href="/marketdata/directory/?currentpage=<%=currentpage+1%>" title="Next">Next</a>                 
      <%end if%>
</div>
</div>
</div>  
</div>
</div>
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->