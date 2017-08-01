<%@ LANGUAGE="VBSCRIPT" %>
<!--#INCLUDE FILE="company_check_exchid_v2.asp"-->
<!--#INCLUDE FILE="member_check_v2.asp"-->
<html>

<head>


<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 6.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title><%=exchname%></title>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="ROBOTS" content="INDEX">
<meta http-equiv="Expiry" content="0">
<meta http-equiv="expires" content="0">
<meta name="description" content="The National Stock Exchange of Australia - Operates a Stock Exchange in Australia focussing on small to medium and high technology companies.">
<meta name="keywords" content="small, medium, company, companies, companys, australia, Australia, Newcastle, enterprises, high technology, stock, exchange, stock exchange, Australian, NSX, nsx">
<%select case exchid
	case "NSX"
	%>
	<link rel=stylesheet href="newsx2.css" type="text/css">
<% case else %>
	<link rel=stylesheet href="<%= Application("nsx_SiteRootURL") %>/newsx2.css" type="text/css">
<% end select%>

<meta name="Microsoft Border" content="none">
<link rel="shortcut icon" href="favicon.ico" ></head>

<body >

<% if len(exchid)<>0 then server.execute "company_header_v2_" & exchid & ".asp"%>
<div align="center">
<table border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" rowspan="4" bgcolor="#FFFFFF" width="170" align="center">
	<%if len(exchid)<>0 then server.execute "company_lmenu_v2_" & exchid & ".asp"%></td>
  </tr>
  <tr>
    <td class="textheader" bgcolor="#FFFFFF" colspan="3" >
    
      <h1><font face="Arial">LODGEMENT STATUS</h1>
    
    </td>
  </tr>
  <tr>
    <td class="plaintext" bgcolor="#FFFFFF" colspan="3">
    
    The Operating Rules requires that listed
entities report market significant events to the Exchange. This information is important to keep the market informed of Issuer activities.&nbsp;&nbsp;
    </td>
  </tr>
  <tr>
  
    

    <td class="plaintext" valign="top" bgcolor="#FFFFFF">
<div align="center">
<table width="550" cellpadding="5">
<!--#INCLUDE FILE="admin/merchtools.asp"-->

<%

' day light saving
daylightsaving=0
if application("nsx_daylight_saving")=true then
	daylightsaving = 1/24
	else
	daylightsaving = 0
end if

errmsg=""
currentpage = trim(request("currentpage"))
if len(currentpage)=0 then currentpage=1
currentpage=cint(currentpage)
if currentpage<1 then currentpage=1

' if mutliple codes requested then restrict by that otherwise ALL codes.
nsxcodes=trim(request.querystring("nsxcode") & " ")
if len(nsxcodes)=0 then
	nsxcodes=trim(request.form("nsxcode") & " ")
end if
group = request("group")
if group = "yes"  then
	srchgrp="nsxcode"
	else
	srchgrp="tradingcode"
end if
' construct search for multiple codes.
srch = " WHERE (coAnn.annDisplay=1)  "
if len(nsxcodes)<>0 then
	nsxcodes=replace(nsxcodes," ","")
	nsxcodes=replace(nsxcodes,";",",")
	nsxcodes=replace(nsxcodes,vbCRLF,"")
	nsxcodes=replace(nsxcodes,".","")
	nsxcodes=replace(nsxcodes,",,",",")

	srch = srch & " AND "
	nsxcode=split(nsxcodes,",")
	for jj = 0 to ubound(nsxcode)
		srch = srch & "(coAnn." & srchgrp & "='" & nsxcode(jj) & "') OR "
	next
	srch = left(srch,len(srch)-4)
		
end if



Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
 

