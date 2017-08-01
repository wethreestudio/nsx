<%
displayboard=""
If Application("http_cache_nsxticker_expires" & "_" & displayboard) < Now() then
' get data and create ticker script.
' cache it for some minutes before going back to database to save load.



cr=vbCRLF
qu=""""
tb=","
'on error resume next
Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
 

ConnPasswords.Open Application("nsx_ReaderConnectionString")
SQL = "SELECT tradingcode, tradedatetime, [open], last, sessionmode, volume,prvclose"
SQL = SQL & " FROM pricescurrent  "

if len(displayboard)=0 then
	SQL = SQL & " WHERE (issuestatus='Active'  AND exchid<>'SIMV')"
	else
	SQL = SQL & " WHERE ((pricescurrent.displayboard) like '%" & displayboard & "%') "
end if
SQL = SQL & " ORDER BY tradingcode"

'response.write SQL & CR
CmdDD.CacheSize=100 
on error resume next
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
 eml=" "
ELSE
    	eml =  ""
    	marketstatus=0 ' open or closed market
    	lastcode=""
    	volume=0
  
       FOR jj = 0 TO rc
      	  nsxcode = ucase(alldata(0,jj))
      	   volume = alldata(5,jj)
      	  
      	  ' minimise number of codes displayed to just 1 security from each series OR if the code has traded
      	  if left(nsxcode,3)<>lastcode or volume>0 then
      	  	lastcode = left(nsxcode,3)
      	 
      	  tradedatetime=alldata(1,jj)
      	  if isdate(tradedatetime) then
      	  	tradedatetime =tradedatetime
      	  	else
      	  	tradedatetime=date
      	  end if
      	  	
       	  	open = alldata(2,jj)
       	  	last = alldata(3,jj)
       	  	sessionmode = alldata(4,jj)
       	  	if sessionmode="NORMAL" then marketstatus = marketstatus+1
 
       	  	prvclose=alldata(6,jj)
       	  	if volume = 0 then
       	  		volume = ""
       	  		else
       	  		volume = "(" & formatnumber(volume,0) & ")"
       	  	end if
       	  	if last=0 then last=prvclose
       	  	if open = 0 then open = last
 		 diff = last - prvclose 
 		
 		 if diff >0 then diff2 ="<a href=prices_alpha.asp?nsxcode=" & nsxcode & "&region=" & displayboard & " class=ticklinksgreen >" & nsxcode & "</a>&nbsp;<font color=green size=2><sub>" & formatnumber(last,3) & "&nbsp;<img src=images/up.gif border=0>&nbsp;" & formatnumber(diff,3) & "&nbsp;" & volume & "</sub></font>"
		 if diff <0 then diff2 ="<a href=prices_alpha.asp?nsxcode=" & nsxcode & "&region=" & displayboard & " class=ticklinksred >" & nsxcode & "</a>&nbsp;<font color=red size=2><sub>" & formatnumber(last,3) & "&nbsp;<img src=images/down.gif border=0>&nbsp;" & formatnumber(diff * -1,3) & "&nbsp;" & volume & "</sub></font>"
		 if diff =0 then diff2 ="<a href=prices_alpha.asp?nsxcode=" & nsxcode & "&region=" & displayboard & " class=ticklinks >" & nsxcode & "</a>&nbsp;<font color=black size=2><sub>" & formatnumber(last,3) & "&nbsp;"  & "&nbsp;" & volume & "</sub></font>"
		 
		 'response.write nsxcode  & diff2 & "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
		 eml = eml & diff2 & "&nbsp;&nbsp;&nbsp"
		 'response.write nsxcode & " " & sessionmode & "<br>"
		 
    		END IF ' exclude ASJ from display
    	  NEXT
     	  	
    	  'text display 
    	  org = sessionmode
    	  'martketstatus =20 ' comment out when live
    	  if marketstatus >=10  then 
    	  	sessionmode="Trading"
    	  	market = "<font size=1><b>&nbsp;Market: </b></font><font size=1 color=green><b> Trading </b></font>" 
    	  	else
    	  	if sessionmode = "HALT" then sessionmode="Enquiry Only (ENQ)"
    	  	if sessionmode = "AHA" then sessionmode="After Hours Adjust (AHA)"
    	  	if sessionmode = "PREOPEN" then sessionmode="Pre-Open (PRE)"
    	  	if sessionmode = "ENQUIRY" then sessionmode="Enquiry Only (ENQ)"
    	  	market = "<font size=1><b>&nbsp;Market: </b></font><font size=1 color=red><b> " & sessionmode & " ...</b></font>"  '& time + .0415	
    	  end if
    	  'tradedatetime = now ' comment out when live
    	   market = market & " <font size=1>Business Day " & formatdatetime(tradedatetime,1) & "</font>"
    	  
    	  ' create file and save ticker data for public use
		ppath = Server.MapPath("/ftp/price/ticker/ticker.htm")
		'response.write ppath & "<br>"
		'response.end
		Set MyFileObject=CreateObject("Scripting.FileSystemObject")
		Set MyTextFile=MyFileObject.CreateTextFile(ppath)
		MyTextFile.Write eml
		MyTextFile.Close
		Set MyTextFile = nothing
	    ' create file nd save market data for public use
		ppath = Server.MapPath("/ftp/price/ticker/market.htm")
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
    		Application("http_cache_nsxticker_content" & "_" & displayboard) = eml 
    		Application("http_cache_nsxmarket_content" & "_" & displayboard) = market
    		Application("http_cache_nsxmarket_sessionmode" & "_" & displayboard) = sessionmode 
  
    		' Set the expiration time.  
    		' the current time + 30 minutes
    		Application("http_cache_nsxticker_expires" & "_" & displayboard) = DateAdd("n", 10, Now())
  
    	Application.UnLock
    	  
		END IF ' database loop
	end if ' error test
	else
	strcached = "cached"
end if ' application timeout

eml = Application("http_cache_nsxticker_content" & "_" & displayboard)
market = Application("http_cache_nsxmarket_content" & "_" & displayboard) 
'response.write displayboard & " " & strcached & " " & Application("http_cache_nsxticker_expires" & "_" & displayboard)

' now add in the indices to the feed.
displayboard="NSX"
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
 		
 		 if diff >0 then diff2 ="<a href=prices_index.asp class=ticklinksgreen >" & nsxcode & "</a>&nbsp;<font color=green size=2><sub>" & formatnumber(last,3) & "&nbsp;<img src=images/up.gif border=0>&nbsp;" & formatnumber(diff,3) & "&nbsp;</sub></font>"
		 if diff <0 then diff2 ="<a href=prices_index.asp class=ticklinksred >" & nsxcode & "</a>&nbsp;<font color=red size=2><sub>" & formatnumber(last,3) & "&nbsp;<img src=images/down.gif border=0>&nbsp;" & formatnumber(diff * -1,3) & "&nbsp;</sub></font>"
		 if diff =0 then diff2 ="<a href=prices_index.asp class=ticklinks >" & nsxcode & "</a>&nbsp;<font color=black size=2><sub>" & formatnumber(last,3) & "&nbsp;"  & "&nbsp;</sub></font>"
		 
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
	    ' create file and save market data for public use
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
    		Application("http_cache_nsxind_expires_" & displayboard) = DateAdd("n", 10, Now())
  
    	Application.UnLock
    	  
		END IF ' database loop
	end if ' error test
	else
	strcached = "cached"
end if ' application timeout

eml_ind = Application("http_cache_nsxind_content_" & displayboard)
'response.write eml_ind & displayboard & " " & strcached & " " & Application("http_cache_nsxind_expires_" & displayboard)
%>
<table width=788>
<tr>
<td class=plaintext>
<script type="text/javascript">
/***********************************************
* Memory Scroller script- © Dynamic Drive DHTML code library (www.dynamicdrive.com)
* This notice MUST stay intact for legal use
* Visit Dynamic Drive at http://www.dynamicdrive.com/ for full source code
***********************************************/

var memorywidth="770px" //scroller width
var memoryheight="22px" //scroller height
var memorybgcolor="white" //scroller background
var memorypadding="2px" //padding applied to the scroller. 0 for non.
var borderCSS="border: 0px solid black;" //Border CSS, applied to scroller to give border.

var memoryspeed=2 //Scroller speed (larger is faster 1-10)
var pauseit=1 //Pause scroller onMousever (0=no. 1=yes)?

var persistlastviewedmsg=1 //should scroller's position persist after users navigate away (1=yes, 0=no)?
var persistmsgbehavior="onload" //set to "onload" or "onclick".

//Specify the scroller's content (don't delete <nobr> tag)
//Keep all content on ONE line, and backslash any single quotations (ie: that\'s great):

var memorycontent='<nobr><%=eml & "&nbsp;&nbsp;&nbsp;" & eml_ind%></nobr>'


////NO NEED TO EDIT BELOW THIS LINE////////////
var combinedcssTable="width:"+(parseInt(memorywidth)+6)+"px;background-color:"+memorybgcolor+";padding:"+memorypadding+";"+borderCSS+";"
var combinedcss="width:"+memorywidth+";height:"+memoryheight+";"

var divonclick=(persistlastviewedmsg && persistmsgbehavior=="onclick")? 'onClick="savelastmsg()" ' : ''
memoryspeed=(document.all)? memoryspeed : Math.max(1, memoryspeed-1) //slow speed down by 1 for NS
var copyspeed=memoryspeed
var pausespeed=(pauseit==0)? copyspeed: 0
var iedom=document.all||document.getElementById
if (iedom)
document.write('<span id="temp" style="visibility:hidden;position:absolute;top:-100px;left:-10000px">'+memorycontent+'</span>')
var actualwidth=''
var memoryscroller

if (window.addEventListener)
window.addEventListener("load", populatescroller, false)
else if (window.attachEvent)
window.attachEvent("onload", populatescroller)
else if (document.all || document.getElementById)
window.onload=populatescroller

function populatescroller(){
memoryscroller=document.getElementById? document.getElementById("memoryscroller") : document.all.memoryscroller
memoryscroller.style.left=parseInt(memorywidth)+8+"px"
if (persistlastviewedmsg && get_cookie("lastscrollerpos")!="")
revivelastmsg()
memoryscroller.innerHTML=memorycontent
actualwidth=document.all? temp.offsetWidth : document.getElementById("temp").offsetWidth
lefttime=setInterval("scrollmarquee()",20)
}

function get_cookie(Name) {
var search = Name + "="
var returnvalue = ""
if (document.cookie.length > 0) {
offset = document.cookie.indexOf(search)
if (offset != -1) {
offset += search.length
end = document.cookie.indexOf(";", offset)
if (end == -1)
end = document.cookie.length;
returnvalue=unescape(document.cookie.substring(offset, end))
}
}
return returnvalue;
}

function savelastmsg(){
document.cookie="lastscrollerpos="+memoryscroller.style.left
}

function revivelastmsg(){
lastscrollerpos=parseInt(get_cookie("lastscrollerpos"))
memoryscroller.style.left=parseInt(lastscrollerpos)+"px"
}

if (persistlastviewedmsg && persistmsgbehavior=="onload")
window.onunload=savelastmsg

function scrollmarquee(){
if (parseInt(memoryscroller.style.left)>(actualwidth*(-1)+8))
memoryscroller.style.left=parseInt(memoryscroller.style.left)-copyspeed+"px"
else
memoryscroller.style.left=parseInt(memorywidth)+8+"px"
}

if (iedom){
with (document){
document.write('<table border="0" cellspacing="0" cellpadding="0" style="'+combinedcssTable+'"><td>')
write('<div style="position:relative;overflow:hidden;'+combinedcss+'" onMouseover="copyspeed=pausespeed" onMouseout="copyspeed=memoryspeed">')
write('<div id="memoryscroller" style="position:absolute;left:0px;top:0px;" '+divonclick+'></div>')
write('</div>')
document.write('</td></table>')
}
}
</script>
<%=market%></td></tr></table>
