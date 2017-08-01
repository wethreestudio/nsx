<!--#INCLUDE FILE="include_all.asp"--><%

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

Function FixHref(href)
	href = trim(lcase(href))
	if left(href,len("http")) <> "http" then
		href = "http://" & href
	end if
	FixHref = href
End Function

page_title = "Company Details"
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
if Not IsNumeric(currentpage) Or len(currentpage) = 0 Then
	currentpage=1
Else
	currentpage=cint(currentpage)
	if currentpage<1 then currentpage=1
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

Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
ConnPasswords.Open Application("nsx_ReaderConnectionString")   
SQL = "SELECT nsxcode, coName, agStatus, Cityname, agName, agLevel, agBuild,"
SQL= SQL & "agAddress, Stateb, Country, agPCode, agSuburb, agPOBOX, agPOSuburb, agPOPcode,"
SQL= SQL & "agemail0, agemail1, agemail2,  agemail4, agemail5, agemail6, agemail7,"
SQL= SQL & "agemail8, agemail9, agweb0, agweb1, agweb2, agweb3, agweb4, agweb5, agweb6, agweb7,"
SQL= SQL & "agweb8, agweb9, agWho, agHistory, agServices, agLogo, agStrapline, agShortDesc,"
SQL= SQL & "agPhone, agFax, agExpiry, agContactName, agContactTitle, agNotes, agLink01, agLink02,"
SQL= SQL & "agLink03, agLink04, agLink05, agLinkTitle01, agLinkTitle02, agLinkTitle03, agLinkTitle04,"
SQL= SQL & "agLinkTitle05, RecordChangeUser, agNature, agBillingNotes, agPdate, agNewFloat,"
SQL= SQL & "agListedDate, agPActivities, agSectorClass, agIssuePrice, agIssueType, agCapitalRaised,"
SQL= SQL & "agOfferCloseDate, agFloatUnderwriter, agOfferDocument, agDelisted, agDelistedDate,"
SQL= SQL & "agSuspended, agSuspendedDate, agACN, agABN, agChairman, agMD, agSecretary, agDirectors,"
SQL= SQL & "agRegistry, agBankers, agBrokers, agAdvisers, agSolicitors, agEx01, agEx02, agEx03,"
SQL= SQL & "agDomicile, agFloatDesc, agaccountants, agtrustee, agfacilitators,balancedate,agEx04"
SQL = SQL & " FROM ((coDetails INNER JOIN [lookup - cities] ON coDetails.agCity = [lookup - cities].tid) INNER JOIN [lookup - states] ON coDetails.agState = [lookup - states].sid) INNER JOIN [lookup - country] ON coDetails.agCountry = [lookup - country].cid "
SQL = SQL & " WHERE (nsxcode='" & SafeSqlParameter(id) & "')"
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
maxpagesize = 10
maxpages = round(.5 + (rc / maxpagesize),0)
st = (currentpage * maxpagesize ) - maxpagesize
fh = st + maxpagesize - 1
if fh > rc then fh = rc

%>

<% if WEOF then %>
	 
There is no record available.
<% else
	
for jj = st to fh
 
