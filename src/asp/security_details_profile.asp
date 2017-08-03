<%
Function remcrlf(xx)
remcrlf = replace(xx & " ",vbCRLF,"")
remcrlf = trim(Replace(remcrlf & " ", "''", "'"))

End Function

%>

<html>

<head>


<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 6.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>NSX National Stock Exchange of Australia</title>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="ROBOTS" content="INDEX">
<meta http-equiv="Expiry" content="0">
<meta http-equiv="expires" content="0">
<meta name="description" content="The National Stock Exchange of Australia - Operates a Stock Exchange in Australia focussing on small to medium and high technology companies.">
<meta name="keywords" content="small, medium, company, companies, companys, australia, Australia, Newcastle, Hamilton, Steven Pritchard,
enterprises, high technology, stock, exchange, stock exchange, Australian, NSX, nsx">
<link rel="stylesheet" href="newsx2.css" type="text/css">



<meta name="Microsoft Border" content="none">
<link rel="shortcut icon" href="favicon.ico" ></head>

<body >

<!--#INCLUDE FILE="../wgeneral/header.asp"-->
<div class="table-responsive"><table border="0" width="1000" cellspacing="0" cellpadding="0">
  <tr>
    <td width="160" valign="top" rowspan="4"><!--#INCLUDE FILE="../wgeneral/lmenu.asp"--></td>
  </tr>
  <tr>
    <td width="980" class="textheader" bgcolor="#FFFFFF" colspan="3" background="images/v2/WELCOME2.jpg"><b>&nbsp;<font color="#FFFFFF">&nbsp;&nbsp;&nbsp;
      <font face="Arial">&nbsp;&nbsp;&nbsp;<img border="0" src="images/v2/3NSXDGOL1.gif" align="middle">&nbsp;&nbsp;&nbsp;SECURITY
      DETAILS&nbsp;</font></font></b></td>
  </tr>
  <tr>
    <td width="980" class="textheader" bgcolor="#FFFFFF" colspan="3">&nbsp;</td>
  </tr>
  <tr>
    <td width="10" valign="top" bgcolor="#FFFFFF">
<p align="left"><font color="#000080"><b><font face="Arial, helvetica, sans-serif" size="2">&nbsp;</font></b></font></p>


    </td>
    <td width="2" class="rhlinks" valign="top" bgcolor="#FFFFFF">
<img border="0" src="images/v2/line.jpg" width="1" >
    </td>
    <td width="820" class="plaintext" valign="top" bgcolor="#FFFFFF">
    <!--#INCLUDE FILE="../admin/merchtools.asp"-->

<%
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
SQL=" SELECT coDetails.coName, coIssues.nsxcode, coIssues.tradingcode, coIssues.ISIN, coIssues.IssueDescription, coIssues.IssueType, coIssues.OffMarketNexus, coIssues.Certificated, coIssues.IssuerSponsor, coIssues.DeferredDeliveryIndicator, coIssues.Settlement, coIssues.PreviousTradingCodes, coIssues.PreviousTradingCodeDates, coIssues.IssueStarted, coIssues.IssueStopped, coIssues.IssueStatus, iFloatDesc, "
SQL = SQL & "CoIssues.DualListed,CoIssues.DualListedDetails,CoIssues.CurrentProfile,CoIssues.CurrentEPS,CoIssues.CurrentDPS,CoIssues.CurrentNTA,CoIssues.CurrentSharesOnIssue, iOfferdocument, iIssuePrice, iIssueType, CoDetails.AgLogo "
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

%>


<%  if WEOF then %>
	 
   There is no record available.
  <% else %>
  
  <p> 
      <%if currentpage > 1 then %>Page:&nbsp;
                <a href="securitydetails.asp?nsxcode=<%=id%>&currentpage=<%=currentpage-1%>">&lt;&lt; Previous <%=maxpagesize%></a> | 
            <%end if%>
            
            <%
      for ii = 1 to maxpages
            	if ii = currentpage then 
      		response.write "<b>" & ii & "</b> | "
      	else
      %>
      <a href="securitydetails.asp?nsxcode=<%=id%>&currentpage=<%=ii%>" ><%=ii%></a> | 

      <%
      	end if
      next
      %>
      
      
    
      
      <%if maxpages > CurrentPage then %>
              
             <a href="securitydetails.asp?nsxcode=<%=id%>&currentpage=<%=currentpage+1%>">Next <%=maxpagesize%> &gt;&gt;</a>
      <%end if%>

	<%
      	  for jj = st to fh
 
