<!--#INCLUDE FILE="include_all.asp"-->
<!--#INCLUDE FILE="admin/merchtools.asp"-->
<%
' display todays prices for codes passed via GET
Server.ScriptTimeout=360
nsxcodes=ucase(trim(request("nsxcode") & " "))
board=ucase(trim(request("board") & " "))
traded = request("traded")

Function FormatValue(value,decimalplaces)

  If IsNull(value) Then
    FormatValue = ""
  ElseIf Cdbl(value) = 0 Then
    FormatValue = ""
  Else
    'FormatValue = Replace(FormatNumber(value,decimalplaces),",","")
	FormatValue = FormatNumber(value,decimalplaces)
  End If

End Function

' construct search for multiple codes.
if len(nsxcodes)<>0 then
	tradingcodes=nsxcodes
	nsxcodes=replace(nsxcodes," ","")
	nsxcodes=replace(nsxcodes,";",",")
	nsxcodes=replace(nsxcodes,vbCRLF,"")
	nsxcodes=replace(nsxcodes,".","")
	nsxcodes=replace(nsxcodes,",,",",")
	srch = srch & " AND SUBSTRING(tradingcode,0,4) IN ("
	nsxcodes=split(nsxcodes,",")
	for jj = 0 to ubound(nsxcodes)
    if len(nsxcodes(jj)) > 0 then
		  srch = srch & "'" & SafeSqlParameter(left(nsxcodes(jj),3)) & "',"
    end if
	next
	srch = left(srch,len(srch)-1)
	srch = srch & ") "
end if

' fudge until trading engine boards align.
If len(traded) > 0 then page_title="Traded Today"
extracodes = ""
delcodes= ""
select case board
case "NCRP"
	page_title="Industrial Securities"
	extracodes = "" ' add extra codes to display
	delcodes = "FMI,MMT,PMI,TMH,AFOA,PIN,SON" ' remove extra codes to display
case "NDBT"
	page_title="Debt Securities"
	extracodes = ""
	delcodes = ""

case "NMIN"
	page_title="Mining & Energy Securities"
	extracodes = "FMI,MMT,PMI,TMH"
	delcodes = ""

case "NRST"
	page_title="Restricted Securities"
	extracodes = "AFOA"
	delcodes = ""
	
case "NPRP"
	page_title="Property Securities"
	extracodes = "PIN,SON,VER"
	delcodes = ""

case "COMM"
 	page_title="Community Securities - Certificated"
 	extracodes = ""
 	delcodes = ""

case "MAIN"
	page_title="Industrial Securities - Certificated"
	extracodes = ""
	delcodes = ""

case "PROP"
	page_title="Property Securities - Certificated"
	extracodes = ""
	delcodes = ""
	
case else
	delcodes = ""
	extracodes = ""
end select

If Len(board) = 0 and len(traded) = 0 and len(nsxcode)=0 then 
  page_title="Prices"
End If

If Len(board)<>0 then
	srch = srch & " AND ((pricescurrent.exchid='" & SafeSqlParameter(board) & "') "
	' fudge until trading engine boards align
	if extracodes <> "" then
		srch = srch & " OR SUBSTRING(tradingcode,0,4) IN ("
		extracodes=split(extracodes,",")
		for jj = 0 to ubound(extracodes)
			srch = srch & "'" & left(extracodes(jj),3) & "',"
		next
		srch = left(srch,len(srch)-1)
		srch = srch & ") "
	end if
	srch = srch & ") "
	' remove codes from display
	if delcodes <> "" then
		srch = srch & " AND ((issuestatus = 'active') AND ( SUBSTRING(tradingcode,0,4) NOT IN ("
		delcodes =split(delcodes,",")
		for jj = 0 to ubound(delcodes)
			srch = srch & "'" & left(delcodes(jj),3) & "',"
		next
		srch = left(srch,len(srch)-1)
		srch = srch & "))) "
	end if
end if 


If Len(displayboard) <> 0 Then
	srchregion = " WHERE ((pricescurrent.displayboard) like '%" & SafeSqlParameter(displayboard) & "%') "
Else
  srchregion = " WHERE 1=1 "
End If
 
If Len(traded) <> 0 Then
	srch = srch & " AND (pricescurrent.volume>0) "
End If 

If Len(tradingcodes) = 0 Then 
  srch = srch & " AND (pricescurrent.exchid<>'SIMV') AND (issuestatus = 'active') "
End If

if traded="all" then
	 srch = " AND (pricescurrent.volume>0) "
end if


Dim db
Dim rows
Dim currentpage
Dim currentPageGroup
Dim pageGroupSize

currentpage = trim(request("currentpage"))
if Not IsNumeric(currentpage) Or len(currentpage) = 0 Then
	currentpage=1
Else
	currentpage=cint(currentpage)
	if currentpage<1 then currentpage=1