nsxcode=alldata( 0 ,jj)
coName=alldata( 1,jj)
agStatus=alldata(2  ,jj)
agCity=alldata( 3 ,jj)
agName=alldata( 4 ,jj)
agLevel=alldata( 5 ,jj)
agBuild=alldata( 6 ,jj)
agAddress=alldata(7  ,jj)
agState=alldata(  8,jj)
agCountry=alldata( 9 ,jj)
agPCode=alldata(  10,jj)
agSuburb=alldata( 11 ,jj)
agPOBOX=alldata( 12 ,jj)
agPOSuburb=alldata(13  ,jj)
agPOPcode=alldata( 14 ,jj)
agemail0=alldata( 15 ,jj)
agemail1=alldata( 16 ,jj)
agemail2=alldata( 17 ,jj)
agemail4=alldata( 18 ,jj)
agemail5=alldata( 19 ,jj)
agemail6=alldata( 20 ,jj)
agemail7=alldata( 21 ,jj)
agemail8=alldata( 22 ,jj)
agemail9=alldata( 23 ,jj)
agweb0=alldata( 24 ,jj)
agweb1=alldata( 25 ,jj)
agweb2=alldata( 26 ,jj)
agweb3=alldata( 27 ,jj)
agweb4=alldata( 28 ,jj)
agweb5=alldata(  29,jj)
agweb6=alldata(  30,jj)
agweb7=alldata(  31,jj)
agweb8=alldata( 32 ,jj)
agweb9=alldata( 33 ,jj)
agWho=alldata(  34,jj)
agHistory=alldata(35  ,jj)
agServices=alldata( 36 ,jj)
agLogo=alldata( 37 ,jj)
agStrapline=alldata(38  ,jj)
agShortDesc=alldata( 39 ,jj)
agPhone=alldata(  40,jj)
agFax=alldata(  41,jj)
agExpiry=alldata( 42 ,jj)
agContactName=alldata(43  ,jj)
agContactTitle=alldata( 44 ,jj)
agNotes=alldata( 45 ,jj)
agLink01=alldata(  46,jj)
agLink02=alldata( 47 ,jj)
agLink03=alldata(  48,jj)
agLink04=alldata( 49 ,jj)
agLink05=alldata( 50 ,jj)
agLinkTitle01=alldata( 51 ,jj)
agLinkTitle02=alldata( 52 ,jj)
agLinkTitle03=alldata( 53 ,jj)
agLinkTitle04=alldata( 54 ,jj)
agLinkTitle05=alldata( 55 ,jj)
RecordChangeUser=alldata(56  ,jj)
agNature=alldata( 58 ,jj)
agBillingNotes=alldata(58  ,jj)
agPdate=alldata( 59 ,jj)
agNewFloat=alldata(60  ,jj)
agListedDate=alldata(61  ,jj)
agPActivities=alldata( 62 ,jj)
agIndustryClass=alldata( 63 ,jj)
agIssuePrice=alldata( 64 ,jj)
agIssueType=alldata( 65 ,jj)
agCapitalRaised=alldata( 66 ,jj)
agOfferCloseDate=alldata( 67 ,jj)
agFloatUnderwriter=alldata( 68 ,jj)
agOfferDocument=alldata( 69 ,jj)
agDelisted=alldata( 70 ,jj)
agDelistedDate=alldata(71  ,jj)
agSuspended=alldata( 72 ,jj)
agSuspendedDate=alldata( 73 ,jj)
agACN=alldata( 74 ,jj)
agABN=alldata(  75,jj)
agChairman=alldata( 76 ,jj)
agMD=alldata( 77 ,jj)
agSecretary=alldata( 78 ,jj)
agDirectors=alldata( 79 ,jj)
agRegistry=alldata( 80 ,jj)
agBankers=alldata( 81 ,jj)
agBrokers=alldata( 82 ,jj)
agAdvisers=alldata(  83,jj)
agSolicitors=alldata(  84,jj)
agEx01=trim(alldata(  85,jj) & " ")
agEx02=trim(alldata( 86 ,jj) & " ")
agEx03=trim(alldata( 87 ,jj) & " ")
agDomicile=alldata( 88 ,jj)
agFloatDesc=alldata(  89,jj)      	  
agauditor=alldata(90,jj)
agtrustee=alldata(91,jj)    	  
agfacilitators=alldata(92,jj)   
balancedate=alldata(93,jj)
agEx04=trim(alldata( 94 ,jj) & " ")
%>
    
