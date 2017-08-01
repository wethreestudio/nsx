<!--#INCLUDE FILE="include_all.asp"-->
<%
on error resume next
page_title = "Adviser Profile"
' meta_description = ""
' alow_robots = "no"
' objJsIncludes.Add "marketdata", "js/marketdata.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"

Function remcrlf(xx)
  remcrlf = replace(xx & " ",vbCRLF,"")
  remcrlf = trim(Replace(remcrlf & " ", "''", "'"))
  remcrlf = replace((remcrlf & " "),"align=""left"""," ")
  remcrlf = replace((remcrlf & " "),"align='left'"," ")
  remcrlf = replace((remcrlf & " "),"align=left"," ")
End Function


%>
<!--#INCLUDE FILE="header.asp"-->



<%
Server.Execute "side_menu.asp"
%>

<div class="hero-banner subpage about-page">
    <div class="hero-banner-img">
            
    </div>
    
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder subpage">
            <div class="col-sm-12 hero-banner-left">

                
                <h1>Adviser profile</h1>

               
            </div>
        </div>
    </div>
</div><!-- /hero-banner -->

<!--#INCLUDE FILE="content_lower_nav.asp"-->

<div class="container subpage">
    <div class="row">
        <div class="col-sm-12">
            <div class="subpage-center">


<%

errmsg=""
currentpage = trim(request("currentpage"))
if len(currentpage)=0 then currentpage=1
currentpage=cint(currentpage)
if currentpage<1 then currentpage=1

id = request.querystring("id")
'response.write  CLng(SafeSqlParameter(ID))
'response.end 
Set regEx = New RegExp 
regEx.Pattern = "^\d+$" 
isPageValid = regEx.Test(id) 
If Not isPageValid Then
   Response.Redirect "/errorpages/404.html"
  response.write "invalid"
  response.end
End If


Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
ConnPasswords.Open Application("nsx_ReaderConnectionString") 
SQL = "SELECT sh.adid,sh.adName,a.adAddress,sh.POBOX,sh.AdEmail,sh.Websites,sh.History,sh.About,sh.Services,sh.Logo,sh.Strapline,sh.ShortDesc,sh.Phone,sh.Fax,sh.adStatus,sh.listeddate, a.adLevel, ct.Country, c.CityName, a.adsuburb, a.adpcode,sh.adPOBOX,sh.adPOSuburb,sh.adPOPCode,stateb   "
SQL = SQL & " FROM shaden sh JOIN advisers a ON a.adid = sh.adid JOIN cities c ON a.adCity = c.tid JOIN countries ct ON ct.cid = a.adCountry "
SQL = SQL & " WHERE (sh.adid=" & CLng(SafeSqlParameter(ID)) & ")"


CmdDD.CacheSize=10
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
maxpagesize = 10
maxpages = round(.5 + (rc / maxpagesize),0)
st = (currentpage * maxpagesize ) - maxpagesize
fh = st + maxpagesize - 1
if fh > rc then fh = rc

%>

