<%@ LANGUAGE="VBSCRIPT" %>
<%Server.ScriptTimeout=360%>
<%
response.expires = 0
response.expiresabsolute = #JAN 2, 2000 00:00:00#
response.cachecontrol = "PRIVATE"


function debugfn(x)

	debugflag = false
	if debugflag then
		'response.write x & "<br>"
	end if
end function

' **** DEFAULT VARIABLES *****
' fields to emulate SQL, why not just use the SQL string, because of complications with special characters???
' query database  SELECT ONLY, no UPDATES or INSERTS allowed.
nsxtable = trim(ucase(request.querystring("nsxtable") & " ")) ' default values 
nsxdb = trim(ucase(request.querystring("nsxdb") & " ")) ' default values (required)
nsxfields = request.querystring("nsxfields") ' null = all fields
nsxsql = request.querystring("nsxsql") ' sql command sent direct ... overrides everything else
nsxsqlflag = ucase(request.querystring("nsxsqlflag")) ' sql command sent direct ... overrides everything else
nsxsortorder = request.querystring("nsxsortorder")  ' "DESC"  ... sort order
nsxsearch = ""
nsxsearch = request.querystring("nsxsearch")  ' "field=criteria,field2=criteria2"  ... null is no search

' specific search
nsxboardgroupid = request.querystring("nsxboardgroupid")  '  "SIM" .. null means all groups
nsxboardid = request.querystring("nsxboardid") ' "SIMV" .. null means all boards
'if len(nsxsearch) = 0 then nsxsearch = " exchid ='" & nsxboardid & "' "

nsxcode = request.querystring("nsxcode") ' "ITH"  .. null means all securities
nsxdatefrom = request.querystring("nsxdatefrom") ' assumes well formed date e.g. 1-jan-2010
nsxdateto = request.querystring("nsxdateto") ' assumes well formed date e.g. 1-jan-2010
nsxtop = trim(request.querystring("nsxtop") & " ") ' sql top 10 etc.
if len(nsxtop)<>0 then nsxtop = " TOP " & nsxtop

' security
nsxun = request.querystring("nsxun")  ' need to block hackers username
nsxpw = request.querystring("nsxpw") '  need to block hackers password
nsxfmt = request.querystring("nsxfmt") ' "XML" or "TXT"  ... that is comma segmented value with " quotes around text old PRN style.
' nsx_data_receiver will also check the referring url to make sure it includes nsx_data_collector.asp
' will decouple database to produce XML files later for performance


' simple security first
if (nsxpw = "simv" and nsxun = "simv") or (nsxpw = "nsxa" and nsxun = "nsxa") or (nsxpw = "bsxm" and nsxun = "bsxm") then 
	nsxlogin = True
	else
	nsxlogin = false
end if
if not nsxlogin then response.end


