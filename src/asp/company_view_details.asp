<!--#INCLUDE FILE="include_all.asp"--><%
Function remcrlf(xx)
  remcrlf = replace(xx & " ",vbCRLF,"")
  remcrlf = trim(Replace(remcrlf & " ", "''", "'"))
End Function


page_title = "Company Details"
' meta_description = ""
' alow_robots = "no"
' objJsIncludes.Add "marketdata", "js/marketdata.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"
%>
<!--#INCLUDE FILE="header.asp"-->

<div style="background-color:#fff; padding-bottom:20px;">
<%
Server.Execute "company_side_menu.asp"
%>


<div style="margin-left:260px; margin-right:12px;" >
<div class="prop min600px"></div>
<div style="float:left;width:750px;">

  <div class="editarea">
<%

on error resume next

errmsg=""

currentpage = trim(request("currentpage"))
if len(currentpage)=0 then currentpage=1
currentpage=cint(currentpage)
if currentpage<1 then currentpage=1


nsxcode = Session("nsxcode") 

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
SQL= SQL & "agListedDate, agPActivities, agIndustryClass, agIssuePrice, agIssueType, agCapitalRaised,"
SQL= SQL & "agOfferCloseDate, agFloatUnderwriter, agOfferDocument, agDelisted, agDelistedDate,"
SQL= SQL & "agSuspended, agSuspendedDate, agACN, agABN, agChairman, agMD, agSecretary, agDirectors,"
SQL= SQL & "agRegistry, agBankers, agBrokers, agAdvisers, agSolicitors, agEx01, agEx02, agEx03,"
SQL= SQL & "agDomicile, agFloatDesc, agaccountants, agtrustee, agfacilitators,balancedate"
SQL = SQL & " FROM ((coDetails INNER JOIN [lookup - cities] ON coDetails.agCity = [lookup - cities].tid) INNER JOIN [lookup - states] ON coDetails.agState = [lookup - states].sid) INNER JOIN [lookup - country] ON coDetails.agCountry = [lookup - country].cid "


SQL = SQL & " WHERE (nsxcode='" & SafeSqlParameter(nsxcode) & "')"
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
agEx01=alldata(  85,jj)
agEx02=alldata( 86 ,jj)
agEx03=alldata( 87 ,jj)
agDomicile=alldata( 88 ,jj)
agFloatDesc=alldata(  89,jj)      	  
agauditor=alldata(90,jj)
agtrustee=alldata(91,jj)    	  
agfacilitators=alldata(92,jj)   
balancedate=alldata(93,jj)
%>

<h1><%=remcrlf(ucase(coname))%></h1>
    

    


    
<table cellpadding="5" cellspacing="0" bgcolor=#FFFFFF width="100%" style="border-bottom:1px solid #666666; ">
  <% 
  lap = 0
  cl = array("#FFFFFF","#EEEEEE")  
  %>

  <tr>
    <td bgcolor="<%=cl(lap)%>" valign="top" class="textlabel" width="20%">
      <font color="#808080">Description:
      
      
      </font>
    </td>
    <td class="plaintext" bgcolor="#FFFFFF">&nbsp;<%=remcrlf(agshortdesc)%></td>
  </tr>    
    

  <%lap = (-lap)+1
  if agacn<>"" then
  %>
  
  <tr>
    <td bgcolor="<%=cl(lap)%>" valign="top" class="textlabel" width="20%">
      <font color="#808080">ACN:
      
      
      </font>
      
      
      </td>
    <td bgcolor="<%=cl(lap)%>" valign="top" width="80%" class="plaintext"><%=agacn%>    
      
      </td>
  </tr>
  <%lap = (-lap)+1%>
  <%end if%>
  <% if agabn<>"" then%>
  <tr>
    <td bgcolor="<%=cl(lap)%>" valign="top" class="textlabel" width="20%">
      <font color="#808080">ABN:
      
      
      </font>
      
      
      </td>
    <td bgcolor="<%=cl(lap)%>" valign="top" width="80%" class="plaintext"><%=agabn%>      
      
      </td>
  </tr>
  <%lap = (-lap)+1%>
  <%end if%>
  <% if nsxcode<>"" then%>
  <tr>
    <td bgcolor="<%=cl(lap)%>" valign="top" class="textlabel" width="20%">
      <font color="#808080">NSX Code:</font></td>
    <td bgcolor="<%=cl(lap)%>" valign="top" width="80%" class="plaintext"><%=adjtextarea(nsxcode)%></td>
  </tr>
