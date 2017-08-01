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

' Get flash company info, Name of company, nsxcode, currentprice, highprice, % change, lowprice, volume, last trade date
security_code = UCase(Trim(SafeSqlParameter(request.querystring("nsxcode"))))
SQL_flash_data = "SELECT TOP 1 [last], [prvclose], [open], [high], [low], [volume], (SELECT TOP 1 tradedatetime FROM PricesTrades WHERE tradingcode='" & security_code & "' ORDER BY prid DESC), [issuedescription], [sessionmode],[logo_summary],[offexchangetrading_url] FROM PricesCurrent WHERE tradingcode='" & security_code & "'"
flash_data = GetRows(SQL_flash_data)
If VarType(flash_data) <> 0 Then
    flash_data_RowsCount = UBound(flash_data,2)
    If flash_data_RowsCount >= 0 Then
        flashdata_last = flash_data(0,0)
        flashdata_prvclose = flash_data(1,0)
        flashdata_opn = flash_data(2,0)
        flashdata_high = flash_data(3,0)
        flashdata_low = flash_data(4,0)
        flashdata_volume = flash_data(5,0)
        If IsDate(flash_data(6,0)) Then 
            flashdata_tradedatetime = CDate(flash_data(6,0))
        Else
          flashdata_tradedatetime = ""
        End If
        flashdata_coName = flash_data(7,0)
        Dim dchange2
        If flashdata_last = 0 Or flashdata_prvclose=0 Then
          dchange2 = 0
        Else
          'dchange2 = 100*((flashdata_last-flashdata_prvclose)/flashdata_prvclose)
            dchange2 = FormatPercent((flashdata_last-flashdata_prvclose)/flashdata_prvclose)
        End If

        If Not IsNumeric(flashdata_last) Then flashdata_last = 0
	    If Not IsNumeric(flashdata_open) Then flashdata_opn = 0
	    If Not IsNumeric(flashdata_high) Then flashdata_high = 0
	    If Not IsNumeric(flashdata_low) Then flashdata_low = 0
	    If Not IsNumeric(flashdata_volume) Then flashdata_volume = 0
	
	    If flashdata_last=0 Then flashdata_last=""
	    If flashdata_open=0 Then flashdata_open=""
	    If flashdata_high=0 Then flashdata_high=""
	    If flashdata_low=0 Then flashdata_low=""
	    If flashdata_volume=0 Then flashdata_volume=""
    End If
End If
' End flash data

%>
<!--#INCLUDE FILE="header.asp"-->
<%
Server.Execute "side_menu.asp"
%>

<div class="hero-banner subpage">
    <div class="hero-banner-img"></div>
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder subpage">
            <div class="col-sm-12 hero-banner-left comp-info">
                <h1><%=flashdata_coName%></h1>
                <div class="comp-info">
                    <div class="comp-info-large">
                        <span class="large"><%=security_code%></span><span class="large"><%=flashdata_last%></span>
                    </div>
                    <div class="comp-info-small">
                        <ul>
                            <li><%=flashdata_last%><br /><span class="red"><%=dchange2%></span></li>
                            <li>LOW<br /><span><%=flashdata_low%></span></li>
                            <li>VOLUME<br /><span><%=flashdata_volume%></span></li>
                            <li>LAST TRADE<br /><span class="light"><%=flashdata_tradedatetime%></span></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%
Server.Execute "content_lower_nav.asp"
%>

<div class="container subpage">
    <div class="row">
        <div class="col-sm-12">
            <div class="subpage-center">

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
if Not IsNumeric(currentpage) Or len(currentpage) = 0 Then
	currentpage=1
Else
	currentpage=cint(currentpage)
	if currentpage<1 then currentpage=1
End If

'id = request.querystring("nsxcode")

'If Not valid_security_code(id) Then 
'	Response.Write ("Invalid Security Code")
'	Response.End
'End If

id =  UCase(SafeSqlParameter(Request.QueryString("nsxcode")))
Set regEx = New RegExp 
regEx.Pattern = "^[a-zA-Z0-9]+$" 
isCodeValid = regEx.Test(id) 
If Not isCodeValid Then
  Response.Redirect "/"
  Response.End
End If

if len(id)=0 then id="pmi"

Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
ConnPasswords.Open Application("nsx_ReaderConnectionString")  
SQL=" SELECT coDetails.coName, coIssues.nsxcode, coIssues.tradingcode, coIssues.ISIN, coIssues.IssueDescription, coIssues.IssueType, coIssues.OffMarketNexus, coIssues.Certificated, coIssues.IssuerSponsor, coIssues.DeferredDeliveryIndicator, coIssues.Settlement, coIssues.PreviousTradingCodes, coIssues.PreviousTradingCodeDates, coIssues.IssueStarted, coIssues.IssueStopped, coIssues.IssueStatus,  coIssues.currentsharesonissue,coIssues.optexpirydate,coIssues.optexprice,coIssues.optdetails,coIssues.ficoupon,coIssues.fiexpirydate,coIssues.fidetails, coIssues.iOfferDocument,coIssues.iIndustryClass,coIssues.iIssuePrice, coIssues.SEDOL, coIssues.CUSIP, coIssues.BBGID, coIssues.BBGTicker"
SQL = SQL & " FROM coDetails INNER JOIN coIssues ON coDetails.nsxcode = coIssues.nsxcode "
SQL = SQl & " WHERE (coIssues.tradingcode='" & SafeSqlParameter(id) & "')"
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
industryclass=alldata(24,jj)
offerprice=alldata(25,jj)
sedol=alldata(26,jj)
cusip=alldata(27,jj)		
BBGID=alldata(28,jj)
BBGTicker=alldata(29,jj)	  

