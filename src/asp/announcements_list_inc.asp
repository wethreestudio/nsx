<%Function fmttf(xx)
if len(xx)=0 or isnull(xx) or isempty(xx) then
	fmttf = xx
else
	fmttf = left(weekdayname(weekday(xx)),3) & " " & Day(xx) & "-" & MonthName(Month(xx),True) & "-" & Year(xx) & " " & formatdatetime(xx,3) 
end if
end Function

Function RemoveHTML( strText )
	Dim RegEx

	Set RegEx = New RegExp

	RegEx.Pattern = "<[^>]*>"
	RegEx.Global = True

	RemoveHTML = RegEx.Replace(strText, "")
End Function

%>


<%

' day light saving
' check annrel, announcements_list.asp, company/resupload3.asp
'daylightsaving = 1/24
daylightsaving=0
if application("nsx_daylight_saving")=true then
	daylightsaving = 1/24
	else
	daylightsaving = 0
end if
displayboard = session("region")

errmsg=""
currentpage = trim(request("currentpage"))
if len(currentpage)=0 then currentpage=1
currentpage=cint(currentpage)
if currentpage<1 then currentpage=1

' if mutliple codes requested then restrict by that otherwise ALL codes.
nsxcodes=trim(request.querystring("nsxcode") & " ")
if len(nsxcodes)=0 then
	nsxcodes=trim(request.form("nsxcode") & " ")
end if

' construct search for multiple codes.
srch = " WHERE (coAnn.annDisplay=1) AND (coAnn.annRelease is not null) "
if len(nsxcodes)<>0 then
	nsxcodes=replace(nsxcodes," ","")
	nsxcodes=replace(nsxcodes,";",",")
	nsxcodes=replace(nsxcodes,vbCRLF,"")
	nsxcodes=replace(nsxcodes,".","")
	nsxcodes=replace(nsxcodes,",,",",")

	srch = srch & " AND "
	nsxcode=split(nsxcodes,",")
	for jj = 0 to ubound(nsxcode)
		srch = srch & "(coAnn.tradingcode='" & SafeSqlParameter(nsxcode(jj)) & "') OR "
	next
	srch = left(srch,len(srch)-4)
		
end if



Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
ConnPasswords.Open Application("nsx_ReaderConnectionString")   

SQL = "SELECT TOP 9 coAnn.annid,annPrecise,annFile,annRelease,annTitle,annFileSize,coAnn.tradingcode,annUpload,coIssues.IssueDescription, annPriceSensitive "
SQL = SQL & " FROM coIssues INNER JOIN coAnn ON coIssues.tradingcode = coAnn.tradingcode "
'SQL = SQL & srch
if len(displayboard)<>0 then
SQL = SQL & " WHERE (coissues.displayboard like '%" & SafeSqlParameter(displayboard) & "%')"
end if
SQL = SQL & " ORDER BY coAnn.annUpload DESC"
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

rowcount = 0
maxpagesize = 30
maxpages = round(.5 + (rc / maxpagesize),0)
st = (currentpage * maxpagesize ) - maxpagesize
fh = st + maxpagesize - 1
if fh > rc then fh = rc

%>

<div align="center">

<div class="table-responsive"><table cellspacing="0" cellpadding="3" width="100%">
  <%  if WEOF then %>
	
  <tr>
    <td class="subcat" width="100%">There are no headlines available.</td>
  </tr>
<% else
	
      	  for jj = st to fh
      	  
      	  id = alldata(0,jj)
      	  precise = replace(trim(alldata(1,jj)) & " ","''","'")
      	  file = trim(alldata(2,jj))
      	  
      	  release = alldata(3,jj)
      	  if trim(release & " " )<>"" then release=cdate(release)
      	  
      	  
      	  title= replace(trim(alldata(4,jj)) & " ","''","'")
      	  
      	  filesize= alldata(5,jj)
      	   if filesize < 1000000 then 
      	  	filesize = formatnumber((filesize/1024),1) & " KB"
      	  elseif filesize >=1000000 and filesize<=1000000000 then
      	  	filesize = formatnumber((filesize/1024000),1) & " MB"
      	  elseif filesize >=1000000000 and filesize<=1000000000000 then
      	  	filesize = formatnumber((filesize/1024000000),1) & " GB"
      	  end if 	  
      	  
      	  nsxcode= ucase(alldata(6,jj))
      	  upload= cdate(alldata(7,jj))
      	  name= replace(trim(alldata(8,jj)) & " ","''","'")
      	  PriceSens = alldata(9,jj)
      	  if PriceSens = True then
      	  	PriceSens = "<br><font color=green size=-2><b>Price<br>Sensitive</b></font"
      	  	else
      	  	PriceSens = "&nbsp;"
      	  end if
      	  
      	  cl = array("#EEEEEE","#FFFFFF")
	lap = (-lap)+1
				
    %>
  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
      
    <td valign="top"  width="100%" class=plaintext>
  
    <font size="1">
  
    <img border="0" src="images/broker_page1_bullet.gif" width="20" height="15"><%
     response.write "<b>" & ucase(nsxcode) & "</b>&nbsp;"
   

   	  	if InStr(1,File,".")>0 then
   	  		category = title
   	  		dash = instr(title,"-")
   	  		if dash <> 0 then
   	  			category = trim(left(title,dash-1))
   	  			title = trim(mid(title,dash+1,len(title)))
   	  		end if
   	  		      	  		
   	  		if formatdatetime(cdate(release),1)=formatdatetime(now,1) then
   	  			releaseinc = formatdatetime(cdate(release),3)
				else
   	  			releaseinc = fmttf(release)
   	  		end if
   	  		
			response.write "<font size=1><a href=ftp/news/" & file & " title=""" & left(removehtml(precise & " "),100) & """ target=_blank>" & title  & "</a>&nbsp;<font color=gray>" & releaseinc & "</font></font>"
						  
		else
			response.write adjtextarea(title & " ") 
			
		end if
		

     
    %> 

</font> 

</td>
    </tr>
  <% NEXT
	end if
	%>
</table></div>
    
  </div>

    
  