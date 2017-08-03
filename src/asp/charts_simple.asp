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

<body >

<!--#INCLUDE FILE="header.asp"-->
<div align="center">
<div class="table-responsive"><table border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" rowspan="4" bgcolor="#FFFFFF"><!--#INCLUDE FILE="lmenu.asp"--></td>
  </tr>
  <tr>
    <td class="textheader" bgcolor="#FFFFFF" >
    <h1><b>&nbsp;&nbsp;&nbsp;&nbsp;
      <font face="Arial">&nbsp;&nbsp;&nbsp;</font></b><font face="Arial">DAILY 
    TRADING CHART</h1>
    </td>
  </tr>
  <tr>
    <td class="textheader" bgcolor="#FFFFFF">&nbsp;</td>
  </tr>
  <tr>
    <td class="plaintext" valign="top" bgcolor="#FFFFFF">
<p align="left">
<%
id = ucase(request("tradingcode"))
coname = replace(request("coname") & " ","''","`")
tday = 100
%>
Last <%=tday%> trading days for <b><%=coname%> (<%=id%>)</b>
</p>
<!--#INCLUDE FILE="admin/merchtools.asp"-->
<div class="table-responsive"><table>




<%

' display daily prices chart
' if mutliple codes requested then restrict by that otherwise ALL codes.
id = ucase(request.querystring("tradingcode"))
coname = replace(request.querystring("coname") & " ","''","`")
		
Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
ConnPasswords.Open Application("nsx_ReaderConnectionString")   

SQL = "SELECT TOP " & tday & " tradedatetime, bid, high , low, offer, volume "
SQL = SQL & " FROM pricesdaily  "
SQL = SQL & " WHERE (tradingcode='" & SafeSqlParameter(id) & "') "
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


'response.write rc & "<br>"
Set BChrt = Server.CreateObject("IntrChart.Chart")
BChrt.LibraryPath = "IntrChart"
'Response.Write "IntrChart " & BChrt.Version  & " Database Example<br>"
sCurDir = Server.MapPath("\ftp\charts")
'sCurDir = "e:\inetpub\vs19698\ftp\charts"
'response.write sCurDir & "<br>"

 


DrawIntrChartOpenClose(BChrt)
iPos = Instr(BChrt.FilePath, "Chart")
sChartFile = "ftp/charts/" & Mid(BChrt.FilePath, iPos)
cfile1= BChrt.FilePath
'response.write cfile1 & "<br>"
%>
	<tr>
		<td><img src=<%=sChartFile%> alt="<%=coname %>"></td>
	</tr>
<%

DrawIntrChartVolume(BChrt)
iPos = Instr(BChrt.FilePath, "Chart")
sChartFile = "ftp/charts/" & Mid(BChrt.FilePath, iPos)
cfile2= BChrt.FilePath
'response.write cfile2 & "<br>"

%>
	<tr>
		<td><img src=<%=sChartFile%> alt="<%=coname %>"></td>
	</tr>
      
      
      
      <%


Function DrawIntrChartOpenClose(BChrt)
'-------------------------------------------------------
' Do the Open/Close Figures
	LastMonth = ""
	For jj = rc to 0 step -1
	
		daily =  alldata(0,jj)
		open = alldata(1,jj)
		high = alldata(2,jj)
		low = alldata(3,jj)
		last =  alldata(4,jj)
		volume =  alldata(5,jj)

	
		SetLabel LastMonth,ChartLabel,daily
			
		'this sets the value and low value in the correct sequence for the chart
		if open = 0 then open = last
		if last = 0 then last = open
		If open > last Then
			HighValue = open
			LowValue = last
		Else 
			HighValue = last
			LowValue = open
		End if
		
		
		
		'response.write highvalue & " " & Lowvalue
					
		BChrt.ChartValue HighValue,"#000080",ChartLabel,,,,LowValue
		
		
	NEXT
	
	ConfigChart()
	'response.write alldata(0,rc-1) & " " & alldata(0,0)
	'response.end
	sdate = day(alldata(0,rc)) & "-" & monthname(month(alldata(0,rc)),1) & "-" & year(alldata(0,rc))
	edate = day(alldata(0,0)) & "-" & monthname(month(alldata(0,0)),1) & "-" & year(alldata(0,0))
	BChrt.TText = "Bid/Offer - " & id & " From " & sdate & " to " &  edate	
	BChrt.LabelX = ""
	BChrt.LabelY = "$"
	
	sBuff = DatePart("n", Now()) & DatePart("s", Now())
    sFilePath = sCurDir & "\Chart" & id & sBuff & ".jpg"
    BChrt.FilePath = sFilePath
    vMsg = BChrt.CreateChart("bar")
    
	If vMsg <> "" Then
		Response.Write vMsg
	End If

End Function


