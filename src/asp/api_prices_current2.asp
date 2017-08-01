<%@ LANGUAGE="VBSCRIPT" %>
<!--#INCLUDE FILE="include/sql_functions.asp"-->
<%Server.ScriptTimeout=180

response.expires = 0
response.expiresabsolute = #JAN 2, 2000 00:00:00#
response.cachecontrol = "PRIVATE"


'Formats
' fmt=xml, txt, rss, mddl, yahoo, stator
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
		eml = eml & "<title>NSX National Stock Exchange of Australia Prices</title>" & cr
		eml = eml & "<link>" & Application("nsx_SiteRootURL") & "</link>" & cr
		eml = eml & "<category>Business</category>"
		eml = eml & "<category>Investing</category>"
		eml = eml & "<category>Stocks and Bonds</category>"
		eml = eml & "<category>Exchanges</category>"
		eml = eml & "<description>NSX National Stock Exchange of Australia Prices</description>" & cr
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
		eml = eml & "<title>NSX National Stock Exchange of Australia Prices</title>" & cr
		eml = eml & "<link>" & Application("nsx_SiteRootURL") & "</link>" & cr
		eml = eml & "<category>Business</category>"
		eml = eml & "<category>Investing</category>"
		eml = eml & "<category>Stocks and Bonds</category>"
		eml = eml & "<category>Exchanges</category>"
		eml = eml & "<description>NSX National Stock Exchange of Australia Prices</description>" & cr
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
		
	case "stator"
		stator = ""
	
end select



' multiple pages
active=ucase(request("active"))
srch = ""
if len(active)=0 then
	srch = " WHERE (prid > 1 ) "
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
			srch = srch & "(left(tradingcode,3)='" & left(nsxcodes(ii),3) & "') OR "
			else
			srch = srch & "(tradingcode='" & nsxcodes(ii) & "') OR "
		end if
	next
	srch = left(srch,len(srch)-4)
	srch = srch & " "
end if

if len(board)<>0 then
	srch = srch & " AND exchid='" & board & "' "
end if 

'response.write srch & "<BR>"
'response.write request.servervariables("QUERY_STRING")
'response.end

 ' get date for latest prices
Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
 
ConnPasswords.Open Application("nsx_ReaderConnectionString")
SQL = "SELECT [tradingcode],[tradedatetime],[open],[high],[low],[last],[volume],[bid],[offer],[bidqty],[offerqty],[tradestatus],[exchid],[currentsharesonissue],[isin],[issuedescription],[issuetype],[industryclass],[marketcap],sessionmode,marketdepth,quotebasis,prvclose "
SQL = SQL & " FROM pricescurrent  "
SQL = SQL &  srch 
SQL = SQL & " ORDER BY " & srt & " ASC"
'response.write SQL & "<BR>"
'x = 20/0
'response.end
CmdDD.CacheSize=100 
CmdDD.Open SQL, ConnPasswords,1,3

WEOF = CmdDD.EOF
sessionmode=""
'can only do getrows if there is more than one record.
if not WEOF then 
	alldata = cmddd.getrows
	rc = ubound(alldata,2) 
	sessionmode = alldata(19,0)
	tradedatetime = alldata(1,0)
	tradestatus= alldata(11,0)
	
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
	
' market status
smodecolor="red"
smode=ucase(trim(sessionmode & " "))
'security status
secmode = smode
secmodecolor = "red"

select case smode
	case "NORMAL"
		smode="TRADING"
		smodecolor="green"
	case "CLOSED"
		smode="CLOSED"
	case "AHA"
		smode="ADJUST"
	case "ENQUIRY"
		smode = "CLOSED"
	case "HALT"
		smode="TRADING"	
		smodecolor="green"
	case "PREOPEN"
		smode="PREOPEN"
		smodecolor="green"
	case ""
		secmode="CLOSED"
		smodecolor="red"
end select

' now for security mode
secmodetest = secmode
select case secmodetest
	case "NORMAL"
		secmode="TRADING"
		secmodecolor="green"
	case "CLOSED"
		secmode =""
	case "AHA"
		secmode=""
	case "ENQUIRY"
		secmode = ""		
	case ""
		secmode=""
end select

if (instr(tradestatus,"SU")>0) and len(tradingcodes)>0 then
	secmode="SUSPENDED"
	secmodecolor="red"
end if


    IF rc=-1 THEN 
    	response.write "No price details available" 
    ELSE
      jj=0
       FOR jj = 0 to rc
 
 		tradingcode = alldata(0,jj)
      	  'if left(trim(ucase(tradingcode)),3)<>"" then
      	  
      	  tradedatetime = alldata(1,jj)
      	  open = alldata(2,jj)
      	  high = alldata(3,jj)
      	  low = alldata(4,jj)
      	  last = alldata(5,jj)
      	  volume = alldata(6,jj)
		  bid = alldata(7,jj) ' buy
