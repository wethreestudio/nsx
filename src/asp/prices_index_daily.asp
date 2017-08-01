<%Server.ScriptTimeout=360%>
<!--#INCLUDE FILE="include_all.asp"-->
<%
response.expires = 0
response.expiresabsolute = #JAN 2, 2000 00:00:00#
response.cachecontrol = "PRIVATE"
page_title = "Index Price History"
' meta_description = ""
' alow_robots = "no"
' objJsIncludes.Add "marketdata", "js/marketdata.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"
objCssIncludes.Add "tablesortercss", "/css/table_sort_blue.css"
%>
<!--#INCLUDE FILE="header.asp"-->





  <!--#INCLUDE FILE="admin/merchtools.asp"-->
<%

' multiple pages
currentpage = trim(request("currentpage"))
if Not IsNumeric(currentpage) Or len(currentpage) = 0 Then
	currentpage=1
Else
	currentpage=cint(currentpage)
	if currentpage<1 then currentpage=1
End If


' display todays prices
' if mutliple codes requested then restrict by that otherwise ALL codes.

id =  UCase(SafeSqlParameter(Request.QueryString("tradingcode")))
Set regEx = New RegExp 
regEx.Pattern = "^[a-zA-Z0-9]+$" 
isCodeValid = regEx.Test(id) 
If Not isCodeValid Then
  Response.Redirect "/"
  Response.End
End If

'If Not valid_security_code(id) Then 
'	Response.Write ("Invalid Security Code")
'	Response.End
'End If

coname = replace(request.querystring("coname") & " ","''","'")
		
Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
 
ConnPasswords.Open Application("nsx_ReaderConnectionString") 
SQL = "SELECT [tradingcode], CONVERT(VARCHAR(10), tradedatetime, 105) as daily, [open], [high], [low], [last], [last],[last]"
SQL = SQL & " FROM indexdaily"
SQL = SQL & " WHERE (tradingcode='" & SafeSqlParameter(id) & "') "
SQL = SQL & " ORDER BY tradingcode, tradedatetime DESC"


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
maxpagesize = 100
maxpages = round(.5 + (rc / maxpagesize),0)
st = (currentpage * maxpagesize ) - maxpagesize
fh = st + maxpagesize - 1
if fh > rc then fh = rc


%>



<%
'Server.Execute "side_menu.asp"
%>

<div class="hero-banner subpage">
    <div class="hero-banner-img"></div>
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder subpage">
            <div class="col-sm-12 hero-banner-left ">
                <h1><%= Server.HtmlEncode(ucase(id) & " "  & coname) %> - Daily Index History</h1>
            </div>
        </div>
    </div>
</div>

<div class="container subpage">
    <div class="row">
        <div class="col-sm-12">
            <div class="subpage-center">
            

  



<div class="pagebar" style="padding-bottom:15px;">Pages:&nbsp;
<%
If currentpage > 1 Then 
%>
  <a href="/prices_index_daily.asp?tradingcode=<%=id%>&amp;currentpage=<%=currentpage-1%>&amp;coname=<%=coname%>" title="Previous">Previous</a>                 
<%
End If
For ii = 1 To maxpages
  If ii = currentpage Then 
%>
  <span class="this-page"><%=ii%></span>
<%
  Else
%>
  <a href="/prices_index_daily.asp?tradingcode=<%=id%>&amp;currentpage=<%=ii%>&amp;coname=<%=coname%>" title="Page <%=ii%>"><%=ii%></a>
<%
  End If
Next
If maxpages > CurrentPage Then 
%>
  <a href="prices_index_daily.asp?tradingcode=<%=id%>&amp;currentpage=<%=currentpage+1%>&amp;coname=<%=coname%>" title="Next">Next</a>                 
<%
End If
%>
<a href="prices_index_history.asp?tradingcode=<%=id%>&amp;coname=<%=coname%>">Download Index History</a>
</div>

	
	