<%  if WEOF then %>
	 
   There is no record available.
  <% else
	
      	  for jj = st to fh
 
      	  agid = alldata(0,jj)
      	  agName= alldata(1,jj)
      	  Address= alldata(2,jj)
      	  POBOX= alldata(3,jj)
      	  AgEmail= alldata(4,jj)
      	  Websites= alldata(5,jj)
      	  History= alldata(6,jj)
      	  About= alldata(7,jj)
      	  Services= alldata(8,jj)
      	  Logo= alldata(9,jj)
      	  Logo = trim(replace(Logo & " ","../advisers/adimg/","images/adviser_images/"))
      	  Strapline= alldata(10,jj)
      	  ShortDesc= alldata(11,jj)
      	  Phone= alldata(12,jj)
      	  Fax= alldata(13,jj)
      	  agStatus= alldata(14,jj)
      	  listeddate=alldata(15,jj)
		  
		  
		  adlevel = alldata(16,jj)
		  adcountry = alldata(17,jj)
		  adcity = alldata(18,jj)
		  adsuburb = alldata(19,jj)
		  adpcode = alldata(20,jj)
		  
		  adPOBOX= alldata(21,jj)
		  adPOSuburb= alldata(22,jj)
		  adPOPCode= alldata(23,jj)
		  state= alldata(24,jj)
		    
		If Len(Trim(Address)) > 0 Then
			If Len(Trim(adlevel)) > 0 Then Address = adlevel & "<br>" & Address
			If Len(Trim(adcity)) > 0 Then Address = Address & "<br>" & adcity
			If Len(Trim(adsuburb)) > 0 Then Address = Address & "&nbsp;" & adsuburb
			If Len(Trim(state)) > 0 Then Address = Address & "&nbsp;" & state
			If Len(Trim(adpcode)) > 0 Then Address = Address & "&nbsp;" & adpcode
			If Len(Trim(adcountry)) > 0 Then Address = Address & "<br>" & adcountry
		End If
		
	  	if len(trim(adPOBOX & " "))=0 or (vartype(adPOBOX)=1) then	
			adPOBOX = "Same as street address"
			else
			If Len(Trim(adPOSuburb)) > 0 Then adPOBOX = adPOBOX & "<br>" & adPOSuburb
			If Len(Trim(adCity)) > 0 Then adPOBOX = adPOBOX & "<br>" & adCity
			If Len(Trim(state)) > 0 Then adPOBOX = adPOBOX & "&nbsp;" & state
			If Len(Trim(adPCode)) > 0 Then adPOBOX = adPOBOX & "&nbsp;" & adPOPCode
			If Len(Trim(Country)) > 0 Then adPOBOX = adPOBOX & "<br>" & adCountry
		end if
     	  
		  
		  if isdate(listeddate) then
      	  	listedyear=year(listeddate)
      	  	memberyears = year(date) - listedyear
      	  end if
		

      	  
      	  
%>



<div class="editarea">
  <div style="float:right;">
  
  
<div class="small-table">
<div class="datagrid">
<table cellspacing="0" cellpadding="0">
    <thead>
        <tr>
            <th style="text-align:left;padding-left:5px;">Contact Details</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>

<table width="100%">
  <tbody>
<% If Len(Trim(Address)) > 0 Then %>
  <tr>
    <td width="90px"><b>Street Address:</b></td>
    <td><%=remcrlf(Address)%></td>
  </tr>
<% End If %>

  <tr>
    <td><b>Postal Address:</b></td>
    <td><%=remcrlf(adpobox)%></td>
  </tr>
  <tr>

    <td><b>Web:</b></td>
    <td>
      <% if instr(websites," http:")> 0 then websites=replace(websites & " "," ","<br>http:")
      response.write websites %>
    </td>
  </tr>
  <tr>
  <%If Len(Trim(agemail)) > 0 Then%>
    <td><b>Email:</b></td>
    <td><%=agemail%></td>
  </tr>
<% End If %>
<%If Len(Trim(phone)) > 0 Then%>
  <tr>
    <td><b>Phone:</b></td>
    <td><%=remcrlf(phone)%></td>
  </tr>
  <% End If %>
<%If Len(Trim(fax)) > 0 Then%>
  <tr>
    <td><b>Fax:</b></td>
    <td><%=remcrlf(fax)%></td>
  </tr>
  <% End If %>
  <tr>
    <td><b>Member Since:</b>
    <td><%=listedyear%></td>
  </tr>
    
    </tbody>
    
    
    </table>
			</td>
        </tr>
    </tbody>
</table>
</div>
</div>  
  
  
  
  
  
    <table>



</table>  
  </div>




  <h1><%=remcrlf(ucase(agname))%></h1>
  <div style="width:100%;"><%=strapline%></div>
  <div style="width:100%;padding:5px;"><%=remcrlf(logo)%></div>
  <div style="width:100%;"><%=remcrlf(shortdesc)%></div>
<%  
If Len(about) < 10 Then about = Replace(about & " ","<p>&nbsp;</p>","")
If Trim(about & " ") <> "" Then
%>
  <h2>About</h2>
  <p><%=remcrlf(about)%></p>
<%
End If
If Len(services) < 10 Then services = Replace(services & " ","<p>&nbsp;</p>","")
If Trim(services & " ") <> "" Then
%>
  <h2>Services</h2>
  <p><%=remcrlf(services)%></p>
<%
End If
If Len(History) < 10 Then History = Replace(History & " ","<p>&nbsp;</p>","")
If Trim(History & " ") <> "" Then
%>
  <h2>History</h2>
  <p><%=remcrlf(History)%></p>
<%
End If
%> 
</div>
 

<% NEXT
	end if
	%>

</div>
</div>
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->