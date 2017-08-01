<!--#INCLUDE FILE="include_all.asp"-->

<%
page_title = "NSX Products"
' meta_description = ""
' alow_robots = "no"
' objJsIncludes.Add "marketdata", "js/marketdata.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"
%>
<!--#INCLUDE FILE="header.asp"-->
<div class="container_cont">

<table border="0" cellpadding="0" style="border-collapse: collapse" width="100%" id="table1" bgcolor="#FFFFFF">
  <tr>
    <td class="plaintext" colspan="2" bgcolor="#FFFFFF">
    
      <b><font color="#FF9933" size="4">&nbsp;</font></b>PRODUCTS &amp; MARKETS</b></font>
    </td>
  </tr>
  <tr>
    <td class="plaintext" valign="top"><!--#INCLUDE FILE="lmenu.asp"--></td>
    <td class="plaintext" valign="top">
    <p>&nbsp;</p>
    <div align="center">
      <table cellpadding="5" style="border-bottom:1px solid #666666; border-collapse: collapse" width="100%" id="table2" >
        <tr>
          <td class="plaintext" bgcolor="#666666" nowrap><font color="#FFFFFF"><b>
          MARKET</b></font></td>
          <td class="plaintext" bgcolor="#666666"><font color="#FFFFFF"><b>
          DESCRIPTION</b></font></td>
        </tr>
        <tr>
          <td class="plaintext" nowrap>
          <a href="<%= Application("nsx_SiteRootURL") %>">
          <img border="0" src="images/NSX-LOGOx150.gif" width="150" height="37"></a></td>
          <td class="plaintext">NSX Limited.&nbsp; Is the owner and operator of 
          Australian Market Licencees or Stock Exchanges in Australia.&nbsp;Shareholder 
			information can be found on the <a href="shareholder_default.asp">
			shareholders page</a>.</td>
        </tr>
        <tr>
          <td class="plaintext" nowrap>
          <a href="<%= Application("nsx_SiteRootURL") %>">
          <img border="0" src="images/NSX-LOGOx150.gif" width="150" height="37"></a><br>
			<font size="1">National Stock Exchange of Australia</font></td>
          <td class="plaintext">
			<a target="_blank" href="<%= Application("nsx_SiteRootURL") %>">National Stock 
			Exchange of Australia </a>is a Stock Exchange set up and managed specifically to cater 
    for the listing of growth enterprises.&nbsp; With electronic trading and clearing and access to 
    an experienced broker and adviser network, we have created an environment 
    capable of achieving the outcomes required for fast growing companies.</td>
        </tr>
        
      </table>
    </div>
    <p>&nbsp;</p>
    <p>&nbsp;</p>
    <p>&nbsp;</td>
  </tr>
  </table>
</div>
<!--#INCLUDE FILE="footer.asp"-->