' format SQL query string either passthrough SQL as is or format from variables.
if nsxsqlflag = "TRUE" then
	SQL = nsxsql 
	else

	SELECT CASE ucase(nsxdb)

	case "PRICES"
	nsxsearch = request.querystring("nsxsearch")  ' "field=criteria,field2=criteria2"  ... null is no search
	nsxsearch = trim(replace(nsxsearch & " ","WHERE",""))
	if len(nsxsearch)<>0 and len(nsxboardid)<>0 then
		nsxsearch = nsxsearch & " AND (pricescurrent.exchid='" & nsxboardid & "') AND (issuestatus = 'Active')"
		else
		nsxsearch = " (pricescurrent.exchid='" & nsxboardid & "') AND (issuestatus = 'Active')"
	end if 

	'response.write nsxsearch
	SQL = "SELECT " & nsxtop & "[tradingcode],[tradedatetime],[open],[high],[low],[last],[volume],[bid],[offer],[bidqty],[offerqty],[tradestatus],[exchid],[currentsharesonissue],[isin],[issuedescription],[issuetype],[industryclass],[marketcap],[sessionmode],[marketdepth],[quotebasis],[prvclose],[currenteps],[currentdps],[currentnta] "
	SQL = SQL & " FROM pricescurrent  "
	if len(nsxsearch)<>0 then SQL = SQL & " WHERE " & nsxsearch
	if len(nsxsortorder)<>0 then SQL = SQL & " ORDER BY " & nsxsortorder
	'response.write SQL
	
	case "PRICESTRADES"
	SQL = "SELECT " & nsxtop & " PricesTrades.SalePrice, PricesTrades.SaleVolume, PricesTrades.TradeDateTime, pricestrades.adddelete "
	SQL = SQL & " FROM BrokerSellers INNER JOIN (BrokerBuyers INNER JOIN (PricesTrades INNER JOIN StockCodes ON PricesTrades.TradingCode = StockCodes.StockCode) ON BrokerBuyers.BrokerId = PricesTrades.BuyerID) ON BrokerSellers.BrokerId = PricesTrades.SellerID "
	if len(nsxsearch)<>0 then SQL = SQL & " WHERE " & nsxsearch
	if len(nsxsortorder)<>0 then SQL = SQL & " ORDER BY " & nsxsortorder

	
	case "ANNOUNCEMENTS"
	SQL = "SELECT " & nsxtop & " coAnn.annid,annPrecise,annFile,annRelease,annTitle,annFileSize,coAnn.tradingcode,annUpload,coIssues.IssueDescription, annPriceSensitive, coAnn.displayboard "
	SQL = SQL & " FROM coIssues INNER JOIN coAnn ON coIssues.tradingcode = coAnn.tradingcode "
	if len(nsxsearch)<>0 then 
		SQL = SQL & " WHERE (coAnn.annRelease is not null) AND "
		' remove next 6 lines after BSX migration is complete		
		SQL = SQL & " ("
		SQL = SQL & " coAnn.tradingcode <> 'CAP' AND coAnn.tradingcode <> 'CFY' AND coAnn.tradingcode <> 'KEW' AND coAnn.tradingcode <> 'MEV'"
		SQL = SQL & " AND coAnn.tradingcode <> 'EIC' AND coAnn.tradingcode <> 'ARF' AND coAnn.tradingcode <> 'BRF' AND coAnn.tradingcode <> 'CLG'"
		SQL = SQL & " AND coAnn.tradingcode <> 'DCE' AND coAnn.tradingcode <> 'EMU' AND coAnn.tradingcode <> 'GHC' AND coAnn.tradingcode <> 'MBK'"
		SQL = SQL & " AND coAnn.tradingcode <> 'TCB' AND coAnn.tradingcode <> 'WTA' "
		SQL = SQL & " ) AND"
		SQL = SQL & nsxsearch
	end if
	if len(nsxsortorder)<>0 then SQL = SQL & " ORDER BY " & nsxsortorder
	
	case "DIARY"
	nsxfields = "[id],[newsdate],[newstitle],[newsprecise],[newsurl] "
	SQL = "SELECT " & nsxtop & " "  & nsxfields
	SQL = SQL & " FROM diary "
	if len(nsxsearch)<>0 then SQL = SQL & " WHERE " & nsxsearch
	if len(nsxsortorder)<>0 then SQL = SQL & " ORDER BY " & nsxsortorder
	
	case "OFFICIALLIST"
		SQL = "SELECT coDetails.coName, coIssues.nsxcode, coIssues.tradingcode, coIssues.ISIN, coIssues.IssueDescription, coIssues.IssueStatus, codetails.agadvisers, coissues.ibrokers, coissues.issuestarted, coissues.issuetype, codetails.agfacilitators "
		SQL = SQL & " FROM coDetails INNER JOIN coIssues ON (coDetails.nsxcode = coIssues.nsxcode) "
		SQL = SQL & " WHERE ((coIssues.iNewFloat=false) and (coIssues.IssueStatus='Active')) "
	if len(nsxsearch)<>0 then SQL = SQL & " AND " & nsxsearch
	if len(nsxsortorder)<>0 then SQL = SQL & " ORDER BY " & nsxsortorder
	
	case "SUSPENDED"
		SQL = "SELECT  nsxcode,issuedescription,tradingcode,issuestopped FROM coIssues "
		SQL = SQL & " WHERE (coIssues.iNewFloat=false) AND (coIssues.Issuestatus ='SUSPENDED') "
	if len(nsxsearch)<>0 then SQL = SQL & " AND " & nsxsearch
	if len(nsxsortorder)<>0 then SQL = SQL & " ORDER BY " & nsxsortorder

	
	case "DELISTED"
		SQL = "SELECT  nsxcode,issuedescription,tradingcode,issuestopped FROM coIssues "
		SQL = SQL & " WHERE (coIssues.iNewFloat=false) AND (coIssues.Issuestatus ='DELISTED') "
	if len(nsxsearch)<>0 then SQL = SQL & " AND " & nsxsearch
	if len(nsxsortorder)<>0 then SQL = SQL & " ORDER BY " & nsxsortorder
			
	case "WAIVERS"
	SQL = "SELECT  wid,dateapproved,ruledescshort,RequestedForSecurities,SectionNumber,RuleNumber,RequestedForIssuer,waiverrequested,waivereffect FROM waivers "
	if len(nsxsearch)<>0 then SQL = SQL & " WHERE " & nsxsearch
	if len(nsxsortorder)<>0 then SQL = SQL & " ORDER BY " & nsxsortorder
	
	case "NEWISSUES"
	
	SQL = "SELECT codetails.nsxcode, coName, agStatus, Cityname, agName, agLevel, agBuild,"
	SQL= SQL & "agAddress, Stateb, Country, agPCode, agSuburb, agPOBOX, agPOSuburb, agPOPcode,"
	SQL= SQL & "agemail0, agemail1, agemail2,  agemail4, agemail5, agemail6, agemail7,"
	SQL= SQL & "agemail8, agemail9, agweb0, agweb1, agweb2, agweb3, agweb4, agweb5, agweb6, agweb7,"
	SQL= SQL & "agweb8, agweb9, agWho, agHistory, agServices, agLogo, agStrapline, agShortDesc,"
	SQL= SQL & "agPhone, agFax, agExpiry, agContactName, agContactTitle, agNotes, agLink01, agLink02,"
	SQL= SQL & "agLink03, agLink04, agLink05, agLinkTitle01, agLinkTitle02, agLinkTitle03, agLinkTitle04,"
	SQL= SQL & "agLinkTitle05, codetails.RecordChangeUser, agNature, agBillingNotes, iPdate, iNewFloat,"
	SQL= SQL & "agListedDate, agPActivities, iIndustryClass, iIssuePrice, iIssueType, iCapitalRaised,"
	SQL= SQL & "iOfferCloseDate, iFloatUnderwriter, iOfferDocument, agDelisted, agDelistedDate,"
	SQL= SQL & "agSuspended, agSuspendedDate, agACN, agABN, agChairman, agMD, agSecretary, agDirectors,"
	SQL= SQL & "agRegistry, agBankers, agBrokers, agAdvisers, agSolicitors, agEx01, agEx02, agEx03,"
	SQL= SQL & "agDomicile, iFloatDesc, iBrokers, iTRanche, IssueDescription, agaccountants, tradingcode, ISIN"
	SQL = SQL & " FROM  (((coDetails INNER JOIN coIssues ON coDetails.nsxcode = coIssues.nsxcode) INNER JOIN [lookup - cities] ON coDetails.agCity = [lookup - cities].tid) INNER JOIN [lookup - states] ON coDetails.agState = [lookup - states].sid) INNER JOIN [lookup - country] ON coDetails.agCountry = [lookup - country].cid "
	SQL = SQL & " WHERE (iNewFloat=True) "
	if len(nsxsearch)<>0 then SQL = SQL & " AND " & nsxsearch
	if len(nsxsortorder)<>0 then SQL = SQL & " ORDER BY " & nsxsortorder
	
		
	case "DIVIDENDS"

		
	case "CAPITAL"

		
	case "INDEX"

	
	case "BROKERS"

	
	case "ADVISERS"

	
	case "FACILITATORS"
	
	
	case "PRICESTICKER"
	nsxfields = "[tradingcode], [tradedatetime], [open], [last], [sessionmode], [volume],[prvclose]"
	SQL = "SELECT " & nsxfields
	SQL = SQL & " FROM pricescurrent "
	if len(nsxsearch)<>0 then SQL = SQL & " WHERE " & nsxsearch
	if len(nsxsortorder)<>0 then SQL = SQL & " ORDER BY " & nsxsortorder

	case "INDEXTICKER"
	nsxfields = "[tradingcode], [tradedatetime], [open], [last],[prvclose]"
	SQL = "SELECT " & nsxfields
	SQL = SQL & " FROM indexcurrent "
	if len(nsxsearch)<>0 then SQL = SQL & " WHERE " & nsxsearch
	if len(nsxsortorder)<>0 then SQL = SQL & " ORDER BY " & nsxsortorder

	
	CASE ELSE
	' when selecting the db direct rather than a canned script (as above).
	SQL = " SELECT " & nsxtop & " " & nsxfields
	SQL = SQL & " FROM " & nsxtable & " "
	' may need to include HAVING and GROUP
	if len(nsxsearch)<>0 then SQL = SQL & " WHERE " & nsxsearch
	if len(nsxsortorder)<>0 then SQL = SQL & " ORDER BY " & nsxsortorder
	
