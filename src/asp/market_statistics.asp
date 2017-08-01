<!--#INCLUDE FILE="include_all.asp"-->
<%
page_title = "Market Statistics"
' meta_description = ""
' alow_robots = "no"
' objJsIncludes.Add "marketdata", "js/marketdata.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"
%>
<!--#INCLUDE FILE="header.asp"-->
<div class="container_cont">
<div class="table-responsive">
<table border="0" width="100%" cellspacing="0" cellpadding="0">
	<tr>
		<td valign="top" rowspan="4" bgcolor="#FFFFFF"><!--#INCLUDE FILE="lmenu.asp"-->
		</td>
	</tr>
	<tr>
		<td class="textheader" bgcolor="#FFFFFF" >
		
			<h1><b><font face="Arial">TRADING STATISTICS&nbsp;</font></b></h1>
		</td>
	</tr>
	<tr>
		<td class="textheader" bgcolor="#FFFFFF">
		
			<h2>Daily Trading Statistics</h2>
			<p><span style="font-weight: 400"><a href="market_eod_nsx.asp">
			<font size="2">Daily 
			Table</font></a></span></p>
			<h2>Monthly Trading Statistics</h2>
			<p><span style="font-weight: 400"><font size="2">
			<a href="market_eom_nsx.asp">Monthly Table</a></font></span></p>
			<h2>Yearly Trading Statistics</h2>
			<p><span style="font-weight: 400"><font size="2">
			<a href="market_eoy_nsx.asp">Calendar Year Table</a></font></span></p>
		
		<p>&nbsp;<p>&nbsp;<p>&nbsp;<p>&nbsp;<p>&nbsp;<p>&nbsp;<p>&nbsp;</td>
	</tr>
	<tr>
		<td class="plaintext" valign="top" bgcolor="#FFFFFF">
		<div align="center">
		</div>
		<p>&nbsp;
    </td>
	</tr>
</table>
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->