<%@ LANGUAGE="VBSCRIPT" %>
<%
Response.Buffer = False
response.expires = 0
response.expiresabsolute = #JAN 2, 2000 00:00:00#
response.cachecontrol = "PRIVATE"

%>

<!--#INCLUDE FILE="head.asp"--><html>

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




<meta name="Microsoft Border" content="none">
<link rel="shortcut icon" href="favicon.ico" ></head>
<%
id = ucase(request("tradingcode"))
coname = replace(request("coname") & " ","''","`")
coname = replace(request("coname") & " ","'","")
tday = 200
%>
<body bgcolor=white topmargin=0  >


<div align="center" id="backgroundchartexecute" style="position:relative;z-index:0;">
	

<div class="table-responsive"><table border="0" width="797" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" rowspan="2" bgcolor="#FFFFFF"><!--#INCLUDE FILE="lmenu.asp"--></td>
  </tr>
  <tr>
    <td class="plaintext" valign="top" bgcolor="#FFFFFF">
  
<div class="table-responsive"><table align=center>
<!--#INCLUDE FILE="admin/merchtools.asp"-->
<%
DATA_PATH = Server.Mappath("newsxdb\nsxprices.mdb")
' display daily prices chart
' if multiple codes requested then restrict by that otherwise ALL codes.
id = ucase(request.querystring("tradingcode"))
		
Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
'ConnPasswords.Open "DBQ=" & DATA_PATH &   ";Driver={Microsoft Access Driver (*.mdb)};UID=" & ConnPasswords_RuntimeUserName & ";PASSWORD=" & ConnPasswords_RuntimePassword

strConnString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & DATA_PATH  
ConnPasswords.Open strConnString 



SQL = "SELECT TOP " & tday & " tradedatetime,[open], [high] , [low], [last], [volume] "
SQL = SQL & " FROM pricesdaily  "
SQL = SQL & " WHERE (tradingcode='" & id & "') and volume>0"
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
	<param name=dataset0Color value="003399">
	<param name=dataset1Color value="darkgray">

	<param name=xAxisOptions value="gridOn,bottomAxis,">



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
    </table></div>







<p align="center">&nbsp;
    <b>Note:</b> Prices displayed are for trades only.&nbsp; Data are available 
up to and including the previous business day.&nbsp; <br>
The charts utilise Java which is required to be installed and operational within 
your browser.</td>
    
  </tr>
</table></div>
</div>

<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </p>
<p>&nbsp;&nbsp; </p>



</body>

</html>