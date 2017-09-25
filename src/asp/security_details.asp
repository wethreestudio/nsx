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

id =  UCase(SafeSqlParameter(Request.QueryString("nsxcode")))
'response.write id
'response.end
Set regEx = New RegExp 
regEx.Pattern = "^[a-zA-Z0-9]+$" 
isCodeValid = regEx.Test(id) 
If Not isCodeValid Then
    Response.Redirect "/errorpages/404.html"
    response.write "invalid"
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

Function FixHref(href)
	href = trim(lcase(href))
	if left(href,len("http")) <> "http" then
		href = "http://" & href
	end if
	FixHref = href
End Function

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
Else
    Response.Redirect "/marketdata/company-directory/"
    Response.end
End If
' End flash data

page_title = "Security Details " & flashdata_coName & " " & UCase(security_code)

Function FormatPrice(p,d)
	If Len(p)>0 Then
		FormatPrice = FormatNumber(p,d)
	Else 
		FormatPrice = "-"
	End If
End Function

%>
<!--#INCLUDE FILE="header.asp"-->
<%
Server.Execute "side_menu.asp"
%>

<div class="hero-banner hero-banner-company subpage">
    <div class="hero-banner-img"></div>
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder subpage">
            <div class="hero-banner-left comp-info">
                <h1><span><%=flashdata_coName%></span></h1>
                <div class="comp-info">
                    <div class="comp-info-large">
                        <span class="large"><%=security_code%></span><span class="large"><%=FormatPrice(flashdata_last,3)%></span>
                    </div>
                    <div class="comp-info-small">
                        <ul>
                            <li>CHANGE<br /><span class="red"><%=dchange2%></span></li>
                            <li>LAST<br /><span><%=flashdata_last%></span></li>
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

<div class="container subpage ">
    <div class="row">
        <div class="col-sm-12 nopad">
            <div class="subpage-center nopad">

<div class="editarea">

<%

'on error resume next

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
	if currentpage < 1 then currentpage=1
End If

if len(id)=0 then id="pmi"

Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
ConnPasswords.Open Application("nsx_ReaderConnectionString")  
SQL=" SELECT "
SQL= SQL & "coDetails.coName, coIssues.nsxcode, coIssues.tradingcode, coIssues.ISIN, coIssues.IssueDescription, coIssues.IssueType, coIssues.OffMarketNexus, coIssues.Certificated, coIssues.IssuerSponsor,coIssues.DeferredDeliveryIndicator, coIssues.Settlement, coIssues.PreviousTradingCodes, coIssues.PreviousTradingCodeDates, coIssues.IssueStarted, coIssues.IssueStopped, coIssues.IssueStatus,  coIssues.currentsharesonissue,coIssues.optexpirydate,coIssues.optexprice,coIssues.optdetails,coIssues.ficoupon,coIssues.fiexpirydate,coIssues.fidetails, coIssues.iOfferDocument,coIssues.iIndustryClass,coIssues.iIssuePrice, coIssues.SEDOL, coIssues.CUSIP, coIssues.BBGID, coIssues.BBGTicker"
SQL= SQL & ",agStatus, Cityname, agName, agLevel, agBuild,"
SQL= SQL & "agAddress, Stateb, Country, agPCode, agSuburb, agPOBOX, agPOSuburb, agPOPcode,"
SQL= SQL & "agemail0, agemail1, agemail2,  agemail4, agemail5, agemail6, agemail7,"
SQL= SQL & "agemail8, agemail9, agweb0, agweb1, agweb2, agweb3, agweb4, agweb5, agweb6, agweb7,"
SQL= SQL & "agweb8, agweb9, agWho, agHistory, agServices, agLogo, agStrapline, agShortDesc,"
SQL= SQL & "agPhone, agFax, agExpiry, agContactName, agContactTitle, agNotes, agLink01, agLink02,"
SQL= SQL & "agLink03, agLink04, agLink05, agLinkTitle01, agLinkTitle02, agLinkTitle03, agLinkTitle04,"
SQL= SQL & "agLinkTitle05, coDetails.RecordChangeUser, agNature, agBillingNotes, agPdate, agNewFloat,"
SQL= SQL & "agListedDate, agPActivities, agSectorClass, agIssuePrice, agIssueType, agCapitalRaised,"
SQL= SQL & "agOfferCloseDate, agFloatUnderwriter, agOfferDocument, agDelisted, agDelistedDate,"
SQL= SQL & "agSuspended, agSuspendedDate, agACN, agABN, agChairman, agMD, agSecretary, agDirectors,"
SQL= SQL & "agRegistry, agBankers, agBrokers, agAdvisers, agSolicitors, agEx01, agEx02, agEx03,"
SQL= SQL & "agDomicile, agFloatDesc, agaccountants, agtrustee, agfacilitators,balancedate,agEx04"
SQL= SQL & " FROM ((coDetails INNER JOIN [lookup - cities] ON coDetails.agCity = [lookup - cities].tid) INNER JOIN [lookup - states] ON coDetails.agState = [lookup - states].sid)"
SQL= SQL & " INNER JOIN [lookup - country] ON coDetails.agCountry = [lookup - country].cid"
SQL= SQL & " INNER JOIN coIssues ON coDetails.nsxcode = coIssues.nsxcode"
SQL= SQL & " WHERE (coDetails.nsxcode='" & SafeSqlParameter(id) & "')"
SQL= SQL & " ORDER BY coissues.issuedescription"
'response.write SQL