'Response.write "Last=" & last
'Response.End		
		  offer = alldata(8,jj) ' sell
		  bidqty = alldata(9,jj)
		  offerqty = alldata(10,jj)
			' hyperlink announcements
			sessionmode = ucase(trim(alldata(19,jj) & " "))
			smode = ""
			if sessionmode = "HALT" then smode = "TH"
			if sessionmode = "PREOPEN" then smode = "PRE"
			status = ""
			quotebasis = alldata(21,jj)
			tradestatus=alldata(11,jj)
			status2 = trim(ucase(tradestatus & " " & smode & " " & quotebasis )) ' status flag
			if status2 <> "" then
				status =  status2 
			end if
			
		board = alldata(12,jj)
		if board = "NCRP" then BOARD="IND"
		if board = "MAIN" then BOARD="IND"
		if board = "NPRP" then BOARD="PROP"
		if trim(board & " ") = "" then BOARD="IND"
		currentsharesonissue = alldata(13,jj)
		if len(trim(currentsharesonissue & " "))= 0 then currentsharesonissue = 0
		isin = alldata(14,jj)
		issuedescription = alldata(15,jj)
		issuetype = alldata(16,jj)
		industryclass = alldata(17,jj)
		marketdepth=""
		marketdepth = alldata(20,jj)
		prvclose=alldata(22,jj)
		
		
		
		If (last <> "0" OR prvclose <>"0") And currentsharesonissue <> "0" Then 
		if CDbl(last) <> 0 And CDbl(currentsharesonissue) > 0 then 

			marketcap = (CDbl(last) * CDbl(currentsharesonissue))/1000000.0
			else
			marketcap = (CDbl(prvclose) * CDbl(currentsharesonissue))/1000000.0
		end if
		End If

'Response.Write tradingcode & " Last:" & last & " prvclose:" & prvclose & " currentsharesonissue:" & currentsharesonissue 