FUNCTION DrawIntrChartVolume(BChrt)
'-------------------------------------------------------
' Do the High/Low Figures
	LastMonth = ""
	For jj = rc to 0 step -1
	
		daily =  alldata(0,jj)
		open = alldata(1,jj)
		high = alldata(2,jj)
		low = alldata(3,jj)
		last =  alldata(4,jj)
		volume =  alldata(5,jj)
	
		SetLabel LastMonth,ChartLabel,daily
			
		BChrt.TText = ""
		BChrt.LabelX = "Volume"
		BChrt.LabelY = "Value ($M)"
		'Volume = volume / 1000000
		BChrt.ChartValue Volume,"#800000",ChartLabel
		
		'response.write daily 

		
		
	NEXT
	
	ConfigChart()
	sdate = day(alldata(0,rc)) & "-" & monthname(month(alldata(0,rc)),1) & "-" & year(alldata(0,rc))
	edate = day(alldata(0,0)) & "-" & monthname(month(alldata(0,0)),1) & "-" & year(alldata(0,0))
	BChrt.TText = "Volume - " & id & " From "  & sdate & " to " &  edate	
	BChrt.LabelX = ""
	BChrt.LabelY = "SHARES"
	sBuff = DatePart("n", Now()) & DatePart("s", Now())
    sFilePath = sCurDir & "\Chart" & id & sBuff & ".jpg"
    BChrt.FilePath = sFilePath
    vMsg = BChrt.CreateChart("bar")
    

	If vMsg <> "" Then
		Response.Write "<BR><BR>" & vMsg & "<BR><BR>"
	End If

End FUNCTION


FUNCTION SetLabel(LastMonth, ChartLabel, Daily)
		'this checks if the data has gone into another month
		' If it has then it sets the label. Otherwise a GridNotch and no label. 
		
		
		If LastMonth = "" Then
			LastMonth = DatePart("m",daily)
			ChartLabel = MonthName(DatePart("m", daily),1) & " " & year(daily)
		Else
			If LastMonth <> DatePart("m",daily) Then
				ChartLabel = MonthName(DatePart("m", daily),1) & " " & year(daily)
				LastMonth = DatePart("m",daily)
			Else
			    LastMonth = DatePart("m",daily)
				ChartLabel = "GridNotch"
				
			End If
		End If
		'response.write daily & " - " & ChartLabel & "<br>"
End FUNCTION
	
FUNCTION ConfigChart
' Set the Chart Properties
	BChrt.BackColor = "white"

    BChrt.BorderColor = "silver"
    BChrt.GraphicBorders = "silver"
    
    BChrt.ChartWidth = 400
    BChrt.ChartHeight = 300
    
    BChrt.Compression = 100
    
    BChrt.LineWidth = 1
	BChrt.LineType = "Line"
	BChrt.DotPoints = True		
	
	'BChrt.OptimalScalePoints = 10
	BChrt.GridLinesVertical = True
	BChrt.GridLinesHorizontal = True
    BChrt.GridLineType = "Solid"

    BChrt.LabelBold = True
    BChrt.ShowSegmentValues = False
	BChrt.ValueTextX = "Down"
	BChrt.ValueTextXBold = False
	BChrt.ThousandSeparators = False
	
	BChrt.HasLegend = False
	
	'BChrt.Trend = "Line"
    
    BChrt.OffSetPieMax = False
    BChrt.PieBorderHeight = 30
    BChrt.PieEllipse = False
    
    BChrt.TBold = True
    BChrt.TFont = "Arial Narrow"
    BChrt.TUnderline = False
    BChrt.TItalic = False
    BChrt.TSize = 10
    BChrt.TAlignment = "center"
    BChrt.TColor = "#800000"
    

    BChrt.Shadow = False

End FUNCTION

FUNCTION EmptyObjects(c1,c2)
	'---This procedure is for cleaning up the images directory but
'	the Server will probably need more time to read the graphic from disk
'	than to delete it. You may need to increase dPause.
	Const dPause = 10

	dEnd = DateAdd("s", dPause, Now())
	bEndNow = False	
	
	While Not bEndNow
		If DateDiff("s", Now(), dEnd) <= 0 Then
			bEndNow = True
		End If
	Wend

	'response.write c1 & "<br>" & c2 & "<br>"
	Set objFSO = CreateObject("Scripting.FileSystemObject")
	objFSO.DeleteFile c1
	objFSO.DeleteFile c2
	Set objFSO = Nothing

End FUNCTION

    %>
    
    <tr>
    <td>
    
    </td>
      </tr>
      
      </table></div>







<p>&nbsp;
    </td>
    
  </tr>
</table></div>
</div>
<!--#INCLUDE FILE="footer.asp"-->
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </p>
<p>&nbsp;&nbsp; </p>

        <%
        'This next line will delete the created jpg file
' If you wish to keep the file then remove this line.
EmptyObjects cfile1,cfile2
Set BChrt = Nothing
%>

</body>

</html>