<%end if%><%lap = (-lap)+1%>
  
  <tr>
    <td bgcolor="<%=cl(lap)%>" valign="top" class="textlabel" width="20%">
      <font color="#808080">Listing Date:</font></td>
    <td bgcolor="<%=cl(lap)%>" valign="top" width="80%" class="plaintext"><%
    if trim(agListedDate & " ") = "" then
    	response.write "To be advised"
    	else
    	response.write formatdatetime(agListedDate,1)
    	end if
    	%></td>
  </tr><%lap = (-lap)+1%>
  <% if agpactivities<>"" then%>
  <tr>
    <td bgcolor="<%=cl(lap)%>" valign="top" class="textlabel" width="20%">
	<font color="#808080">Principal
      Activities:</font></td>
    <td bgcolor="<%=cl(lap)%>" valign="top" width="80%" class="plaintext"><%=adjtextarea(agPactivities)%></td>
  </tr>
<%lap = (-lap)+1%><%end if%>
  <% if agindustryclass<>"" then%>
  <tr>
    <td bgcolor="<%=cl(lap)%>" valign="top" class="textlabel" width="20%">
	<font color="#808080">Industry
      Class:</font></td>
    <td bgcolor="<%=cl(lap)%>" valign="top" width="80%" class="plaintext"><%=adjtextarea(agIndustryClass)%></td>
  </tr>
<%lap = (-lap)+1%><%end if%>
  <% if agaddress<>"" then%>
  <tr>
    <td bgcolor="<%=cl(lap)%>" valign="top" class="textlabel" width="20%">
	<font color="#808080">Street Address:</font></td>
    <td bgcolor="<%=cl(lap)%>" valign="top" width="80%" class="plaintext">
    <%response.write agBuild & " "
    response.write agLevel & "<br>"
    response.write agAddress & "<br>"
    response.write agSuburb
    response.write " " & agCity
    response.write " " & agState
    response.write " " & agCountry
    response.write " " & agPCode
    %>
   
    </td>
  </tr>
<%lap = (-lap)+1%><%end if%>

  <% if agPOBOX<>"" then%>
  <tr>
    <td bgcolor="<%=cl(lap)%>" valign="top" class="textlabel" width="20%">
	<font color="#808080">Postal Address:</font></td>
    <td bgcolor="<%=cl(lap)%>" valign="top" width="80%" class="plaintext">
    <%
    response.write agPOBOX & "<br>"
    response.write agPOSUBURB & "<br>"
    response.write " " & agCity & " " & agState & " " & agCountry & " " & agPOPCode
 
    %>
 
    </td>
  </tr>
<%lap = (-lap)+1%><%end if%>

  <% if agdomicile<>"" then%>
  <tr>
    <td bgcolor="<%=cl(lap)%>" valign="top" class="textlabel" width="20%">
	<font color="#808080">Company
      Base:</font></td>
    <td bgcolor="<%=cl(lap)%>" valign="top" width="80%" class="plaintext"><%=adjtextarea(agDomicile)%></td>
  </tr>
<%lap = (-lap)+1%><%end if%>
  <% if agweb0<>"" then%>
  <tr>
    <td bgcolor="<%=cl(lap)%>" valign="top" class="textlabel" width="20%">
	<font color="#808080">Web:</font></td>
    <td bgcolor="<%=cl(lap)%>" valign="top" width="80%" class="plaintext">
    <%
    if len(trim(agweb0))>0 then response.write "<a href=" & agweb0 &" target=_blank>" & agweb0 & "</a><br>"
    if len(trim(agweb1))>0 then response.write "<a href=" & agweb1 &" target=_blank>" & agweb1 & "</a><br>"
    if len(trim(agweb2))>0 then response.write "<a href=" & agweb2 &" target=_blank>" & agweb2 & "</a><br>"
    if len(trim(agweb3))>0 then response.write "<a href=" & agweb3 &" target=_blank>" & agweb3 & "</a><br>"
    if len(trim(agweb4))>0 then response.write "<a href=" & agweb4 &" target=_blank>" & agweb4 & "</a><br>"
    if len(trim(agweb5))>0 then response.write "<a href=" & agweb5 &" target=_blank>" & agweb5 & "</a><br>"
    if len(trim(agweb6))>0 then response.write "<a href=" & agweb6 &" target=_blank>" & agweb6 & "</a><br>"
    if len(trim(agweb7))>0 then response.write "<a href=" & agweb7 &" target=_blank>" & agweb7 & "</a><br>"
    if len(trim(agweb8))>0 then response.write "<a href=" & agweb8 &" target=_blank>" & agweb8 & "</a><br>"
    if len(trim(agweb9))>0 then response.write "<a href=" & agweb9 &" target=_blank>" & agweb9 & "</a><br>"

    %>
    </td>
  </tr>