CmdDD.CacheSize=10
CmdDD.Open SQL, ConnPasswords,1,3

WEOF = CmdDD.EOF

'can only do getrows if there is more than one record.
if not WEOF then
	alldata = CmdDD.getrows
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

<% If WEOF Then %>

<% Else %>

<%
for jj = st to fh
 
coName=alldata( 0,jj)
nsxcode=alldata( 1 ,jj)
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

'nsxcode=alldata( 0 ,jj)
'coName=alldata( 1,jj)
agStatus=alldata(30  ,jj)
agCity=alldata( 31 ,jj)
agName=alldata( 32 ,jj)
agLevel=alldata( 33 ,jj)
agBuild=alldata( 34 ,jj)
agAddress=alldata(35  ,jj)
agState=alldata(  36,jj)
agCountry=alldata( 37 ,jj)
agPCode=alldata(  38,jj)
agSuburb=alldata( 39 ,jj)
agPOBOX=alldata( 40 ,jj)
agPOSuburb=alldata( 41,jj)
agPOPcode=alldata( 42 ,jj)
agemail0=alldata( 43,jj)
agemail1=alldata( 44,jj)
agemail2=alldata( 45,jj)
agemail4=alldata( 46,jj)
agemail5=alldata( 47,jj)
agemail6=alldata( 48,jj)
agemail7=alldata( 49,jj)
agemail8=alldata( 50,jj)
agemail9=alldata( 51,jj)
agweb0=alldata( 52,jj)
agweb1=alldata( 53,jj)
agweb2=alldata( 54,jj)
agweb3=alldata( 55,jj)
agweb4=alldata( 56,jj)
agweb5=alldata(  57,jj)
agweb6=alldata(  58,jj)
agweb7=alldata(  59,jj)
agweb8=alldata( 60 ,jj)
agweb9=alldata( 61 ,jj)
agWho=alldata(  62,jj)
agHistory=alldata(63  ,jj)
agServices=alldata( 64 ,jj)
agLogo=alldata( 65 ,jj)
agStrapline=alldata(66  ,jj)
agShortDesc=alldata( 67 ,jj)
agPhone=alldata(  68,jj)
agFax=alldata(  69,jj)
agExpiry=alldata( 70 ,jj)
agContactName=alldata(71  ,jj)
agContactTitle=alldata( 72 ,jj)
agNotes=alldata( 73 ,jj)
agLink01=alldata(  74,jj)
agLink02=alldata( 75 ,jj)
agLink03=alldata(  76,jj)
agLink04=alldata( 77 ,jj)
agLink05=alldata( 78 ,jj)
agLinkTitle01=alldata( 79 ,jj)
agLinkTitle02=alldata( 80 ,jj)
agLinkTitle03=alldata( 81 ,jj)
agLinkTitle04=alldata( 82 ,jj)
agLinkTitle05=alldata( 83 ,jj)
RecordChangeUser=alldata(84  ,jj)
agNature=alldata( 85 ,jj)
agBillingNotes=alldata(86  ,jj)
agPdate=alldata( 87 ,jj)
agNewFloat=alldata(88  ,jj)
agListedDate=alldata(89  ,jj)
agPActivities=alldata( 90 ,jj)
agIndustryClass=alldata( 91 ,jj)
agIssuePrice=alldata( 92 ,jj)
agIssueType=alldata( 93 ,jj)
agCapitalRaised=alldata( 94 ,jj)
agOfferCloseDate=alldata( 95 ,jj)
agFloatUnderwriter=alldata( 96 ,jj)
agOfferDocument=alldata( 97 ,jj)
agDelisted=alldata( 98 ,jj)
agDelistedDate=alldata(99  ,jj)
agSuspended=alldata( 100 ,jj)
agSuspendedDate=alldata( 101 ,jj)
agACN=alldata( 102 ,jj)
agABN=alldata( 103,jj)
agChairman=alldata( 104 ,jj)
agMD=alldata( 105 ,jj)
agSecretary=alldata( 106 ,jj)
agDirectors=alldata( 107 ,jj)
agRegistry=alldata( 108 ,jj)
agBankers=alldata( 109 ,jj)
agBrokers=alldata( 110 ,jj)
agAdvisers=alldata( 111,jj)
agSolicitors=alldata( 112,jj)
agEx01=trim(alldata( 113,jj) & " ")
agEx02=trim(alldata( 114 ,jj) & " ")
agEx03=trim(alldata( 115 ,jj) & " ")
agDomicile=alldata( 116 ,jj)
agFloatDesc=alldata( 117,jj)      	  
agauditor=alldata(118,jj)
agtrustee=alldata(119,jj)    	  
agfacilitators=alldata(120,jj)   
balancedate=alldata(121,jj)
agEx04=trim(alldata( 122 ,jj) & " ")

