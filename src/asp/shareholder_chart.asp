<!--#INCLUDE FILE="include_all.asp"-->
<%

%>
<!--#INCLUDE FILE="header.asp"-->
<div class="container_cont">
<table border="0" cellpadding="0" style="border-collapse: collapse" width="100%" id="table1" bgcolor="#FFFFFF">
  <tr>
    <td class="plaintext" valign="top" align="center"><!--#INCLUDE FILE="shareholder_lmenu.asp"--></td>
    <td class="plaintext" valign="top">
    
		<p><br>
		NSX Limited Share Price Performance</b></font></p>
		<h2>Current Price</h2><%
on error resume next ' incase of access denied error keep going
Dim objXmlHttp
Dim rst
Set objXmlHttp = Server.CreateObject("Msxml2.ServerXMLHTTP")
codes = array("NSX.AX")
lbls = array("NSX Ltd FPO") 
FOR jj = 0 to ubound(codes)
	objXmlHttp.open "GET", "http://finance.yahoo.com/d?s=" & codes(jj) & "&f=l1pvohb3b2gwa5b6i5d1", False
	objXmlHttp.send
	rst = objXmlHttp.responseText
	test = rst
	rst = split(rst,",")
	prv = rst(1)
	price = rst(0)
	chn = price - prv
	vol = formatnumber(rst(2),0)
	opn = rst(3)
	high = rst(4)
	bid = rst(5)
	ask = rst(6)
	low = rst(7)
	range = replace(rst(8),"""","")
	bidqty = rst(9)
	askqty = rst(10)
	orders = rst(11)
	issuedshares = 99059556 ' as at 11 august 2010 
	mktcap = formatnumber((issuedshares * price)/1000000,1) 
	lastdate = replace(rst(12),"""","")
	'response.write lastdate
	' yahoo provides in mm/dd/yyyy format - cdate doesn't convert properly so have to manually reconstruct date.
	lastdateddmmyyyy = split(lastdate,"/")
	lastdate = lastdateddmmyyyy(1) & "-" & monthname(lastdateddmmyyyy(0)) & "-" & lastdateddmmyyyy(2)
	'lastdate = formatdatetime(cdate(lastdate),1)
	
	if 	chn > 0 then
		dchn = "+" & formatnumber(chn,2)
		clr ="green"
		bul = "<img src=images/up.gif border=0 >"
	end if
	if chn < 0 then
		dchn = formatnumber(chn,2)
		clr = "red"
		bul = "<img src=images/down.gif border=0 >"
	end if
	if chn = 0 then
		dchn = ""
		clr = "black"
		bul = ""
	end if
	pchn = 100*(price - prv)/price
	prv = formatnumber(prv,3)
	'response.write  "<b><font color=black>" & lbls(jj) & ": " & formatnumber(rst(0),3) & " <font color=" & clr & ">" & bul & dchn & "</font> | </font></b>"

NEXT

	'objXmlHttp.open "GET", "http://finance.yahoo.com/d?s=NSX.AX&f=t", False
	'objXmlHttp.send
	'rst = objXmlHttp.responseText
	'response.write rst

set objXmlHttp  = nothing
set rst = nothing
%>Last Trade Date: <%=lastdate%><table width="560" id="table2" cellspacing="0" cellpadding="2" style="border-bottom: 2px solid #333333; padding-left: 4px; padding-right: 4px; padding-top: 1px; padding-bottom: 1px">
			<tr>
				<td class="plaintext" bgcolor="#666666"><b>
				<font color="#FFFFFF">Last</font></b></td>
				<td class="plaintext" bgcolor="#666666"><b>
				<font color="#FFFFFF">$ +/- <br>
				Change</font></b></td>
				<td class="plaintext" bgcolor="#666666"><b>
				<font color="#FFFFFF">Bid</font></b></td>
				<td class="plaintext" bgcolor="#666666"><b>
				<font color="#FFFFFF">Offer</font></b></td>
				<td class="plaintext" bgcolor="#666666"><b>
				<font color="#FFFFFF">Open</font></b></td>
				<td class="plaintext" bgcolor="#666666"><b>
				<font color="#FFFFFF">High</font></b></td>
				<td class="plaintext" bgcolor="#666666"><b>
				<font color="#FFFFFF">Low</font></b></td>
				<td class="plaintext" bgcolor="#666666"><b>
				<font color="#FFFFFF">Volume</font></b></td>
				<td class="plaintext" bgcolor="#666666"><font color="#FFFFFF">
				<b>Prv <br>
				Close</b></font></td>
				<td class="plaintext" bgcolor="#666666"><font color="#FFFFFF">
				<b>52 wk <br>
				Range</b></font></td>
				<td class="plaintext" bgcolor="#666666"><font color="#FFFFFF">
				<b>Mkt <br>
				Cap $m</b></font></td>
			</tr>
			<tr>
				<td class="plaintext" nowrap bgcolor="#DDDDDD"><%=price%></td>
				<td class="plaintext" nowrap><font color=<%=clr%>><%=bul & " " & dchn & " (" & formatnumber(pchn,2) & "%)"%></font></td>
				<td class="plaintext" nowrap bgcolor="#DDDDDD"><%=bid%></td>
				<td class="plaintext" nowrap><%=ask%></td>
				<td class="plaintext" nowrap bgcolor="#DDDDDD"><%=opn%></td>
				<td class="plaintext" nowrap><%=high%></td>
				<td class="plaintext" nowrap bgcolor="#DDDDDD"><%=low%></td>
				<td class="plaintext" nowrap><%=vol%></td>
				<td class="plaintext" nowrap bgcolor="#DDDDDD"><%=prv%></td>
				<td class="plaintext" nowrap><%=range%></td>
				<td class="plaintext" nowrap bgcolor="#DDDDDD"><%=mktcap%></td>
			</tr>
		</table>
		<h2>6 Month Share Chart</h2>
		<%
		enddate = date
		fromdate = enddate - 182
		enddate = day(enddate) & "/" & month(enddate) & "/" & year(enddate)
		fromdate = day(fromdate ) & "/" & month(fromdate ) & "/" & year(fromdate )
		%>
		
		<img src="http://hfgapps.hubb.com/asxtools/imageChart.axd?BI=2&COMT=index&OVS=XJO&TF=D6&TIMA1=20&TIMA2=20&s=NSX" border=0 width=560>&nbsp;
	

    </td>
  </tr>
  </table>
</div>

<!--#INCLUDE FILE="footer.asp"-->