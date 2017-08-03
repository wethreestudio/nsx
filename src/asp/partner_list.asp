<!--#INCLUDE FILE="include_all.asp"-->

<%

'< '% CHECKFOR = "CSX" % >
'< !-- # INCLUDE FILE="member_check.asp "-- >

page_title = "Partner Services"
' meta_description = ""
' alow_robots = "no"
objJsIncludes.Add "cms_page", "/js/cms_page.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"

'page = Request.QueryString("page")
'If Len(page) <= 0 Then 
'	page = "1"
'End If
'Set regEx = New RegExp 
'regEx.Pattern = "^[\w_\-]+$" 
'isPageValid = regEx.Test(page) 
'If Not isPageValid Then
'  Response.Redirect "/"
'End If

Dim q
Dim cat
q = Request.QueryString("q")
Set regEx = New RegExp 
regEx.Pattern = "^[a-z0-9 ]+$" 
isPageValid = regEx.Test(q) 
If Not isPageValid Then
  'Response.Redirect "/"
	q = ""
Else 
	cat = q
	q = " AND (category = '" & q & "' OR category LIKE '" & q & ",%' OR category LIKE '%," & q & "' OR category LIKE '%," & q & ",%') "
End If

objJsIncludes.Add "tablesorter", "/js/jquery.tablesorter.min.js"
objJsIncludes.Add "tablesorterp", "/js/addons/pager/jquery.tablesorter.pager.js"

objCssIncludes.Add "tablesorterpcss", "/js/addons/pager/jquery.tablesorter.pager.css"

bySecurity = Request.QueryString("bysecurity") ' List brokers by security

'Dim conn
Set conn = GetReaderConn()
%>
<!--#INCLUDE FILE="header.asp"-->
<script type="text/javascript" >
$(document).ready(function() {
    //$("#myTable").tablesorter( { widgets: ["zebra"] ,  headers: { 1: { sorter: false }, 2: { sorter: false }, 3: { sorter: false }, 4: { sorter: false } } } );
	
	$("#category").change(function() {
		$('#category_select').submit();
	});	
	}
);
</script>
<div style="background-color:#fff; padding-bottom:20px;">
<%
Server.Execute "company_side_menu.asp"
%>







<div style="margin-left:260px; margin-right:12px;" >
<div class="prop min600px"></div>
<div style="float:left;width:750px;">



  <div class="editarea">

 

<h1>Partner List</h1>

<div style="padding-bottom:20px;">
	<form action="partner_list.asp" method="get" id="category_select">
<%
sql = "SELECT category FROM partners WHERE adStatus=1 ORDER BY adName DESC"
Set rs2 = conn.Execute(sql)
If rs2.EOF Then
  %>&nbsp;<%
Else
	Dim list
	set list = server.createObject("System.Collections.Sortedlist")
	While Not rs2.EOF
		tmp = split(rs2("category"), ",")
		For Each c In tmp
			orig = c
			c = LCase(Trim(c))
			If Not list.Contains(c) Then
				list.Add c, orig
			End If
		Next
		rs2.MoveNext 
	Wend  
	If list.count > 0 Then
	selected = ""
%>
<label for="category">Filter results by</label>&nbsp;<select id="category" name="q" class="autosubmit">
<option value="">No filter</option>
<%
	For i = 0 To list.count - 1
	
		selected = ""
		if list.getkey(i) = cat Then
			selected = " selected" 
		end if
%>
<option value="<%=list.getKey(i)%>"<%=selected%>><%=list.getByIndex(i)%></option>
<%
	Next
%>
</select>
<%	
	
	End If

End If
%>	
	
	
	</form>

</div>

<%
sql = "SELECT adid, adlogosmall, adName, adWeb0, adWeb1, category, featured, service_offering FROM partners WHERE adStatus=1 AND featured=1  " & q & " ORDER BY adName DESC"


Set rs = conn.Execute(sql)

Dim adId
Dim adLogo
Dim adName
Dim website
Dim offerURL
Dim category
Dim featured
Dim service_offering
Dim cls
Dim row_num

If rs.EOF Then
	' do nothing
Else
%>

<b>Featured</b><br>
<div> 
<table id="myTable" class="tablesorter" width="99%"> 
<thead> 
<tr> 
    <th>Partner</th>
    <th style="width:210px">Service Offering</th>
    <th style="width:150px">Category</th>
	<th style="width:80px">Profile</th>
    
</tr> 
</thead> 
<tbody>

<%
  row_num = 0
  While Not rs.EOF
	If row_num Mod 2 = 0 Then
		cls = ""
	Else
		cls = " class=""odd"""
	End If
	row_num = row_num + 1
	adId = rs("adid")
	adLogo = rs("adlogosmall")
	adName = rs("adName")
	If Len(adLogo) > 0 Then
		adLogo = "/images/partner_images/" & adLogo
	End If
	website = rs("adweb0")
	offerURL = rs("adweb1")
	category = rs("category")
	featured = rs("featured")
    service_offering = rs("service_offering")
   
    
