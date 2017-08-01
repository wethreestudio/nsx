<%

' Used to generate a job report email
' Run this function at the beginning and end of each job script
' Any jobs with a run_count of zero(0) are flagged a error
Function LogJob(JobName)
	Dim d
	Dim sql
	Dim conn

	Set conn = Server.CreateObject("ADODB.Connection")
	conn.Open Application("nsx_WriterConnectionString")

	d = FormatSQLDate(Date(), False)
	
	SQL = "SELECT job_name FROM job_log WHERE job_name='" & SafeSqlParameter(JobName) & "' AND run_date='" & d & "'"
	Set cmd = Server.CreateObject("ADODB.Recordset")
	cmd.Open SQL, conn
	If cmd.EOF And cmd.BOF Then
		SQL = "INSERT INTO job_log (job_name,run_date,run_count) VALUES ('" & SafeSqlParameter(JobName) & "','" & d & "',0)"
	Else
		SQL = "UPDATE job_log SET run_count=run_count+1 WHERE job_name='" & SafeSqlParameter(JobName) & "' AND run_date='" & d & "'"
	End If

	Set cmd2 = Server.CreateObject("ADODB.Command")
	cmd2.ActiveConnection = conn
	cmd2.CommandText = SQL
	cmd2.Execute()
	conn.Close
	Set conn = Nothing			
End Function

' Check a security code is in a valid format
function valid_security_code(code)
	code = UCase(Trim(code))
	Set RegularExpressionObject = New RegExp
	RegularExpressionObject.Pattern = "^[A-Z][A-Z0-9]{2,6}$"
	dim Matches : Set Matches = RegularExpressionObject.Execute(code)
	valid_security_code = (Matches.Count > 0)
end function

function valid_integer(intString)
	intString = UCase(Trim(intString))
	Set RegularExpressionObject = New RegExp
	RegularExpressionObject.Pattern = "^[0-9]{2,6}$"
	dim Matches : Set Matches = RegularExpressionObject.Execute(intString)
	valid_integer = (Matches.Count > 0)
end function

Function ImpolodeCollection(col,joiner)
  ret = ""
  For Each element In col
    If Len(element) > 0 Then 
		  ret = ret & element & joiner
		End If
  Next
  ret = Left(ret,Len(ret)-Len(joiner))
  ImpolodeCollection = ret
End Function

