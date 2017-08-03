<!--#INCLUDE FILE="include_all.asp"-->
<%

Response.Redirect "/marketdata/official_list"
Response.End


page_title = "Market Official List"
' meta_description = ""
' alow_robots = "no"
' objJsIncludes.Add "marketdata", "js/marketdata.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"

%>
<!--#INCLUDE FILE="header.asp"-->
 
<div class="container_cont">







<div class="editarea">  
<h1>Official List<a href="<%= Application("nsx_SiteRootURL") %>/ftp/rss/nsx_rss_officiallist.xml"><img class="rss" alt="" src="img/rss.jpg"></a></h1>

<!--#INCLUDE FILE="admin/merchtools.asp"-->
<%

' multiple pages
currentpage = trim(request("currentpage"))
if len(currentpage)=0 then currentpage=1
currentpage=cint(currentpage)
if currentpage<1 then currentpage=1

srch=""
board=ucase(trim(request("board")))
if len(board)<>0 then srch = srch & " AND (coissues.displayboard LIKE '" & board & "') "



' display todays prices
' if multiple codes requested then restrict by that otherwise ALL codes.
		
Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
 
ConnPasswords.Open Application("nsx_ReaderConnectionString")


SQL = "SELECT coDetails.coName, coIssues.nsxcode, coIssues.tradingcode, coIssues.ISIN, coIssues.IssueDescription, coIssues.IssueStatus, codetails.agadvisers, coissues.ibrokers, coissues.issuestarted, coissues.issuetype, codetails.agfacilitators "
SQL = SQL & " FROM coDetails INNER JOIN coIssues ON (coDetails.nsxcode = coIssues.nsxcode) "
SQL = SQL & " WHERE ((coIssues.iNewFloat=0) and (coIssues.IssueStatus='Active')  AND (coIssues.DisplayBoard<>'SIMV'))" & srch
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
maxpagesize = 58
maxpages = round(.5 + (rc / maxpagesize),0)
st = (currentpage * maxpagesize ) - maxpagesize
fh = st + maxpagesize - 1
if fh > rc then fh = rc

row_counter = 0


%>





Number of Listed Securities: <b><%=formatnumber(rc+1,0)%></b><br><br>
</div>

<div class="pagebar" style="padding-bottom:15px;">Pages:&nbsp;
      <%if currentpage > 1 then %>
<a href="market_officiallist.asp?currentpage=<%=currentpage-1%>" title="Previous">Previous</a>                 
            <%end if%>
            
            <%
      for ii = 1 to maxpages
            	if ii = currentpage then 
      %>
        <span class="this-page"><%=ii%></span>
      <%
      	else
      %>
      <a href="market_officiallist.asp?currentpage=<%=ii%>" title="Page <%=ii%>"><%=ii%></a>
      <%
      	end if
      next
      
      
    
      %>
      <%if maxpages > CurrentPage then %>
<a href="market_officiallist.asp?currentpage=<%=currentpage+1%>" title="Next">Next</a>                 
      <%end if%>
</div>


<table id="myTable" class="tablesorter1" width="99%"> 


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
      	  
      cl = array("#EEEEEE","#FFFFFF")
	

	if lapstart then
		lapstart = false
		else
		if prvcode <> nsxcode then
			response.write "  </table>" & vbCrLf
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
     <td width=20 class="plaintext" valign="top"><a href="company_details.asp?nsxcode=<%=nsxcode%>" title="click for company details"><%=nsxcode %></a></td>
     <td width=700 class="plaintext" valign="top"><a href="company_details.asp?nsxcode=<%=nsxcode%>" title="click for company details"><%=Server.HTMLEncode(CoName)%></a><br>
		<table width="100%" class="ol_inner" >
	   <tr class="ol_inner">
          <td class="ol_inner" valign="top" width="100" >Code</td>
          <td class="ol_inner" valign="top" width="100" >ISIN</td>

          <td class="ol_inner" valign="top" width="200" >Adviser</td>
 <!--         <td valign="top" class="subcat2" width="150" ><b>Facilitator</b></td> -->
          <td class="ol_inner" valign="top" nowrap align="right">Listed On</td>
        </tr>
<%
  end if
%>
	 <tr class="ol_inner" >
	 <td class="ol_inner" valign="top" width="100"><a href="security_details.asp?nsxcode=<%=tradingcode %>" title="<%=Server.HTMLEncode(issuedescription) %> - click for security details"><%=tradingcode %></a></td>
	 <td class="ol_inner" valign="top" width="100"><%=isin%>&nbsp;</td>

     <td class="ol_inner" valign="top" width="200"><%
		bb =  adjtextarea(advisers) & "<BR>"
		cc = instr(bb,"<BR>")-1
       response.write Server.HTMLEncode(left(bb,cc))

     %>&nbsp;</td>
 <!--    
     <td  class="subcat2" valign="top" width="150"><%
		bb =  adjtextarea(facilitators) & "<BR>"
		cc = instr(bb,"<BR>")-1
       response.write Server.HTMLEncode(left(bb,cc))

     %>&nbsp;</td>
   -->  
     <td class="ol_inner" valign="top" nowrap align="right"><%=issuestarted%>&nbsp;</td>
    </tr>
    
	<%
	
  prvcode = nsxcode
  
NEXT
		  %>
		  </table>
		  <%
		  
end if
    %>
 

    </td>
    
  </tr>
</table>


<div class="pagebar">Pages:&nbsp;
      <%if currentpage > 1 then %>
<a href="market_officiallist.asp?currentpage=<%=currentpage-1%>" title="Previous">Previous</a>                 
            <%end if%>
            
            <%
      for ii = 1 to maxpages
            	if ii = currentpage then 
      %>
        <span class="this-page"><%=ii%></span>
      <%
      	else
      %>
      <a href="market_officiallist.asp?currentpage=<%=ii%>" title="Page <%=ii%>"><%=ii%></a>
      <%
      	end if
      next
      
      
    
      %>
      <%if maxpages > CurrentPage then %>
<a href="market_officiallist.asp?currentpage=<%=currentpage+1%>" title="Next">Next</a>                 
      <%end if%>
</div>












</div>
<!--#INCLUDE FILE="footer.asp"-->
