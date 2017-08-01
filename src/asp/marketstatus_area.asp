<!--#INCLUDE FILE="functions.asp"-->
<!--#INCLUDE FILE="globals.asp"--><%
mode = ""
checkstatus = False


If IsEmpty(Application("marketstatus_update")) Or IsEmpty(Application("marketstatus")) Then
	checkstatus = True
Else
	If DateDiff("n",Application("marketstatus_update"),Now()) > 5 Then
		checkstatus = True
	End If
End If

If checkstatus Then

Response.Write ("Checking Status<br>")
if false then
	Set conn = Server.CreateObject("ADODB.Connection")
	conn.Open Application("nsx_ReaderConnectionString")
	Set rs = Server.CreateObject("ADODB.Recordset")
	rs.Open "SELECT sessionmode FROM pricescurrent WHERE (issuestatus='Active') ORDER BY tradingcode", conn
	marketstatus = 0
	While Not rs.EOF
		sessionmode = rs("sessionmode")
		If Trim(UCase(sessionmode)) = "NORMAL" Then 
			marketstatus = marketstatus+1
		End If
		rs.MoveNext
	Wend
	mode = sessionmode
	If marketstatus >=10 Then sessionmode = "OPEN" 
	rs.Close
	Set rs = Nothing
	conn.Close
	Set conn = Nothing
	Application("marketstatus_update") = Now()
	Application("marketstatus") = mode
	end if
	Application("marketstatus_update") = Now()
	Application("marketstatus") = "open"	
	mode ="normal"
Else
	mode = Application("marketstatus")
End If


mode = trim(lcase(mode))
img = "market_amber.png"
sessionmode = ""
If mode = "open" Then
	img = "market_green.png"
	sessionmode = "Normal (NML)"
ElseIf mode = "halt" Then 
	img = "market_amber.png"
	sessionmode="Enquiry Only (ENQ)"
ElseIf mode = "aha" Then 
	img = "market_amber.png"
	sessionmode="After Hours Adjust (AHA)"
ElseIf mode = "preopen" Then
	img = "market_amber.png" 
	sessionmode="Pre-Open (PRE)"
ElseIf mode = "enquiry" Then 
	img = "market_amber.png"
	sessionmode="Enquiry Only (ENQ)"
Else
	If Hour(Now()) > 17 Then
		img = "market_red.png"
		sessionmode="Shutdown"
	Else
		img = "market_amber.png"
		sessionmode="Enquiry Only (ENQ)"
	End If
End If
%><a href="/investors/trading_hours_and_calendar"><img src="/img/<%=img%>" alt="" width="9" height="9" style="padding-right:4px;top:-7px;"></a><%=systemTime%>