Sub NSXAnnouncemntCategorySelect(name,id,css_class)
%>
<select size="1" name="<%=name%>" id="<%=id%>" class="<%=css_class%>">
  <option value="">*** NSX Official list ***</option>
  <option>40010 NSX Admission to Official List</option>
  <option>40020 NSX Commencement of Official Quotation</option>
  <option>40021 NSX Trust Deed</option>
  <option>40022 NSX Articles of Association/Constitution</option>
  <option>40023 NSX Director's Declaration & Undertaking</option>
  <option>40024 NSX Nominated Adviser's Declaration</option>
  <option>40025 NSX Sponsor's Declaration</option>
  <option>40030 NSX Trading Halt</option>
  <option>40031 NSX Trading Halt Status</option>
  <option>40050 NSX Suspension from Official Quotation</option>
  <option>40051 NSX Reinstatement to Official Quotation</option>
  <option>40060 NSX Removal from Official List</option>
  <option>40080 NSX Query</option>
  <option>40081 NSX Response to Query</option>
  <option>40090 NSX Change to Basis of Quotation</option>
  <option>40099 NSX Official List Other</option>
  <option value="">*** Interests ***</option>
  <option>40110 NSX Becoming a Substantial Shareholder</option>
  <option>40120 NSX Change in Substantial Shareholder</option>
  <option>40130 NSX Ceasing to be a Substantial Shareholder</option>
  <option>40140 NSX Section 205G Notice Initial/Final Director's Interests</option>
  <option>40150 NSX Section 205G Notice Change in Director's Interests</option>
  <option>40199 NSX Interests Other</option>
  <option value="">*** Takeovers ***</option>
  <option>40220 NSX Takeover Offer Document</option>
  <option>40230 NSX Takover Offeree Director's Statement</option>
  <option>40240 NSX Variation of Takeover Offer</option>
  <option>40250 NSX Supplementary Bidder's Statement</option>
  <option>40260 NSX Supplementary Target's Statement</option>
  <option>40299 NSX Takeover Other</option>
  <option value="">*** Capital ***</option>
  <option>40310 NSX Bonus Issue</option>
  <option>40315 NSX Placement</option>
  <option>40320 NSX Issues to Public</option>
  <option>40325 NSX Capital Reconstruction</option>
  <option>40330 NSX New Issue Letter of Offer & Acceptance Form</option>
  <option>40335 NSX Alteration to Issued Capital</option>
  <option>40340 NSX Non Renounceable Issue</option>
  <option>40341 NSX Renounceable Issue</option>
  <option>40399 NSX Issued Capital Other</option>
  <option>40350 NSX Prospectus</option>
  <option>40360 NSX Disclosure Document</option>
  <option>40365 NSX Extension of Offer</option>
  <option>40370 NSX On Market BuyBack</option>
  <option>40380 NSX Exercise of Options</option>
  <option value="">*** Assets ***</option>
  <option>40410 NSX Asset Acquisition</option>
  <option>40420 NSX Asset Disposal</option>
  <option>40430 NSX Strategic Alliance Notice</option>
  <option>40440 NSX Joint Venture Notice</option>
  <option>40450 NSX Major Contract Notice</option>
  <option>40460 NSX Agreement Notice</option>
  <option>40470 NSX Patent Notice</option>
  <option>40490 NSX Merger Notice</option>
  <option>40499 NSX Assets Other</option>
  <option value="">*** Periodic Disclosure ***</option>
  <option>40510 NSX Annual Report</option>
  <option>40515 NSX Change of Balance Date</option>
  <option>40516 NSX Chairman's Address</option>
  <option>40517 NSX Letter to Shareholder's</option>
  <option>40520 NSX Top 20 Shareholders</option>
  <option>40530 NSX Preliminary/Final Statement</option>
  <option>40540 NSX Half Yearly Report</option>
  <option>40550 NSX Half Yearly Report Audit Review</option>
  <option>40560 NSX Quarterly Report</option>
  <option>40570 NSX Interest Payment Notification</option>
  <option>40571 NSX Dividend Notification</option>
  <option>40572 NSX NTA Notification</option>
  <option>40573 NSX Income Distribution Notification</option>
  <option>40585 NSX Drilling Program Report</option>
  <option>40586 NSX Clinical Trial Report</option>
  <option>40587 NSX Investor/Analyst Briefing</option>
  <option>40588 NSX Media Release</option>
  <option>40599 NSX Periodic Disclosure Other</option>
  <option value="">*** Details Notification *** </option>
  <option>40720 NSX Details of Company Address</option>
  <option>40730 NSX Details of Registered Office</option>
  <option>40750 NSX Details of Share Registry</option>
  <option>40760 NSX Company Name Change Notification</option>
  <option>40770 NSX Trading Code Change Notification</option>
  <option>40780 NSX Principal Activities Change Notification</option>
  <option>40799 NSX Details Other</option>
  <option value="">*** Officers and Entities *** </option>
  <option>40810 NSX Director Appointment/Resignation</option>
  <option>40811 NSX Chairman Appointment/Resignation</option>
  <option>40812 NSX CEO Appointment/Resignation</option>
  <option>40813 NSX Key Officer Appointment/Resignation</option>
  <option>40814 NSX Company Secretary Appointment/Resignation</option>
  <option>40815 NSX Sponsor Appointment/Resignation</option>
  <option>40816 NSX Nominated Adviser Appointment/Resignation</option>
  <option>40817 NSX Responsible Entity Appointment/Resignation</option>
  <option>40818 NSX Trustee Appointment/Resignation</option>
  <option>40819 NSX Trust Manager Appointment/Resignation</option>
  <option>40829 NSX Appointment/Resignation Other</option>
  <option value="">*** Meetings ***</option>
  <option>40910 NSX Notice of Annual General Meeting</option>
  <option>40920 NSX Notice of Extraordinary Meeting</option>
  <option>40930 NSX Results of Meeting</option>
  <option>40940 NSX Proxy Form</option>
  <option>40950 NSX Alteration to Notice of Meeting</option>
  <option>40999 NSX Notice of Meeting Other</option>
  <option value="">*** Other *** </option>
  <option>41901 NSX Censure / Disciplinary Action / Sanction Notice</option>
  <option>41911 NSX ASIC Determination</option>
  <option>41999 NSX General Market Disclosure Other</option>