<%lap = (-lap)+1%><%end if%>
  <% if agemail0<>"" then%>
  <tr>
    <td bgcolor="<%=cl(lap)%>" valign="top" class="textlabel" width="20%">
	<font color="#808080">Email:</font></td>
    <td bgcolor="<%=cl(lap)%>" valign="top" width="80%" class="plaintext">
    <%
    if len(trim(agemail0))>0 then response.write "<a href=mailto:" & agemail0 &">" & agemail0 & "</a><br>"
    if len(trim(agemail1))>0 then response.write "<a href=mailto:" & agemail1 &">" & agemail1 & "</a><br>"
    if len(trim(agemail2))>0 then response.write "<a href=mailto:" & agemail2 &">" & agemail2 & "</a><br>"
    if len(trim(agemail3))>0 then response.write "<a href=mailto:" & agemail3 &">" & agemail3 & "</a><br>"
    if len(trim(agemail4))>0 then response.write "<a href=mailto:" & agemail4 &">" & agemail4 & "</a><br>"
    if len(trim(agemail5))>0 then response.write "<a href=mailto:" & agemail5 &">" & agemail5 & "</a><br>"
    if len(trim(agemail6))>0 then response.write "<a href=mailto:" & agemail6 &">" & agemail6 & "</a><br>"
                    
    %>
     </td>
  </tr>
<%lap = (-lap)+1%><%end if%>
  <% if agphone<>"" then%>
  <tr>
    <td bgcolor="<%=cl(lap)%>" valign="top" class="textlabel" width="20%">
	<font color="#808080">Phone:</font></td>
    <td bgcolor="<%=cl(lap)%>" valign="top" width="80%" class="plaintext"><%=adjtextarea(agphone)%></td>
  </tr>
<%lap = (-lap)+1%><%end if%>
  <% if agfax<>"" then%>
  <tr>
    <td bgcolor="<%=cl(lap)%>" valign="top" class="textlabel" width="20%">
	<font color="#808080">Fax:</font></td>
    <td bgcolor="<%=cl(lap)%>" valign="top" width="80%" class="plaintext"><%=adjtextarea(agfax)%></td>
  </tr>
<%lap = (-lap)+1%><%end if%>
  <% if agchairman<>"" then%>
  <tr>
    <td bgcolor="<%=cl(lap)%>" valign="top" class="textlabel" width="20%">
	<font color="#808080">Chairman</font></td>
    <td bgcolor="<%=cl(lap)%>" valign="top" width="80%" class="plaintext">
	<% if len(trim(agemail7))>0 then 
	response.write " <a href=mailto:" & agemail7 &">" & adjtextarea(agchairman) & "</a><br>"
	else
	response.write adjtextarea(agchairman)
	end if
	%>
    </td>
  </tr>
<%lap = (-lap)+1%><%end if%>
  <% if agmd<>"" then%>
  <tr>
    <td bgcolor="<%=cl(lap)%>" valign="top" class="textlabel" width="20%">
	<font color="#808080">Managing
      Director / CEO:</font></td>
    <td bgcolor="<%=cl(lap)%>" valign="top" width="80%" class="plaintext">
        <%if len(trim(agemail8))>0 then 
        response.write " <a href=mailto:" & agemail8 &">" & adjtextarea(agmd)& "</a><br>"
        else
        response.write adjtextarea(agmd)
        end if
        %></td>
  </tr>
<%lap = (-lap)+1%><%end if%>
  <% if agdirectors<>"" then%>
  <tr>
    <td bgcolor="<%=cl(lap)%>" valign="top" class="textlabel" width="20%">
	<font color="#808080">Directors:</font></td>
    <td bgcolor="<%=cl(lap)%>" valign="top" width="80%" class="plaintext"><%=adjtextarea(agdirectors)%></td>
  </tr>
<%lap = (-lap)+1%><%end if%>
  <% if agsecretary<>"" then%>
  <tr>
    <td bgcolor="<%=cl(lap)%>" valign="top" class="textlabel" width="20%">
	<font color="#808080">Company
      secretary:</font></td>
    <td bgcolor="<%=cl(lap)%>" valign="top" width="80%" class="plaintext">
    <%if len(trim(agemail9))>0 then 
    response.write " <a href=mailto:" & agemail9 &">" & adjtextarea(agSecretary) & "</a><br>"
    else
    response.write adjtextarea(agSecretary)
    end if%></td>
  </tr>
