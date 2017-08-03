<%
displayboard="nsx"
If Application("http_cache_nsxind_expires" & "_" & displayboard) < Now() then
' get data and create ticker script.
' cache it for some minutes before going back to database to save load.



cr=vbCRLF
qu=""""
tb=","
on error resume next
Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
 

ConnPasswords.Open Application("nsx_ReaderConnectionString")
SQL = "SELECT tradingcode, tradedatetime, [open], last, prvclose"
SQL = SQL & " FROM indexcurrent  "

if len(displayboard)=0 then
	SQL = SQL & " WHERE (last<>0) AND (tradingcode<>'TESTINDEX')"
	else
	SQL = SQL & " WHERE (last<>0) AND (tradingcode<>'TESTINDEX') "
end if
SQL = SQL & " ORDER BY tradingcode"

'response.write SQL & CR
CmdDD.CacheSize=100 
'on error resume next
CmdDD.Open SQL, ConnPasswords,1,3
' check no error with database.
if err.number <> 0 then
' if error in database then just used cached dta until fixed.
' make sure connection is closed
	CmdDD.Close
	Set CmdDD = Nothing
	emlerr=""
	Response.Clear
	' do error report
	emlerr=""
	emlerr = emlerr & "ERROR CONDITIONS:" & cr & cr
	emlerr = emlerr & "Error Number: " & Err.Number & cr
	emlerr = emlerr & "Error Description: " & Err.Description & cr	
	emlerr = emlerr & "Source: " & Err.Source & cr
	emlerr = emlerr & "LineNumber: " & Err.Line & cr
	emlerr = emlerr & "Date & time: " & now & cr
	emlerr = emlerr & "Local_addr: " & request.servervariables("local_addr") & cr
	emlerr = emlerr & "Remote_addr: " & request.servervariables("remote_addr") & cr
	emlerr = emlerr & "Document: " & request.servervariables("path_info") & cr
	sesserr = "Errors Found: " & err.line
	emlflag = True
	
	' send off email to be aware eveything still works
	if emlflag = True then	
		email = "errors@nsxa.com.au"
    	name = "NSX Error Report"
    	flename = "ERROR.TXT"
    
		    Set MyJMail2 = Server.CreateObject("JMail.SMTPMail")
 		   	MyJMail2.ServerAddress = Application("SMTP_Server") & ":" & Application("SMTP_Port")
		    MyJMail2.Sender= email
		    MyJMail2.SenderName = name
		    MyJMail2.AddRecipient "scott.evans@nsxa.com.au"
		    MyJMail2.Subject="NSX Error Message - " & sesserr
		    MyJMail2.Priority = 1 'High importance!
		    MyJMail2.addcustomattachment  flename, emlerr
		    MyJMail2.Body="NSX ERRORS ATTACHED: " & flename & " " & sesserr
		    MyJMail2.Execute
		    set MyJMail2=nothing
		   	set emlerr = nothing
		end if


 else
 	' can do normal database
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
IF WEOF THEN 
 eml_ind=" "
ELSE
    	eml_ind =  ""
    	marketstatus=0 ' open or closed market
  
       FOR jj = 0 TO rc
      	  nsxcode = ucase(alldata(0,jj))
      	  tradedatetime=alldata(1,jj)
      	  if isdate(tradedatetime) then
      	  	tradedatetime =tradedatetime
      	  	else
      	  	tradedatetime=date
      	  end if
      	  	
       	  	open = alldata(2,jj)
       	  	last = alldata(3,jj)
       	   	prvclose=alldata(4,jj)
       	   	if last=0 then last=prvclose
       	  	if open = 0 then open = last
 		 diff = last - prvclose 
 		
 		 if diff >0 then diff2 ="<a href=prices_index.asp class=ticklinksgreen >" & nsxcode & "</a>&nbsp;<font color=green size=2><sub>" & formatnumber(last,3) & "&nbsp;<img src=images/up.gif border=0>&nbsp;" & formatnumber(diff,3) & "&nbsp;" & volume & "</sub></font>"
		 if diff <0 then diff2 ="<a href=prices_index.asp class=ticklinksred >" & nsxcode & "</a>&nbsp;<font color=red size=2><sub>" & formatnumber(last,3) & "&nbsp;<img src=images/down.gif border=0>&nbsp;" & formatnumber(diff * -1,3) & "&nbsp;" & volume & "</sub></font>"
		 if diff =0 then diff2 ="<a href=prices_index.asp class=ticklinks >" & nsxcode & "</a>&nbsp;<font color=black size=2><sub>" & formatnumber(last,3) & "&nbsp;"  & "&nbsp;" & volume & "</sub></font>"
		 
		 'response.write nsxcode  & diff2 & "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
		 eml_ind = eml_ind & diff2 & "&nbsp;&nbsp;&nbsp"
		' response.write nsxcode & " " & sessionmode & eml_ind & "<br>"
		'response.end
    		
    	  NEXT
     	  	
    	  'text display 
    	  
    	  ' create file and save ticker data for public use
		ppath = Server.MapPath("ftp/price/ticker/ticker_index.htm")
		'response.write ppath & "<br>"
		'response.end
		Set MyFileObject=CreateObject("Scripting.FileSystemObject")
		Set MyTextFile=MyFileObject.CreateTextFile(ppath)
		MyTextFile.Write eml_ind
		MyTextFile.Close
		Set MyTextFile = nothing
	    ' create file nd save market data for public use
		ppath = Server.MapPath("ftp/price/ticker/market_index.htm")
		'response.write ppath & "<br>"
		Set MyFileObject=CreateObject("Scripting.FileSystemObject")
		Set MyTextFile=MyFileObject.CreateTextFile(ppath)
		MyTextFile.Write market
		MyTextFile.Close
		Set MyTextFile = nothing
		strcached = "not cached"
		' cache ticker data
		Application.Lock
    		' Save the response to an application level variable
    		Application("http_cache_nsxind_content_" & displayboard) = eml_ind
    		Application("http_cache_nsxind_sessionmode_" & displayboard) = sessionmode 
  
    		' Set the expiration time.  
    		' the current time + 30 minutes
    		Application("http_cache_nsxind_expires_" & displayboard) = DateAdd("n", .5, Now())
  
    	Application.UnLock
    	  
		END IF ' database loop
	end if ' error test
	else
	strcached = "cached"
end if ' application timeout

eml_ind = Application("http_cache_nsxind_content_" & displayboard)
'response.write eml_ind & displayboard & " " & strcached & " " & Application("http_cache_nsxind_expires_" & displayboard)
%>
<div class="table-responsive"><table width=788><tr><td class=plaintext><%=eml_ind%></td></tr></table></div>