</select>
<%
End Sub

Function CompleteURL()
  Dim prot
  Dim https
  Dim domainname
  Dim filename
  Dim querystring
  Dim port
  
  port = request.ServerVariables("SERVER_PORT")
  If port = 80 Or port = 443 Then
    port = ""
  Else
    port = ":" & port
  End If 
  prot = "http" 
  https = lcase(request.ServerVariables("HTTPS")) 
  if https <> "off" then prot = "https" 
  domainname = Request.ServerVariables("SERVER_NAME") 
  filename = Request.ServerVariables("SCRIPT_NAME") 
  querystring = Request.ServerVariables("QUERY_STRING") 
  CompleteURL = prot & "://" & domainname & port & filename & "?" & querystring	    
End Function

Function dateOrdinal(num)
   num = cint(num)
   select case num
      case 1,21,31
         dateOrdinal = num&"st"
      case 2,22
         dateOrdinal = num&"nd"
      case 3,23
         dateOrdinal = num&"rd"
      case else
         dateOrdinal = num&"th"
   end select
End Function

Function monthAbbreviation(num)
   num = cint(num)
   select case num
      case 1
         monthAbbreviation = "Jan"
      case 2
         monthAbbreviation = "Feb"
      case 3
         monthAbbreviation = "Mar"
      case 4
         monthAbbreviation = "Apr"
      case 5
         monthAbbreviation = "May"
      case 6
         monthAbbreviation = "Jun"
      case 7
         monthAbbreviation = "Jul"
      case 8
         monthAbbreviation = "Aug"
      case 9
         monthAbbreviation = "Sep"
      case 10
         monthAbbreviation = "Oct"
      case 11
         monthAbbreviation = "Nov" 
      case 12
         monthAbbreviation = "Dec"                                                                                           
      case else
         monthAbbreviation = "ERR"
   end select
End Function

Function timeAMPM(dt)
  h = Hour(dt)
  m = Minute(dt)
  ampm = "AM"
  If (h >= 12) Then
    ampm = "PM"
    If (h > 12) Then
      h = h - 12
    End If
  End If
  If m < 10 Then
    m = "0" & m
  End If
  timeAMPM = h & ":" & m & " " & ampm
End Function

Function Is_Mobile()
  Set Regex = New RegExp
  With Regex
    .Pattern = "(up.browser|up.link|mmp|symbian|smartphone|midp|wap|phone|windows ce|pda|mobile|mini|palm|ipad)"
    .IgnoreCase = True
    .Global = True
  End With
  Match = Regex.test(Request.ServerVariables("HTTP_USER_AGENT"))
  If Match then
    Is_Mobile = True
  Else
    Is_Mobile = False 
  End If
End Function

Function RecordWebError(title, objErr)
  Dim description
  Dim url
  Dim remote_ip
  Dim sql
  Dim cleanup_sql
	description=""
	If Not IsNull(objErr) Then
  	description = description & "ERROR CONDITIONS:" & vbCrLf & vbCrLf
  	description = description & "Error Number: " & objErr.Number & vbCrLf
  	description = description & "Error Description: " & objErr.Description & vbCrLf	
  	description = description & "Source: " & objErr.Source & vbCrLf
  	' description = description & "LineNumber: " & objErr.Line & vbCrLf
  End If
  description = description & "ALL_HTTP:" & vbCrLf & vbCrLf
	description = description & "Document: " & request.servervariables("ALL_HTTP") & vbCrLf
  url = CompleteURL()
  remote_ip =  request.servervariables("remote_addr")
  sql = "INSERT INTO [website_errors] ([title], [description], [url], [remote_ip], [created_on]) VALUES ('" & title & "','" & description & "','" & url & "','" & remote_ip & "',GETDATE());"
  cleanup_sql = "DELETE FROM [website_errors] WHERE DATEDIFF(day, GETDATE(), created_on) > 30;"
  On Error Resume Next
  Set ConnError = Server.CreateObject("ADODB.Connection")
  ConnError.Open Application("nsx_WriterConnectionString")
 	ConnError.Execute cleanup_sql
 	ConnError.Execute sql
  ConnError.Close
  Set ConnError = Nothing
  If Application("Send_Error_Email") = "yes" Or err.number <> 0 Then
    Set MyJMail2 = Server.CreateObject("JMail.SMTPMail")
    MyJMail2.ServerAddress = Application("SMTP_Server") & ":" & Application("SMTP_Port")
    MyJMail2.Sender = "errors@nsxa.com.au"
    MyJMail2.SenderName = "NSX Website Error"
    MyJMail2.AddRecipient Application("Error_Email")    
    MyJMail2.Subject="NSX Error Message - " & title
    MyJMail2.Priority = 1 'High importance!
    MyJMail2.Body = description
    MyJMail2.Execute
    set MyJMail2=nothing 
  End If
