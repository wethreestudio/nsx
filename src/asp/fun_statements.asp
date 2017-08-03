<%
'response.write "here" 
'nsxcode = request.querystring("nsxcode")
'response.write nsxcode
'response.end

%>
<!--#INCLUDE FILE="include_all.asp"-->
<!--#INCLUDE FILE="admin/merchtools.asp"-->
<%

objCssIncludes.Add "fun_statements", "/css/fun_statements.css"

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

page_title = "Financials " & flashdata_coName & " " & UCase(security_code)

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
<%

nsxcode = request.querystring("nsxcode")
compact = request.querystring("compact")
if vartype(compact)<2 then 
	compact = 1
	else
	compact = 0
end if
compact=1

Set regEx = New RegExp 
regEx.Pattern = "^[a-zA-Z0-9]+$" 
isCodeValid = regEx.Test(nsxcode) 
If Not isCodeValid Then
  Response.Redirect "/"
  Response.End
End If

Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set rs = Server.CreateObject("ADODB.Recordset")
ConnPasswords.Open Application("nsx_ReaderConnectionString")

SQL=SQL & "SELECT TOP 8 fun_statementheader.ID, fun_statementheader.IssuerCode, fun_statementheader.BalanceDate, fun_statementheader.SourceDocument, fun_statementheader.ReportingCurrency, coDetails.coName,fun_statementheader.ExchangeRate,fun_statementheader.ReportingUnits,coDetails.agLogo "
SQL=SQL & "FROM coDetails RIGHT JOIN fun_statementheader ON coDetails.nsxcode = fun_statementheader.IssuerCode "
SQL=SQL & "WHERE (((fun_statementheader.IssuerCode)='" & nsxcode & "'))"
SQL=SQL & "ORDER BY fun_statementheader.IssuerCode, fun_statementheader.BalanceDate DESC"

Set rs = ConnPasswords.execute(SQL)

WEOF = rs.EOF
if not WEOF then 
	AnnRows = rs.getrows()
	AnnRowsCount = ubound(AnnRows,2) 
	else
	AnnRowsCount = -1
end if

rs.close
set rs = nothing


'If VarType(AnnRows) <> 0 Then AnnRowsCount = UBound(AnnRows,2)



tda = "<td class='tabletext'>"
tdb = "</td>"
tra = "<tr >"
trb = "</tr>"
tha = "<thead>"
thb = "</thead>"
br = "<br />"
statement_header = ""

If AnnRowsCount >= 0 Then
Issuername = AnnRows(5,0)
issuercode = AnnRows(1,0)
Logo = trim(AnnRows(8,0) & " " )
response.write "<h1>Annual Statements for " & IssuerName & " (" & issuercode & ")</h1>"
response.write "<div  style='padding-top;8px;padding-bottom:8px;'><div class="table-responsive"><table width='99%'><tr>"
'response.write "<span style='display:inline-block; vertical-align:bottom;'>"
if len(Logo)> 0 then
	response.write "<td width='50%'><img src='/images/company_images/" & logo &"' ></td>"
	else
	response.write "<td width='50%'>&nbsp;</td>"
end if