End If

If Len(Request("currentpage")) > 0 Then currentpage = CInt(Trim(Request("currentpage")))

currentPageGroup = 0
If Len(Request("currentPageGroup")) > 0 Then currentPageGroup = CInt(Trim(Request("currentPageGroup")))
pageGroupSize = 50

sSQL = "SELECT [tradingcode],[tradedatetime],[open],[high],[low],[last],[volume],[bid],[offer],[bidqty],[offerqty],[tradestatus],[exchid],[currentsharesonissue],[isin],[issuedescription],[issuetype],[industryclass],[marketcap],[sessionmode],[marketdepth],[quotebasis],[prvclose],[currenteps],[currentdps],[currentnta] "
sSQL = sSQL & " FROM pricescurrent  "
sSQL = sSQL &  srchregion & srch 
sSQL = sSQL & " ORDER BY tradingcode ASC"

'Response.Write sSQL
'Response.End




' market status
smodecolor="red"
smode=ucase(trim(sessionmode & " "))
'security status
secmode = smode
secmodecolor = "red"
marketstatus = 0

select case smode
	case "NORMAL"
		smode="TRADING"
		smodecolor="green"
	case "CLOSED"
		smode="CLOSED"
	case "AHA"
		smode="ADJUST"
	case "ENQUIRY"
		smode = "CLOSED"
	case "HALT"
		smode="TRADING"	
		smodecolor="green"
	case "PREOPEN"
		smode="PREOPEN"
		smodecolor="green"
	case ""
		secmode="CLOSED"
		smodecolor="red"
end select
' now for security mode
secmodetest = secmode
select case secmodetest
	case "NORMAL"
		secmode="TRADING"
		secmodecolor="green"
	case "CLOSED"
		secmode =""
	case "AHA"
		secmode=""
	case "ENQUIRY"
		secmode = ""		
	case ""
		secmode=""
end select
if (instr(tradestatus,"SU")>0) and len(tradingcodes)>0 then
	secmode="SUSPENDED"
	secmodecolor="red"
end if


objJsIncludes.Add "tablesorter", "/js/jquery.tablesorter.min.js"
objJsIncludes.Add "tablesorterp", "/js/addons/pager/jquery.tablesorter.pager.js"

objCssIncludes.Add "tablesorterpcss", "/js/addons/pager/jquery.tablesorter.pager.css"
%>
<!--#INCLUDE FILE="header.asp"-->

<script type="text/javascript" >
// add parser through the tablesorter addParser method 
$.tablesorter.addParser({ 
	// set a unique id 
	id: 'formatted_num', 
	is: function(s) { 
		// return false so this parser is not auto detected 
		return false; 
	}, 
	format: function(s) { 
		// format your data for normalization 
		var x = s.toLowerCase().replace(/,/g,''); 
		x = parseFloat(x);
		return (isNaN(x)) ? null : x;
	}, 
	// set type, either numeric or text 
	type: 'numeric' 
}); 

$(document).ready(function() 
    { 
		$.tablesorter.formatInt = function (s) {
			var x = s.toLowerCase().replace(/,/g,''); 
            var i = parseInt(x);
            return (isNaN(i)) ? null : i;
        };
        $.tablesorter.formatFloat = function (s) {
			var x = s.toLowerCase().replace(/,/g,''); 
            var i = parseFloat(x);
            return (isNaN(i)) ? null : i;
        };
		
        var pagesize = 20;
        
        if ($("#pager select").length>0) 
        {
          pagesize=$("#pager select").val();
        }
        $("#myTable").tablesorter( { 
			widgets: ["zebra"],
			headers: { 
			
	            1: { 
					sorter: 'formatted_num' 
                },			
				2: { 
					sorter: false
                },
				3: { 
					sorter: false
                },
				4: { 
					sorter: false
                },
				5: { 
                    sorter:'formatted_num' 
					//sorter: false
                } 
            }
		});
        $("#myTable").tablesorterPager({ container: $("#pager"), positionFixed: false, size: pagesize }); 
    } 
);
</script>
<!-- <div class="container_cont"> -->

<%
Server.Execute "side_menu.asp"
%>

<div class="hero-banner subpage">
    <div class="hero-banner-img"></div>
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder subpage">
            <div class="col-sm-12 hero-banner-left">
                <h1>Prices</h1>
            </div>
        </div>
    </div>
</div>

