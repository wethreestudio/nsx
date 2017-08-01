<%
Function fmttf(xx)
if len(xx)=0 or isnull(xx) or isempty(xx) then
	fmttf = xx
else
	fmttf = Day(xx) & "-" & MonthName(Month(xx),True) & "-" & Year(xx) & " " & formatdatetime(xx,3) 
end if
end Function


' day light saving
' check annrel, announcements_list.asp, company/resupload3.asp
'daylightsaving = 1/24
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
	response.write "need symbol"
	response.end
end if
group = request("group")
if group = "yes"  then
	srchgrp="nsxcode"
	else
	srchgrp="tradingcode"
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
		srch = srch & "(coAnn." & srchgrp & "='" & nsxcode(jj) & "') OR "
	next
	srch = left(srch,len(srch)-4)
		
end if

board=ucase(trim(request("board")))
if len(board)<>0 then srch = srch & " AND (coissues.displayboard LIKE '" & board & "') "

datefrom=request("datefrom")
if isdate(datefrom) then
  datefrom = cdate(datefrom)
	srch = srch & " AND coann.recorddatestamp>='" & YEAR(datefrom) & "-" & MONTH(datefrom) & "-" & DAY(datefrom) & "'"
end if

dateto=request("dateto")
if isdate(dateto) then
  dateto = cdate(dateto)
	srch = srch & " AND coann.recorddatestamp<='" & YEAR(dateto) & "-" & MONTH(dateto) & "-" & DAY(dateto) & "'"
end if


  

Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
'ConnPasswords.Open Application("nsx_ReaderConnectionString")   
ConnPasswords.Open Application("nsx_ReaderConnectionString") 

SQL = "SELECT coAnn.annid,annPrecise,annFile,annRelease,annTitle,annFileSize,coAnn.tradingcode,annUpload,coIssues.IssueDescription, annPriceSensitive, coissues.displayboard "
SQL = SQL & " FROM coIssues INNER JOIN coAnn ON coIssues.tradingcode = coAnn.tradingcode "
SQL = SQL & srch
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

	'cr=vbCRLF
     cr="<br>"
	qu=""""
	tb=","
        eml = ""


 if WEOF then 
	
  eml = eml & "No records available."
   else
	
      	  for jj = 0 to rc
      	  
      	  id = alldata(0,jj)
      	  precise = replace(trim(alldata(1,jj)) & " ","''","'")
      	  precise = replace(trim(alldata(1,jj)) & " ","""","'")
      	  file = trim(alldata(2,jj))
      	  
      	  release = alldata(3,jj)
      	  if trim(release & " " )<>"" then release=cdate(release)
      	  
      	  
      	  title= replace(trim(alldata(4,jj)) & " ","''","'")
      	  
      	  filesize= CLng(alldata(5,jj))
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
      	  	PriceSens = "Price Sensitive"
      	  	else
      	  	PriceSens = ""
      	  end if
      	  
     eml = eml & qu & nsxcode & qu & tb
     eml = eml & qu & pricesens & qu & tb
     eml = eml & qu & name & qu & tb

   	  	if InStr(1,File,".")>0 then
   	  		category = title
   	  		dash = instr(title,"-")
   	  		if dash <> 0 then
   	  			category = trim(left(title,dash-1))
   	  			title = trim(mid(title,dash+1,len(title)))
   	  		end if
   	  	end if
   	  	
			eml = eml & qu & Application("nsx_SiteRootURL") & "/ftp/news/" & file & qu & tb
			eml = eml & qu & title & qu & tb
			eml = eml & qu & precise & qu & tb
			eml = eml & qu & category & qu & tb
			eml = eml & qu &  fmttf(release) & qu 
			eml = eml & cr
			
			NEXT
			
			END IF
			
			response.write eml
	
			%>