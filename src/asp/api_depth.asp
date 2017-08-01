<%@ LANGUAGE="VBSCRIPT" %>
<!--#INCLUDE FILE="include/sql_functions.asp"-->
<%Server.ScriptTimeout=180

response.expires = 0
response.expiresabsolute = #JAN 2, 2000 00:00:00#
response.cachecontrol = "PRIVATE"


'Formats
' fmt=xml, txt, rss, mddl, yahoo
' srt=pubdate,symbol,name
' maxx = number of symbols to display, default = all
' nsxcode = symbol to display
' desc = true, false display description info

fmt=trim(request("fmt") & " ")
if len(fmt)=0 then fmt="rss"
srt=trim(request("srt") & " ")
if len(srt)=0 then srt="symbol"
if srt ="symbol" then srt="tradingcode"
if srt ="pubdate" then srt="recorddatestamp"
if srt ="name" then srt="issuedescription"
if srt <> "issuedescription" AND srt <> "tradingcode" AND srt <> "recorddatestamp" then srt="symbol"


desc=trim(request("desc") & " ")
if len(desc)=0 then 
	desc=false
	else
	desc = true
end if
maxx=trim(request("maxx") & " ")
if len(maxx)=0 then maxx="all"


' Replace single quotes in text before inserting in DB
Function RepAP(str)
     RepAP = Replace(str & " ", "'", "''") 
End Function

Function cnvddmmyyyy(xx)
' convert dates into dd-mmm-yyyy format
	dd = day(xx)
	mm = monthname(month(xx),1)
	yy = year(xx)
	cnvddmmyyyy = dd &"-"& mm & "-" & yy
End Function