' redundant fields
offmarketnexus = ""
IssuerSponsor = ""
DeferredDeliveryIndicator = ""
%>

<div class="row">
    <div class="col-lg-4 col-md-4 col-sm-4 company-details">
        <h2>Company</h2>
        <p>

        <% if agacn<>"" then%>
            <span class="title">ACN/ARBN</span>
            <%=agacn%>
        <%end if%>

        <% if agabn<>"" then%>
            <span class="title">ABN:</span>
            <%=agabn%>
        <%end if%>

        <span class="title">NSX Code</span>
        <%=tradingcode%>
        
        <% 
        sql = "SELECT tradingcode,issuedescription FROM coIssues WHERE nsxcode='" & SafeSqlParameter(id) & "' AND issuestatus='Active' ORDER BY tradingcode ASC"
        Set conn = GetReaderConn()
        Set rs = conn.Execute(sql)  
        If Not rs.EOF Then
        %>
        <span class="title">NSX Listed Securities</span>
	      <%  
	      While Not rs.EOF
	      %>
            <a href="/marketdata/company-directory/<%=ucase(rs("tradingcode"))%>"><%=ucase(rs("tradingcode"))%></a><%=" - " & rs("issuedescription")%><br>
	      <%
            rs.MoveNext 
	      Wend 
	      rs.Close
	      Set rs = Nothing
	      %>
        <%end if%>
        <span class="title">Listing Date</span> 
        <%
        if trim(agListedDate & " ") = "" then
    	    response.write "To be advised"
    	else
    	    response.write formatdatetime(agListedDate,1)
    	end if
    	%>

        <% if agpactivities<>"" then%>
            <span class="title">Principal Activities</span>
            <%=adjtextarea(agPactivities)%>
        <%end if%>
    <% if agindustryclass<>"" then%>
        <span class="title">Industry Class:</span>
    <%
	    if len(agindustryclass)<>0 then
            agIndustryClass = mid(agindustryclass,instr(agindustryclass,"-")+1,len(agindustryclass))
	    end if
	    response.write adjtextarea(agIndustryClass)
    %>
  <%end if%>
        </p>
    </div>
    <div class="col-lg-4 col-md-4 col-sm-4 company-details">
        <h2>Contact</h2>
        <p>
        <% if agaddress<>"" then%>
    <span class="title">Street Address:</span>
    <%response.write agBuild & " "
    response.write agLevel & "<br>"
    response.write agAddress & "<br>"
    response.write agSuburb
    response.write " " & agCity
    response.write " " & agState
    response.write " " & agCountry
    response.write " " & agPCode
    %>
  <%end if%>

  <% if agPOBOX<>"" then%>
    <span class="title">Postal Address:</span>
    <%
    response.write agPOBOX & "<br>"
    response.write agPOSUBURB & "<br>"
    response.write " " & agCity & " " & agState & " " & agCountry & " " & agPOPCode
    %>
  <%end if%>

  <% if agdomicile<>"" then%>
  <span class="title">Company Base:</span>
    <%=adjtextarea(agDomicile)%>
  <%end if%>
  <% if agweb0<>"" then%>
    <span class="title">Web:</span>
    <%
    if len(trim(agweb0))>0 then response.write "<a href=""" & FixHref(agweb0) &""" target=""_blank"">" & Replace(agweb0,"http://","",1,1) & "</a><br>"
    if len(trim(agweb1))>0 then response.write "<a href=""" & FixHref(agweb1) &""" target=""_blank"">" & Replace(agweb1,"http://","",1,1) & "</a><br>"
    if len(trim(agweb2))>0 then response.write "<a href=""" & FixHref(agweb2) &""" target=""_blank"">" & Replace(agweb2,"http://","",1,1) & "</a><br>"
    if len(trim(agweb3))>0 then response.write "<a href=""" & FixHref(agweb3) &""" target=""_blank"">" & Replace(agweb3,"http://","",1,1) & "</a><br>"
    if len(trim(agweb4))>0 then response.write "<a href=""" & FixHref(agweb4) &""" target=""_blank"">" & Replace(agweb4,"http://","",1,1) & "</a><br>"
    if len(trim(agweb5))>0 then response.write "<a href=""" & FixHref(agweb5) &""" target=""_blank"">" & Replace(agweb5,"http://","",1,1) & "</a><br>"
    if len(trim(agweb6))>0 then response.write "<a href=""" & FixHref(agweb6) &""" target=""_blank"">" & Replace(agweb6,"http://","",1,1) & "</a><br>"
    if len(trim(agweb7))>0 then response.write "<a href=""" & FixHref(agweb7) &""" target=""_blank"">" & Replace(agweb7,"http://","",1,1) & "</a><br>"
    if len(trim(agweb8))>0 then response.write "<a href=""" & FixHref(agweb8) &""" target=""_blank"">" & Replace(agweb8,"http://","",1,1) & "</a><br>"
    if len(trim(agweb9))>0 then response.write "<a href=""" & FixHref(agweb9) &""" target=""_blank"">" & Replace(agweb9,"http://","",1,1) & "</a><br>"
    %>
  <%end if%>
  <% if agemail0<>"" then%>
    <span class="title">Email:</span>
    <%
    if len(trim(agemail0))>0 then response.write "<a href=""mailto:" & agemail0 &""">" & agemail0 & "</a><br>"
    if len(trim(agemail1))>0 then response.write "<a href=""mailto:" & agemail1 &""">" & agemail1 & "</a><br>"
    if len(trim(agemail2))>0 then response.write "<a href=""mailto:" & agemail2 &""">" & agemail2 & "</a><br>"
    if len(trim(agemail3))>0 then response.write "<a href=""mailto:" & agemail3 &""">" & agemail3 & "</a><br>"
    if len(trim(agemail4))>0 then response.write "<a href=""mailto:" & agemail4 &""">" & agemail4 & "</a><br>"
    if len(trim(agemail5))>0 then response.write "<a href=""mailto:" & agemail5 &""">" & agemail5 & "</a><br>"
    if len(trim(agemail6))>0 then response.write "<a href=""mailto:" & agemail6 &""">" & agemail6 & "</a><br>"   
    %>
  <%end if%>

  <% if agphone<>"" then%>
    <span class="title">Phone:</span>
    <%=adjtextarea(agphone)%>
  <%end if%>

  <% if agfax<>"" then%>
    <span class="title">Fax:</span>
    <%=adjtextarea(agfax)%>
  <%end if%>

        </p>
    </div>
    <div class="col-lg-4 col-md-4 col-sm-4 company-details ">
        <h2>People</h2>
        <p>
        <img class="people" src="" />
        <% if agchairman<>"" then%>
  
    <span class="title">Chairman:</span>
    
	<% if len(trim(agemail7))>0 then 
	response.write " <a href=""mailto:" & agemail7 &""">" & adjtextarea(agchairman) & "</a><br>"
	else
	response.write adjtextarea(agchairman)
	end if
	%>
  <%end if%>

  <% if agMD<>"" then%>
    <span class="title">Managing Director / CEO:</span>
    <%if len(trim(agemail8))>0 then 
        response.write " <a href=""mailto:" & agemail8 &""">" & adjtextarea(agMD)& "</a><br>"
    else
        response.write adjtextarea(agMD)
    end if
    %>
  <%end if%>

  <% if agdirectors<>"" then%>
    <span class="title">Directors:</span>
    <%=adjtextarea(agdirectors)%>
  <%end if%>

  <% if agsecretary<>"" then%>
    <span class="title">Company Secretary:</span>
    <%if len(trim(agemail9))>0 then 
		response.write " <a href=""mailto:" & agemail9 &""">" & adjtextarea(agSecretary) & "</a><br>"
    else
		response.write adjtextarea(agSecretary)
    end if%>
  
  <%end if%>
  <% if agbankers<>"" then%>
    <span class="title">Bankers:</span>
    <%=adjtextarea(agbankers)%>
  <%end if%>
  
        </p>
    </div>
</div>

<div class="row">
    <div class="col-lg-4 col-md-4 col-sm-4 company-details lower">
        <h2>Corporate</h2>
        <p>

        <% if agsolicitors<>"" then%>
            <span class="title">Solicitors:</span>
            <%=adjtextarea(agSolicitors)%>
        <%end if%>

        <% if agadvisers<>"" then%>
            <span class="title">Nominated Advisers:</span>
          <%=adjtextarea(agAdvisers)%>
        <%end if%>

        <% if agauditor<>"" then%>
            <span class="title">Auditor:</span>
          <%=adjtextarea(agauditor)%>
        <%end if%>

        <% if agregistry<>"" then%>
            <span class="title">Share Registry:</span>
          <%=adjtextarea(agRegistry)%>
        <%end if%>

        <% if balancedate<>"" then%>
			<span class="title"> Balance Date:</span>
            <%=adjtextarea(balancedate)%>
        <%end if%>

        </p>
    </div>
    <div class="col-lg-4 col-md-4 col-sm-4 company-details lower">
        <h2>Operating information</h2>
        <p>
         <% if tradingcode <> "" then%>
  
    <span class="title">Trading Code:</span>
    <a href="/summary/<%=tradingcode%>"><%=tradingcode%></a>
  
  <%end if%>
  <% if isin<>"" then%>
    <span class="title">ISIN:</span>
    <%=isin%>
  
  <%end if%>
  <%If len(trim(sedol & " "))<>0 then %>
    <span class="title">SEDOL:</span>
    <%=sedol%>
  
  <%end if%>

  <%If len(trim(cusip & " "))<>0 then %>
    <span class="title">CUSIP:</span>
    <%=cusip%>
  <%end if%>

  <%If len(trim(BBGID & " "))<>0 then %>
    <span class="title">FIGI:</span>
    <%=BBGID%>
  
  <%end if%> 
  <%If len(trim(BBGTicker & " "))<>0 then %>
    <span class="title">Bloomberg Ticker:</span>
    <%=BBGTicker%>
  
  <%end if%>   
  <% if issuedescription<>"" then%>
    <span class="title">Security Description:</span>
    <%=adjtextarea(issuedescription)%>
  
  <%end if%>
  <% if issuetype<>"" then%>
    <span class="title">Security Type:</span>
    <%=adjtextarea(issuetype)%>
  
  <%end if%>  
  <% if offmarketnexus<>"" then%>
    <span class="title">Off Market Nexus:</span>
    <%=adjtextarea(offmarketnexus)%>
  
  <%end if%> 
  <% if certificated<>"" then%>
    <span class="title">Certificated:</span>
    <%=adjtextarea(certificated)%>
  
  <%end if%>   
  <% if issuersponsor<>"" then%>
  
    <span class="title">Issuer Sponsor:</span>
    <%=adjtextarea(issuersponsor)%>
  
  <%end if%>  
  <% if deferreddeliveryindicator<>"" then%>
  
    <span class="title">Deferred Delivery Indicator:</span>
    <%=adjtextarea(deferreddeliveryindicator)%>
  
  <%end if%> 
  <% if settlement<>"" then%>
  
    <span class="title">Settlement:</span>
    <%=adjtextarea(settlement)%>
  
  <%end if%> 

  <% if issuestatus<>"" then%>
  
    <span class="title">Security Status:</span>
    <%=adjtextarea(issuestatus)%>
  
  <%end if%> 
        </p>
    </div>
    <div class="col-lg-4 col-md-4 col-sm-4 company-details lower">
        <h2>How to trade</h2>
        <p>
         <% if issuestarted<>"" then%>
  
    <span class="title">Started Trading on:</span>
    <%=issuestarted%>
  
  <%end if%> 
  <% if len(trim(issuestopped& " "))<>0 then %>
  
    <span class="title">Stopped Trading on:</span>
    <%=issuestopped%>
  
  <%end if%> 
  <% if previoustradingcodes<>"" then%>
  
    <span class="title">Previous Security Codes:</span>
    <%=previoustradingcodes%>
  
  <%end if%> 
  
	<span class="title">Previous Security Effective Dates:</span>
    <%
    
    if isdate(previoustradingcodedates) then
    response.write day(previoustradingcodedates) & " " & Monthname(month(previoustradingcodedates)) & " " & year(previoustradingcodedates)
    else
    response.write previoustradingcodedates
    end if
    %>
  
  <% if len(trim(duallisteddetails & " "))<>0 then %>
  
    <span class="title">Dual Listing Details:</span>
    <%=duallisteddetails%>
  
  <%end if%>
  
    <span class="title">Total Securities Issued in this Class:</span>
    <%=currentsharesonissue%>
  
    <span class="title">Listing Price:</span>
    <%=offerprice%>
  
  
    <span class="title">Original offer document(s):</span>
    <%
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
%>
  
    <span class="title">Announcements:</span>
    <a href="/marketdata/company-directory/announcements/<%=tradingcode%>/">Announcements for this security</a>
    
  <% if len(optexpirydate)<>"" then  %>
  <span class="title">Option Details</span>
    
    <span class="title">Expiry Date:</span>
    <%=optexpirydate%>
   
  
    <span class="title">Expiry Price:</span>
    <%=optexprice%>
   
  
    <span class="title">Expiry Terms:</span>
    <%=replace(optdetails & " ",vbcrlf,"<BR>")%>
  
 <%end if%>
 <% if len(ficoupon)<>"" then %>
 
    <span class="title">Fixed Interest Details</span>
    
    <span class="title">Coupon:</span>
    <%=ficoupon%>
  
  
    <span class="title">Expiry Date:</span>
    <%=fiexpirydate%>
  
  
    <span class="title">Fixed Interest Terms:</span>
    <%=fmtcrlf(fidetails)%>
  
  <%end if%>
        </p> 
    </div>
</div>

<% NEXT
end if
%>
                </div> 
            </div>
        </div>
    </div>
</div>
<!--#INCLUDE FILE="footer.asp"-->