<div class="container subpage">
    <div class="row">
        <div class="col-sm-12">
            <div class="subpage-center">

    <div class="editarea">
        
        <div style="width:100%;text-align:middle">
        Filter Securities:
        <a href=" /marketdata/prices/">All</a> | 
        <a href=" /marketdata/prices/?traded=1" >Traded Today</a>&nbsp;
        Sector: <a href=" /marketdata/prices/?nsxcode=&board=ncrp" >Industrial</a> | 
        <a href=" /marketdata/prices/?nsxcode=&board=nprp">Property</a> | 
        <a href=" /marketdata/prices/?nsxcode=&board=ndbt">Debt</a> |
        <a href=" /marketdata/prices/?nsxcode=&board=nmin">Mining &amp; Energy</a> |
        <a href=" /marketdata/prices/?nsxcode=&board=nrst">Restricted</a>
        <br/>Certificated Securities: 
        <a href=" /marketdata/prices/?nsxcode=&currentpage=1&board=comm" class="rhlinks">Community Banks</a> |
        <a href=" /marketdata/prices/?nsxcode=&currentpage=1&board=main" class="rhlinks">Industrial</a> |
        <a href=" /marketdata/prices/?nsxcode=&currentpage=1&board=prop" class="rhlinks">Property</a>
        </div>
        <div style="width:100%;clear:both;height:5px"></div>

        <div class="pager2" id="pager">	
          <form action="javascript:void(0)" method="get">
	        <span>
                <i class="first fa fa-step-backward"></i>
                <i class="prev fa fa-backward"></i>
                <input type="text" class="pagedisplay" style="border:none;width:70px;text-align:center">
                <i class="next fa fa-forward"></i>
                <i class="last fa fa-step-forward"></i>

		        <select class="pagesize" style="vertical-align: middle;">
			        <option value="20" selected="selected">20</option>
			        <option value="40">40</option>
			        <option value="100">100</option>
			        <option value="200">200</option>
		        </select>
	        </span>
	        </form>
        </div>
<div class="table-responsive">
<table id="myTable" class="table tablesorter"> 
        <thead> 
        <tr> 
            <th>NSX<br>Code</th> 
            <th>Last$</th> 
            <th>Bid<br>Qty</th> 
            <th>Bid<br>$</th> 
            <th>Offer<br>$</th>
            <th>Offer<br>Qty</th>
            <th>Open<br>$</th>
            <th>High<br>$</th>
            <th>Low<br>$</th>
            <th>Vol.<br>units</th>
            <th>Mkt.<br>Cap. $m</th>
            <th>Prev<br>Cls</th>
            <th>Chge<br>(last vs Prv)<br>%</th>
            <th>Chge<br>(last vs open)<br>%</th>
            <!-- th>PE x</th -->
            <!--<th>Div<br>Yld %</th>-->
            <th>Stat<br>Code</th>
        </tr> 
        </thead> 
        <tbody>

<%
Set conn = GetReaderConn()
Set rs = conn.Execute(sSQL)
If rs.EOF Then
  %><tr>
  <td colspan="17" align="center">No Records <%=SQL%></td>
  </tr><%
