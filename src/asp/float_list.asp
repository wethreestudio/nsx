<!--#INCLUDE FILE="include_all.asp"-->

<%
page_title = "Float List"
meta_description = "A list of securities floating, or about to float, on the National Stock Exchange of Australia"
' alow_robots = "no"
' objJsIncludes.Add "marketdata", "js/marketdata.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"



errmsg=""
currentpage = trim(request("currentpage"))
if len(currentpage)=0 then currentpage=1
currentpage=cint(currentpage)
if currentpage<1 then currentpage=1

Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
ConnPasswords.Open Application("nsx_ReaderConnectionString")

SQL = "SELECT Tradingcode,IssueDescription,iofferclosedate,ipdate,iCapitalRaised FROM coIssues WHERE iNewFloat = 1"
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
maxpagesize = 15
maxpages = round(.5 + (rc / maxpagesize),0)
st = (currentpage * maxpagesize ) - maxpagesize
fh = st + maxpagesize - 1
if fh > rc then fh = rc





%>
<!--#INCLUDE FILE="header.asp"-->
<div class="container_cont plaintext">                             
<h1><span>New Floats</span><a href="<%= Application("nsx_SiteRootURL") %>/ftp/rss/nsx_rss_floats.xml"><img class="rss" alt="" src="img/rss.jpg"></a></h1>
<p>
  Click on the Security name to view further details of the float.  Securities Floating = <%=(rc+1)%>
</p>


<div class="table-responsive"><table width="100%" cellspacing="0" style="border-bottom:1px solid #808080; " cellpadding="5">
  <tr>
    <td class="plaintext" bgcolor="#666666"><font color="#FFFFFF"><b>CODE</b></font></td>
    <td class="plaintext" bgcolor="#666666"><font color="#FFFFFF"><img border="0" src="images/nsxdiag.gif" width="22" height="11" align="right" alt=""><b>SECURITY</b></font></td>
  </tr>
<%  if WEOF then %>
  <tr>
    <td class="plaintext">&nbsp;</td>
    <td class="plaintext">There are no details available.</td>
  </tr>
<% else
     for jj = st to fh
      nsxcode = trim(alldata(0,jj))
      coname = trim(replace(alldata(1,jj)& " ","''","'"))
      if IsDate(alldata(2,jj)) then
        iofferclosedate = formatdatetime(alldata(2,jj),1)
      end if
      ipdate = alldata(3,jj)
      icapitalraised = alldata(4,jj)
      Compliance = instr(trim(ucase(iCapitalRaised) & " "),"COMPLIANCE")
      cl = array("#EEEEEE","#FFFFFF")
      lap = (-lap)+1	
%>
  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
       <td class="plaintext" valign="top" ><b><%=nsxcode%></b></td>
    <td class="plaintext" valign="top" ><a href="float_details.asp?nsxcode=<%=nsxcode%>" title="Click to view offer details"><img border="0" src="images/nsxdiag.gif" width="22" height="11" align="right" alt=""><%=coname%></a><br>
    <font face=arial size=-2><% if Compliance=0 then %>&nbsp; Prospectus Closes: <%=iofferclosedate%>
    <%else%>&nbsp; Compliance Listing. No prospectus required.
   <%end if%>
   &nbsp; Proposed Listing Date: <%=ipdate%> | <a href="/marketdata/search_by_company?nsxcode=<%=nsxcode%>">
	Check Announcements</a></font></td></tr>
<% 
    next
  end if
%>
</table></div>
<p>&nbsp;</p>
<h2>Disclaimer</h2>
<p>
<ul>
<li>NSX Codes are proposed only and are subject to change without notice. You may not rely on this
information in any way.</li>
<li>Listings Dates are proposed dates for first quotation of securities set out in the entity's prospectus or
information memorandum. You may not rely on this information in any way.</li>
<li>Listing dates are anticipated dates for first quotation of securities set by NSX following completion of
admission procedures. However, they are subject to change without notice and you may not rely
on this information in any way.</li>
</ul>
</p>
<p>
During the exposure period from the date of lodgment of the Prospectus at the Australian Securities & Investments Commission:
<div class="table-responsive"><table border="0" cellspacing="0" width="100%" cellpadding="5" style="border: 1px dotted #808080">
			<tr>
				<td valign="top" bgcolor="#eeeeee">(a)</td>
				<td valign="top" bgcolor="#eeeeee">A Company will not process any applications received until after the exposure period;</td>
			</tr>
			<tr>
				<td valign="top">(b)</td>
				<td valign="top">No preference will be conferred on applications received in the exposure period;</td>
			</tr>
			<tr>
				<td valign="top" bgcolor="#eeeeee">(c)</td>
				<td valign="top" bgcolor="#eeeeee">(i) the purpose of the exposure period is to enable the Prospectus to be examined by market participants prior to the raising of funds;</td>
			</tr>
			<tr>
				<td valign="top"></td>
				<td valign="top">(ii) that examination may result in the identification of deficiencies in the Prospectus; and</td>
			</tr>
			<tr>
				<td valign="top" bgcolor="#eeeeee"></td>
				<td valign="top" bgcolor="#eeeeee">(iii) in those circumstances, any application that has been received may need to be dealt with in accordance with section 724 of the Corporations Act 2001.</td>
			</tr>
		</table></div>
</P>


</div>
<!--#INCLUDE FILE="footer.asp"-->