nsxcode=alldata(1,jj)
coName=alldata(0,jj)
tradingcode=alldata(2,jj)
ISIN=alldata(3,jj)
IssueDescription=alldata(4,jj)
IssueType=alldata(5,jj)
OffMarketNexus=alldata(6,jj)
Certificated=alldata(7,jj)
IssuerSponsor=alldata(8,jj)
DeferredDeliveryIndicator=alldata(9,jj)
Settlement=alldata( 10,jj)
PreviousTradingCodes=alldata(11,jj)
PreviousTradingCodeDates=alldata(12,jj)
IssueStarted=alldata(13,jj)
IssueStopped=alldata(14 ,jj)
IssueStatus=alldata(15,jj)
FloatDesc=alldata(16,jj)
DualListed=alldata(17,jj)
DualListedDetails=alldata(18,jj)
CurrentProfile=alldata(19,jj)
CurrentEPS=alldata(20,jj)
CurrentDPS=alldata(21,jj)
CurrentNTA=alldata(22,jj)
SharesOnIssue=alldata(23,jj)
iOfferDocument=alldata(24,jj)
iIssuePrice=alldata(25,jj)
iIssueType=alldata(26,jj)
agLogo=alldata(27,jj)
 	  
      	  
%>


    
<div class="table-responsive"><table border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr>
    <td class="plaintext" bgcolor="#6D7BA0" height="4"><b><font size="3" color="#FFFFFF">&nbsp;<%=remcrlf(ucase(coname))%> 
    (ISSUER)</font></b></td>
    <td class="plaintext" rowspan="8" width="180"><img border="0" src="images/v2/NSXBLUR4.jpg"></td>
  </tr>
  <tr><td>
  <%
    if trim(aglogo & " ")="" then 
    response.write "&nbsp;"
    else
    %>
    <img border="0" src="../company/logos/<%=agLogo%>">
    <% end if %>

</td></tr>
  <tr><td>&nbsp;</td></tr>
  <tr><td>&nbsp;</td></tr>
  <tr><td>&nbsp;</td></tr>
</table></div>
    <div class="table-responsive"><table border="0" cellpadding="0" cellspacing="5" bgcolor="#FFFFFF" width="470">
  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="150">
      Trading Code:
      
      
      </td>
    <td bgcolor="#FFFFFF" valign="top" width="325" class="plaintext"><%=tradingcode%>    
      
      </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="475" colspan="2">
    <img border="0" src="images/v2/line.jpg" width="100%" height="1">
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="150">
      ISIN:
      
      
      </td>
    <td bgcolor="#FFFFFF" valign="top" width="325" class="plaintext"><%=isin%>      
      
      </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="475" colspan="2">
      <img border="0" src="images/v2/line.jpg" width="100%" height="1">
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="150">
      Security Description:</td>
    <td bgcolor="#FFFFFF" valign="top" width="325" class="plaintext"><%=adjtextarea(issuedescription)%></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="475" colspan="2">
    <img border="0" src="images/v2/line.jpg" width="100%" height="1">
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="150">
      Offer Document:</td>
    <td bgcolor="#FFFFFF" valign="top" width="325" class="plaintext">
    <%
   
    if trim(iOfferdocument & " ")="" then
    response.write "Not Applicable."
    else
      	response.write "<a href=../ftp/news/" & iOfferdocument &  " target=_blank ><b>" & iOfferdocument & "</b></a>"
      	response.write "<br>The Offer document is made available here for information purposes only."
     end if
           %>

    
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="475" colspan="2">
    <img border="0" src="images/v2/line.jpg" width="100%" height="1">
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="150">Issue Description:</td>
    <td bgcolor="#FFFFFF" valign="top" width="325" class="plaintext"><%=adjtextarea(IssueType)%></td>
  </tr>

<tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="475" colspan="2">
    <img border="0" src="images/v2/line.jpg" width="100%" height="1">
    </td>
  </tr>

  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="150">
      Security Type:</td>
    <td bgcolor="#FFFFFF" valign="top" width="325" class="plaintext"><%=adjtextarea(iIssueType)%></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="475" colspan="2">
    <img border="0" src="images/v2/line.jpg" width="100%" height="1">
    </td>
  </tr>

  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="150">Off Market
      Nexus:</td>
    <td bgcolor="#FFFFFF" valign="top" width="325" class="plaintext"><%=adjtextarea(offmarketnexus)%></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="475" colspan="2">
    <img border="0" src="images/v2/line.jpg" width="100%" height="1">
    </td>
  </tr>

  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="150">Certificated:</td>
    <td bgcolor="#FFFFFF" valign="top" width="325" class="plaintext"><%=adjtextarea(certificated)%></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="475" colspan="2">
    <img border="0" src="images/v2/line.jpg" width="100%" height="1">
    </td>
  </tr>

  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="150">Issuer
      Sponsor:</td>
    <td bgcolor="#FFFFFF" valign="top" width="325" class="plaintext"><%=adjtextarea(issuersponsor)%>    
    
    
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="475" colspan="2">
    <img border="0" src="images/v2/line.jpg" width="100%" height="1">
    </td>
  </tr>

  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="150">Deferred
      Delivery Indicator:</td>
    <td bgcolor="#FFFFFF" valign="top" width="325" class="plaintext"><%=adjtextarea(deferreddeliveryindicator)%></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="475" colspan="2">
    <img border="0" src="images/v2/line.jpg" width="100%" height="1">
    </td>
  </tr>

  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="150">Settlement:</td>
    <td bgcolor="#FFFFFF" valign="top" width="325" class="plaintext">
    <%=adjtextarea(settlement)%>
    
    
    </td>
  </tr>
  
  <%if trim(issuestatus & " ") <>"" then %>
  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="475" colspan="2">
    <img border="0" src="images/v2/line.jpg" width="100%" height="1">
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="150">Security
      Status:</td>
    <td bgcolor="#FFFFFF" valign="top" width="325" class="plaintext">
    <%=adjtextarea(issuestatus)%></td>
  </tr>
  <%end if%>
  
  <%if trim(issuestarted & " ")<>"" then %>
  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="475" colspan="2">
    <img border="0" src="images/v2/line.jpg" width="100%" height="1">
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="150">Security
      Started Trading on:</td>
    <td bgcolor="#FFFFFF" valign="top" width="325" class="plaintext"><%=formatdatetime(issuestarted,1)%></td>
  </tr>
  <%end if%>
  
  <%if trim(issuestopped & " ")<>"" then%>
  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="475" colspan="2">
    <img border="0" src="images/v2/line.jpg" width="100%" height="1">
    </td>
  </tr>

  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="150">Security
      Stopped Trading on:</td>
    <td bgcolor="#FFFFFF" valign="top" width="325" class="plaintext"><%=issuestopped%></td>
  </tr>
  <%end if%>
  
  <%if previoustradingcodes<>"none" then%>
  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="475" colspan="2">
    <img border="0" src="images/v2/line.jpg" width="100%" height="1">
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="150">Previous
      Security Codes:</td>
    <td bgcolor="#FFFFFF" valign="top" width="325" class="plaintext"><%=previoustradingcodes%></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="475" colspan="2">
    <img border="0" src="images/v2/line.jpg" width="100%" height="1">
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="150">Previous
      Security Effective Dates:</td>
    <td bgcolor="#FFFFFF" valign="top" width="325" class="plaintext"><%=PreviousTradingCodeDates%></td>
  </tr>
  <%end if%>
  
  <%if DualListed=True then %>
  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="475" colspan="2">
    <img border="0" src="images/v2/line.jpg" width="100%" height="1">
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="150">Dual 
    Listing Details:</td>
    <td bgcolor="#FFFFFF" valign="top" width="325" class="plaintext"><%=adjtextarea(DualListedDetails)%></td>
  </tr>
  <%end if%>
  
 <%if SharesOnIssue > 0 then%>
  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="475" colspan="2">
    <img border="0" src="images/v2/line.jpg" width="100%" height="1">
    </td>
  </tr>
    <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="150">Shares on 
    Issue*:</td>
    <td bgcolor="#FFFFFF" valign="top" width="325" class="plaintext"><%=formatnumber(SharesOnIssue,0)%></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="475" colspan="2">
    <img border="0" src="images/v2/line.jpg" width="100%" height="1">
    </td>
  </tr>
    <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="150">Original 
    Issue Price:</td>
    <td bgcolor="#FFFFFF" valign="top" width="325" class="plaintext"><%=iIssuePrice%></td>
  </tr>
  <%end if%>
  
  <%if currentEPS > -1 then%>
  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="475" colspan="2">
    <img border="0" src="images/v2/line.jpg" width="100%" height="1">
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="150">Earnings 
    Per Share*:</td>
    <td bgcolor="#FFFFFF" valign="top" width="325" class="plaintext"><%=formatnumber(CurrentEPS,2)%></td>
  </tr>
  <%end if%>
  
  <%if currentDPS > -1 then%>
  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="475" colspan="2">
    <img border="0" src="images/v2/line.jpg" width="100%" height="1">
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="150">Dividends 
    Per Share*:<br>
    (cents)</td>
    <td bgcolor="#FFFFFF" valign="top" width="325" class="plaintext"><%=formatnumber(CurrentDPS,2)%></td>
  </tr>
  <%end if%>
  
  <%if currentNTA > -1 then%>
  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="475" colspan="2">
    <img border="0" src="images/v2/line.jpg" width="100%" height="1">
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="150">Asset 
    Backing*:</td>
    <td bgcolor="#FFFFFF" valign="top" width="325" class="plaintext"><%=formatnumber(CurrentNTA,2)%></td>
  </tr>
  <%end if%>
  
  <%if trim(CurrentProfile & " ") <>"" then%>
  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="475" colspan="2">
    <img border="0" src="images/v2/line.jpg" width="100%" height="1">
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="150">Additional 
    Information:</td>
    <td bgcolor="#FFFFFF" valign="top" width="325" class="plaintext"><%=CurrentProfile%></td>
  </tr>
  <%end if%>
  
  <tr>
    <td bgcolor="#FFFFFF" valign="top" class="textlabel" width="475" colspan="2">
    <img border="0" src="images/v2/line.jpg" width="100%" height="2">
    </td>
  </tr>
  
</table></div>

   


    
    

<p>* as at Balance Date</p>
<% NEXT
	end if
	%>

    </td>
    
  </tr>
</table></div>
<!--#INCLUDE FILE="../wgeneral/footer.asp"-->
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </p>
<p>&nbsp;&nbsp; </p>
<SCRIPT LANGUAGE="JavaScript1.2"
        SRC="menu/HM_LoaderL1.js"
        TYPE='text/javascript'></SCRIPT>
</body>

</html>