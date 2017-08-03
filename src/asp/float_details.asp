<!--#INCLUDE FILE="include_all.asp"-->
<%
Function remcrlf(xx)
  remcrlf = replace(xx & " ",vbCRLF,"")
  remcrlf = trim(Replace(remcrlf & " ", "''", "'"))
End Function

page_title = "Float Details"
' meta_description = ""
' alow_robots = "no"
' objJsIncludes.Add "marketdata", "js/marketdata.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"
%>
<!--#INCLUDE FILE="header.asp"-->
<div class="container_cont">
<div class="editarea">



<%
on error resume next

is_odd = true

Function trClass()
	if is_odd then
		trClass = " class=""alt"""
	else
		trClass = ""
	end if
	is_odd = Not is_odd
End Function

Function fixLink(hyperlink)
	if Left(hyperlink, 4) <> "http" Then
		fixLink = "http://" & hyperlink
	Else
		fixLink = hyperlink
	End If
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
SQL = "SELECT codetails.nsxcode, coName, agStatus, Cityname, agName, agLevel, agBuild,"
SQL= SQL & "agAddress, Stateb, Country, agPCode, agSuburb, agPOBOX, agPOSuburb, agPOPcode,"
SQL= SQL & "agemail0, agemail1, agemail2,  agemail4, agemail5, agemail6, agemail7,"
SQL= SQL & "agemail8, agemail9, agweb0, agweb1, agweb2, agweb3, agweb4, agweb5, agweb6, agweb7,"
SQL= SQL & "agweb8, agweb9, agWho, agHistory, agServices, agLogo, agStrapline, agShortDesc,"
SQL= SQL & "agPhone, agFax, agExpiry, agContactName, agContactTitle, agNotes, agLink01, agLink02,"
SQL= SQL & "agLink03, agLink04, agLink05, agLinkTitle01, agLinkTitle02, agLinkTitle03, agLinkTitle04,"
SQL= SQL & "agLinkTitle05, codetails.RecordChangeUser, agNature, agBillingNotes, iPdate, iNewFloat,"
SQL= SQL & "agListedDate, agPActivities, iIndustryClass, iIssuePrice, iIssueType, iCapitalRaised,"
SQL= SQL & "iOfferCloseDate, iFloatUnderwriter, iOfferDocument, agDelisted, agDelistedDate,"
SQL= SQL & "agSuspended, agSuspendedDate, agACN, agABN, agChairman, agMD, agSecretary, agDirectors,"
SQL= SQL & "agRegistry, agBankers, agBrokers, agAdvisers, agSolicitors, agEx01, agEx02, agEx03,"
SQL= SQL & "agDomicile, iFloatDesc, iBrokers, iTRanche, IssueDescription, agaccountants, tradingcode, ISIN"
SQL = SQL & " FROM  (((coDetails INNER JOIN coIssues ON coDetails.nsxcode = coIssues.nsxcode) INNER JOIN [lookup - cities] ON coDetails.agCity = [lookup - cities].tid) INNER JOIN [lookup - states] ON coDetails.agState = [lookup - states].sid) INNER JOIN [lookup - country] ON coDetails.agCountry = [lookup - country].cid "
SQL = SQL & " WHERE (iNewFloat=1 and tradingcode='" & SafeSqlParameter(id) & "')"
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

<%  if WEOF then %>
	 
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
iPdate=alldata( 59 ,jj)
iNewFloat=alldata(60  ,jj)
agListedDate=alldata(61  ,jj)
iPActivities=alldata( 62 ,jj)
iIndustryClass=alldata( 63 ,jj)
iIssuePrice=alldata( 64 ,jj)
iIssueType=alldata( 65 ,jj)
iCapitalRaised=alldata( 66 ,jj)

Compliance = instr(ucase(iCapitalRaised),"COMPLIANCE")