<h1><%=remcrlf(coname)%></h1>
<% If Len(agstrapline)>0 Then %>
<p><%=agstrapline%></p>
<% End If %>
<%
If Len(Trim(aglogo)) > 0 then 
%>	<img src="/images/company_images/<%=agLogo%>" alt="Logo - <%=remcrlf(ucase(coname))%>" style="padding-top:8px;padding-bottom:8px">
<% 
End If
%>
<% If Len(agshortdesc)>0 Then %>
<p><%=remcrlf(agshortdesc)%></p>
<% End If %>
</div>


    
<table id="myTable" class="tablesorter" width="99%"> 
<tbody> 
  <% if agacn<>"" then%>
  <tr <%=trClass()%>>
    <td align="left" valign="top" width="240"><b>ACN or ARBN:</b></td>
    <td><%=agacn%></td>
  </tr>
  <%end if%>
  <% if agabn<>"" then%>
  <tr <%=trClass()%>>
    <td align="left" valign="top"><b>ABN:</b></td>
    <td align="left" valign="top"><%=agabn%></td>
  </tr>
  <%end if%>
  <% if nsxcode<>"" then%>
  <tr <%=trClass()%>>
    <td align="left" valign="top"><b>NSX Code:</b></td>
    <td align="left" valign="top"><%=adjtextarea(nsxcode)%></td>
  </tr>
  <%end if%>
  <% 
  sql = "SELECT tradingcode,issuedescription FROM coIssues WHERE nsxcode='" & SafeSqlParameter(id) & "' AND issuestatus='Active' ORDER BY tradingcode ASC"
  Set conn = GetReaderConn()
  Set rs = conn.Execute(sql)  
  If Not rs.EOF Then
  %>
  <tr <%=trClass()%>>
	<td align="left" valign="top"><b>NSX Listed Securities:</b></td>
    <td align="left" valign="top">
	<%  
	While Not rs.EOF
	%>
		<a href="/summary/<%=ucase(rs("tradingcode"))%>"><%=ucase(rs("tradingcode"))%></a><%=" - " & rs("issuedescription")%><br>
	<%
		rs.MoveNext 
	Wend 
	rs.Close
	Set rs = Nothing
	%>
	</td>
  </tr>
  <%end if%>
  <tr <%=trClass()%>>
    <td align="left" valign="top"><b>Listing Date:</b></td>
    <td align="left" valign="top">
    <%
    if trim(agListedDate & " ") = "" then
    	response.write "To be advised"
    	else
    	response.write formatdatetime(agListedDate,1)
    	end if
    	%></td>
  </tr>
  <% if agpactivities<>"" then%>
  <tr <%=trClass()%>>
    <td align="left" valign="top"><b>Principal Activities:</b></td>
    <td align="left" valign="top"><%=adjtextarea(agPactivities)%></td>
  </tr>
  <%end if%>
  <% if agindustryclass<>"" then%>
  <tr <%=trClass()%>>
    <td align="left" valign="top"><b>Industry Class:</b></td>
    <td align="left" valign="top"><%
	if len(agindustryclass)<>0 then 
		agIndustryClass = mid(agindustryclass,instr(agindustryclass,"-")+1,len(agindustryclass))
	end if
	response.write adjtextarea(agIndustryClass)%></td>
  </tr>
  <%end if%>
  <% if agaddress<>"" then%>
  <tr <%=trClass()%>>
    <td align="left" valign="top"><b>Street Address:</b></td>
    <td align="left" valign="top">
    <%response.write agBuild & " "
    response.write agLevel & "<br>"
    response.write agAddress & "<br>"
    response.write agSuburb
    response.write " " & agCity
    response.write " " & agState
    response.write " " & agCountry
    response.write " " & agPCode
    %></td>
  </tr>
  <%end if%>

  <% if agPOBOX<>"" then%>
  <tr <%=trClass()%>>
    <td align="left" valign="top"><b>Postal Address:</b></td>
    <td align="left" valign="top">
    <%
    response.write agPOBOX & "<br>"
    response.write agPOSUBURB & "<br>"
    response.write " " & agCity & " " & agState & " " & agCountry & " " & agPOPCode
    %></td>
  </tr>
  <%end if%>

  <% if agdomicile<>"" then%>
  <tr <%=trClass()%>>
    <td align="left" valign="top"><b>Company Base:</b></td>
    <td align="left" valign="top"><%=adjtextarea(agDomicile)%></td>
  </tr>
  <%end if%>
  <% if agweb0<>"" then%>
  <tr <%=trClass()%>>
    <td align="left" valign="top"><b>Web:</b></td>
    <td align="left" valign="top">
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
    </td>
  </tr>
  <%end if%>
  <% if agemail0<>"" then%>
  <tr <%=trClass()%>>
    <td align="left" valign="top"><b>Email:</b></td>
    <td align="left" valign="top">
    <%
    if len(trim(agemail0))>0 then response.write "<a href=""mailto:" & agemail0 &""">" & agemail0 & "</a><br>"
    if len(trim(agemail1))>0 then response.write "<a href=""mailto:" & agemail1 &""">" & agemail1 & "</a><br>"
    if len(trim(agemail2))>0 then response.write "<a href=""mailto:" & agemail2 &""">" & agemail2 & "</a><br>"
    if len(trim(agemail3))>0 then response.write "<a href=""mailto:" & agemail3 &""">" & agemail3 & "</a><br>"
    if len(trim(agemail4))>0 then response.write "<a href=""mailto:" & agemail4 &""">" & agemail4 & "</a><br>"
    if len(trim(agemail5))>0 then response.write "<a href=""mailto:" & agemail5 &""">" & agemail5 & "</a><br>"
    if len(trim(agemail6))>0 then response.write "<a href=""mailto:" & agemail6 &""">" & agemail6 & "</a><br>"   
    %>
     </td>
  </tr>
  <%end if%>
  <% if agphone<>"" then%>
  <tr <%=trClass()%>>
    <td align="left" valign="top"><b>Phone:</b></td>
    <td align="left" valign="top"><%=adjtextarea(agphone)%></td>
  </tr>
  <%end if%>
  <% if agfax<>"" then%>
  <tr <%=trClass()%>>
    <td align="left" valign="top"><b>Fax:</b></td>
    <td align="left" valign="top"><%=adjtextarea(agfax)%></td>
  </tr>
  <%end if%>
  <% if agchairman<>"" then%>
  <tr <%=trClass()%>>
    <td align="left" valign="top"><b>Chairman:</b></td>
    <td align="left" valign="top">
	<% if len(trim(agemail7))>0 then 
	response.write " <a href=""mailto:" & agemail7 &""">" & adjtextarea(agchairman) & "</a><br>"
	else
	response.write adjtextarea(agchairman)
	end if
	%>
    </td>
  </tr>
  <%end if%>
  <% if agmd<>"" then%>
  <tr <%=trClass()%>>
    <td align="left" valign="top"><b>Managing Director / CEO:</b></td>
    <td align="left" valign="top">
        <%if len(trim(agemail8))>0 then 
        response.write " <a href=""mailto:" & agemail8 &""">" & adjtextarea(agmd)& "</a><br>"
        else
        response.write adjtextarea(agmd)
        end if
        %></td>
  </tr>
  <%end if%>
  <% if agdirectors<>"" then%>
  <tr <%=trClass()%>>
    <td align="left" valign="top"><b>Directors:</b></td>
    <td align="left" valign="top"><%=adjtextarea(agdirectors)%></td>
  </tr>
  <%end if%>
  <% if agsecretary<>"" then%>
  <tr <%=trClass()%>>
    <td align="left" valign="top"><b>Company Secretary:</b></td>
    <td align="left" valign="top">
    <%if len(trim(agemail9))>0 then 
		response.write " <a href=""mailto:" & agemail9 &""">" & adjtextarea(agSecretary) & "</a><br>"
    else
		response.write adjtextarea(agSecretary)
    end if%></td>
  </tr>
  <%end if%>
  <% if agbankers<>"" then%>
  <tr <%=trClass()%>>
    <td align="left" valign="top"><b>Bankers:</b></td>
    <td align="left" valign="top"><%=adjtextarea(agbankers)%></td>
  </tr>
  <%end if%>
  <% if agsolicitors<>"" then%>
  <tr <%=trClass()%>>
    <td align="left" valign="top"><b>Solicitors:</b></td>
    <td align="left" valign="top"><%=adjtextarea(agSolicitors)%></td>
  </tr>
  <%end if%>
  <% if agadvisers<>"" then%>
  <tr <%=trClass()%>>
    <td align="left" valign="top"><b>Nominated Advisers:</b></td>
    <td align="left" valign="top"><%=adjtextarea(agAdvisers)%></td>
  </tr>
  <%end if%>
  <% if agfacilitators<>"" then%>
  <tr <%=trClass()%>>
	<td align="left" valign="top"><b>Facilitators:</b></td>
    <td align="left" valign="top"><%=adjtextarea(agfacilitators)%></td>
  </tr>
  <%end if%>
  <% if agbrokers<>"" then%>
  <tr <%=trClass()%>>
    <td align="left" valign="top"><b>Brokers:</b></td>
    <td align="left" valign="top"><%=adjtextarea(agBrokers)%></td>
  </tr>
  <%end if%>
  <% if agauditor<>"" then%>
  <tr <%=trClass()%>>
    <td align="left" valign="top"><b>Auditor:</b></td>
    <td align="left" valign="top"><%=adjtextarea(agauditor)%></td>
  </tr>
  <%end if%>
  <% if agregistry<>"" then%>
  <tr <%=trClass()%>>
    <td align="left" valign="top"><b>Share Registry:</b></td>
    <td align="left" valign="top"><%=adjtextarea(agRegistry)%></td>
  </tr>
  <%end if%>
  <% if agtrustee<>"" then%>
  <tr <%=trClass()%>>
    <td align="left" valign="top"><b>Trustee or Manager or Responsible Entity:</b></td>
    <td align="left" valign="top"><%=adjtextarea(agtrustee)%></td>
  </tr>
  <%end if%>
<% if agEx04<>"" then%>
<tr <%=trClass()%>>
    <td align="left" valign="top"><b>Other Trading Exchanges:</b></td>
    <td align="left" valign="top"><%
	
	markets_ary = split(agEx04,"}")
	markets_count = ubound(markets_ary)
	for jjj = 0 to markets_count
		agex04 = split(markets_ary(jjj),"|")
		ex_name = agex04(0)
		ex_url = agex04(1)
		response.write " " & "<a href='" & ex_url & "' class='' target='_blank'>" & ex_name & "</a><br>"
	NEXT
	
	
	%>
	</td>
  </tr>
  <%end if%>
  <% if balancedate<>"" then%>
  <tr <%=trClass()%>>
    <td align="left" valign="top"><b>Balance Date:</b></td>
    <td align="left" valign="top"><%=adjtextarea(balancedate)%></td>
  </tr>
  <%end if%>

  </tbody>
</table>

<% 
	Next
End If
%>



</div>
<!--#INCLUDE FILE="footer.asp"-->