ConnPasswords.Open Application("nsx_ReaderConnectionString")
SQL = "SELECT coAnn.annid,annPrecise,annFile,annRelease,annTitle,annFileSize,coAnn.tradingcode,annUpload,coIssues.IssueDescription, annPriceSensitive "
SQL = SQL & " FROM coIssues INNER JOIN coAnn ON coIssues.tradingcode = coAnn.tradingcode "
SQL = SQL & srch
SQL = SQL & " ORDER BY coAnn.annUpload DESC"
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
maxpagesize = 30
maxpages = round(.5 + (rc / maxpagesize),0)
st = (currentpage * maxpagesize ) - maxpagesize
fh = st + maxpagesize - 1
if fh > rc then fh = rc

%>
   





  <tr>
    <td class="plaintext" colspan="3" align="left"><b>Pages</b>: <%if currentpage > 1 then %>
    <a href="company_announcements_status_v2.asp?nsxcode=<%=nsxcodes%>&currentpage=1"&group=<%=group%>>First</a> | 
    <b>
    <a href="company_announcements_status_v2.asp?nsxcode=<%=nsxcodes%>&currentpage=<%=currentpage-1%>&group=<%=group%>">
	<font size="3">&lt;&lt;</font></b><b>
	</b>Previous <%=maxpagesize%></a> | 
            <%end if%>
            
            <%
            startpage = currentpage
            endpage = maxpages
            pages = 20
            if startpage + pages > maxpages then 
            	endpage = maxpages
            	else
            	endpage = startpage + pages
            end if
                 
      for ii = startpage to endpage
            	if ii = currentpage then 
      		response.write "<b>" & ii & "</b> | "
      	else
      %>
      <a href="company_announcements_status_v2.asp?nsxcode=<%=nsxcodes%>&currentpage=<%=ii%>&group=<%=group%>" ><%=ii%></a> | 

      <%
      	end if
      next
      
      
    
      %>
      <%if maxpages > CurrentPage then %>
              
             <a href="company_announcements_status_v2.asp?nsxcode=<%=nsxcodes%>&currentpage=<%=currentpage+1%>&group=<%=group%>">Next <%=maxpagesize%> </a>
    <a href="company_announcements_status_v2.asp?nsxcode=<%=nsxcodes%>&currentpage=<%=currentpage-1%>&group=<%=group%>">
	<font face="Arial">&gt;&gt;</font></a>
      <%end if%>
    </td>
  </tr>
</table>

<div align="center">
<table border="0" cellspacing="0" cellpadding="5"  width="550" style="border-left-width: 1px; border-right-width: 1px; border-top-width: 1px; border-bottom: 1px solid #666666">
  <tr>
    <td class="plaintext" width="55" bgcolor="#666666"><font color="#FFFFFF"><b>
	FLAG</b></font></td>
    <td class="plaintext" bgcolor="#666666"><font color="#FFFFFF"><b>HEADLINE</b></font></td>
    <td class="plaintext" bgcolor="#666666" width="70"><font color="#FFFFFF"><b>LODGEMENT DATE</b></font></td>
    <td class="plaintext" bgcolor="#666666" width="70"><font color="#FFFFFF"><b>RELEASE 
	<br>
	DATE</b></font></td>
  </tr>
<%  if WEOF then %>
	
  <tr>
    <td class="plaintext" colspan="4">There are no articles available.</td>
  </tr>
