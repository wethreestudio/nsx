<!--#INCLUDE FILE="include_all.asp"-->
<%
' page_title = "Why List on NSX"
' meta_description = ""
' alow_robots = "no"
objJsIncludes.Add "cms_page", "/js/cms_page.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"

page = Request.QueryString("page")
page_size = 20

Set regEx = New RegExp 
regEx.Pattern = "^[\w_\-]+$" 
isPageValid = regEx.Test(page) 
If Not isPageValid Then
  Response.Redirect "/"
End If

page = CInt(page)

objJsIncludes.Add "tablesorter", "/js/jquery.tablesorter.min.js"
objJsIncludes.Add "tablesorterp", "/js/addons/pager/jquery.tablesorter.pager.js"
objCssIncludes.Add "tablesortercss", "/css/table_sort_blue.css"
objCssIncludes.Add "tablesorterpcss", "/js/addons/pager/jquery.tablesorter.pager.css"

bySecurity = Request.QueryString("bysecurity") ' List brokers by security

alow_robots = "no" ' Because this page takes too long

%>
<!--#INCLUDE FILE="header.asp"-->
<script type="text/javascript" >
$(document).ready(function() 
    { 
        $("#myTable").tablesorter( { widgets: ["zebra"] } );
    } 
);
</script>

<div style="background-color:#fff; padding-bottom:20px;">
<%
Server.Execute "side_menu.asp"
%>

<div style="margin-left:260px; margin-right:12px;" >
<div class="prop min600px"></div>
<%
  RenderContent page,"editarea" 
%>




<%

daylightsaving=0
if application("nsx_daylight_saving")=true then
	daylightsaving = 1/24
	else
	daylightsaving = 0
end if

errmsg=""
currentpage = trim(request("currentpage"))
if len(currentpage)=0 then currentpage=1
currentpage=cint(currentpage)
if currentpage<1 then currentpage=1

' if multiple codes requested then restrict by that otherwise ALL codes.
nsxcodes=trim(request.querystring("nsxcode") & " ")
if len(nsxcodes)=0 then
	nsxcodes=trim(request.form("nsxcode") & " ")
end if
group = request("group")
if group = "yes"  then
	srchgrp="nsxcode"
	else
	srchgrp="tradingcode"
end if


' construct search for multiple codes.
next_page = Request.QuerString("next")
prev_page = Request.QuerString("prev")
' yyyy-MM-dd HH:mm:ss
Set regEx = New RegExp 
regEx.Pattern = "^[0-9]{4}-[0-9]{2}-[0-9]{2}(\s)?$" 
nextvalid = regEx.Test(next_page) 
prevvalid = regEx.Test(prev_page) 

srch = " WHERE "
if nextvalid then 
	srch = srch & " coAnn.annRelease > '" & next_page & "' AND "
elseif prevvalid then
	srch = srch & " coAnn.annRelease < '" & prev_page & "' AND "
end if


srch = srch & " coAnn.annDisplay=1 AND coAnn.annRelease is not null "
if len(nsxcodes)= 0 then srch = srch & " AND (coAnn.DisplayBoard<>'SIMV')" ' only allow sim securities if explicitly requested.
if len(nsxcodes)<>0 then
	nsxcodes=replace(nsxcodes," ","")
	nsxcodes=replace(nsxcodes,";",",")
	nsxcodes=replace(nsxcodes,vbCRLF,"")
	nsxcodes=replace(nsxcodes,".","")
	nsxcodes=replace(nsxcodes,",,",",")

	srch = srch & " AND "
	nsxcode=split(nsxcodes,",")
	for jj = 0 to ubound(nsxcode)
		srch = srch & "(coAnn." & srchgrp & "='" & SafeSqlParameter(nsxcode(jj)) & "') OR "
	next
	srch = left(srch,len(srch)-4)
		
end if

displayboard=ucase(trim(request("region")))
if len(displayboard)<>0 then srch = srch & " AND (coissues.displayboard = '" & Trim(SafeSqlParameter(displayboard)) & "') "

Set conn = Server.CreateObject("ADODB.Connection")
conn.Open Application("nsx_ReaderConnectionString")

' IDS

Set rs1 = Server.CreateObject("ADODB.Recordset")


SQL = "SELECT TOP 20 CONVERT(char(20), coAnn.annRelease,126) as rel_date "
SQL = SQL & " FROM coIssues INNER JOIN coAnn ON coIssues.tradingcode = coAnn.tradingcode "
SQL = SQL & srch 
SQL = SQL & " ORDER BY coAnn.annRelease DESC"
'response.write SQL : Response.End

rs1.Open SQL, conn, adOpenForwardOnly, adLockReadOnly
prev_date = rs1("rel_date")
next_date = rs1("rel_date")

While Not rs1.EOF
	next_date = rs1("rel_date")
Wend
rs1.Close
Set rs1 = Nothing

If Len(Request.QuerString("next")) > 0 Then
%>



<%
End If


Set rs = Server.CreateObject("ADODB.Recordset")


SQL = "SELECT TOP 20 coAnn.annid,annPrecise,annFile,annRelease,annTitle,annFileSize,coAnn.tradingcode,coAnn.nsxcode,annUpload,coIssues.IssueDescription, annPriceSensitive, coissues.displayboard, CONVERT(VARCHAR(20), annUpload, 100) AS annReleasef "
SQL = SQL & " FROM coIssues INNER JOIN coAnn ON coIssues.tradingcode = coAnn.tradingcode "
SQL = SQL & srch '" WHERE coAnn.annid IN (" & page_ids & ") "
SQL = SQL & " ORDER BY coAnn.annRelease DESC"
'response.write SQL : Response.End

rs.Open SQL, conn, adOpenForwardOnly, adLockReadOnly

Dim alt
alt = true
%>
<table class="tablesorter">
<thead> 
<tr> 
    <th>Issuer</th>
	<th>&nbsp;</th> 
    <th>Headline</th>  
    <th>Date</th> 
</tr> 
</thead> 
<tbody>
<%
While Not rs.EOF
	altclass = " class=""odd"""
	If alt Then altClass = " class=""even"""
	alt = Not alt	
%>
	<tr<%=altClass%>>
      
		<td><a href="/company_details.asp?nsxcode=<%=Left(rs("nsxcode"),3)%>"><%=Left(rs("nsxcode"),3)%></a>
<%
	If rs("annPriceSensitive") = True Then
		Response.Write "<br><font color=green size=-2><b>Price<br>Sensitive</b></font>"
	End If
%>
		<td>
			<%=rs("IssueDescription")%>
		</td>
		</td>
		<td style="white-space:normal;">
			<div class="ann_list_div">
			<a target="_blank" title="<%=rs("annPrecise")%>" href="/ftp/news/<%=rs("annFile")%>"><%=rs("annPrecise")%></a></div>
			<%=rs("annTitle")%>
		</td>
		<td width="155" nowrap="nowrap">
			<%=rs("annReleasef")%>
		</td>
		</tr>
<%
	rs.MoveNext
Wend

rs.Close
Set rs = Nothing
conn.Close
Set conn = Nothing
%>
</tbody>


</table>


</div>




</div>   
</div>      

<!--#INCLUDE FILE="footer.asp"-->