END SELECT



end if 

' select the correct database
SELECT CASE nsxdb

	case "PRICES" 
	DATA_PATH = Server.Mappath("newsxdb\nsxprices.mdb")
	
	case "PRICESTRADES"
	DATA_PATH = Server.Mappath("newsxdb\nsxprices.mdb")
	
	case "PRICESTICKER"
	DATA_PATH = Server.Mappath("newsxdb\nsxprices.mdb")
	
	case "INDEX" 
	DATA_PATH = Server.Mappath("newsxdb\nsxindex.mdb")
	
	case "INDEXTICKER"
	DATA_PATH = Server.Mappath("newsxdb\nsxindex.mdb")
	
	case "ANNOUNCEMENTS"
	DATA_PATH = Server.Mappath("newsxdb\newsxdb.mdb")
	
	case "SUSPENDED"
	DATA_PATH = Server.Mappath("newsxdb\newsxdb.mdb")
	
	case "DELISTED"
	DATA_PATH = Server.Mappath("newsxdb\newsxdb.mdb")
	
	case "OFFICIALLIST"
	DATA_PATH = Server.Mappath("newsxdb\newsxdb.mdb")
	
	case "WAIVERS"
	DATA_PATH = Server.Mappath("newsxdb\newsxdb.mdb")
	
	case "DIARY"
	DATA_PATH = Server.Mappath("newsxdb\nsxmarket.mdb")
		
	case "DIVIDENDS"
	DATA_PATH = Server.Mappath("newsxdb\nsxcorporateactions.mdb")
		
	case "CAPITAL"
	DATA_PATH = Server.Mappath("newsxdb\nsxcorporateactions.mdb")
		
	case "INDEX"
	DATA_PATH = Server.Mappath("newsxdb\nsxindex.mdb")
	
	case "BROKERS"
	DATA_PATH = Server.Mappath("newsxdb\newsxdb.mdb")
	
	case "ADVISERS"
	DATA_PATH = Server.Mappath("newsxdb\newsxdb.mdb")
	
	case "FACILITATORS"
	DATA_PATH = Server.Mappath("newsxdb\newsxdb.mdb")
	
	case "NEWISSUES"
	DATA_PATH = Server.Mappath("newsxdb\newsxdb.mdb")
	
	CASE ELSE
	' database name directly referenced.
	DATA_PATH = Server.Mappath("newsxdb\" & nsxdb & ".mdb")
	
END SELECT
	
		
Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
strConnString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & DATA_PATH 
ConnPasswords.Open strConnString 
'SQL = "SELECT pricesdaily.tradingcode, IssueDescription, cdate(Format([pricesdaily.tradedatetime],'mmm-yyyy')), First(pricesdaily.last), Max(pricesdaily.last) , Min(pricesdaily.last), Last(pricesdaily.last), Sum(pricesdaily.volume), last(pricesdaily.last), last(pricesdaily.last) "
'SQL = SQL & " FROM pricescurrent INNER JOIN pricesdaily ON pricesdaily.tradingcode = pricescurrent.tradingcode "
'SQL = SQL & " GROUP BY pricesdaily.tradingcode, pricescurrent.IssueDescription, cdate(Format([pricesdaily.tradedatetime],'mmm-yyyy')) "
'SQL = SQL & " HAVING (pricesdaily.tradingcode='" & id & "') " & srch
'SQL = SQL & " ORDER BY pricesdaily.tradingcode, cdate(Format([pricesdaily.tradedatetime],'mmm-yyyy')) DESC"

'response.write SQL
CmdDD.CacheSize=500 
CmdDD.Open SQL, ConnPasswords,0,1

WEOF = CmdDD.EOF

'can only do getrows if there is more than one record.
if not WEOF then 
	alldata = cmddd.getrows
	rc = ubound(alldata,2) ' row count
	cc = ubound(alldata,1) ' column count
	else
	rc = -1
	alldata = ""
end if

CmdDD.Close
Set CmdDD = Nothing

ConnPasswords.Close
Set ConnPasswords = Nothing

 
 cr=vbCRLF
	 'cr="<br>"
	qu=""""
	tb="~"
    data_result = ""
    
    if WEOF then 
    	data_result = "-1"  
    else

		jj = 0 ' rows
		kk = 0 ' columns

        for jj = 0 to rc
       		for kk = 0 to cc
       		
       		data_col = alldata(kk,jj)
       		if isnumeric(data_col) then
       			data_col = cdbl(data_col)
       			else
       			if len(data_col)<>0 then 
					if isdate(data_col) then
						data_date = data_col
						data_date = day(data_col) & "-" & monthname(month(data_col),1) & "-" & year(data_col) 
						if instr(data_col," ") > 0 then data_date = data_date & " " & mid(data_col,instr(data_col," "),len(data_col))
						data_col = data_date
					end if					
       				data_col = replace(data_col,"''","'")
       				data_col = replace(data_col,vbCRLF,"`")
       				data_col =  qu & replace(data_col,qu,"") & qu					
       			else
       				data_col = qu & data_col & qu
       			end if
       		end if ' end is numeric	
       		
       		data_result = data_result & data_col & tb
       		
       		next ' column
       		kk = 0
       		
       		'response.write data_result
       		'response.end
       		data_result = mid(data_result,1,len(data_result)-1) ' remove last column delimiter
       		data_result = data_result & cr
			data_result = replace(data_result,"®","&reg;")
       		
       	next ' row
       	data_result = mid(data_result,1,len(data_result)-1) ' remove last record delimiter
       	response.write data_result
       	
       	
    end if ' end of WEOF if

%>