<% else
	
      	  for jj = st to fh
      	  
      	  id = alldata(0,jj)
      	  precise = replace(trim(alldata(1,jj)) & " ","''","'")
      	  file = trim(alldata(2,jj))
      	  
      	  release = alldata(3,jj)
      	  if trim(release & " " )<>"" then 
      	  	release=cdate(release)
      	  	release=fmttf(release)
      	  	else
      	  	release = "Pending"
      	  	end if
      	  sent = alldata(7,jj)
      	  if trim(sent & " " )<>"" then 
      	  	sent=cdate(sent)
      	  	sent=fmttf(sent)
      	  end if
      	  
      	  
      	  title= replace(trim(alldata(4,jj)) & " ","''","'")
      	  
      	  filesize= CLng(alldata(5,jj))
      	   if filesize < 1000000 then 
      	  	filesize = formatnumber((filesize/1024),1) & " KB"
      	  elseif filesize >=1000000 and filesize<=1000000000 then
      	  	filesize = formatnumber((filesize/1024000),1) & " MB"
      	  elseif filesize >=1000000000 and filesize<=1000000000000 then
      	  	filesize = formatnumber((filesize/1024000000),1) & " GB"
      	  end if 	  
      	  
      	  nsxcode= ucase(alldata(6,jj))
      	  upload= cdate(alldata(7,jj))
      	  name= replace(trim(alldata(8,jj)) & " ","''","'")
      	  PriceSens = alldata(9,jj)
      	  if PriceSens = True then
      	  	PriceSens = "<br><font color=green size=-2><b><i>Price<br>Sensitive</i></b></font"
      	  	else
      	  	PriceSens = "&nbsp;"
      	  end if
      	  
     cl = array("#EEEEEE","#FFFFFF")
	lap = (-lap)+1
				
    %>
  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
      
    <td class="plaintext" valign="top"   width="55"><b><font size="1"><%=ucase(nsxcode)%></font></b><font size="1"><%=PriceSens%></font></td>
    <td class="plaintext" valign="top"><font size="1"><%
   
   	  
   	  	if InStr(1,File,".")>0 then
   	  		category = title
   	  		dash = instr(title,"-")
   	  		if dash <> 0 then
   	  			category = trim(left(title,dash-1))
   	  			title = trim(mid(title,dash+1,len(title)))
   	  		end if
			response.write "<a href=ftp/news/" & file & " title=""" & precise & """ target=_blank><b>" & adjtextarea(category) & "</b></a> "
		else
			response.write "<b>" & adjtextarea(title) & "</b>&nbsp;"
		end if
	
    %></font></td>
    
    <td class="plaintext" valign="top"   width="70"><font size="1"><%=sent%></font></td>
    
     <td class="plaintext" valign="top" nowrap  width="70"><font size="1"><%=release%></font></td>
    </tr>
<% NEXT
	end if
	%>

<tr>
<td class=plaintext colspan="4">
<p align="left"><b>Pages</b>: <%if currentpage > 1 then %>
    <a href="company_announcements_status_v2.asp?nsxcode=<%=nsxcodes%>&currentpage=1">First</a> | 
    <b>
    <a href="company_announcements_status_v2.asp?nsxcode=<%=nsxcodes%>&currentpage=<%=currentpage-1%>">
	<font size="3">&lt;&lt;</font></b><b>
	</b>Previous <%=maxpagesize%></a> | 
            <%end if%>
            
            <%
            startpage = currentpage
            endpage = maxpages
            pages = 20
            if startpage + pages > maxpages then 
            	endpage = maxpages
            	else
            	endpage = startpage + pages
            end if
                 
      for ii = startpage to endpage
            	if ii = currentpage then 
      		response.write "<b>" & ii & "</b> | "
      	else
      %>
      <a href="company_announcements_status_v2.asp?nsxcode=<%=nsxcodes%>&currentpage=<%=ii%>&group=<%=group%>" ><%=ii%></a> | 

      <%
      	end if
      next
      
      
    
      %>
      <%if maxpages > CurrentPage then %>
              
             <a href="company_announcements_status_v2.asp?nsxcode=<%=nsxcodes%>&currentpage=<%=currentpage+1%>&group=<%=group%>">Next <%=maxpagesize%> </a>
    <a href="company_announcements_status_v2.asp?nsxcode=<%=nsxcodes%>&currentpage=<%=currentpage-1%>&group=<%=group%>">
<font face="Arial">&gt;&gt;</font></a>
      <%end if%>


</td></tr>

  
</table>
    
    
    </div>
    
    
    <p align="left">&nbsp;</div>
    
    
    </td>
    <td width="2" class="plaintext" valign="top" bgcolor="#FFFFFF">



    </td>
    <td class="plaintext" valign="top" bgcolor="#FFFFFF" rowspan=2>

    </td>
    
    

</table>
</div>
<% if len(exchid)<>0 then server.execute "company_footer_v2_" & exchid & ".asp"%>
</body>

</html>