<table id="myTable" class="tablesorter" width="99%">
  <thead>
    <tr> 
      <th width="100">Date<br>&nbsp;</th>
      <th>Last<br>$</th>  
      <th>Daily Change<br>(last vs prv last)&nbsp;%</th> 
      <th>Change<br>(last vs open)&nbsp;%</th>
      <th>Open<br>&nbsp;</th>
      <th>High<br>&nbsp;</th>
      <th>Low<br>&nbsp;</th>
    </tr>   
  </thead>
  <tbody>       
        <%
    if WEOF then 
    	response.write "<tr><td colspan=12 class=plaintext>No price details available.</td</tr>" 
    else
    
    dailyprice0 = 0 
    dailyprice1 = 0
    i=0
    
    For ii = fh to st step -1

  		
  		
  		
     	  open = alldata(2,ii)
      	  last = alldata(5,ii)

      	  	dailyprice1 = last
      	  	dailychange = 0
   			if dailyprice0 <> 0 then
      	  		dailychange = 100*((dailyprice1-dailyprice0)/dailyprice0)
      	  	end if
      	  		dailyprice0 = dailyprice1
      	  		
      	  	if open = 0 then
				change = 0
			else
				change = 100*((last-open)/open)
			end if
			alldata(6,ii)=change
			alldata(7,ii)=dailychange
    
    next  
    
       for jj = st to fh

      	  nsxcode = alldata(0,jj)
      	  daily = alldata(1,jj)
      	  open = alldata(2,jj)
      	  high = alldata(3,jj)
      	  low = alldata(4,jj)
      	  last = alldata(5,jj)
       	 change = alldata(6,jj)
      	 dailychange = alldata(7,jj) 
      	  
		 if open = 0 then open = last
		 if low = 0 then low = last
		 if high = 0 then high = last
		 
		 
		 if (open<>0) and (open > high) then high = open
		 if (open<>0) and (open < low) then low = open
     	 
  
	 
		 if last = 0 then
		 	last = "-"
		 	else
		 	last = formatnumber(last,3)
		 end if
		 
		 if low = 0 then
		 	low = "-"
		 	else
		 	low = formatnumber(low,3)
		 end if
		 if high = 0 then
		 	high = "-"
		 	else
		 	high = formatnumber(high,3)
		 end if
		if open = 0 then
		 	open = "-"
		 	else
		 	open = formatnumber(open,3)
		 end if
		    
       
       if change > 0  then 
          	img1 = "<img border=""0"" src=""/images/up.gif"" style=""vertical-align:middle;padding-left:4px;"" alt="""">"
       	col2 = "green"
       
		elseif change < 0  then
			img1="<img border=""0"" src=""/images/down.gif"" style=""vertical-align:middle;padding-left:4px;"" alt="""">"
			col2 = "red"
		
		else
			col2 = "navy"
			img1 = "<img border=""0"" src=""/images/v2/level.gif"" style=""vertical-align:middle;padding-left:4px;"" alt="""">"
		end if
		if change = 0 then 
			change = "-"
			else
			change = formatnumber(change,2) & "%"
		end if
	
      	  
      	  ' do the daily price change formatting
      	  
      	  	
      	  if dailychange > 0  then 
          	img2 = "<img border=""0"" src=""/images/up.gif"" style=""vertical-align:middle;padding-left:4px;"" alt="""">"
       		col3 = "green"
       
		elseif dailychange < 0 then
			img2="<img border=""0"" src=""/images/down.gif"" style=""vertical-align:middle;padding-left:4px;"" alt="""">"
			col3 = "red"
		
		else
			col3 = "navy"
			img2 = "<img border=""0"" src=""/images/v2/level.gif"" style=""vertical-align:middle;padding-left:4px;"" alt="""">"
		end if
		if dailychange = 0 then 
			dailychange = "-"
			else
			dailychange = formatnumber(dailychange,2) & "%"
		end if
		
	
		
		
   cl = array("#EEEEEE","#FFFFFF")
	lap = (-lap)+1
  		c = " class=""odd"""
  		If i Mod 2 = 0 Then c = ""				
%>
    <tr <%=c%>>
      <td align="right" nowrap><%=fmtdate(daily)%>&nbsp;</td>
      <td align="right" valign="middle"><%=last%>&nbsp;</td>
      <td align="right" valign="middle"><font color="<%=col3%>"><%=dailychange%><%=img2%></font>&nbsp;</td>
      <td align="right" valign="middle"><font color="<%=col2%>"><%=change%><%=img1%></font>&nbsp;</td>
      <td align="right" valign="middle"><%=open%>&nbsp;</td>
      <td align="right" valign="middle"><%=high%>&nbsp;</td>
      <td align="right" valign="middle"><%=low%>&nbsp;</td>
    </tr>
<%
    	   i=i+1
    	  NEXT
    end if
%>
     
      
        
    
      
    </tbody>      
  </table>
  </div>
</div>
			</div></div>
<!--#INCLUDE FILE="footer.asp"-->