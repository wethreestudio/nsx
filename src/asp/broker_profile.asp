<!--#INCLUDE FILE="include_all.asp"-->
<%
on error resume next
Function remcrlf(xx)

'Response.Write "<!-- Raw: " & xx & "-->"

remcrlf = replace(xx & " ",vbCRLF,"")
remcrlf = Replace((remcrlf & " "), "''", "'")
remcrlf = replace((remcrlf & " "),"../members/memimg","images/broker_images")
remcrlf = replace((remcrlf & " "),"../advisers/adimg","images/broker_images")
remcrlf = replace((remcrlf & " "),"align=""left"""," ")
remcrlf = replace((remcrlf & " "),"align='left'"," ")
remcrlf = replace((remcrlf & " "),"align=left"," ")

'Response.Write "<!-- Result: " & remcrlf & "-->"
End Function

page_title = "Broker Profile"
' meta_description = ""
' alow_robots = "no"
' objJsIncludes.Add "marketdata", "js/marketdata.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"
%>
<!--#INCLUDE FILE="header.asp"-->
<div class="container_cont container subpage">
<div class="user_content">



<%

errmsg=""
currentpage = trim(request("currentpage"))
if len(currentpage)=0 then currentpage=1
currentpage=cint(currentpage)
if currentpage<1 then currentpage=1

id = request.querystring("id")
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

   
SQL = "SELECT agid,agName,Address,POBOX,AgEmail,Websites,History,About,Services,Logo,Strapline,ShortDesc,Phone,Fax,agStatus,listeddate, agLevel, agAddress, CityName, stateb, Country, agPCode,agPOBOX,agPOSuburb,agPOPCode "
SQL = SQL & " FROM shagen WHERE (agid=" & CLng(SafeSqlParameter(ID)) & ")"

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
      	  Strapline= alldata(10,jj)
      	  ShortDesc= alldata(11,jj)
      	  Phone= alldata(12,jj)
      	  Fax= alldata(13,jj)
      	  agStatus= alldata(14,jj)
      	  listeddate= alldata(15,jj)
		  
		  agLevel= alldata(16,jj)
		  agAddress= alldata(17,jj)
		  CityName= alldata(18,jj)
		  state= alldata(19,jj)
		  Country= alldata(20,jj)
		  agPCode= alldata(21,jj)
		  agPOBOX= alldata(22,jj)
		  agPOSuburb= alldata(23,jj)
		  agPOPCode= alldata(24,jj)
		  
		If Len(Trim(agAddress)) > 0 Then
			If Len(Trim(agLevel)) > 0 Then agAddress = agLevel & "<br>" & agAddress
			If Len(Trim(CityName)) > 0 Then agAddress = agAddress & "<br>" & CityName
			If Len(Trim(agSuburb)) > 0 Then agAddress = agAddress & "&nbsp;" & agSuburb
			If Len(Trim(state)) > 0 Then agAddress = agAddress & "&nbsp;" & state
			If Len(Trim(agPCode)) > 0 Then agAddress = agAddress & "&nbsp;" & agPCode
			If Len(Trim(Country)) > 0 Then agAddress = agAddress & "<br>" & Country
		End If
		
		if len(trim(agPOBOX) & " ") = 0 or (vartype(agPOBOX) = 1) then	
			agPOBOX = "Same as street address"
			else
			If Len(Trim(agPOSuburb)) > 0 Then agPOBOX = agPOBOX & "<br>" & agPOSuburb
			If Len(Trim(CityName)) > 0 Then agPOBOX = agPOBOX & "<br>" & CityName
			If Len(Trim(state)) > 0 Then agPOBOX = agPOBOX & "&nbsp;" & state
			If Len(Trim(agPCode)) > 0 Then agPOBOX = agPOBOX & "&nbsp;" & agPOPCode
			If Len(Trim(Country)) > 0 Then agPOBOX = agPOBOX & "<br>" & Country
		end if
		
		Address = agAddress
		  
      	   listedyear = ""
      	  memberyears = ""
      	  if isdate(listeddate) then
      	  	listedyear=year(listeddate)
      	  	memberyears = year(date) - listedyear
      	  end if    	  
%>

<div class="editarea">
  <div style="float:right;">
  
  
<div class="small-table">
<div class="datagrid">
<div class="table-responsive"><table cellspacing="0" cellpadding="0">
    <thead>
        <tr>
            <th style="text-align:left;padding-left:5px;">Contact Details</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>

<div class="table-responsive"><table width="100%">
  <tbody>
<%
If Len(Trim(Address)) > 0 Then
%>
  <tr>
    <td width="90px"><b>Street Address:</b></td>
    <td><%=remcrlf(address)%></td>
  </tr>
<%
End If
%>
<%
'If Len(Trim(agPObox)) > 0 Then
%>
  <tr>
    <td><b>Postal Address:</b></td>
    <td><%=remcrlf(agPOBOX)%></td>
  </tr>
<%
'End If
%>
  <tr>
    <td><b>Web:</b></td>
    <td>
      <% if instr(websites," http:")> 0 then websites=replace(websites & " "," ","<br>http:")
      response.write websites %>
    </td>
  </tr>
<%If Len(Trim(agemail)) > 0 Then%>
  <tr>
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
    
    
    </table></div>
			</td>
        </tr>
    </tbody>
</table></div>
</div>
</div>  
  
  
  
  
  
    <div class="table-responsive"><table>



</table></div>  
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
If Len(history) < 10 Then history = Replace(history & " ","<p>&nbsp;</p>","")
If Trim(history & " ") <> "" Then
%>
  <h2>History</h2>
  <p><%=remcrlf(history)%></p>
<%
End If
%> 
</div>
 
 
 
 
 
 
 
 
 
  



<% NEXT
	end if
	%>




</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->