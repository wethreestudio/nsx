<!--#INCLUDE FILE="include_all.asp"-->
<!--#INCLUDE FILE="admin/merchtools.asp"-->
<%
Function remcrlf(xx)
  remcrlf = replace(xx & " ",vbCRLF,"")
  remcrlf = trim(Replace(remcrlf & " ", "''", "'"))
End Function

'id = request.querystring("nsxcode")

'If Not valid_security_code(id) Then 
'	Response.Write ("Invalid Security Code")
'	Response.End
'End If
id =  UCase(SafeSqlParameter(Request.QueryString("nsxcode")))
Set regEx = New RegExp 
regEx.Pattern = "^[a-zA-Z0-9]+$" 
isCodeValid = regEx.Test(id) 
If Not isCodeValid Then
  Response.Redirect "/"
  Response.End
End If

coname=ucase(request("coname"))


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

page_title = "Dividends " & flashdata_coName & " " & UCase(security_code)
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

<h1><%=UCase(id)%> - <%=coname%> - Dividend Details</h1>
<div class="table-responsive"><table border="0" width="100%" cellspacing="0" cellpadding="0">


  <tr>
    <td class="plaintext" valign="top" bgcolor="#FFFFFF">

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
SQL=" SELECT nsxcode,tradingcode,DivType,DivExDate,DivAnnDate,DivPayDate,DivBooksCloseDate,DivRecDate,DivFreq,DivPeriodCovered,DivFrankRate,DivDesc,DivAmt,DivTaxRate,DivAnnFile"
SQL = SQL & " FROM dividends "
SQL = SQl & " WHERE (nsxcode='" & SafeSqlParameter(left(id,3)) & "') " & srch
SQL = SQL & " ORDER BY tradingcode,divanndate DESC,id DESC"

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
    prvcode=""
 


%>



<%  if WEOF then %>
 There is no record available.
  <% else %>
<div class="table-responsive"><table id="myTable" class="tablesorter" width="99%">

<thead>
  <tr>
    <th  >Security</th>
    <th  align=right >Amount $/s</th>
    <th  align=right>Ex-Date</th>
    <th  align=right >Record Date</th>
    <th   align=right>Pay Date</th>
    <th  align=right>Franking %</th>
	<th   align=right>Type</th>
    <th >Reference</th>
  </tr>
 </thead>
     <tfoot>
    <tr>
        <td colspan="8"></td>
    </tr>
    </tfoot>

 <tbody>
  	<%
  	lap=1
      	 
      	 for jj = st to fh
      	 tradingcode=alldata(1,jj)
      	 if (prvcode<>tradingcode) and prvcode<>"" then

%>
 <tr><td class=plaintext colspan=8>
<hr noshade color=#808080 width=99% size=1>
</td></tr>
<%
lap = 1
end if

      	 
      	 
      	 
      
 			nsxcode=alldata( 0,jj)
 			DivType=alldata(2,jj)
 			DivExDate=alldata(3,jj)
 			if isdate(DivExDate) then DivExDate = fmtdate(DivExDate)
 			DivAnnDate=alldata(4,jj)
 			if isdate(DivAnnDate) then DivAnnDate = fmtdate(DivAnnDate)
 			DivPayDate=alldata(5,jj)
 			if isdate(DivPayDate) then DivPayDate = fmtdate(DivPayDate)
 			DivBooksCloseDate=alldata(7,jj)
 			if isdate(DivBooksCloseDate) then DivBooksCloseDate= fmtdate(DivBooksCloseDate)
 			DivRecDate=alldata(7,jj)
 			if isdate(DivRecDate) then DivRecDate= fmtdate(DivRecDate)
 			DivFreq=alldata(8,jj)
 			DivPeriodCovered=alldata(9,jj)
 			DivFrankRate=alldata(10,jj) * 100
 			DivDesc=alldata(11,jj)
 			DivAmt=alldata(12,jj)
 			if divamt=0 or divamt=null then divamt="No Dividend"
 			DivTaxRate=alldata(13,jj)
 			DivAnnFile=alldata(14,jj)
			
			
			divurl = "ftp/news/"
			'if (instr(divannfile,"BSX"))>0 then divurl = "http://www.bsx.com.au/dataRepository/"

			
			if divannfile <> "" then
			divannfile="<a href=" & divurl & divannfile & " target=_blank><img src=images/icons/txt.gif border=0></a>"
			else
			divannfile=""
			end if
	  

				
    %>
  <tr class="<%=cl(lap)%>" >
       <td  valign="top"  align=left><%=tradingcode%>&nbsp;</td>
    <td valign="top" align=right><%=DivAmt%>&nbsp;</td>
    <td valign="top"  align=right><%=DivExDate%>&nbsp;</td>
    <td valign="top" align=right><%=DivRecDate%>&nbsp;</td>
    <td valign="top"  align=right><%=DivPayDate%>&nbsp;</td>
    <td valign="top" align=right><%=DivFrankRate%>&nbsp;</td>
    <td valign="top"  align=right><%=DivType%>&nbsp;</td>
    <td valign="top"  align=center><%=divannfile%>&nbsp;</td>

  </tr>
 
  <%lap = (-lap)+1%>
    
<%

prvcode = tradingcode
NEXT %>

  <tr>
<td colspan=8>
<hr noshade color=#808080 width=99% size=1>
</td></tr>
</tbody>
</table></div>

<%
	end if
	%>
	</tbody>
</table></div>

</div>
</div>
</div>
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->