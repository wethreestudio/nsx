<!--#INCLUDE FILE="include_all.asp"-->
<!--#INCLUDE FILE="admin/merchtools.asp"-->
<%
Function remcrlf(xx)
  remcrlf = replace(xx & " ",vbCRLF,"")
  remcrlf = trim(Replace(remcrlf & " ", "''", "'"))
End Function

is_odd = false

Function trClass()
	if is_odd then
		trClass = " class=""odd"""
	else
		trClass = ""
	end if
	is_odd = Not is_odd
End Function

coname = ""


id =  UCase(SafeSqlParameter(Request.QueryString("nsxcode")))
Set regEx = New RegExp 
regEx.Pattern = "^[a-zA-Z0-9]+$" 
isCodeValid = regEx.Test(id) 
If Not isCodeValid Then
  Response.Redirect "/"
  Response.End
End If



If Len(id) > 0 And Len(id) < 10 Then
	sql = "SELECT TOP 1 coName FROM coDetails WHERE nsxcode='" & SafeSqlParameter(id) & "'"
	Set conn = GetReaderConn()
	Set rs = conn.Execute(sql)
	If Not rs.EOF Then coname = rs("coName")
Else
	Response.Write "Security code not provided" : Response.End
End If


objCssIncludes.Add "table_sort_blue", "/css/table_sort_blue.css"
'coname=ucase(request("coname"))

' Get flash company info, Name of company, nsxcode, currentprice, highprice, % change, lowprice, volume, last trade date
security_code = UCase(Trim(SafeSqlParameter(request.querystring("nsxcode"))))
SQL_flash_data = "SELECT TOP 1 [last], [prvclose], [open], [high], [low], [volume], (SELECT TOP 1 tradedatetime FROM PricesTrades WHERE tradingcode='" & security_code & "' ORDER BY prid DESC), [issuedescription], [sessionmode],[logo_summary],[offexchangetrading_url] FROM PricesCurrent WHERE tradingcode='" & security_code & "'"
flash_data = GetRows(SQL_flash_data)
If VarType(flash_data) <> 0 Then
    flash_data_RowsCount = UBound(flash_data,2)
    If flash_data_RowsCount >= 0 Then
        flashdata_last = flash_data(0,0)
        flashdata_prvclose = flash_data(1,0)
        flashdata_opn = flash_data(2,0)
        flashdata_high = flash_data(3,0)
        flashdata_low = flash_data(4,0)
        flashdata_volume = flash_data(5,0)
        If IsDate(flash_data(6,0)) Then 
            flashdata_tradedatetime = CDate(flash_data(6,0))
        Else
          flashdata_tradedatetime = ""
        End If
        flashdata_coName = flash_data(7,0)
        Dim dchange2
        If flashdata_last = 0 Or flashdata_prvclose=0 Then
          dchange2 = 0
        Else
          'dchange2 = 100*((flashdata_last-flashdata_prvclose)/flashdata_prvclose)
            dchange2 = FormatPercent((flashdata_last-flashdata_prvclose)/flashdata_prvclose)
        End If

        If Not IsNumeric(flashdata_last) Then flashdata_last = 0
	    If Not IsNumeric(flashdata_open) Then flashdata_opn = 0
	    If Not IsNumeric(flashdata_high) Then flashdata_high = 0
	    If Not IsNumeric(flashdata_low) Then flashdata_low = 0
	    If Not IsNumeric(flashdata_volume) Then flashdata_volume = 0
	
	    If flashdata_last=0 Then flashdata_last=""
	    If flashdata_open=0 Then flashdata_open=""
	    If flashdata_high=0 Then flashdata_high=""
	    If flashdata_low=0 Then flashdata_low=""
	    If flashdata_volume=0 Then flashdata_volume=""
    End If
End If
 
 Function FormatPrice(p,d)
	If Len(p)>0 Then
		FormatPrice = FormatNumber(p,d)
	Else 
		FormatPrice = "-"
	End If
End Function
 
 
' End flash data

page_title = "Capital " & flashdata_coName & " " & UCase(security_code)
%>

<!--#INCLUDE FILE="header.asp"-->
<%
Server.Execute "side_menu.asp"
%>

<div class="hero-banner subpage">
    <div class="hero-banner-img"></div>
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder subpage">
            <div class="col-sm-12 hero-banner-left comp-info">
                <h1><%=flashdata_coName%></h1>
                <div class="comp-info">
                    <div class="comp-info-large">
                        <span class="large"><%=security_code%></span><span class="large"><%=FormatPrice(flashdata_last,3)%></span>
                    </div>
                    <div class="comp-info-small">
                        <ul>
                            <li>CHANGE<br /><span class="red"><%=dchange2%></span></li>
                            <li>LAST<br /><span><%=flashdata_last%></span></li>
                            <li>VOLUME<br /><span><%=flashdata_volume%></span></li>
                            <li>LAST TRADE<br /><span class="light"><%=flashdata_tradedatetime%></span></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%
Server.Execute "content_lower_nav.asp"
%>

<div class="container subpage">
    <div class="row">
        <div class="col-sm-12">
            <div class="subpage-center">