%>
  <tr<%=cls%>> 
      <td>
<%	  
If Len(adLogo) > 0 then
	Response.Write "<img width=""220"" height=""60"" src=""" & adLogo & """ alt=""" & adName & """>"
Else 
	Response.Write adName & "&nbsp;"
End If	  
%>
	</td>
	
	
    <td><%=service_offering%></td>
    <td><%
	
	Dim clist1
	set clist1 = server.createObject("System.Collections.Sortedlist")
	tmp = split(category, ",")
	For Each c In tmp
		orig = c
		c = LCase(Trim(c))
		If Not clist1.Contains(c) Then
			clist1.Add c, orig
		End If
	Next 
	cat_link  = ""
	For i = 0 To clist1.count - 1
		cat_link = cat_link & "<a href=""partner_list.asp?q=" & clist1.getKey(i) & """ alt="""  & clist1.getByIndex(i) & """>"  & clist1.getByIndex(i) & "</a>,&nbsp;"
	Next
	If Len(cat_link) > 0 Then
		cat_link = Left(cat_link, Len(cat_link) - Len(",&nbsp;"))
	Else
		cat_link = "&nbsp;"
	End If
	response.Write cat_link	
	
	%></td>
	<td><div style="padding:8px"><a href="/partner_profile.asp?id=<%=adId%>" class="btn-blue small">Profile</a></div></td>
  </tr> 
<%
    rs.MoveNext 
	
  Wend  

%>
</tbody>
</table>

</div>
<br><br>
<%
End If
%>






<%
sql = "SELECT adid, adlogosmall, adName, adWeb0, adWeb1, category, featured, service_offering FROM partners WHERE adStatus=1 AND featured<>1 " & q & " ORDER BY adName DESC"

Set rs = conn.Execute(sql)
If rs.EOF Then
  ' Do Nothing
Else
%>
<div> 
<table id="myTable" class="tablesorter" width="99%"> 
<thead> 
<tr> 
    <th>Partner</th>
    <th style="width:210px">Service Offering</th>
    <th style="width:150px">Category</th>
	<th style="width:80px">Profile</th>
    
</tr> 
</thead> 
<tbody>
<%
  row_num = 0
  While Not rs.EOF
	If row_num Mod 2 = 0 Then
		cls = ""
	Else
		cls = " class=""odd"""
	End If
	row_num = row_num + 1
	adId = rs("adid")
	adLogo = rs("adlogosmall")
	adName = rs("adName")
	If Len(adLogo) > 0 Then
		adLogo = "/images/partner_images/" & adLogo
	End If
	website = rs("adweb0")
	offerURL = rs("adweb1")
	category = rs("category")
	featured = rs("featured")
    service_offering = rs("service_offering")
   
    
%>
<tr<%=cls%>>
      <td>
<%	  
If Len(adLogo) > 0 then
	Response.Write "<img width=""220"" height=""60"" src=""" & adLogo & """ alt=""" & adName & """>"
Else 
	Response.Write adName & "&nbsp;"
End If	  
%>
	</td>
	
	
    <td><%=service_offering%></td>
    <td><%
	
	Dim clist2
	set clist2 = server.createObject("System.Collections.Sortedlist")
	tmp = split(category, ",")
	For Each c In tmp
		orig = c
		c = LCase(Trim(c))
		If Not clist2.Contains(c) Then
			clist2.Add c, orig
		End If
	Next 
	cat_link  = ""
	For i = 0 To clist2.count - 1
		cat_link = cat_link & "<a href=""partner_list.asp?q=" & server.urlencode(clist2.getKey(i)) & """ alt="""  & clist2.getByIndex(i) & """>"  & clist2.getByIndex(i) & "</a>,&nbsp;"
	Next
	If Len(cat_link) > 0 Then
		cat_link = Left(cat_link, Len(cat_link) - Len(",&nbsp;"))
	Else
		cat_link = "&nbsp;"
	End If
	response.Write cat_link
	
	
	%></td>
	<td><div style="padding:8px"><a href="/partner_profile.asp?id=<%=adId%>" class="btn-blue small">Profile</a></div></td>
  </tr> 
<%
    rs.MoveNext 
  Wend  

%>
</tbody>
</table>

</div>
<%
End If
%>


</div>

</div>
</div>

<div style="clear:both;"></div>
</div>
<div style="height:20px;background-color:#fff;clear:both;margin-bottom:8px;"></div>


<!--#INCLUDE FILE="footer.asp"-->