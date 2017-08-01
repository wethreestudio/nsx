<!--#INCLUDE FILE="include_all.asp"-->
<!--#INCLUDE FILE="admin/merchtools.asp"-->
<%


id = ucase(request("tradingcode"))
coname = replace(request("coname") & " ","''","`")
coname = replace(request("coname") & " ","'","")
tday = 260


'Response.Write("chart_index here")

'Response.Redirect "/marketdata/prices"

'Response.End

page_title = id & " - Chart"
' meta_description = ""
' alow_robots = "no"
' objJsIncludes.Add "marketdata", "js/marketdata.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"
%>
<!--#INCLUDE FILE="header.asp"-->

<div class="hero-banner subpage">
    <div class="hero-banner-img"></div>
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder subpage">
            <div class="col-sm-12 hero-banner-left">
                <h1>Market Data</h1>
            </div>
        </div>
    </div>
</div><!-- /hero-banner -->

<div class="container subpage">
    <div class="row">
        <div class="col-sm-12">
<div class="editarea">
<h1>End Of Day - Index Chart</h1>
<p>
Daily index for the last <%= Server.HTMLEncode(tday) %> values represented by a line.
</p>
<table border="0" width="100%" cellspacing="0" cellpadding="0">

  <tr>
    <td class="plaintext" valign="top" bgcolor="#FFFFFF" align="center">
    
<table align="center">
<tr><td>

<%

'http://code.google.com/apis/chart

' BEGIN FUNCTION AREA

'* Min ******************************************************
' Finds and returns the lowest value in an array of numbers.
' Ignores non-numeric and Null data contained in the array.
' Returns Null if no numeric items are found in the array.
'************************************************************
Function Min(aNumberArray)
	Dim I               ' Standard loop counter
	Dim dblLowestSoFar  ' Numeric variable for current lowest item
	
	' Init it to Null so I know it's empty
	dblLowestSoFar = Null

	' Loop through the array
	For I = LBound(aNumberArray) to UBound(aNumberArray)
		' Testing line left in for debugging if needed
		'Response.Write aNumberArray(I) & "<BR>"
		
		' Check to be sure the item is numeric so we don't bomb out by trying to
		' compare a number to a string.
		If IsNumeric(aNumberArray(I)) Then
			' Convert it to a Double for comparison and compare it to previous lowest #.
			' If it's lower than the current lowest or the value of dblLowestSoFar is
			' still NULL then set dblLowestSoFar to it's new value.
			If CDbl(aNumberArray(I)) < dblLowestSoFar Or IsNull(dblLowestSoFar) Then
				dblLowestSoFar = CDbl(aNumberArray(I))
			End If
		End If
	Next 'I
	
	Min = dblLowestSoFar
End Function


'* Max ******************************************************
'Finds and returns the highest value in an array of numbers.
'Ignores non-numeric and Null data contained in the array.
'Returns Null if no numeric items are found in the array.
'************************************************************
Function Max(aNumberArray)
	Dim I
	Dim dblHighestSoFar

	dblHighestSoFar = Null

	For I = LBound(aNumberArray) to UBound(aNumberArray)
		' Testing line left in for debugging if needed
		'Response.Write aNumberArray(I) & "<BR>"
		If IsNumeric(aNumberArray(I)) Then
			If CDbl(aNumberArray(I)) > dblHighestSoFar Or IsNull(dblHighestSoFar) Then
				dblHighestSoFar = CDbl(aNumberArray(I))
			End If
		End If
	Next 'I
	
	Max = dblHighestSoFar
End Function

Function fmtddmmyy(x)

	dd = day(x)
	mm = monthname(month(x),1)
	yy = year(x)
	fmtddmmyy = dd & mm & yy
end function

' END FUNCTION AREA




id = ucase(request("tradingcode"))
coname = trim(replace(request("coname") & " ","''","`"))
if len(coname)=0 then coname ="All+Equities+Index"

tday = 260

    if len(id)=0 then id="NSXAEI"
    
    ttitle = coname & "+(" & lcase(id) & ")"
    ttitle = replace(ttitle," ","+")
    size= request("size")
    if len(size)=0 then size="400x200"
 

' display daily prices chart

		
Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
'ConnPasswords.Open Application("nsx_ReaderConnectionString")   

  
ConnPasswords.Open Application("nsx_ReaderConnectionString") 

SQL = "SELECT TOP " & tday & " tradedatetime,[open], [high] , [low], [last] "

SQL = SQL & " FROM indexdaily  "
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
	' divide into 5 even parts to get date intervals to match x axis
	evengap = round(0.5+(rc/10),0)
	

	For jj = 0 to rc
	
		daily =  alldata(0,jj)
		open = alldata(1,jj)
		high = alldata(2,jj)
		low = alldata(3,jj)
		last =  alldata(4,jj)


		'this sets the value and low value in the correct sequence for the chart
		
		
		if alllast = "" then
			alllast = last
			else
			alllast = alllast & "," & last
		end if
		if alldaily = "" then
			alldaily = fmtddmmyy(daily)
			lastdaily = fmtddmmyy(daily)
			else
			if (jj mod evengap) = 0 then
				alldaily = fmtddmmyy(daily) & "|" & alldaily 
			end if
			firstdaily = fmtddmmyy(daily)
		end if
	

	NEXT
	alldaily = firstdaily & "|" & alldaily
	lastarry=split(alllast,",")
	maxlast= 1.01 * max(lastarry)
	minlast= 0.99 * min(lastarry)
	maxdiff=maxlast-minlast

	alllast=""
	xvalues=""
	rc = ubound(lastarry)
	
	for ii = lbound(lastarry) to rc

		if alllast = "" then
			alllast = formatnumber(100 * ((lastarry(ii)-minlast)/maxdiff),1)
			else
			alllast = formatnumber(100 * ((lastarry(ii)-minlast)/maxdiff),1) & "," & alllast
		end if
	
	next 

		
		
		ssl = "http://"	 ' Chart API only works over HTTP
		
		finalchart = ssl & "chart.apis.google.com/chart?"
		finalchart= finalchart & "cht=lc&chs=" & size & "&chm=B,76A4FB,0,0,0"
		' daily data, text encoding
		finalchart=finalchart & "&chd=t:"  & alllast
		' axis labels
		finalchart=finalchart & "&chxl=0:|" & alldaily  
		' axis range
		'finalchart = finalchart & "&chxp=0," & firstdaily & "," & lastdaily
		' title
		finalchart = finalchart & "&chtt=" & ttitle
		' axis range
		finalchart = finalchart & "&chxt=x,y,r"
		finalchart = finalchart & "&chxr=1," & minlast & "," & maxlast & "|2," & minlast & "," & maxlast
		finalchart = finalchart & "&chf=c,ls,0,EEEEEE,0.1,cccccc,0.1"
		finalchart = finalchart & "&chg=10,20" 
		finalchart = finalchart & "&chls=2"
		
		finalchart = replace(finalchart,"&","&amp;")
		
		finalchart= "<a href=""/marketdata/prices""><img src='" & finalchart & "' border=0  title='click for more indices' alt=""chart""></a>"
	response.write finalchart
end if



%>
    </td>
      </tr>
  
    </table>

&nbsp;
</td>
</tr>
</table>
</div>
</div>
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->