End Function

Function GetRows (Sql)
  Dim returnData
  Set conn = GetReaderConn()
  Set cmd = Server.CreateObject("ADODB.Recordset") 
  cmd.Open Sql, conn
  If Not cmd.EOF Then 
    returnData = cmd.getrows
  End If
  cmd.Close
  Set cmd = Nothing
  GetRows = returnData
End Function

Function MarketMode()
  SQL = "SELECT [sessionmode] "
  SQL = SQL & " FROM pricescurrent  "
  SQL = SQL & " WHERE (issuestatus='Active')"
  SQL = SQL & " ORDER BY tradingcode"
  PCRow = GetRows(SQL)
  PCRowCount = 0
  If VarType(PCRow) <> 0 Then PCRowCount = UBound(PCRow,2)
  marketstatus = 0
  For i = 0 To PCRowCount
    sessionmode = PCRow(0,i)
    If Trim(UCase(sessionmode)) = "NORMAL" Then marketstatus = marketstatus+1
  Next
  If marketstatus >=10  Then
  	sessionmode = "OPEN" 
  End If
  MarketMode = sessionmode
End Function

Function JSEncodeString(Unencoded)
  Unencoded = Replace(Unencoded, "''", "'")
  Unencoded = Replace(Unencoded, "'", "\'")
  Unencoded = Replace(Unencoded, vbCrLf, "\n")
  Unencoded = Replace(Unencoded, vbCr, "\n")
  Unencoded = Replace(Unencoded, vbLf, "\n")
  JSEncodeString = Unencoded
End Function

Function SafeSqlParameter(Param)
  Param = Replace(Param, "'", "''")
  SafeSqlParameter = Param
End Function

Function PrintAllCoIssues()
  Rows = GetRows("SELECT nsxcode,tradingcode,issuedescription FROM coIssues WHERE IssueStatus='active' ORDER BY nsxcode ASC")
  RowCount = Ubound(Rows,2) 
  For i = 0 to RowCount-1
    If Len(Rows(0,i)) > 0 Then
      Response.Write ("['" + Rows(0,i) & "','" & Rows(1,i) & "','" & JSEncodeString(Server.HTMLEncode(Rows(2,i))) & "']")
      If i < RowCount-1 Then
        Response.Write (",")
      End If
      Response.Write (VbCrLf)
    End If
  Next
End Function

Function GetCompanyChartData(Code, Records)
  Dim Sql
  Sql = "SELECT TOP " & Records & " DATEADD(dd, 0, DATEDIFF(dd, 0, [tradedatetime])) as daily, [last]"
  Sql = Sql & " FROM pricesdaily"
  SQL = Sql & " WHERE last > 0 AND (tradingcode='" & SafeSqlParameter(Code) & "') "
  Sql = Sql & " ORDER BY tradingcode, DATEADD(dd, 0, DATEDIFF(dd, 0, [tradedatetime])) DESC"
  GetCompanyChartData = GetChartData(Sql, 0)
End Function

Function GetIndexChartData (Code, Records)
'GetIndexChartData = GetChartData("SELECT TOP " & Records & " tradedatetime, [last] FROM indexdaily WHERE tradingcode='" & SafeSqlParameter(Code) & "' ORDER BY tradedatetime DESC", 1) '' LIMIT " & Records, 1)
GetIndexChartData = GetChartData("SELECT tradedatetime, [last] FROM indexdaily WHERE tradingcode='" & SafeSqlParameter(Code) & "' and tradedatetime >= DATEADD(month, -12, GETDATE()) ORDER BY tradedatetime DESC", 1) '' LIMIT " & Records, 1)
End Function