' redundant fields
offmarketnexus = ""
IssuerSponsor = ""
DeferredDeliveryIndicator = ""
%>

<div class="row">
    <div class="col-lg-4 col-md-4 col-sm-4 company-details ">
        <h2>Company</h2>
        <p>
        <span class="title">ACN/ARBN</span>
        600 238 444
        <span class="title">NSX Code</span>
        <%=tradingcode%>
        <span class="title">NSX Listed Securities</span>
        <%=tradingcode%> - <%=remcrlf(coName)%>
        <span class="title">Listing Date</span>
        <%=issuestarted%>
        <span class="title">Principal Activities</span>
        ***Electronics manufacturing***
        <span class="title">Industry Class</span>
        Information Technology
        </p>
    </div>
    <div class="col-lg-4 col-md-4 col-sm-4 company-details ">
        <h2>Contact</h2>
        <p>
        <span class="title">Street Address</span>
        Level 12
        225 George Street
        Sydney NSW Australia
        <span class="title">Company Base</span>
        Malaysia
        <span class="title">Web</span>
        www.advancetc.com
        <span class="title">Email</span>
        general@advancetc.com
        <span class="title">Phone</span>
        02 9290 9606
        </p>
    </div>
    <div class="col-lg-4 col-md-4 col-sm-4 company-details ">
        <h2>People</h2>
        <p>
        <img class="people" src="" />
        <span class="title">CEO</span>
        Loi Cheng Pheng
        <span class="title">Directors</span>
        Loi Cheng Pheng
        Lee Gim Keong
        Loi Yeow Koon, 
        Jonathan Cho Chee Tuck
        Tan Keng Yaw, 
        William CHO Chee Seng
        <span class="title">Company Secretary</span>
        William Keng Yaw Tan
        </p>
    </div>
</div>

<div class="row">
    <div class="col-lg-4 col-md-4 col-sm-4 company-details lower">
        <h2>Corporate</h2>
        <p>
        <span class="title">Solicitors</span>
        GRT Lawyers
        <span class="title">Nominated Advisers</span>
        Southasia Advisory Sdn Bhd
        <span class="title">Auditor</span>
        BDO Audit Pty Ltd
        <span class="title">Share Registry</span>
        Boardroom Pty Limited
        Level 12
        225 George Street
        Sydney NSW 2000
        GPO Box 3993 
        Sydney NSW 2001
        <span class="title">Phone</span>
        1300 737 760
        +61 2 9290 9600 (Int)
        <span class="title">Fax</span>
        1300 653 459
        +61 2 9279 0664 (Int)
        <span class="title">Balance Date</span>
        31-Dec
        </p>
    </div>
    <div class="col-lg-4 col-md-4 col-sm-4 company-details lower">
        <h2>Operating information</h2>
        <p>
        <span class="title">Trading Code</span>
        A88
        <span class="title">ISIN</span>
        AU000000A880
        <span class="title">FIGI</span>
        BBG0072GNFS7
        <span class="title">Bloomberg Ticker</span>
        A88 AO Equity
        <span class="title">Security Description</span>
        AdvanceTC Limited FPO
        <span class="title">Security Type</span>
        01 - Ordinary
        <span class="title">Certificated</span>
        0 - Uncertificated
        <span class="title">Settlement</span>
        Chess T+2
        <span class="title">Security Status</span>
        Active
        </p>
    </div>
    <div class="col-lg-4 col-md-4 col-sm-4 company-details lower">
        <h2>How to trade</h2>
        <p>
        <span class="title">Started Trading</span>
        Friday, 5 September 2014

        <span class="title">Previous Security Codes</span>
        None

        <span class="title">Previous Security Effective Dates</span>
        None

        <span class="title">Total Securities Issued in Class</span>
        345,365,182

        <span class="title">Listing Price</span>
        0.55

        <span class="title">Original offer document(s)</span>
        Compliance Listing

        <span class="title">Announcements</span>
        Announcements for this security
        </p> 
    </div>
</div>

<h1><%=remcrlf(coName)%></h1> 

<table id="myTable" class="tablesorter" width="99%">
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
    <td align="left" valign="top" width="240"><b>FIGI:</b></td>
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
    <td align="left" valign="top" width="240"><b>Original offer document(s):</b></td>
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
      		    response.write ii+1 & ". <a href=""ftp/news/" & aa(0) &  """ target=_blank class=""rhlinks"">" & aa(1) & "</a><br>"      	
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
</table>

<% NEXT
	end if
	%>
</div> 
</div>
</div>
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->