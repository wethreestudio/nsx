<!--#INCLUDE FILE="include_all.asp"-->
<%


UserIPAddress = Request.ServerVariables("HTTP_X_FORWARDED_FOR")
If UserIPAddress = "" Then
	UserIPAddress = Request.ServerVariables("REMOTE_ADDR")
End If
If UserIPAddress = "209.11.218.6" Then
	Response.Write "Your IP address (209.11.218.6) has exceeded the traffic limit for this page. Please contact techsupport@nsxa.com.au to resolve this issue or make alternative arrangements to obtain this data."
	Response.End
End If

Function remcrlf(xx)
  remcrlf = replace(xx & " ",vbCRLF,"")
  remcrlf = trim(Replace(remcrlf & " ", "''", "'"))
End Function

Function fmtcrlf(xx)
  fmtcrlf= replace(xx & " ",vbcrlf & vbCRLF,"<br><br>")
  fmtcrlf= replace(fmtcrlf& " ",vbcrlf," ")
  fmtcrlf= trim(Replace(fmtcrlf & " ", "''", "'"))
End Function

page_title = "Security Details"
' meta_description = ""
' alow_robots = "no"
' objJsIncludes.Add "marketdata", "js/marketdata.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"

objCssIncludes.Add "table_sort_blue", "/css/table_sort_blue.css"

%>
<!--#INCLUDE FILE="header.asp"-->
<div class="container_cont">
<div class="editarea">




<%

on error resume next

is_odd = false

Function trClass()
	if is_odd then
		trClass = " class=""odd"""
	else
		trClass = ""
	end if
	is_odd = Not is_odd
End Function


errmsg=""

currentpage = trim(request("currentpage"))
if len(currentpage)=0 then currentpage=1
currentpage=cint(currentpage)
if currentpage<1 then currentpage=1

id = request.querystring("nsxcode")
if len(id)=0 then id="pmi"

Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
ConnPasswords.Open Application("nsx_ReaderConnectionString")  
SQL=" SELECT coDetails.coName, coIssues.nsxcode, coIssues.tradingcode, coIssues.ISIN, coIssues.IssueDescription, coIssues.IssueType, coIssues.OffMarketNexus, coIssues.Certificated, coIssues.IssuerSponsor, coIssues.DeferredDeliveryIndicator, coIssues.Settlement, coIssues.PreviousTradingCodes, coIssues.PreviousTradingCodeDates, coIssues.IssueStarted, coIssues.IssueStopped, coIssues.IssueStatus,  coIssues.currentsharesonissue,coIssues.optexpirydate,coIssues.optexprice,coIssues.optdetails,coIssues.ficoupon,coIssues.fiexpirydate,coIssues.fidetails, coIssues.iOfferDocument,coIssues.iIndustryClass,coIssues.iIssuePrice, coIssues.SEDOL, coIssues.CUSIP, coIssues.BBGID, coIssues.BBGTicker"
SQL = SQL & " FROM coDetails INNER JOIN coIssues ON coDetails.nsxcode = coIssues.nsxcode "
SQL = SQl & " WHERE (coIssues.tradingcode='" & id & "')"
SQL = SQL & " ORDER BY coissues.issuedescription"

'response.write SQL

CmdDD.CacheSize=10
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
maxpagesize = 1
maxpages = round(.5 + (rc / maxpagesize),0)
st = (currentpage * maxpagesize ) - maxpagesize
fh = st + maxpagesize - 1
if fh > rc then fh = rc
 
    lap = 0
    cl = array("#FFFFFF","#EEEEEE")
    
 


%>


<%  If WEOF Then %>
	 
   There is no record available.
  <% Else %>

	<%
      	  for jj = st to fh
 
nsxcode=alldata( 1 ,jj)
coName=alldata( 0,jj)
tradingcode=alldata( 2,jj)
ISIN=alldata( 3,jj)
IssueDescription=alldata(4 ,jj)
IssueType=alldata(5 ,jj)
OffMarketNexus=alldata(6 ,jj)
Certificated=alldata(7 ,jj)
IssuerSponsor=alldata( 8,jj)
DeferredDeliveryIndicator=alldata(9 ,jj)
Settlement=alldata( 10,jj)
PreviousTradingCodes=alldata(11 ,jj)
PreviousTradingCodeDates=alldata( 12,jj)
IssueStarted=alldata( 13,jj)
if len(issuedstarted) <> "" then issuestarted = formatdatetime(issuestarted,1)
IssueStopped=alldata(14 ,jj)
if len(issuestopped) <> "" then issuestopped = formatdatetime(issuestopped,1)
IssueStatus=alldata( 15,jj)