Function GetChartData(Sql, ChxIndex)
  Dim ret(2)
  Rows = GetRows(Sql)
  RowCount = Ubound(Rows,2)
  GapEvery = Round(0.5+((RowCount-1)/5),0)
  Dim XLabel 
  Dim ChartData
  Dim MinLast
  Dim MaxLast
  Dim LastDiff
  MaxLast = -1
  MinLast = 10000
  For i = 0 To RowCount-1
		Daily =  Rows(0,i)
		Last =  Rows(1,i)   
    If (i Mod GapEvery) = 0 Then
        XLabel = Day(Daily) & MonthName(Month(Daily),1) & "|" & XLabel
    End If 
    If Last < MinLast Then
      MinLast = Last
    End If
    If Last > MaxLast Then
      MaxLast = Last
    End If    
  Next
  LastDiff = MaxLast-MinLast
  MinLast = MinLast - (LastDiff*.1)
  MaxLast = MaxLast + (LastDiff*.1)
  If MinLast < 0 Then
    MinLast = 0
  End If
  LastDiff = MaxLast-MinLast
	For i = 0 To RowCount-1 
    Last =  Rows(1,i)
		If Len(ChartData) = 0 Then
        ChartData = FormatNumber( 100 * ((Last-MinLast)/LastDiff), 3 )
    Else
        ChartData = FormatNumber( 100 * ((Last-MinLast)/LastDiff), 3 ) & "," & ChartData  
    End If 
  Next   
  XLabel = Left(XLabel,Len(XLabel)-1)

  'x axis show last 4 quarterly of past 12 months as APR/17 etc 
  d=CDate(Date)
  x_year = DatePart("yyyy",d)
  x_year = Right(x_year,2)
  x_month = DatePart("m",d)
  'XLabel = ""

  XLabel = MonthName(DatePart("m",(DateAdd("m",-12,d))),True) & "." & Right(DatePart("yyyy",(DateAdd("m",-12,d))),2) & "|"
  XLabel = XLabel & MonthName(DatePart("m",(DateAdd("m",-9,d))),True) & "." + Right(DatePart("yyyy",(DateAdd("m",-9,d))),2) & "|"
  XLabel = XLabel & MonthName(DatePart("m",(DateAdd("m",-6,d))),True) & "." + Right(DatePart("yyyy",(DateAdd("m",-6,d))),2) & "|"
  XLabel = XLabel & MonthName(DatePart("m",(DateAdd("m",-3,d))),True) & "." + Right(DatePart("yyyy",(DateAdd("m",-3,d))),2) & "|"
  XLabel = XLabel & MonthName(DatePart("m",d),True) & "." + x_year

  ret(0) = ChartData
  ret(1) = XLabel
  ret(2) = ChxIndex & "," & MinLast & "," & MaxLast
  
  GetChartData =  ret
End Function

Function isEmailValid(email) 
    Set regEx = New RegExp 
    regEx.Pattern = "^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w{2,}$" 
    isEmailValid = regEx.Test(trim(email)) 
End Function 

' Strip HTML tags from text. Leaving plain text
Function stripTags(HTMLstring)
  On Error Resume Next
	Set RegularExpressionObject = New RegExp
	With RegularExpressionObject
		.Pattern = "<[^>]+>"
		.IgnoreCase = True
		.Global = True
	End With
	stripTags = RegularExpressionObject.Replace(HTMLstring, "")
	Set RegularExpressionObject = nothing
End Function

' Get a snippet of the paragraph
Function getSnippet(str, wordcount)
  stringSection = ""
  If Len(str) > 0 Then
	  words = Split(str)
	  
	  wordCounter = 0
	  
	  FOR EACH word IN words
		 stringSection = stringSection & word
		 wordCounter = wordCounter + 1
		 IF wordCounter >= wordcount THEN
			exit for
		 ELSE
			stringSection = stringSection & " "
		 END IF
	  NEXT
  End If
  getSnippet = stringSection
End Function

Function ConvertFromUTF8(sIn)
  Dim oIn: Set oIn = CreateObject("ADODB.Stream")
  oIn.Open
  oIn.CharSet = "utf-8"
  oIn.WriteText sIn
  oIn.Position = 0
  oIn.CharSet = "UTF-8"
  ConvertFromUTF8 = oIn.ReadText
  oIn.Close
End Function