<div class="editarea">

<h1>Issued Capital Details - <%=coname%></h1>

<%
errmsg=""
currentpage = trim(request("currentpage"))
if Not IsNumeric(currentpage) Or len(currentpage) = 0 Then
	currentpage=1
Else
	currentpage=cint(currentpage)
	if currentpage<1 then currentpage=1
End If


uptodate = request.querystring("uptodate")
if len(id)=0 then id="pmi"
if len(uptodate)=0 then 
	srch =""
	else
	uptodate = cdate(uptodate)
	srch = " AND capitalexdate<='" & FormatSQLDate(uptodate,false) & "' "
end if

Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
 
ConnPasswords.Open Application("nsx_ReaderConnectionString")
SQL=" SELECT nsxcode,tradingcode,capitalexdate,capitaltype,capitaldescription,capitalchange,capitalannfile,capitalanndate,listedtype"
SQL = SQL & " FROM capital "
SQL = SQl & " WHERE (nsxcode='" & left(id,3) & "') " & srch
SQL = SQL & " ORDER BY tradingcode,capitalexdate,id"

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
maxpagesize = 1000
maxpages = round(.5 + (rc / maxpagesize),0)
st = (currentpage * maxpagesize ) - maxpagesize
fh = st + maxpagesize - 1
if fh > rc then fh = rc
 
    lap = 0
    cl = array("odd","even")
    
 


%>


<%  if WEOF then %>
	 
   There is no record available.
<% else %>
  
 
<table id="myTable" class="tablesorter" width="99%">
<thead>
        <tr>
          <th valign="top" align="left">Security</th>
		  <th valign="top" align="right">Event Date</th>
		  <th valign="top" align="left">Type</th>
		  <th valign="top" align="left">Description</th>
		  <th valign="top" align="right">Issued</th>
		  <th valign="top" align="right" nowrap="nowrap">Total Securities</th>
		  <th valign="top" align="left">Reference</th>
		  <th valign="top" align="left">Status</th>
        </tr>
		</thead>
       <tbody> 

  	<%
  	lap=1
      	  listed = 0
      	  unlisted = 0
      	  prvcode=""
      	 for jj = st to fh
      	 	tradingcode=alldata(1,jj)
      	 

if (prvcode<>tradingcode) and prvcode<>"" then
is_odd = false
%>
<tr>
	<td colspan="8" style="background-color:#C1C1C1;color:#fff;font-weight:bold;">
	Total <%=prvcode%> Listed: <%=formatnumber(listed,0)%><br>
	Total <%=prvcode%> Unlisted: <%=formatnumber(unlisted,0)%><br>
	Current <%=prvcode%> Issued Capital: <%=formatnumber(unlisted+listed,0)%>
	</td>
</tr>
<%
lap = 1
listed = 0
unlisted = 0 
end if
 
			nsxcode=alldata( 0,jj)
		
			capitalexdate=alldata(2,jj)
			if isdate(capitalexdate) then capitalexdate = fmtdate(capitalexdate)
			capitaltype=alldata(3,jj)
			capitaldescription=alldata(4,jj)
			capitalchange=formatnumber(alldata(5,jj),0)
			capitalannfile=trim(alldata(6,jj) & " ")
			capitalanndate=alldata(7,jj)
			listedtype=ucase(alldata(8,jj))
			if listedtype="LISTED" then 
				listed = listed + capitalchange
				else
				unlisted = unlisted + capitalchange
			end if
			if isdate(capitalanndate) then capitalanndate = fmtdate(capitalanndate)

			if capitalannfile <> "" then
			
			capurl = "ftp/news/"
			'if (instr(capitalannfile,"BSX"))>0 then capurl = "http://www.bsx.com.au/dataRepository/"
			
			capitalannfile="<a href=" & capurl & capitalannfile & " target=_blank><img src=images/icons/txt.gif border=0></a>"
			else
			capitalannfile=""
			end if
	  


				
    %>
  <tr <%=trClass()%>>
    <td valign="top" ><%=tradingcode%></td>
    <td align=right valign="top" nowrap><%=capitalexdate%></td>
    <td valign="top"><%=capitaltype%></td>
    <td valign="top"><%=capitaldescription%></td>
    <td valign="top" align="right" nowrap><%=capitalchange%></td>
    <td valign="top" align="right" nowrap><%=formatnumber(listed+unlisted,0)%></td>
    <td valign="top" align="center"><%=capitalannfile%></td>
    <td valign="top" align="center"><%=listedtype%></td>
  </tr>
    
<%

prvcode = tradingcode
NEXT %>

<tr>
	<td colspan="8" style="background-color:#C1C1C1;color:#fff;font-weight:bold;">
		Total <%=tradingcode%> Listed: <%=formatnumber(listed,0)%><br>
		Total <%=tradingcode%> Unlisted: <%=formatnumber(unlisted,0)%><br>
		Current <%=tradingcode%> Issued Capital: <%=formatnumber(unlisted+listed,0)%>
	</td>
</tr>

</tbody>
</table>


<%
	end if
	%>

</div>
</div>
</div>
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->