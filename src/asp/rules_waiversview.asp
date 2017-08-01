<!--#INCLUDE FILE="include_all.asp"-->
<%
' page_title = "Waivers"
' meta_description = ""
' alow_robots = "no"
' objJsIncludes.Add "cms_page", "js/cms_page.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"
%>
<!--#INCLUDE FILE="header.asp"-->


<%
Server.Execute "side_menu.asp"
%>

<div class="hero-banner subpage <%= hero_banner_class %>">
    <div class="hero-banner-img"></div>
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder subpage">
            <div class="col-sm-12 hero-banner-left">
                <h1>Waiver details</h1>
              
            </div>
        </div>
    </div>
</div><!-- /hero-banner -->


<div class="container subpage maincontent" >
  

    <div class="row">
        <div class="col-sm-12">
        
        

<div align="center" class="f-w-table">
<table >

<!--#INCLUDE FILE="admin/merchtools.asp"-->

<%

currentpage = trim(request("currentpage"))
if Not IsNumeric(currentpage) Or len(currentpage) = 0 Then
	currentpage=1
Else
	currentpage=cint(currentpage)
	if currentpage<1 then currentpage=1
End If


id = request("id")
if Not IsNumeric(id) Or len(id) = 0 Then
	id=1
Else
	currentpage=cint(id)
	if id<1 then id=1
End If

Set regEx = New RegExp 
regEx.Pattern = "^[a-zA-Z0-9]+$" 
isCodeValid = regEx.Test(id) 
If Not isCodeValid Then
  Response.Redirect "/errorpages/404.html"
  response.write "invalid"
  Response.End
End If



Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
ConnPasswords.Open Application("nsx_ReaderConnectionString")   
SQL = "SELECT * FROM waivers WHERE (wid=" & CLng(id) & ")"
CmdDD.Open SQL, ConnPasswords,1,3

    lap = 0
    cl = array("alt","")

%>
<%  if CmdDD.EOF then %>
	
  <tr>
    <td  ></td>
    <td >No Waiver Available.</td>
  </tr>
<% else
	while not CMDdd.EOF
	
	

    
      

%>




<thead>
    <tr>
      <th   colspan="2" align="left"><p><%=adjtextarea(CmdDD("RuleDescShort")) %></p>
	  <img class="water-mark" alt="" src="/images/nsx-water-mark.png" /></th>
    </tr>
</thead>
<tbody>
		<tr class="<%=cl(lap)%>">
      <td  align="left">Rule:</td>
      <td  align="left"><%=CmdDD("SectionNumber") & " " & CmdDD("RuleNumber")%></td>
    	</tr>
    <%lap = (-lap)+1%>
    <%if trim(cmddd("DateRequested") & " ") <> "" then%>
		<tr class="<%=cl(lap)%>">
      <td  align="left">Date Requested:</td>
      <td  align="left"><%=formatdatetime(CmdDD("DateRequested"),1) %></td>
    	</tr>
    <%end if%><%lap = (-lap)+1%>
    <%if trim(cmddd("RequestedBy") & " ") <> "" then%>
		<tr class="<%=cl(lap)%>">
      <td  align="left">Requested By:</a></td>
      <td  align="left"><%=CmdDD("RequestedBy") %></td>
    	</tr>
    <%end if%><%lap = (-lap)+1%>
    <%if trim(cmddd("DateApproved") & " ") <> "" then%>
		<tr class="<%=cl(lap)%>">
      <td  align="left">Date Approved:</a></td>
      <td  align="left"><%=formatdatetime(CmdDD("DateApproved"),1) %></td>
    	</tr>
   	<%end if%><%lap = (-lap)+1%>
   	<%if trim(cmddd("ApprovedBy") & " ") <> "" then%>
		<tr class="<%=cl(lap)%>">
      <td  align="left">Approved By:</a></td>
      <td  align="left"><%=CmdDD("ApprovedBy") %></td>
    	</tr>
   	<%end if%><%lap = (-lap)+1%>
    <%if trim(cmddd("RequestedForIssuer") & " ") <> "" then%>
		<tr class="<%=cl(lap)%>">
      <td  align="left">Issuer:</a></td>
      <td  align="left"><%=adjtextarea(CmdDD("RequestedForIssuer") & " ") %>
      </td>
    	</tr>
   	<%end if%><%lap = (-lap)+1%>
    <%if trim(cmddd("RequestedForSecurities") & " ") <> "" then%>
		<tr class="<%=cl(lap)%>">
      <td  align="left">Securities:</a></td>
      <td  align="left"><%=CmdDD("RequestedForSecurities") %></td>
    	</tr>
   	<%end if%><%lap = (-lap)+1%>
    <%if trim(cmddd("RuleDescLong") & " ") <> "" then%>
	<tr class="<%=cl(lap)%>">
      <td  align="left" >Description of Rule:</td>
      <td  align="left"><%=adjtextarea(CmdDD("RuleDescLong") & " ")%></td>
    </tr>
    <%end if%><%lap = (-lap)+1%>


   <%if trim(cmddd("WaiverRequested") & " ") <> "" then%>
	<tr class="<%=cl(lap)%>">
      <td  align="left" >Waiver Requested:</td>
      <td  align="left"><%=adjtextarea(CmdDD("WaiverRequested") & " ")%></td>
    </tr>
    <%end if%><%lap = (-lap)+1%>
    <%if trim(cmddd("WaiverEffect") & " ") <> "" then%>
<tr class="<%=cl(lap)%>">
      <td  align="left" >Effect of Waiver:</td>
      <td  align="left"><%=adjtextarea(CmdDD("WaiverEffect") & " ")%></td>
    </tr>
    <%end if%>
	<%lap = (-lap)+1%>

<% Cmddd.MoveNext
	WEND
	end if
	
	CmdDD.Close
Set CmdDD = Nothing

ConnPasswords.Close
Set ConnPasswords = Nothing
	%>
  </tbody>
</table>
    
	</div>
    
    
<p align="left">&nbsp;</p>
  

</div>
 </div></div></div></div>
<!--#INCLUDE FILE="footer.asp"-->