iOfferCloseDate=alldata( 67 ,jj)
iFloatUnderwriter=alldata( 68 ,jj)
iOfferDocument=alldata( 69 ,jj)
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
agEx01=alldata(  85,jj)
agEx02=alldata( 86 ,jj)
agEx03=alldata( 87 ,jj)
agDomicile=alldata( 88 ,jj)
iFloatDesc=alldata(  89,jj)  
iBrokers=alldata(90,jj)
iTranche=alldata(91,jj)   
iIssueDesc=alldata(92,jj) 	  
agaccountants=alldata(93,jj)
tradingcode=alldata(94,jj)
ISIN=alldata(95,jj)


    lap = 0
    cl = array("#FFFFFF","#EEEEEE")
    
     

      	  
%>
<h1>Float Details - <%=remcrlf(ucase(iissuedesc))%> (<%=adjtextarea(tradingcode)%>)</h1>
<%
If Len(Trim(aglogo & " ")) > 0 Then
	Response.Write "<p><img src=images/company_images/" & aglogo & " border=0></p>"
End If
If Len(Trim(agstrapline & " ")) > 0 Then
	Response.Write "<p>" & agstrapline & "</p>"
End If
If Len(Trim(agshortdesc & " ")) > 0 Then
  Response.Write "<p>" & agshortdesc & "</p>"
End If
%>
<div class="f-w-table">
<div class="table-responsive"><table>
    <thead>
        <tr>
            <th colspan="5">
            <p><%if compliance<>0 then
    	response.write "COMPLIANCE LISTING"
    	else
    	response.write "PROSPECTUS LISTING"
    end if
    %> <span>&nbsp;</span></p>
            <img src="/images/nsx-water-mark.png" alt="" class="water-mark" /></th>
        </tr>
    </thead>
    <tfoot>
    <tr>
        <td colspan="2">&nbsp;</td>
    </tr>
    </tfoot>
    <tbody>
        <!--tr class="sub-header">
            <td align="left">Document</td>
            <td width="65">Type</td>
            <td width="90">Download</td>
        </tr-->
        <tr <%=trClass()%>>
            <td align="left"  width="250">Proposed NSX Code:</td>
            <td align="left"><%=adjtextarea(tradingcode)%>&nbsp;</td>
        </tr>
        <tr <%=trClass()%>>
            <td align="left">Proposed Listing Date:</td>
            <td align="left"><%=adjtextarea(iPDate)%>&nbsp;</td>
        </tr>
<%if trim(ipactivities & " ")<>"" then%>		
        <tr <%=trClass()%>>
            <td align="left">Principal Activities:</td>
            <td align="left"><%=adjtextarea(iPactivities)%>&nbsp;</td>
        </tr>
<%end if%>
<%if trim(iIndustryClass & " ")<>"" then%>
        <tr <%=trClass()%>>
            <td align="left">Industry Class:</td>
            <td align="left"><%=adjtextarea(iIndustryClass)%>&nbsp;</td>
        </tr>
<%end if%>
<%if Compliance=0 then%>
        <tr <%=trClass()%>>
            <td align="left">Issue Price:</td>
            <td align="left"><%=adjtextarea(iIssuePrice)%>&nbsp;</td>
        </tr>
<%end if%>
<%if trim(iIssueType & " ")<>"" then%>
        <tr <%=trClass()%>>
            <td align="left">Issue Type:</td>
            <td align="left"><%=adjtextarea(iIssueType)%>&nbsp;</td>
        </tr>
<%end if%>
<%if trim(ISIN & " ")<>"" then%>
        <tr <%=trClass()%>>
            <td align="left">ISIN:</td>
            <td align="left"><%=adjtextarea(ISIN)%>&nbsp;</td>
        </tr>
<%end if%>	
<%if trim(iCapitalRaised & " ")<>"" then%>
        <tr <%=trClass()%>>
            <td align="left">Capital to be raised:</td>
            <td align="left"><%=adjtextarea(iCapitalRaised)%>&nbsp;</td>
        </tr>
<%end if%>
<%if trim(iFloatunderwriter & " ")<>"" then%>
        <tr <%=trClass()%>>
            <td align="left">Offer Underwriter(s):</td>
            <td align="left"><%=iFloatUnderwriter%>&nbsp;</td>
        </tr>
<%end if%>
<%if trim(iBrokers & " ")<>"" then%>
        <tr <%=trClass()%>>
            <td align="left">Offer Broker(s):</td>
            <td align="left"><%=replace(iBrokers & " ",vbCRLF,"<BR>")%>&nbsp;</td>
        </tr>
