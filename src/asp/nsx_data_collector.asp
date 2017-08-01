<%

function debugfn(x)

	debugflag = true
	if debugflag then
		response.write x & "<br>"
	end if
end function

' collect NSX data from remote domain XML files.
' this file to be installed on the remote domain pairs with api_tables_???.asp ???= sim
' data ends up in ALLDATA variable as an array to plug into existing code.
' replaces direct data connection string objects.
' this function is maintained by NSX please do not amend without permission of NSX.
'on error resume next ' - uncomment after testing
Dim objXmlHttp

' recommended server method, can retrieve files in any format as well as XML.
Set objXmlHttp = Server.CreateObject("Msxml2.ServerXMLHTTP")


' URL, and authentication information for the request.
' Syntax:
'   .open(bstrMethod, bstrUrl, bAsync, bstrUser, bstrPassword)


If 1=1 Then ' fake test in case wish to add something later

' fields to emulate SQL, why not just use the SQL string, because of complications with special characters???
' query database SELECT ONLY, no UPDATES or INSERTS allowed.
'nsxtable = "pricescurrent" ' default values
'nsxdb = "nsxprices" ' default values (required)
'nsxfields = "" ' null = all fields
'nsxsql = "" ' sql command sent direct ... overrides everything else
'nsxsqlflag = "" ' true/false sql command sent direct ... overrides everything else nsxtdb is required
'nsxsort = "ASC"  ' "DESC"  ... sort order
'nsxsearch = ""  ' "field=criteria,field2=criteria2"  ... null is no search

' specific search
'nsxboardgroupid = "NSX"  '  "SIM" .. null means all groups
'nsxboardid = "NCRP" ' "SIMV" .. null means all boards
'nsxcode = "SUG"  ' "ITH"  .. null means all securities
'nsxdatefrom = "" ' assumes well formed date e.g. 1-jan-2010
'nsxdateto = "" ' assumes well formed date e.g. 1-jan-2010

' security
'nsxun = "SIMV"  ' need to block hackers username
'nsxpw = "SIMV"  '  need to block hackers password
'nsxfmt = "ARRAY" ' "XML" or "TXT"  ... that is TAB segmented value with " quotes around text old PRN style (output format)
' api_tables_data_receiver will also check the referring url to make sure it includes nsx_data_collector.asp

' test script
'SQL = "SELECT tradingcode,tradedatetime,[open],high,low,last,volume,bid,offer,bidqty,offerqty,tradestatus,exchid,currentsharesonissue,isin,issuedescription,issuetype,industryclass,marketcap,sessionmode,marketdepth,quotebasis,prvclose "
'SQL = SQL & " FROM pricescurrent  "
'nsxsql = SQL


' format and send off request

	rqststr = Application("nsx_AdminSiteRootURL") & "/api_tables.asp?nsxun=simv&nsxpw=simv" 
	rqststr  = rqststr  & "&nsxtable=" & nsxtable 
	rqststr  = rqststr  & "&nsxdb=" & nsxdb
	rqststr  = rqststr  & "&nsxfields=" & nsxfields 
	rqststr  = rqststr  & "&nsxsql=" & nsxsql
	rqststr  = rqststr  & "&nsxsqlflag=" & nsxsqlflag 
	rqststr  = rqststr  & "&nsxsortorder=" & nsxsortorder
	rqststr  = rqststr  & "&nsxsearch=" & nsxsearch
	rqststr  = rqststr  & "&nsxboardgroupid=" & nsxboardgroupid
	rqststr  = rqststr  & "&nsxboardid=" & nsxboardid
	rqststr  = rqststr  & "&nsxcode=" & nsxcode
	rqststr  = rqststr  & "&nsxdatefrom=" & nsxdatefrom
	rqststr  = rqststr  & "&nsxdateto=" & nsxdateto
	rqststr  = rqststr  & "&nsxfmt=" & nsxfmt
	
	debugfn(rqststr) 
	'response.end
 
	objXmlHttp.open "GET", rqststr, False
	objXmlHttp.send
	rst = objXmlHttp.responseText
	
	debugfn(replace(rst,vbCRLF,"<br>")  & " len=" & len(rst))
	response.end
	
	' test if no records returned
	if rst = "No records available." or rst = "" or rst = "-1" or len(rst)=0 then
		rc = -1
		alldata = ""
	else
	
	
	' format result
	' the result returned is PRN format
	' put the result into ARRAY format so that existing functions will work.
	rst = split(rst,vbCRLF)
	fh2 = ubound(rst) ' rows
	fh3 = ubound(split(rst(0),","))

	debugfn("rows=" & fh2 & " cols=" & fh3)

	DIM alldata() ' initialise a dynamic array
	ReDIM alldata(fh3,fh2) ' then create the correct sized array
	' have to manually recreate the array by indexing.

	kk = 0
	jj = 0 
	qu = """"

	for jj = 0 to fh2

		rst2 = split(rst(jj),",")
		fh4 = ubound(rst2)
		for kk = 0 to fh4
			rst3 = rst2(kk)
			rst3 = replace(rst3,qu,"")
			alldata(kk,jj)=rst3
			
			debugfn(rst3)
			
		next ' kk
	
	NEXT	' jj
	rc = ubound(alldata,2)
	end if ' at least 1 record returned.

end if ' end of fake test 1=1

Set objXmlHttp = nothing
Set rqststr = nothing

%>