Sub PrintSearchBox1(title,action,widthPx,caption,searchparamname)
%>
<div style="width:<%=widthPx%>px">
<form id="<%=stype%>search" name="<%=stype%>search" action="<%=action%>" method="get">
	<div class="sidebar_topArea">
    	<h2><%=title%></h2>
        	<div class="input_cont">
        	   <input type="text" id="<%=searchparamname%>" name="<%=searchparamname%>" class="inputtxtbox2">
             <input id="<%=stype%>searchgo" type="button" class="inputtBtn" value="" onclick="$('#<%=stype%>search').submit()">
             <div class="clearfix"></div>
          </div>
        <div class="bottom_link">
        	<%=caption%>&nbsp;
        </div>
    </div>
 </form>
</div>
<%
End Sub
 
Sub PrintSearchBox(title,stype,widthPx,caption,resultType)
%>
<script type="text/javascript">
$(document).ready(function() {
	$('#<%=stype%>searchbox').focus();
	$("#<%=stype%>searchbox").autocomplete("/default_search2.asp?t=<%=stype%>&rt=<%=resultType%>", {
		width: 331,
		selectFirst: false
	}); 
	$('#<%=stype%>search').submit(function() {
	//alert('TEST');
		//val foundsecurity = $("#<%=stype%>foundsecurity").val(); 
		return true;  
	});  
	$("#<%=stype%>searchbox").result(function(event, data, formatted) {
	 var d = data[1].split(';');
    $("#<%=stype%>id").val(d[0]);
    $("#<%=stype%>t").val(d[1]);
    $("#<%=stype%>search").submit();
	});
	
	jQuery('#<%=stype%>searchbox').click(function() { 
		selectAllText(jQuery(this)); 
	});
});


</script>
<div style="width:<%=widthPx%>px">
<form id="<%=stype%>search" name="<%=stype%>search" action="/search.asp" method="get">
	<div class="sidebar_topArea">
    	<h2><%=title%></h2>
        	<div class="input_cont">
        	<% If Len(resultType) > 0 Then %>
        	   <input name="st" type="hidden" id="<%=stype%>st" value="<%=resultType%>"/>
        	<% End If %>
        	   <input type="text" id="<%=stype%>searchbox" name="q" class="inputtxtbox2">
             <input id="<%=stype%>searchgo" type="button" class="inputtBtn" value="" onclick="$('#<%=stype%>search').submit()">
             <input name="id" type="hidden" id="<%=stype%>id"/>
             <input name="t" type="hidden" id="<%=stype%>t"/>
             <div class="clearfix"></div>
          </div>
        <div class="bottom_link">
        	<%=caption%>&nbsp;
        </div>
    </div>
 </form>
</div>
<%
End Sub

Function AdjTextArea(str)
  'Replace all vbCrLf with <BR>s
  
  'Replace all spaces with &nbsp;
'  str = Replace(str, " ", "&nbsp;")
'  str = Replace(str, "’", "&#39;")
'  str = Replace(str, "'", "&#39;")
  
  str = Server.HTMLEncode(str)
  str = Replace(str, vbCrLf, "<BR>")
  AdjTextArea = str
End Function

Function fmttf(xx)
  if len(xx)=0 or isnull(xx) or isempty(xx) then
  	fmttf = xx
  else
  	fmttf = left(weekdayname(weekday(xx)),3) & " " & Day(xx) & "-" & MonthName(Month(xx),True) & "-" & Year(xx) & " " & formatdatetime(xx,3) 
  end if
end Function




' Remove all HTML formatting tags from text.

Function HTMLDecode(sText)
    Dim regEx
    Dim matches
    Dim match
    sText = Replace(sText, "&quot;", Chr(34))
    sText = Replace(sText, "&lt;"  , Chr(60))
    sText = Replace(sText, "&gt;"  , Chr(62))
    sText = Replace(sText, "&amp;" , Chr(38))
    sText = Replace(sText, "&nbsp;", Chr(32))


    Set regEx= New RegExp

    With regEx
     .Pattern = "&#(\d+);" 'Match html unicode escapes
     .Global = True
    End With

    Set matches = regEx.Execute(sText)

    'Iterate over matches
    For Each match in matches
        'For each unicode match, replace the whole match, with the ChrW of the digits.

        sText = Replace(sText, match.Value, ChrW(match.SubMatches(0)))
    Next

    HTMLDecode = sText
End Function




Function RemoveHTML( strText )
	RemoveHTML = stripTags(strText)
End Function
%>