<%end if%>

<%if iOfferCloseDate<>Null then%>
        <tr <%=trClass()%>>
            <td align="left">Expected offer close date:</td>
            <td align="left"><%=formatdatetime(iOfferCloseDate,1)%>&nbsp;</td>
        </tr>
<%end if%> 
<% if trim(iFloatDesc & " ")<>"" then%>
        <tr <%=trClass()%>>
            <td align="left">Synopsis of Listing:</td>
            <td align="left"><%=adjtextarea(iFloatDesc)%>&nbsp;</td>
        </tr>
<%end if%> 
<%if trim(iOfferdocument & " ")<>"" then%>
        <tr <%=trClass()%>>
            <td align="left"><%if Compliance>0 then
			response.write "Listing Document:"
    	else
			response.write "Offer Document(s):"
		end if
		%></td>
            <td align="left">
		<%
		bb = split(iofferdocument & ";",";")
		 bbcount = ubound(bb)
		 for ii = 0 to bbcount
			if len(trim(bb(ii) & " ")) <> 0 then
				' get file name and title
				aa=split(bb(ii) & "|","|")
				response.write ii+1 & ". <a href=""/ftp/news/" & aa(0) &  """ target=_blank >" & aa(1) & "</a><br>"      	
			end if
		 next
%>&nbsp;</td>
        </tr>
<%end if%>
        <tr <%=trClass()%>>
            <td align="left">Announcements:</td>
            <td align="left"><% response.write "<a href=""/marketdata/search_by_company?nsxcode=" & id &  """ >Check announcements for more information</a>" %>&nbsp;</td>
        </tr>
<%IF trim(iBroker & " ")<>"" then%>
        <tr <%=trClass()%>>
            <td align="left">Sponsoring Broker:</td>
            <td align="left"><%=iBrokers%>&nbsp;</td>
        </tr>
<%end if%>
    </tbody>
</table></div>
</div>
<%
is_odd = true
%>
<div class="f-w-table">
<div class="table-responsive"><table>
    <thead>
        <tr>
            <th colspan="5">
            <p><%=ucase(adjtextarea(coname))%> <span>&nbsp;</span></p>
            <img src="/images/nsx-water-mark.png" alt="" class="water-mark" /></th>
        </tr>
    </thead>
    <tfoot>
    <tr>
        <td colspan="2">&nbsp;</td>
    </tr>
    </tfoot>
    <tbody>


        <tr <%=trClass()%>>
            <td align="left" width="250">Issuer:</td>
            <td align="left"><%=ucase(adjtextarea(coname))%>&nbsp;</td>
        </tr>
        <tr <%=trClass()%>>
            <td align="left">Address:</td>
            <td align="left"><%response.write agBuild & " "
			response.write agLevel & "<br>"
			response.write agAddress & "<br>"
			response.write agSuburb
			response.write " " & agCity
			response.write " " & agState
			response.write " " & agCountry
			response.write " " & agPCode
			%>&nbsp;</td>
        </tr>
        <tr <%=trClass()%>>
            <td align="left">ACN:</td>
            <td align="left"><%=agacn%>&nbsp;</td>
        </tr>
<%if trim(agabn & " ")<>"" then%>
        <tr <%=trClass()%>>
            <td align="left">ABN:</td>
            <td align="left"><%=agabn%>&nbsp;</td>
        </tr>
<%end if%>
        <tr <%=trClass()%>>
            <td align="left">Company Base:</td>
            <td align="left"><%=adjtextarea(agDomicile)%>&nbsp;</td>
        </tr>