CurrentSharesonIssue=formatnumber(alldata( 16,jj),0)
optexpirydate=alldata( 17,jj)
if len(optexpirydate) <> "" then optexpirydate= formatdatetime(optexpirydate,1)
optexprice=alldata( 18,jj)
optdetails=alldata( 19,jj)
ficoupon=alldata( 20,jj)
fiexpirydate=alldata( 21,jj)
if len(fiexpirydate) <> "" then fiexpirydate= formatdatetime(fiexpirydate,1)
fidetails=alldata( 22,jj)
offerdocument=alldata(23,jj)
'if trim(offerdocument & " ") = "" then
'	offerdocument="Compliance Listing"
'	else
'	offerdocument="<a href=""ftp/news/" & offerdocument & """>" & offerdocument & "</a>"
'end if
industryclass=alldata(24,jj)
offerprice=alldata(25,jj)
sedol=alldata(26,jj)
cusip=alldata(27,jj)		
BBGID=alldata(28,jj)
BBGTicker=alldata(29,jj)	  
%>
  
  		
<h1><%=remcrlf(coName)%></h1> 

<div class="table-responsive"><table id="myTable" class="tablesorter" width="99%">
<tbody> 
  <% if tradingcode<>"" then%>
  <tr <%=trClass()%>>
    <td align="left" valign="top" width="240"><b>Trading Code:</b></td>
    <td><a href="/summary/<%=tradingcode%>"><%=tradingcode%></a></td>
  </tr>
  <%end if%>
  <% if isin<>"" then%>
  <tr <%=trClass()%>>
    <td align="left" valign="top" width="240"><b>ISIN:</b></td>
    <td><%=isin%></td>
  </tr>
  <%end if%>
  <%If len(trim(sedol & " "))<>0 then %>
  <tr <%=trClass()%>>
    <td align="left" valign="top" width="240"><b>SEDOL:</b></td>
    <td><%=sedol%></td>
  </tr>
  <%end if%>  
  <%If len(trim(cusip & " "))<>0 then %>
  <tr <%=trClass()%>>
    <td align="left" valign="top" width="240"><b>CUSIP:</b></td>
    <td><%=cusip%></td>
  </tr>
  <%end if%> 
  <%If len(trim(BBGID & " "))<>0 then %>
  <tr <%=trClass()%>>
    <td align="left" valign="top" width="240"><b>Bloomberg ID:</b></td>
    <td><%=BBGID%></td>
  </tr>
  <%end if%> 
  <%If len(trim(BBGTicker & " "))<>0 then %>
  <tr <%=trClass()%>>
    <td align="left" valign="top" width="240"><b>Bloomberg Ticker:</b></td>
    <td><%=BBGTicker%></td>
  </tr>
  <%end if%>   
  <% if issuedescription<>"" then%>
  <tr <%=trClass()%>>
    <td align="left" valign="top" width="240"><b>Security Description:</b></td>
    <td><%=adjtextarea(issuedescription)%></td>
  </tr>
  <%end if%>
  <% if issuetype<>"" then%>
  <tr <%=trClass()%>>
    <td align="left" valign="top" width="240"><b>Security Type:</b></td>
    <td><%=adjtextarea(issuetype)%></td>
  </tr>
  <%end if%>  
  <% if offmarketnexus<>"" then%>
  <tr <%=trClass()%>>
    <td align="left" valign="top" width="240"><b>Off Market Nexus:</b></td>
    <td><%=adjtextarea(offmarketnexus)%></td>
  </tr>
  <%end if%> 
  <% if certificated<>"" then%>
  <tr <%=trClass()%>>
    <td align="left" valign="top" width="240"><b>Certificated:</b></td>
    <td><%=adjtextarea(certificated)%></td>
  </tr>
  <%end if%>   
  <% if issuersponsor<>"" then%>
  <tr <%=trClass()%>>
    <td align="left" valign="top" width="240"><b>Issuer Sponsor:</b></td>
    <td><%=adjtextarea(issuersponsor)%></td>
  </tr>
  <%end if%>  
  <% if deferreddeliveryindicator<>"" then%>
  <tr <%=trClass()%>>
    <td align="left" valign="top" width="240"><b>Deferred Delivery Indicator:</b></td>
    <td><%=adjtextarea(deferreddeliveryindicator)%></td>
  </tr>
  <%end if%> 
  <% if settlement<>"" then%>
  <tr <%=trClass()%>>
    <td align="left" valign="top" width="240"><b>Settlement:</b></td>
    <td><%=adjtextarea(settlement)%></td>
  </tr>
  <%end if%> 

  <% if issuestatus<>"" then%>
  <tr <%=trClass()%>>
    <td align="left" valign="top" width="240"><b>Security Status:</b></td>
    <td><%=adjtextarea(issuestatus)%></td>
  </tr>
  <%end if%> 
  <% if issuestarted<>"" then%>
  <tr <%=trClass()%>>
    <td align="left" valign="top" width="240"><b>Started Trading on:</b></td>
    <td><%=issuestarted%></td>
  </tr>
  <%end if%> 
  <% if len(trim(issuestopped& " "))<>0 then %>
  <tr <%=trClass()%>>
    <td align="left" valign="top" width="240"><b>Stopped Trading on:</b></td>
    <td><%=issuestopped%></td>
  </tr>
  <%end if%> 
  <% if previoustradingcodes<>"" then%>
  <tr <%=trClass()%>>
    <td align="left" valign="top" width="240"><b>Previous Security Codes:</b></td>
    <td><%=previoustradingcodes%></td>
  </tr>
  <%end if%> 
  <tr <%=trClass()%>>
	<td align="left" valign="top" width="240"><b>Previous Security Effective Dates:</b></td>
    <td><%
    
    if isdate(previoustradingcodedates) then
    response.write day(previoustradingcodedates) & " " & Monthname(month(previoustradingcodedates)) & " " & year(previoustradingcodedates)
    else
    response.write previoustradingcodedates
    end if
    %></td>
  </tr>
  
  <% if len(trim(duallisteddetails & " "))<>0 then %>
  <tr <%=trClass()%>>
    <td align="left" valign="top" width="240"><b>Dual Listing Details:</b></td>
    <td><%=duallisteddetails%></td>
  </tr>
  <%end if%>
  
  <tr <%=trClass()%>>
    <td align="left" valign="top" width="240"><b>Total Securities Issued in this Class:</b></td>
    <td><%=currentsharesonissue%></td>
  </tr>
  
  <tr <%=trClass()%>>
    <td align="left" valign="top" width="240"><b>Listing Price:</b></td>
    <td><%=offerprice%></td>
  </tr>
  <tr <%=trClass()%>>
    <td align="left" valign="top" width="240"><b>Original offer document:</b></td>
    <td><%
    if trim(offerdocument & " " )="" then
    	response.write "Compliance Listing"
    else
    bb = split(offerdocument & ";",";")
     bbcount = ubound(bb)
     for ii = 0 to bbcount
     	if len(trim(bb(ii) & " ")) <> 0 then
     		' get file name and title
     		aa=split(bb(ii) & "|","|")
     		if trim(aa(1) & " ")="" then aa(1)="Offer Document"
      		response.write "<b>" & ii+1 & ". <a href=""ftp/news/" & aa(0) &  """ target=_blank class=""rhlinks"">" & aa(1) & "</a></b><br>"      	
     	end if
     	
     	
     next
    end if

      
           %></td>
  </tr>
  
  <tr <%=trClass()%>>
    <td align="left" valign="top" width="240"><b>Announcements:</b></td>
    <td><a href="/marketdata/search_by_company?nsxcode=<%=tradingcode%>">Announcements for this security</a></td>
  </tr>  
  

  <% if len(optexpirydate)<>"" then  %>
  <tr <%=trClass()%>>
    <td colspan="2" align="left" valign="top"><b>Option Details</b></td>
  </tr>  
  <tr <%=trClass()%>>
    <td align="left" valign="top" width="240"><b>Expiry Date:</b></td>
    <td><%=optexpirydate%></td>
  </tr> 
  <tr <%=trClass()%>>
    <td align="left" valign="top" width="240"><b>Expiry Price:</b></td>
    <td><%=optexprice%></td>
  </tr> 
  <tr <%=trClass()%>>
    <td align="left" valign="top" width="240"><b>Expiry Terms:</b></td>
    <td><%=replace(optdetails & " ",vbcrlf,"<BR>")%></td>
  </tr>
 <%end if%>
 <% if len(ficoupon)<>"" then %>
 
  <tr <%=trClass()%>>
    <td colspan="2" align="left" valign="top"><b>Fixed Interest Details</b></td>
  </tr>  
  <tr <%=trClass()%>>
    <td align="left" valign="top" width="240"><b>Coupon:</b></td>
    <td><%=ficoupon%></td>
  </tr>
  <tr <%=trClass()%>>
    <td align="left" valign="top" width="240"><b>Expiry Date:</b></td>
    <td><%=fiexpirydate%></td>
  </tr>
  <tr <%=trClass()%>>
    <td align="left" valign="top" width="240"><b>Fixed Interest Terms:</b></td>
    <td><%=fmtcrlf(fidetails)%></td>
  </tr>
  <%end if%>
  </tbody>
</table></div>

 


<% NEXT
	end if
	%>
 </div> 
</div>
<!--#INCLUDE FILE="footer.asp"-->