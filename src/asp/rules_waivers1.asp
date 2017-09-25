<!--#INCLUDE FILE="include_all.asp"-->
<%
' page_title = "Waivers"
' meta_description = ""
' alow_robots = "no"
objJsIncludes.Add "cms_page", "js/cms_page.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"


  
page = Request.QueryString("page")
Set regEx = New RegExp 
regEx.Pattern = "^[\w_\-]+$" 
isPageValid = regEx.Test(page) 
If Not isPageValid Then
  Response.Redirect "/"
End If

objJsIncludes.Add "tablesorter", "/js/jquery.tablesorter.min.js"
objJsIncludes.Add "tablesorterp", "/js/addons/pager/jquery.tablesorter.pager.js"

objCssIncludes.Add "tablesorterpcss", "/js/addons/pager/jquery.tablesorter.pager.css"

objJsIncludes.Add "jquery_autocomplete_js", "/js/jquery.autocomplete.js"
objCssIncludes.Add "jquery_autocomplete_css", "/css/jquery.autocomplete.css"

bySecurity = Request.QueryString("bysecurity") ' List brokers by security
%>
<!--#INCLUDE FILE="header.asp"-->
<script type="text/javascript" >
$(document).ready(function() 
    { 
    
      var pagesize = 20;
      
      if ($("#pager select").length>0) 
      {
        pagesize=$("#pager select").val();
      }
       
    
      $.tablesorter.addParser({
        // set a unique id          
        id: 'approved',
        is: function(s) {
            // return false so this parser is not auto detected
            return false;
        },
        format: function(s) {
            var x = s.split(";")
            return x[1];
        },
        // set type, either numeric or text
        type: 'numeric'
      });

      // call the tablesorter plugin 
      $("#myTable").tablesorter({ 
          // sort on the first column and third column, order asc 
          widgets: ["zebra"] ,
          headers: { 
            0: { sorter:'approved'  },
            1: { sorter: false } 
          }         
      });     
    
      $("#myTable").tablesorter( { widgets: ["zebra"] } );
      $("#myTable").tablesorterPager({ container: $("#pager"), positionFixed: false, size: pagesize });  
    } 
);
</script>


<%
Server.Execute "side_menu.asp"
%>

<div class="hero-banner subpage <%= hero_banner_class %>">
    <div class="hero-banner-img"></div>
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder subpage">
            <div class="col-sm-12 hero-banner-left">
                <h1>Waivers</h1>
              
            </div>
        </div>
    </div>
</div><!-- /hero-banner -->
<%
Server.Execute "content_lower_nav.asp"
%>

<div class="container subpage maincontent" >
  

    <div class="row">
        <div class="col-sm-12">


<div class="editarea">
<%

'.'PrintSearchBox1 "NSX Waiver Search","/companies_listed/waivers","350","Enter company code","nsxcode"
'RenderContent page,"editarea" 
%>
</div>


<div class="pager2" id="pager">	
  <form action="javascript:void(0)" method="get">
	<span>
        <i class="first fa fa-step-backward"></i>
        <i class="prev fa fa-backward"></i>
        <input type="text" class="pagedisplay" style="border:none;width:70px;text-align:center">
        <i class="next fa fa-forward"></i>
        <i class="last fa fa-step-forward"></i>

		<select class="pagesize">
			<option value="20" selected="selected">20</option>
			<option value="40">40</option>
			<option value="100">100</option>
			<option value="200">200</option>
		</select>
	</span>
	</form>
</div>


<div style="float:right;width:99%;">
<div class="table-responsive"><table id="myTable" class="tablesorter" style="width:100%">
<thead> 
<tr> 
    <th width="160">Date Approved</th>
    <th>Waiver Requested</th>
</tr> 
</thead>

<tbody>
<%

errmsg=""
currentpage = trim(request("currentpage"))
if len(currentpage)=0 then currentpage=1
currentpage=cint(currentpage)
if currentpage<1 then currentpage=1

sortorder = ucase(trim(request("sort") & " "))
sortorder2= sortorder
select case sortorder
	case "APPROVAL"
		sortorder = "dateapproved DESC"
	case "ISSUER"
		sortorder = "RequestedForIssuer,dateapproved DESC"
	case else
		sortorder = "dateapproved DESC"
end select



where = ""
nsxcode = Request.QueryString("nsxcode")

If Len(nsxcode) > 0 Then
  where = "AND RequestedForSecurities LIKE '%" & SafeSqlParameter(nsxcode) & "%' OR RequestedForIssuer LIKE '%" & SafeSqlParameter(nsxcode) & "%' "
End If

SQL = "SELECT wid,dateapproved,ruledescshort,RequestedForSecurities,SectionNumber,RuleNumber,RequestedForIssuer FROM waivers "
SQL = SQL & "WHERE displayboard<>'SIMV' " & where
SQL = SQL & "ORDER BY " & sortorder 

Set conn = GetReaderConn()
Set rs = conn.Execute(SQL)
If rs.EOF Then
%>
  <tr>
    <td colspan="2">There are no waivers to display.</td>
  </tr>
<%
Else
  While Not rs.EOF
    id = rs("wid")
    dateapproved = rs("dateapproved")
    ruledescshort = rs("ruledescshort")
    RequestedForSecurities = rs("RequestedForSecurities")
    SectionNumber = rs("SectionNumber") 
    RuleNumber = rs("RuleNumber") 
    Issuer = rs("RequestedForIssuer") 
    ruledescshort = stripTags(ruledescshort)
%>
 <tr>
    <td valign="top">
<%   
  If len(trim(dateapproved & " ")) = 0 Then
    Response.Write dateapproved & " " & id
  Else
    Response.Write Day(dateapproved) & "-" & monthname(month(dateapproved),3) & "-" & year(dateapproved)
  End If
%><span style="display:none">;<%
  If len(trim(dateapproved & " ")) = 0 Then
    Response.Write dateapproved & " " & id
  Else
    m = month(dateapproved)
    fm = m & ""
    If m < 10 Then fm = "0" & m 
    d = day(dateapproved)
    fd = d & ""
    If d < 10 Then fd = "0" & d 
    Response.Write Year(dateapproved) & fm & fd
  End If
%></span>
    </td>
    <td >Rule: <%=stripTags(SectionNumber) & " " & stripTags(RuleNumber)%><br><b><%=left(ruledescshort,200)%></b><br>
    Issuer: <%=left(stripTags(issuer),150) %> Securities: <%=left(stripTags(RequestedForSecurities),150) %>
      <a href="<%="rules_waiversview.asp?ID=" & ID%>">More...</a>
    </td>
  </tr>
<% 
    rs.MoveNext 
  Wend  
End If
%>
</tbody>
</table></div>
</div>


    
  


</div>
<div style="clear:both;"></div>
</div>


<!--#INCLUDE FILE="footer.asp"-->