Else
	securities_listed = 0
  While Not rs.EOF
    marketcap = 0
	securities_listed = securities_listed + 1
    If Not IsNull(rs("last")) Then
	
    
    col3 = "navy"
    img3 = "<img border=""0"" src=""images/v2/level.gif"" alt="""" align=""middle"">"
    col2 = "navy"
    img1 = "<img border=""0"" src=""images/v2/level.gif"" alt="""" align=""middle"">"
     
    volume = 0     
    dchange = 0
    last = 0
    prvclose = 0
    change = 0
    low = 0
    open = 0
    
    If Not IsNull(rs("low")) Then low = CDbl(rs("low"))
    If Not IsNull(rs("open")) Then open = CDbl(rs("open")) 
    If Not IsNull(rs("last")) Then last = CDbl(rs("last"))
    If Not IsNull(rs("prvclose")) Then prvclose = CDbl(rs("prvclose"))
    If Not IsNull(rs("volume")) Then volume = CDbl(rs("volume"))   

    If open <> 0 And open < low Then low = open
    If open <> 0 Then change = 100*((last-open)/open)
        
    
    If last = 0 Or prvclose=0 Then
      dchange = 0
    Else
      dchange = 100*((last-prvclose)/prvclose)
    End If    
    
		If dchange > 0 And Not IsNull(rs("volume")) Then 
      img3 = "<img border=""0"" src=""images/up.gif"" alt="""" align=""middle"">"
      col3 = "green"
		ElseIf dchange < 0 And Not IsNull(rs("volume")) Then
			img3="<img border=""0"" src=""images/down.gif"" alt="""" align=""middle"">"
			col3 = "red"
		End If
    
    If change > 0 And volume <> 0 Then 
      img1 = "<img border=""0"" src=""images/up.gif"" alt="""" align=""middle"">"
      col2 = "green"
    ElseIf change < 0 And volume<> 0 Then
      img1="<img border=""0"" src=""images/down.gif"" alt="""" align=""middle"">"
      col2 = "red"
    End If		
	
	
	
	
	
			If Not IsNull(rs("currentsharesonissue")) And Cdbl(rs("last")) <> 0 Then marketcap = (CDbl(rs("last")) * CDbl(rs("currentsharesonissue")))/1000000.0
		End If
		If marketcap = 0 And Not IsNull(rs("prvclose")) Then
			If Not IsNull(rs("currentsharesonissue")) And CDbl(rs("prvclose")) > 0 Then marketcap = (CDbl(rs("prvclose")) * CDbl(rs("currentsharesonissue")))/1000000.0
		End If

		sessionmode = Ucase(Trim(rs("sessionmode") & " "))
		smode = ""
		
		SELECT CASE sessionmode
			CASE "HALT"
				smode = "TH"
			CASE "PREOPEN"
				smode = "PRE"
			CASE "ENQUIRY"
				smode = "ENQ"
			CASE "NORMAL"
				smode = ""
			CASE "CLOSING"
				smode = "CLS"
			CASE else
				smode = sessionmode
		END SELECT
		'if sessionmode="NORMAL" then marketstatus = marketstatus+1

		status = ""
		quotebasis = rs("quotebasis")
		tradestatus = rs("tradestatus")
		status2 = trim(ucase(tradestatus & " " & smode & " " & quotebasis )) ' status flag
		if status2 <> "" then
			status = "<a href=""/marketdata/search_by_company?nsxcode=" & rs("tradingcode") & " "  & """ title='Click here for news'>" & status2 & "</a>&nbsp;" 
		end if
		
		' DIV YIELD % calculation
		dy = ""
		divyield = ""
		currentdps = rs("currentdps")
		if currentdps = 0 or currentdps = "" or currentdps = null or calprice = 0 then
			dy = 0
		else
			dy = 100 * ((currentdps / 100)  / calcprice)
		end if
		if dy < 0 then
			divyield = formatnumber(dy,1) 
		elseif dy = 0 then
			divyield = ""
		elseif dy  > 0 then
			divyield = formatnumber(dy,1)
		end if	
    
		' PE times calculation
		pe = ""
		currenteps = rs("currenteps") '(23,jj)
		if currenteps = 0 or currenteps = "" or currenteps = null then
			pe = 0
		else
			calcprice = prvclose
			if last <> 0 then calcprice = last
			pe = calcprice / (currenteps / 100)
		end if
		
		if pe < 0 then
			pe = formatnumber(pe,1) 
		elseif pe = 0 then
			pe = ""
		elseif pe  > 0 then
			pe = formatnumber(pe,1)
			pe = Replace(pe,",","")
		end if 
    
    
	
%>                     	 
<tr> 
	<td><a href="/summary/<%=rs("tradingcode")%>" title="Click for more detail. <%=rs("issuedescription")%>"><%=rs("tradingcode")%></a></td> 
    <td align="right"><%=FormatValue(rs("last"),3)%></td> 
    <td align="right"><%=FormatValue(rs("bidqty"),0)%></td> 
    <td align="right"><%=FormatValue(rs("bid"),3)%></td> 
    <td align="right"><%=FormatValue(rs("offer"),3)%></td>
    <td align="right"><%=FormatValue(rs("offerqty"),0)%></td>
    <td align="right"><%=FormatValue(open,3)%></td>
    <td align="right"><%=FormatValue(rs("high"),3)%></td>
    <td align="right"><%=FormatValue(low,3)%></td>
    <td align="right"><%=FormatValue(volume,0)%></td>
    <td align="right"><%=FormatValue(marketcap,1)%></td>
    <td align="right"><%=FormatValue(rs("prvclose"),3)%></td>
    <td><span style="color:<%=col3%>"><%=FormatValue(dchange,3)%>&nbsp;</span><%=img3%></td>
    <td><span style="color:<%=col2%>"><%=FormatValue(change,3)%>&nbsp;</span><%=img1%></td>
    <!-- td align="right"><%=pe%></td -->
   <!-- <td align="right"><%=divyield%></td> -->
    <td align="center"><%=status%></td> 
</tr>
<%    
    rs.MoveNext  
  Wend  
End If
Set rs = Nothing
%>  
</tbody> 
</table>
</div>

<h2>Notes</h2>
<ol>
<li>Click column headings to sort, click again to reverse sort order.</li>
<li>Press the <b>Shift</b> key while clicking headings to sort using multiple columns.</li>
<li>Price information on this page is delayed.</li>
<li>Explanations for price data can be found on the <a href="prices_definitions.asp"><strong>Definitions</strong></a> page.  
<li>Explanations for trading status codes can be found on the <a href="/regulation/exchange/trading-codes/"><strong>Trading Codes</strong></a> page.</li>
<li>For calculation of market capitalisation if a security has never traded then the last price is the IPO price or as determined by the Exchange.</li>
</ol>
<%
if page_title = "All Securities" then response.write securities_listed%></li>
</div>
</div>
</div>
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->