<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>New Page 1</title>
</head>

<body>

<table width=500>
<tr>
<td>

<%
id = ucase(request("tradingcode"))
coname = replace(request("coname") & " ","''","`")
coname = replace(request("coname") & " ","'","")
tday = 260
%>
<%
    tradingcode=request.querystring("tradingcode")
    
    %>
    
    <%

' display daily prices chart
' if multiple codes requested then restrict by that otherwise ALL codes.
id = ucase(request.querystring("tradingcode"))
		
Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
'ConnPasswords.Open Application("nsx_ReaderConnectionString")   

  
ConnPasswords.Open Application("nsx_ReaderConnectionString") 



SQL = "SELECT TOP " & tday & " tradedatetime,[open], [high] , [low], [last],max(last),min(last) "
SQL = SQL & " FROM indexdaily  "
SQL = SQL & " WHERE (tradingcode='" & id & "') "
SQL = SQL & " ORDER BY tradedatetime ASC"


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
	maxheight = 300
	maxwidth = 400
	response.write rc
if rc>0 then

	For jj = 0 to rc
	
		daily =  alldata(0,jj)
		open = alldata(1,jj)
		high = alldata(2,jj)
		low = alldata(3,jj)
		last =  alldata(4,jj)
		maxlast = alldata(5,jj)
		minlast= alldata(6,jj)
		height= last
		response.write last

		'this sets the value and low value in the correct sequence for the chart
		
		
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
		
		response.write "<img src=images/v2/line.jpg width=1 height=" & height & " align=bottom >"


		
		
	NEXT
end if
	observations = jj
	alldaily = replace(alldaily,"/","-")
	'sdate = alldata(0,rc-1) ' start date
	'edate = alldata(0,0)  ' end date
%>



</td>

</tr></table>


<p>&test;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>


<p><img border="0" src="images/v2/line.jpg" width="10" height="1"></p>


</body>

</html>