Function ApplyXMLFormatting(strInput)
	strInput = strInput & " "
 	strInput= replace(strInput,"''","'")
  	strInput = Replace(strInput,"<BR>", " ")
  	strInput = Replace(strInput,"&", "&amp;")
  	strInput = Replace(strInput,"'", "&apos;")
  	strInput = Replace(strInput,"""", "&quot;")
  	strInput = Replace(strInput, ">", "&gt;")
  	strInput = Replace(strInput,"<","&lt;")
  	strInput = trim(strInput)
  	ApplyXMLFormatting = strInput
End Function   

Function fmtTime(strInput)
	fmtTime = formatdatetime(strInput,4) & ":00"
End Function



cr=vbCRLF
qu=""""
tb=","

select case fmt
	case "xml"
		Author = "mail@nsxa.com.au" 
		PubDate= left(weekdayname(weekday(date),1),3) & ", " & Day(date) & " " & monthname(month(date),1) & " " & year(date) & " " & fmtTime(time) & " +1000"
		eml = "<?xml version=" & qu & "1.0" & qu & " encoding=" & qu & "ISO-8859-1" & qu & " ?>" & cr
		eml = eml & "<?xml-stylesheet type=" & qu & "text/xsl" & qu & " href=" & qu & Application("nsx_SiteRootURL") & "/ftp/rss/rss2html.xsl" & qu & " version=" & qu & "1.0" & qu & "?>" & cr  
		eml = eml & "<rss version=" & qu & "2.0" & qu & ">" & cr
		eml = eml & "<channel>" & cr
		eml = eml & "<title>NSX National Stock Exchange of Australia Depth</title>" & cr
		eml = eml & "<link>" & Application("nsx_SiteRootURL") & "</link>" & cr
		eml = eml & "<category>Business</category>"
		eml = eml & "<category>Investing</category>"
		eml = eml & "<category>Stocks and Bonds</category>"
		eml = eml & "<category>Exchanges</category>"
		eml = eml & "<description>NSX National Stock Exchange of Australia Depth</description>" & cr
		eml = eml & "<language>en-us</language>" & cr
		eml = eml & "<copyright>Copyright 1937-" & year(date)  & " NSX</copyright>" & cr
		eml = eml & "<docs>" & Application("nsx_SiteRootURL") & "/ftp/rss</docs>" & cr
		eml = eml & "<lastBuildDate>" & PubDate & "</lastBuildDate>" & cr
		eml = eml & "<image>"
		eml = eml & "<title>NSX Prices</title>"
		eml = eml & "<url>" & Application("nsx_SiteRootURL") & "/images/NSX-LOGOx150.gif</url>"
		eml = eml & "<link>" & Application("nsx_SiteRootURL") & "</link>"
		eml = eml & "</image>"
	
	case "txt"
		txt = ""
	
	case "rss"
		Author = "mail@nsxa.com.au" 
		PubDate= left(weekdayname(weekday(date),1),3) & ", " & Day(date) & " " & monthname(month(date),1) & " " & year(date) & " " & fmtTime(time) & " +1000"
		eml = "<?xml version=" & qu & "1.0" & qu & " encoding=" & qu & "ISO-8859-1" & qu & " ?>" & cr
		eml = eml & "<?xml-stylesheet type=" & qu & "text/xsl" & qu & " href=" & qu & Application("nsx_SiteRootURL") & "/ftp/rss/rss2html.xsl" & qu & " version=" & qu & "1.0" & qu & "?>" & cr  
		eml = eml & "<rss version=" & qu & "2.0" & qu & ">" & cr
		eml = eml & "<channel>" & cr
		eml = eml & "<title>NSX National Stock Exchange of Australia Depth</title>" & cr
		eml = eml & "<link>" & Application("nsx_SiteRootURL") & "</link>" & cr
		eml = eml & "<category>Business</category>"
		eml = eml & "<category>Investing</category>"
		eml = eml & "<category>Stocks and Bonds</category>"
		eml = eml & "<category>Exchanges</category>"
		eml = eml & "<description>NSX National Stock Exchange of Australia Depth</description>" & cr
		eml = eml & "<language>en-us</language>" & cr
		eml = eml & "<copyright>Copyright 1937-" & year(date)  & " NSX</copyright>" & cr
		eml = eml & "<docs>" & Application("nsx_SiteRootURL") & "/ftp/rss</docs>" & cr
		eml = eml & "<lastBuildDate>" & PubDate & "</lastBuildDate>" & cr
		eml = eml & "<image>"
		eml = eml & "<title>NSX Prices</title>"
		eml = eml & "<url>" & Application("nsx_SiteRootURL") & "/images/NSX-LOGOx150.gif</url>"
		eml = eml & "<link>" & Application("nsx_SiteRootURL") & "</link>"
		eml = eml & "</image>"
		
	case "mddl"
		mddl = ""
	
	case "yahoo"
		yahoo = ""
	
end select



' multiple pages
active=ucase(request("active"))
if len(active)=0 then
	srch = " WHERE (issuestatus = 'Active') "
	else
	srch = " WHERE (issuestatus = '" & SafeSqlParameter(active) & "') "
end if

' display todays prices
' if multiple codes requested then restrict by that otherwise ALL codes.
nsxcodes=ucase(trim(request("nsxcode") & " "))
board=ucase(trim(request("board") & " "))
grp=ucase(request("group"))
if trim(grp & " ") = "" then grp="YES"


' construct search for multiple codes.
if len(nsxcodes)<>0 then
	tradingcodes=nsxcodes
	nsxcodes=replace(nsxcodes," ","")
	nsxcodes=replace(nsxcodes,";",",")
	nsxcodes=replace(nsxcodes,vbCRLF,"")
	nsxcodes=replace(nsxcodes,".","")
	nsxcodes=replace(nsxcodes,",,",",")

	srch = srch & " AND "
	nsxcodes=split(nsxcodes,",")
	for ii = 0 to ubound(nsxcodes)
		if grp = "YES" then
			srch = srch & "(left(tradingcode,3)='" & SafeSqlParameter(left(nsxcodes(ii),3)) & "') OR "
			else
			srch = srch & "(tradingcode='" & SafeSqlParameter(nsxcodes(ii)) & "') OR "
		end if
	next
	srch = left(srch,len(srch)-4)
	srch = srch & " "
end if

if len(board)<>0 then
	srch = srch & " AND exchid='" & SafeSqlParameter(board) & "' "
end if 

'response.write srch & "<BR>"
'response.write request.servervariables("QUERY_STRING")
'response.end

 ' get date for latest prices
Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
 
ConnPasswords.Open Application("nsx_ReaderConnectionString")
SQL = "SELECT tradingcode,tradedatetime,issuedescription,marketdepth "
SQL = SQL & " FROM pricescurrent  "
SQL = SQL &  srch 
SQL = SQL & " ORDER BY " & srt & " ASC"
'response.write SQL & "<BR>"
'response.end
CmdDD.CacheSize=100 
CmdDD.Open SQL, ConnPasswords,1,3

WEOF = CmdDD.EOF
sessionmode=""
'can only do getrows if there is more than one record.
if not WEOF then 
	alldata = cmddd.getrows
	rc = ubound(alldata,2) 
	tradedatetime = alldata(1,0)
	
		if isdate(tradedatetime) then
			tradedatetime = tradedatetime 
		else
			tradedatetime = now
		end if
	
	else
		rc = -1
end if

CmdDD.Close
Set CmdDD = Nothing

  ConnPasswords.Close
	Set ConnPasswords = Nothing

    IF rc=-1 THEN 
    	response.write "No record details available" 
    ELSE
      jj=0
       FOR jj = 0 to rc
 
 		tradingcode = alldata(0,jj)
      	  'if left(trim(ucase(tradingcode)),3)<>"" then
      	  
      	  tradedatetime = alldata(1,jj)
      	 
		issuedescription = alldata(2,jj)
		marketdepth=""
		marketdepth = alldata(3,jj)
		

				
 ' format the price data   
 select case fmt
 	case "xml"
 	
 	' modified XML format
 		 precise = ""
      	  precise = precise & "<marketdepth>"  & marketdepth & "</marketdepth>" & cr
      	       	  
      	  
      	  release = tradedatetime
     	  release = left(weekdayname(weekday(release),1),3) & ", " & Day(release) & " " & monthname(month(release),1) & " "  & year(release) & " " & fmtTime(release) & " +1000"      	  
      	  
   	  		eml = eml & "<item>" & cr
   	  		eml = eml & "<title>" &  ApplyXMLFormatting(tradingcode) &  " " & ApplyXMLFormatting(issuedescription) & "</title>" & cr
   	  		eml = eml & "<description>" & ApplyXMLFormatting(title)  & "</description>" & cr
   	  		eml = eml & precise & cr
			eml = eml & "<link>" & Application("nsx_SiteRootURL") & "/prices_alpha.asp?nsxcode=" & tradingcode & "</link>" & cr
			eml = eml & "<author>" & Author & "</author>" & cr
			eml = eml & "<pubDate>" & release & "</pubDate>" & cr 
			eml = eml & "<guid isPermaLink=" & qu & "false" & qu & ">" & Application("nsx_SiteRootURL") & "/prices_alpha.asp?nsxcode=" & tradingcode & "</guid>" & cr
   	  		eml = eml & "<category>NSX Stock Exchange Prices</category>" & cr
   	  		eml = eml & "<comments>" & Application("nsx_SiteRootURL") & "</comments>" & cr
			eml = eml & "</item>" & cr & cr
 	
 	case "txt"
 	
 	
 	txt = txt & qu & tradingcode & qu & tb 
 	txt = txt & qu & issuedescription & qu & tb 
 	txt = txt  & qu & marketdepth & qu  & cr
 	txt = txt  & qu & formatdatetime(tradedatetime,3) & qu & tb 
 	txt = txt & cr
 	
 	case "rss"
 	
 		' standard RSS format
 		  release = tradedatetime
     	  release = left(weekdayname(weekday(release),1),3) & ", " & Day(release) & " " & monthname(month(release),1) & " "  & year(release) & " " & fmtTime(release) & " +1000"      	  
      	  precise = ""
      	  precise = precise & "<br>" & "Last Update: " & release
      	  precise = precise & "<br>" & "Market Depth: " & marketdepth
      	  precise = precise & "<br><br>" & "<img src=" & Application("nsx_SiteRootURL") & "/images/NSX-LOGOx150.gif border=0 height=20 align=middle>National Stock Exchange of Australia"

      	  precise = precise & "<br>"
      	  precise = ApplyXMLFormatting(precise)
      	  
   	  		eml = eml & "<item>" & cr
   	  		eml = eml & "<title>" &  ApplyXMLFormatting(tradingcode) &  " " & ApplyXMLFormatting(issuedescription) & "</title>" & cr
   	  		eml = eml & "<description>" & precise  & "</description>" & cr
			eml = eml & "<link>" & Application("nsx_SiteRootURL") & "/prices_alpha.asp?nsxcode=" & tradingcode & "</link>" & cr
			eml = eml & "<author>" & Author & "</author>" & cr
			eml = eml & "<pubDate>" & release & "</pubDate>" & cr 
			eml = eml & "<guid isPermaLink=" & qu & "false" & qu & ">" & Application("nsx_SiteRootURL") & "/prices_alpha.asp?nsxcode=" & tradingcode & "</guid>" & cr
   	  		eml = eml & "<category>NSX Stock Exchange Prices</category>" & cr
   	  		eml = eml & "<comments>" & Application("nsx_SiteRootURL") & "</comments>" & cr
			eml = eml & "</item>" & cr & cr
 	
 	case "mddl"
 	
 	case "yahoo"
 	
 	
 	
 	yahoo = yahoo & qu & tradingcode & qu & tb & last & tb & qu & formatdatetime(tradedatetime,3) & qu & tb  & qu & issuedescription & qu & tb & qu & marketdepth & qu & cr
  
end select
      	  
    	  
    	  NEXT
    	  
   ' write footer 	  
   select case fmt
 	case "xml"
 		eml = eml & "</channel>" & cr
		eml = eml & "</rss>" & cr
		response.write eml
 	
 	case "txt"
 		response.write txt
 	
 	case "rss"
 		eml = eml & cr & cr & "</channel>" & cr
		eml = eml & cr & cr & "</rss>" & cr
		response.write eml
   
 	
 	case "mddl"
 	
 	case "yahoo"
 		response.write yahoo
  
	end select

END IF


    %>
     
 