<%lap = (-lap)+1%><%end if%>
  <% if agbankers<>"" then%>
  <tr>
    <td bgcolor="<%=cl(lap)%>" valign="top" class="textlabel" width="20%">
	<font color="#808080">Bankers:</font></td>
    <td bgcolor="<%=cl(lap)%>" valign="top" width="80%" class="plaintext"><%=adjtextarea(agbankers)%></td>
  </tr>
<%lap = (-lap)+1%><%end if%>
  <% if agsolicitors<>"" then%>
  <tr>
    <td bgcolor="<%=cl(lap)%>" valign="top" class="textlabel" width="20%">
	<font color="#808080">Solicitors:</font></td>
    <td bgcolor="<%=cl(lap)%>" valign="top" width="80%" class="plaintext"><%=adjtextarea(agSolicitors)%></td>
  </tr>
<%lap = (-lap)+1%><%end if%>
  <% if agadvisers<>"" then%>
  <tr>
    <td bgcolor="<%=cl(lap)%>" valign="top" class="textlabel" width="20%">
	<font color="#808080">Advisers:</font></td>
    <td bgcolor="<%=cl(lap)%>" valign="top" width="80%" class="plaintext"><%=adjtextarea(agAdvisers)%></td>
  </tr>
<%lap = (-lap)+1%><%end if%>
  <% if agfacilitators<>"" then%>
  	<tr>
    <td bgcolor="<%=cl(lap)%>" valign="top" class="textlabel" width="20%">
	<font color="#808080">Facilitators:</font></td>
    <td bgcolor="<%=cl(lap)%>" valign="top" width="80%" class="plaintext"><%=adjtextarea(agfacilitators)%></td>
  </tr>
  <%lap = (-lap)+1%><%end if%>
    <% if agbrokers<>"" then%>
  	<tr>
    <td bgcolor="<%=cl(lap)%>" valign="top" class="textlabel" width="20%">
	<font color="#808080">Brokers:</font></td>
    <td bgcolor="<%=cl(lap)%>" valign="top" width="80%" class="plaintext"><%=adjtextarea(agBrokers)%></td>
  	</tr>
  <%lap = (-lap)+1%><%end if%>
   <% if agauditor<>"" then%>
  <tr>
    <td bgcolor="<%=cl(lap)%>" valign="top" class="textlabel" width="20%">
	<font color="#808080">Auditor:</font></td>
    <td bgcolor="<%=cl(lap)%>" valign="top" width="80%" class="plaintext"><%=adjtextarea(agauditor)%></td>
  </tr>
 <%lap = (-lap)+1%> <%end if%>
  <% if agregistry<>"" then%>
  <tr>
    <td bgcolor="<%=cl(lap)%>" valign="top" class="textlabel" width="20%">
	<font color="#808080">Share
      Registry:</font></td>
    <td bgcolor="<%=cl(lap)%>" valign="top" width="80%" class="plaintext"><%=adjtextarea(agRegistry)%></td>
  </tr>
<%lap = (-lap)+1%><%end if%>
 <% if agtrustee<>"" then%>
  <tr>
    <td bgcolor="<%=cl(lap)%>" valign="top" class="textlabel" width="20%">
	<font color="#808080">Trustee or Manager or Responsible Entity:</font></td>
    <td bgcolor="<%=cl(lap)%>" valign="top" width="80%" class="plaintext"><%=adjtextarea(agtrustee)%></td>
  </tr>
<%lap = (-lap)+1%><%end if%>

 <% if balancedate<>"" then%>

  <tr>
    <td bgcolor="<%=cl(lap)%>" valign="top" class="textlabel" width="20%"><font color="#808080">Balance Date:</font></td>
    <td bgcolor="<%=cl(lap)%>" valign="top" width="80%" class="plaintext"><%=adjtextarea(balancedate)%></td>
  </tr>
  <%lap = (-lap)+1%><%end if%>
</table>

<% NEXT
	end if
	%>

    </td>
    
  </tr>
</table>




</div>
</div>
</div>

<div style="clear:both;"></div>
</div>
<div style="height:20px;background-color:#fff;clear:both;margin-bottom:8px;"></div>
<!--#INCLUDE FILE="footer.asp"-->