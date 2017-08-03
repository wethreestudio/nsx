<!--#INCLUDE FILE="include_all.asp"--><%

Response.Redirect "/about/nsx_announcements"
Response.End

page_title = "Shareholder Announcements"
' meta_description = ""
' alow_robots = "no"
' objJsIncludes.Add "cms_page", "/js/cms_page.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"
%><!--#INCLUDE FILE="header.asp"-->
<div class="container_cont"> 
<div class="editarea">
<div class="table-responsive"><table border="0" cellpadding="0" style="border-collapse: collapse" width="100%" id="table1"  bgcolor="#FFFFFF">
  <tr>
    <td class="plaintext" valign="top" align="center" width="150"><!--#INCLUDE FILE="shareholder_lmenu.asp"--></td>
    <td class="plaintext" valign="top">
    
      <p><br>
		ANNOUNCEMENTS</b></font>&nbsp;</p>
    
    <div align="center">
    <div class="table-responsive"><table border="1" cellpadding="5" cellspacing="5" style="border-collapse: collapse; border-left-width: 0px; border-right-width: 0px; border-top-width: 0px" width="80%" id="table2">
      <tr>
        <td style="border-style: none; border-width: medium" class="plaintext" bgcolor="#666666">
        <font color="#FFFFFF"><b>NSX releases statutory documents to the 
		Australian Securities Exchange</b></font></td>
      </tr>
      <tr>
        <td style="border-left-style: none; border-left-width: medium; border-right-style: none; border-right-width: medium; border-top-style: none; border-top-width: medium; border-bottom-style: solid; border-bottom-width: 1px" class="plaintext">
<ul>
  <li>
<a target="_blank" href="http://www.asx.com.au/asx/statistics/announcements.do?by=asxCode&amp;asxCode=nsx&amp;timeframe=D&amp;period=W">
Lodged in the last week</a><li>
<a target="_blank" href="http://www.asx.com.au/asx/statistics/announcements.do?by=asxCode&amp;asxCode=nsx&amp;timeframe=D&amp;period=M">
Lodged in the last month</a><li>
<a target="_blank" href="http://www.asx.com.au/asx/statistics/announcements.do?by=asxCode&amp;asxCode=nsx&amp;timeframe=D&amp;period=M3">
Lodged in the last 3 months</a><li>
<a target="_blank" href="http://www.asx.com.au/asx/statistics/announcements.do?by=asxCode&amp;asxCode=nsx&amp;timeframe=D&amp;period=M6">
Lodged in the last 6 Months</a></li>


<%
for ii = year(date) to 2005 step -1
%>

  <li>
<a target="_blank" href="http://www.asx.com.au/asx/statistics/announcements.do?by=asxCode&amp;asxCode=nsx&amp;timeframe=Y&amp;year=<%=ii%>">
Lodged during <%=ii%></a></li>
  <%next%>
</ul></td>
      </tr>
    </table></div>
    </div>
    <p>&nbsp;</p>
    <p>&nbsp;</td>
  </tr>
  </table></div>
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->