response.write "<td width='50%' align=right style='vertical-align:bottom'><a href='fun_statement_download.asp?nsxcode=" & nsxcode & "&format=XLS' class='blue-link'>View Spreadsheet</a></td>"
response.write "</tr></table></div></div>"
Dim table_values
table_values=array()
ItemRowsCount = 200 ' should be same as number of accounts in chart of accounts.  Need to make this dynamic.
ReDim table_values(AnnRowsCount+3,ItemRowsCount+3)

  
	i = 0
  For i = 0 To  AnnRowsCount
 	
	statement_id = AnnRows(0,i)
    issuercode = AnnRows(1,i)
    balancedate = AnnRows(2,i)
	if isdate(balancedate) then
		balancedate_fmt = day(balancedate) & "-" & monthname(month(balancedate),1) & "<br />" & year(balancedate)
		else
		balance_fmt = balancedate
	end if
    sourcedocument = AnnRows(3,i)
	if len(sourcedocument) <> 0 then sourcedocument = "<a href='ftp/news/" & sourcedocument & "' target=_blank><img src='images/icons/pdficon_small.png' border=0 title='Source " & statement_id & ": " & sourcedocument & "'></a>"
    reportingcurrency = ucase(AnnRows(4,i))
    Issuername = AnnRows(5,i)
	ExchangeRate = AnnRows(6,i)
	if vartype(ExchangeRate)<2 then ExchangeRate = 1
	ReportingUnits = AnnRows(7,i)
	if vartype(ReportingUnits)<2 then reportingunits = 1
	
	Select case ReportingUnits
		case 1000
			ReportingUnits_fmt = "'000"
		case 1
			ReportingUnits_fmt = ""
		case 1000000
			ReportingUnits_fmt = "'mil."
		case 1000000000
			ReportingUnits_fmt = "'bil."
		case else
			ReportingUnits_fmt = ReportingUnits
	End Select
		
		

	 if i = 0 then 
		table_values(i,0) = "headerflagtext"
		table_values(i+1,0) = "totalflag"
		table_values(i+2,0) = ""
		table_values(i+3,0) = balancedate_fmt
		table_values(i+3,1) = sourcedocument
		table_values(i+3,2) = reportingcurrency & ReportingUnits_fmt
		table_values(1,1) = ""
		table_values(1,2) = ""
		table_values(2,1) = ""
		table_values(2,2) = ""
		
		else

		table_values(i+3,0) = balancedate_fmt
		table_values(i+3,1) = sourcedocument
		table_values(i+3,2) = reportingcurrency & ReportingUnits_fmt
	end if	
 
	' join on each statement_item to the header in columns. only way seems to loop?
	' some problem with ODBC driver
	Set rs = Server.CreateObject("ADODB.Recordset")
	
	SQL2 = "SELECT fun_chartofaccounts.chartofaccounts_id, fun_chartofaccounts.AccountTitle, fun_chartofaccounts.HeaderFlagText, fun_chartofaccounts.TotalsFlag, Items.item_value "
	SQL2 = SQL2 & "FROM fun_chartofaccounts LEFT JOIN (SELECT * FROM fun_statement_item WHERE (fun_statement_item.statementheader_id=" & statement_id & "))  AS Items ON fun_chartofaccounts.chartofaccounts_id = Items.chartofaccounts_id "
	SQL2 = SQL2 & "WHERE fun_chartofaccounts.sortblock<>4 "
	SQL2 = SQL2 & "ORDER BY fun_chartofaccounts.sortblock ASC,fun_chartofaccounts.chartofaccounts_id ASC"

	
	
	
	rs.CacheSize=100 
	Set rs = ConnPasswords.execute(SQL2)	
	WEOF = rs.EOF

	if not WEOF then 
		ItemRows = rs.getrows()
		ItemRowsCount = ubound(ItemRows,2) 
	else
		ItemRowsCount = 0
	end if
	rs.close
	set rs = nothing
	
	' if no statement items found then don't display
	on error resume next
	
		j = 0
		lap = 0
		for j = 0 to ItemRowsCount
		lap = lap +1

			if i = 0 then ' first record has the header info we need to discard the rest
				
				chartofaccounts_id = ItemRows(0,j)
				accounttitle = ItemRows(1,j)
				headerflagtext = ItemRows(2,j)
				totalsflag = ItemRows(3,j)
				item_value  = ItemRows(4,j)

				if (item_value = 0) or vartype(item_value) = 1 then item_value = ""

				table_values(i+0,j+3) = headerflagtext
				table_values(i+1,j+3) = totalsflag
				table_values(i+2,j+3) = accounttitle '"(" & chartofaccounts_id & ") " & accounttitle 
				'if len(item_value) > 0 then item_value = item_value / (1000/ReportingUnits)
				table_values(i+3,j+3) = item_value '& " (" & chartofaccounts_id & ")"
				
			else
				chartofaccounts_id = ItemRows(0,j)
				item_value  = ItemRows(4,j)
				if (item_value = 0) or vartype(item_value) = 1 then item_value = ""
				'if len(item_value) > 0 then item_value = item_value / (1000/ReportingUnits)
				table_values(i+3,j+3) = item_value '& " (" & chartofaccounts_id & ")"
			end if
			
		Next ' j

  Next '  i

  
  ' format statement array for output
  table_values_rows = ubound(table_values,2)
  table_values_cols = AnnRowsCount+3
  response.write "<div class="table-responsive"><table class='tablesorter' id='myTable' width='99%'>" & vbCRLF
  lap = 1
  cl = array("odd","even")
  for z = 0 to table_values_rows


		y = 0
		cell_counter = 0
		cell_fmt = ""
		for y = 0 to table_values_cols
			' dont display rows with zero values
			' dont display null rows
			' display header values
			' check for new row and add in attributes
			cell_totals = table_values(1,z)
			'response.write cell_totals
			if cell_totals = "True" then 
				cell_totals_fmt = "headertotals"
				else
				cell_totals_fmt = ""
			end if
			cell_header = trim(table_values(0,z) & "")
			if len(cell_header)=0 then cell_header="h4"
			cell_value = table_values(y,z)
			cell_type = vartype(cell_value)
			
			' format header values
			if y = 0 then 
				' first column is text labels
				tra = "<tr >"
				h1 = false
				h2 = false
				h3 = false
				h4 = false
				cell_tot = false
				'response.write cell_header
				if len(cell_header)=0 then cell_header="h3"
				'response.write cell_header
					SELECT case cell_header
						CASE "h1"
							h1 = true
						    tra = "<tr class='fun_h1 " & cl(lap) & "'>"
							
						CASE "h2"
							h2 = true
							tra = "<tr class='fun_h2 " & cl(lap) & "'>"
						CASE "h3"
							h3 = true
							tra = "<tr class='fun_h3 " & cl(lap) & "'>"
							
						CASE ELSE
							h4 = true
							tra = "<tr class='fun_h4 " & cl(lap) & "'>"
					END SELECT
					
			else
				if cell_header <> "h1" then
					tra = "<tr class=" & cl(lap) & ">"
					else
					tra = "<tr >"
					lap = 1
				end if
					
				'trb = ""
			end if	
			'  format cell values from first principles due to mixed data
			if (cell_type > 1) and (y > 1) then ' not empty or null
				if cell_type = 6 then  'money type
					tda = "<td align=right class='" & cell_totals_fmt & " " & "fun_" & cell_header & "   ' >"
					if cell_value > 999 or cell_value < -999 then 
						cell_fmt = cell_fmt &  tda & formatnumber(cell_value,0,,-1) & tdb
					else
						if cell_value < 0 then
						cell_fmt = cell_fmt &  tda & "(" & abs(cell_value) & ")" & tdb
						else
						cell_fmt = cell_fmt &  tda  & cell_value & tdb
						end if
					end if


				else
						if z > 2 then
							' counter to check if entire row has zero values, if so don't display
							if cell_type=8 and (not h1)  and (not h2) and (not cell_total) then cell_counter = cell_counter + 1
							tda = "<td class='" &  "fun_" & cell_header & "  ' >"							
							cell_fmt = cell_fmt & tda & cell_value & tdb
						else
							tda = "<th align=right class='' >"
							cell_fmt = cell_fmt & tda & cell_value & "</th>" & vbCRLF
						end if
				end if
			end if
		NEXT ' y cell
		if z < 3 then
			response.write tra
			response.write "<thead>" & vbCRLF
			response.write cell_fmt 
			response.write "</thead>" & vbCRLF
			response.write trb
		else
			if (cell_counter <= AnnRowsCount+1) and (compact=1) then 
				'response.write cell_counter

					if len(cell_fmt)<>0 then ' entire blank row
						response.write tra & cell_fmt &trb & vbCRLF
						lap = (-lap)+1 ' for odd / even
					end if
				else
				'response.write cell_counter
				'response.write  tra & cell_fmt & trb & vbCRLF
			end if
		end if
		if z = 2 then response.write "<tbody>"
	NEXT ' z row
	response.write "</tbody></table></div>"


  
  Else
  response.write "No statements found"

  
End If

%>
</div>
</div>
</div>
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->