'xx = 30/0.0
'Response.End
		
      	  if volume<>0 and open = 0 then open = last
      	  if volume<>0 and high = 0 then high = last
      	  if volume<>0 and low = 0 then low = last
      	  if (open<>0) and (open > high) then high = open
		  if (open<>0) and (open < low) then low = open

		' calculate the percentage change
		' intra-day movement
      	 if open = 0 then
			change = 0
			else
			change = 100*((last-open)/open)
		end if
		' interday movement
		 if last = 0 or prvclose=0 then
			dchange = 0
			else
			dchange = 100*((last-prvclose)/prvclose)
		end if
		If IsNumeric(last) Then last = CDbl(last)
		If IsNumeric(bid) Then bid = CDbl(bid)
		If IsNumeric(offer) Then offer = CDbl(offer)
		If IsNumeric(low) Then low = CDbl(low)
		If IsNumeric(high) Then high = CDbl(high)
		If IsNumeric(open) Then open = CDbl(open)
		If IsNumeric(volume) Then volume = CDbl(volume)
		If IsNumeric(bidqty) Then bidqty = CDbl(bidqty)
		If IsNumeric(offerqty) Then offerqty = CDbl(offerqty)
		If IsNumeric(change) Then change = CDbl(change)
		If IsNumeric(dchange) Then dchange = CDbl(dchange)

		 	last = formatnumber(last,3)
		 	prvclose = prvclose
		 	bid = formatnumber(bid,3)
		 	offer = formatnumber(offer,3)
		 	low = formatnumber(low,3)
		 	high = formatnumber(high,3)
		 	open = formatnumber(open,3)
		 	volume = formatnumber(volume,0)
		 	bidqty = formatnumber(bidqty,0)
	 		offerqty = formatnumber(offerqty,0)
			marketcap = marketcap	
			change = formatnumber(change,2)
		 	dchange = formatnumber(dchange,2)
	
				
 ' format the price data   
 select case fmt
 	case "xml"
 	
 	' modified XML format
 		 precise = ""
      	  precise = precise & "<last>"  & last & "</last>" & cr
      	  precise = precise & "<bidqty>"  & bidqty & "</bidqty>" & cr
      	  precise = precise & "<bid>" & bid & "</bid>" & cr
      	  precise = precise & "<offer>"& Offer & "</offer>" & cr
      	  precise = precise & "<offerqty>"& OfferQty & "</offerqty>" & cr
      	  precise = precise & "<change>" & change & "</change>" & cr
      	  precise = precise & "<open>" & open & "</open>" & cr
      	  precise = precise & "<high>" & High & "</high>" & cr
      	  precise = precise & "<low>" & Low & "</low>" & cr
      	  precise = precise & "<volume>" & replace(Volume,",","") & "</volume>" & cr
      	  precise = precise & "<marketcap>" & replace(marketcap,",","") & "</marketcap>" & cr
      	  precise = precise & "<status>" & status & "</status>" & cr
      	  precise = precise & "<prvclose>" & prvclose & "</prvclose>" & cr
      	  precise = precise & "<prvchange>" & dchange & "</prvchange>" & cr
      	  precise = precise & "<issuedshares>"& replace(currentsharesonissue,",","") & "</issuedshares>" & cr
      	  precise = precise & "<issuetype>" & issuetype & "</issuetype>" & cr
      	  precise = precise & "<industry>" & industryclass & "</industry>" & cr
      	  
      	  
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
 	
 	pch = last - prvclose
 	psgn = ""
 	if pch > 0 then 
 		psgn = "+"
 		else
 		psgn = ""
 	end if
 		
 	if dchange > 0 then 
 		dsgn = "+"
 		else
 		dsgn = ""
 	end if
 	
 	If IsDate(tradedatetime) Then tradedatetime = CDate(tradedatetime)
 	txt = txt & qu & tradingcode & qu & tb 
 	txt = txt  & last & tb 
 	'txt = txt  & qu & formatdatetime(tradedatetime,3) & qu & tb 
	txt = txt  & qu & tradedatetime & qu & tb 
 	txt = txt & qu & psgn & pch & qu & tb
 	txt = txt & qu & dsgn & dchange & "%" & qu & tb 
 	txt = txt & qu & issuedescription & qu & tb
 	txt = txt & open & tb
 	txt = txt & high & tb
 	txt = txt & low & tb
 	txt = txt & trim(replace(volume & " ",",","")) & tb
 	txt = txt & trim(replace(marketcap & " ",",","")) & tb
 	txt = txt & qu & status & qu & tb
 	txt = txt & prvclose & tb
 	txt = txt & trim(replace(currentsharesonissue & " ",",","")) & tb
 	txt = txt & qu & issuetype & qu & tb
 	txt = txt & qu & industryclass & qu & tb
 	txt = txt & bid & tb
 	txt = txt & replace(bidqty,",","") & tb
 	txt = txt & offer & tb
 	txt = txt & replace(offerqty,",","")
 	txt = txt & cr
 	
 	case "rss"
 	
 		' standard RSS format
 		  release = tradedatetime
     	  release = left(weekdayname(weekday(release),1),3) & ", " & Day(release) & " " & monthname(month(release),1) & " "  & year(release) & " " & fmtTime(release) & " +1000"      	  
      	  precise = ""
      	  precise = precise & "<br>" & "Last Update: " & release
      	  precise = precise & "<br>" & "Last: " & last
      	  precise = precise & "<br>"& "Bid Qty: " & bidqty
      	  precise = precise & "<br>"& "Bid: " & bid
      	  precise = precise & "<br>"& "Offer: " & Offer
      	  precise = precise & "<br>"& "Offer Qty: " & OfferQty
      	  precise = precise & "<br>"& "Change: " & change
      	  precise = precise & "<br>"& "Open: " & open
      	  precise = precise & "<br>"& "High: " & High
      	  precise = precise & "<br>"& "Low: " & Low
      	  precise = precise & "<br>"& "Volume: " & Volume
      	  precise = precise & "<br>"& "Market Cap: " & marketcap
      	  precise = precise & "<br>"& "Status: " & status
      	  precise = precise & "<br>"& "Previous Close: " & prvclose
      	  precise = precise & "<br>"& "Previous Change: " & dchange
      	  precise = precise & "<br>"& "Issued Shares: " & currentsharesonissue
      	  precise = precise & "<br>"& "Issue Type: " & issuetype
      	  precise = precise & "<br>"& "Industry: " & industryclass
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
 	
 	pch = last - prvclose
 	psgn = ""
 	if pch > 0 then 
 		psgn = "+"
 		else
 		psgn = ""
 	end if
 		
 	if dchange > 0 then 
 		dsgn = "+"
 		else
 		dsgn = ""
 	end if
 	
 	
 	yahoo = yahoo & qu & tradingcode & qu & tb & last & tb & qu & formatdatetime(tradedatetime,3) & qu & tb & qu & psgn & pch & " - " & dsgn & dchange & "%" & qu & tb & qu & issuedescription & qu & cr
 
  	case "stator"
 	
 	pch = last - prvclose
 	psgn = ""
 	if pch > 0 then 
 		psgn = "+"
 		else
 		psgn = ""
 	end if
 		
 	if dchange > 0 then 
 		dsgn = "+"
 		else
 		dsgn = ""
 	end if
	if len(volume)<>0 then 
		volume = replace(volume,",","")
		else
		volume = 0
	end if
 	
 	
 	stator = stator & qu & tradingcode & qu  & tb & last & tb & qu & formatdatetime(tradedatetime,3) & qu  & tb & qu & psgn & pch & " - " & dsgn & dchange & "%" & qu  & tb 
	stator = stator & qu & issuedescription & qu  & tb & open & tb & high & tb & low & tb & last & tb & prvclose & tb & volume & cr
  
 
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
	
	case "stator"
 		response.write stator
  
	end select

END IF


    %>
     
 