<%if trim(agweb0 & " ")<>"" then%>
        <tr <%=trClass()%>>
            <td align="left">Web:</td>
            <td align="left">
			<%
			if len(trim(agweb0))>0 then response.write "<a href=""" & fixLink(agweb0) &""" target=_blank>" & agweb0 & "</a><br>"
			if len(trim(agweb1))>0 then response.write "<a href=""" & fixLink(agweb1) &""" target=_blank>" & agweb1 & "</a><br>"
			if len(trim(agweb2))>0 then response.write "<a href=""" & fixLink(agweb2) &""" target=_blank>" & agweb2 & "</a><br>"
			if len(trim(agweb3))>0 then response.write "<a href=""" & fixLink(agweb3) &""" target=_blank>" & agweb3 & "</a><br>"
			%>&nbsp;</td>
        </tr>
<%end if%>
<%if trim(agemail0 & " ")<>"" then%>
        <tr <%=trClass()%>>
            <td align="left">Email:</td>
            <td align="left">
			<%
			if len(trim(agemail0))>0 then response.write "<a href=mailto:""" & agemail0 &""">" & agemail0 & "</a><br>"
			if len(trim(agemail1))>0 then response.write "<a href=mailto:""" & agemail1 &""">" & agemail1 & "</a><br>"
			if len(trim(agemail2))>0 then response.write "<a href=mailto:""" & agemail2 &""">" & agemail2 & "</a><br>"
			%>&nbsp;</td>
        </tr>  
<%end if%>
<%if trim(agphone & " ")<>"" then%>
        <tr <%=trClass()%>>
            <td align="left">Phone:</td>
            <td align="left"><%=adjtextarea(agphone)%>&nbsp;</td>
        </tr>
<%end if%>
<%if trim(agfax & " ")<>"" then%>
        <tr <%=trClass()%>>
            <td align="left">Fax:</td>
            <td align="left"><%=adjtextarea(agfax)%>&nbsp;</td>
        </tr>
<%end if%>
<%if trim(agchairman & " ")<>"" then%>
        <tr <%=trClass()%>>
            <td align="left">Chairman:</td>
            <td align="left"><%=adjtextarea(agchairman)%>&nbsp;</td>
        </tr>
<% end if%>
<%if trim(agmd & " ")<>"" then%>
        <tr <%=trClass()%>>
            <td align="left">Managing Director / CEO:</td>
            <td align="left"><%=adjtextarea(agmd)%>&nbsp;</td>
        </tr>
<%end if%>
        <tr <%=trClass()%>>
            <td align="left">Directors:</td>
            <td align="left"><%=adjtextarea(agdirectors)%>&nbsp;</td>
        </tr> 
<%if trim(agSecretary & " ")<>"" then%>
        <tr <%=trClass()%>>
            <td align="left">Company Secretary:</td>
            <td align="left"><%=adjtextarea(agSecretary)%>&nbsp;</td>
        </tr>   
<%end if%>
<%if trim(agBankers & " ")<>"" then%>
        <tr <%=trClass()%>>
            <td align="left">Bankers:</td>
            <td align="left"><%=adjtextarea(agbankers)%>&nbsp;</td>
        </tr> 
<%end if%>
<%if trim(agSolicitors & " ")<>"" then%>
        <tr <%=trClass()%>>
            <td align="left">Solicitors:</td>
            <td align="left"><%=adjtextarea(agSolicitors)%>&nbsp;</td>
        </tr>  
<%end if%>
<%if trim(agadvisers & " ")<>"" then%>
        <tr <%=trClass()%>>
            <td align="left">Advisers:</td>
            <td align="left"><%=adjtextarea(agAdvisers)%>&nbsp;</td>
        </tr>   
<%end if%>
<%if trim(agbrokers & " ")<>"" then%>
		<tr <%=trClass()%>>
            <td align="left">Brokers:</td>
            <td align="left"><%=adjtextarea(agBrokers)%>&nbsp;</td>
        </tr> 
<%end if%>
<%if trim(agRegistry & " ")<>"" then%>
        <tr <%=trClass()%>>
            <td align="left">Share Registry:</td>
            <td align="left"><%=adjtextarea(agRegistry)%>&nbsp;</td>
        </tr>   
<%end if%>
<%if trim(agaccountants & " ")<>"" then%>
        <tr <%=trClass()%>>
            <td align="left">Auditors:</td>
            <td align="left"><%=adjtextarea(agaccountants)%>&nbsp;</td>
        </tr>
<%end if%>
    </tbody>
</table></div>
</div>


<% NEXT
	end if
	%>


</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->