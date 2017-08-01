<%@ LANGUAGE="VBSCRIPT" %>
<!--#INCLUDE FILE="include_all.asp"-->
<%
Response.Buffer = False
response.expires = 0
response.expiresabsolute = #JAN 2, 2000 00:00:00#
response.cachecontrol = "PRIVATE"

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
<meta name="AUTHOR" content="Scott Evans, Evans Shepherd Consulting, http://www.evansshepherd.com.au">
<meta name="DISTRIBUTION" content="GLOBAL">
<meta name="RATING" content="GENERAL">
<meta name="description" content="The National Stock Exchange of Australia - Operates a Stock Exchange in Australia focussing on small to medium and high technology companies.">
<meta name="keywords" content="small, medium, company, companies, companys, australia, Australia, Newcastle, enterprises, high technology, stock, exchange, stock exchange, Australian, NSX, nsx">
<link rel=stylesheet href="newsx2.css" type="text/css">



<meta name="Microsoft Border" content="none">
<link rel="shortcut icon" href="favicon.ico" ></head>
<%
id = ucase(request("tradingcode"))
coname = replace(request("coname") & " ","''","`")
coname = replace(request("coname") & " ","'","")
tday = 200
%>
<body >

<!--#INCLUDE FILE="header.asp"-->
<div align="center" >
	

<table border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" rowspan="3" bgcolor="#FFFFFF"><!--#INCLUDE FILE="lmenu.asp"--></td>
  </tr>
  <tr>
    <td class="textheader" bgcolor="#FFFFFF" >
    <h1><b>&nbsp;&nbsp;&nbsp;&nbsp;
      <font face="Arial">&nbsp;&nbsp;&nbsp;</font></b></h1>
	
		<h1><font face="Arial">END OF 
	DAY - DAILY 
    PRICE / VOLUME CHART</h1>
		<p>Daily prices for the last <%=tday%> trades represented by a line.</p>
		<p>Daily volume traded represented by a bar.</p>
		<p>
    <b><font size="2">Note:</font></b><font size="2">
		<span style="font-weight: 400">Prices displayed are for trades only.&nbsp;
The charts utilise <a target="_blank" href="http://www.java.com">Java</a> which is required to be installed and operational within 
your browser.</span></font></p>
		<p>&nbsp;</p>
	
    </td>
  </tr>
  <tr>
    <td class="plaintext" valign="top" bgcolor="#FFFFFF">
    <%
    tradingcode=request.querystring("tradingcode")
    
    %>
<table align=center>
<!--#INCLUDE FILE="admin/merchtools.asp"-->
<%

' display daily prices chart
' if multiple codes requested then restrict by that otherwise ALL codes.
id = ucase(request.querystring("tradingcode"))
		
Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
'ConnPasswords.Open Application("nsx_ReaderConnectionString")   

  
ConnPasswords.Open Application("nsx_ReaderConnectionString") 



SQL = "SELECT TOP " & tday & " tradedatetime,[open], [high] , [low], [last], [volume] "
SQL = SQL & " FROM pricesdaily  "
SQL = SQL & " WHERE (tradingcode='" & SafeSqlParameter(id) & "') and volume>0"
SQL = SQL & " ORDER BY tradedatetime DESC"


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

%>

<%
'get the data
'-------------------------------------------------------
' Do the Open/Close Figures
	LastMonth = ""
	alldaily = ""
	allopen = ""
	allhigh = ""
	alllow=""
	allclose=""
	
if rc>0 then
	For jj = rc to 0 step -1
	
		daily =  alldata(0,jj)
		open = alldata(1,jj)
		high = alldata(2,jj)
		low = alldata(3,jj)
		last =  alldata(4,jj)
		volume =  alldata(5,jj)

		'this sets the value and low value in the correct sequence for the chart
		'if open = 0 then open = last
		'if last = 0 then last = open
		'If open > last Then
			'HighValue = open
			'LowValue = last
		'Else 
			'HighValue = last
			'LowValue = open
		'End if
		if allvolume = "" then
				allvolume = volume
				else
				allvolume = allvolume & "," & volume
		end if
		if alllast = "" then
			alllast = last
			else
			alllast = alllast & "," & last
		end if
		if alldaily = "" then
			alldaily = daily
			else
			alldaily = alldaily & "," & daily
		end if
		

		
		
	NEXT
	alldaily = replace(alldaily,"/","-")
	sdate = alldata(0,rc) ' start date
	edate = alldata(0,0)  ' end date
%>
    
    <tr>
    <td>
    <OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
	codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" 
	WIDTH="400" 
	HEIGHT="250" 
	id="charts" 
	ALIGN="">
<PARAM NAME=movie VALUE="charts.swf?library_path=charts_library&xml_source=ftp/charts/sample.xml">
<PARAM NAME=quality VALUE=high>
<PARAM NAME=bgcolor VALUE=#666666>

<EMBED src="charts.swf?library_path=charts_library&xml_source=sample.xml"
       quality=high 
       bgcolor=#666666  
       WIDTH="400" 
       HEIGHT="250" 
       NAME="charts" 
       ALIGN="" 
       swLiveConnect="true" 
       TYPE="application/x-shockwave-flash" 
       PLUGINSPAGE="http://www.macromedia.com/go/getflashplayer">
</EMBED>
</OBJECT>


    <APPLET CODE="com.ve.kavachart.applet.twinAxisDateComboApp"  codebase="prices/jars/" archive="twinAxisDateComboApp.jar" WIDTH=700 HEIGHT=357>
	<param name=dataset1onRight value=true>
	<param name=dataset1Type value=stick>
	<param name=titleString value="<%=id%>: <%=coname%>">
	<param name=titleFont value="Arial,14,0">

	<param name=yAxisOptions value="currencyLabels,gridOn">

	<param name=yAxisTitle value="Share Price">
	<param name=dataset0Name value="Share Price">

	<param name=auxAxisTitle value="Volume">
	<param name=dataset1Name value="Volume">
	<param name=auxAxisOptions value="gridOn">

	<param name=dwellUseDatasetName value="true">
	<param name=dwellYString value="#">
	<param name=dwellLabelDateFormat value="dd-MMM-yy">
	
	<param name=scrollWindows value="10">
	<param name=plotAreaRight value="0.90">
	<param name=plotAreaLeft value="0.13">
	<param name=plotAreaBottom value="0.15">

	<param name=axisDateFormat value="dd-MMM-yyyy">
	<param name="inputDateFormat" value="MM-dd-yyyy">

	<param name=scalingType value=4>
	<param name=dataset0Color value="003399">
	<param name=dataset1Color value="darkgray">

	<param name=xAxisOptions value="gridOff,bottomAxis">



	<param name=dataset0dateValues value="<%=alldaily%>">
	<param name=dataset0yValues value="<%=alllast%>">
	<param name=dataset1dateValues value="<%=alldaily%>">
	<param name=dataset1yValues value="<%=allvolume%>">
	

</APPLET>





    </td>
      </tr>
      
      
 <%
 
 else
  %>
  <tr><td>No Records available</td></tr>
      
    <%end if%>
    </table>







<p align="center">&nbsp;
    </td>
    
  </tr>
</table>
</div>
<!--#INCLUDE FILE="footer.asp"-->
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </p>
<p>&nbsp;&nbsp; </p>



</body>

</html>