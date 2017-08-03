<%

referer = request.servervariables("http_referer")
if instr(referer,"nsxa") <= 0 then response.end

cr=vbCRLF
qu=""""
tb=","

Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
 

ConnPasswords.Open Application("nsx_ReaderConnectionString")
SQL = "SELECT tradingcode, tradedatetime, [open], last, sessionmode, volume,prvclose"
SQL = SQL & " FROM pricescurrent  "
SQL = SQL & " WHERE (issuestatus='Active')"
SQL = SQL & " ORDER BY tradingcode"

'response.write SQL & CR
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
IF WEOF THEN 
 eml=" "
ELSE
    	eml =  ""
  
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
       	  	sessionmode = alldata(4,jj)
       	  	volume = alldata(5,jj)
       	  	prvclose=alldata(6,jj)
       	  	if volume = 0 then
       	  		volume = ""
       	  		else
       	  		volume = "(" & formatnumber(volume,0) & ")"
       	  	end if
       	  	if last=0 then last=prvclose
       	  	if open = 0 then open = last
 		 diff = last - prvclose 
 		
 		 if diff >0 then diff2 ="<a href=security_summary.asp?nsxcode=" & nsxcode & " class=ticklinksgreen target=_blank>" & nsxcode & "</a>&nbsp;<font color=green size=2><sub>" & formatnumber(last,3) & "&nbsp;<img src=images/up.gif border=0>&nbsp;" & formatnumber(diff,3) & "&nbsp;" & volume & "</sub></font>"
		 if diff <0 then diff2 ="<a href=security_summary.asp?nsxcode=" & nsxcode & " class=ticklinksred target=_blank>" & nsxcode & "</a>&nbsp;<font color=red size=2><sub>" & formatnumber(last,3) & "&nbsp;<img src=images/down.gif border=0>&nbsp;" & formatnumber(diff * -1,3) & "&nbsp;" & volume & "</sub></font>"
		 if diff =0 then diff2 ="<a href=security_summary.asp?nsxcode=" & nsxcode & " class=ticklinks target=_blank>" & nsxcode & "</a>&nbsp;<font color=black size=2><sub>" & formatnumber(last,3) & "&nbsp;"  & "&nbsp;" & volume & "</sub></font>"
		 
		 'response.write nsxcode  & diff2 & "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
		 eml = eml & diff2 & "&nbsp;&nbsp;&nbsp"
    		
    	  NEXT
     	  	
    	  'test display 
    	  if sessionmode = "NORMAL" or SESSIONMODE="HALT" then 
    	  	market = "<font size=1><b>&nbsp;NSX Market: </b></font><font size=1 color=green><b> Open - Trading ...</b></font>"
    	  	else
    	  	if sessionmode = "AHA" then sessionmode="After Hours Adjust (AHA)"
    	  	if sessionmode = "PREOPEN" then sessionmode="Pre-Open (PRE)"
    	  	if sessionmode = "ENQUIRY" then sessionmode="Enquiry Only (ENQ)"
    	  	market = "<font size=1><b>&nbsp;NSX Market: </b></font><font size=1 color=red><b> Closed - " & sessionmode & " ...</b></font>"  	
    	  end if
    	   market = market & " <font size=1>Business Day = " & formatdatetime(tradedatetime,1) & "&nbsp;&nbsp;&nbsp;data = last <img src=images/up.gif border=0><img src=images/down.gif border=0>change (volume) - click code for detail</font>"
    	  
    	  
    	  
END IF

%>

<html>

<head>


<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 6.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>NSX National Stock Exchange of Australia</title>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="ROBOTS" content="INDEX">
<meta http-equiv="Expiry" content="0">
<meta http-equiv="expires" content="0">
<meta name="description" content="The National Stock Exchange of Australia - Operates a Stock Exchange in Australia focussing on small to medium and high technology companies.">
<meta name="keywords" content="small, medium, company, companies, companys, australia, Australia, Newcastle, enterprises, high technology, stock, exchange, stock exchange, Australian, NSX, nsx">
<link rel="stylesheet" href="newsx2.css" type="text/css">



<meta name="Microsoft Border" content="none">
<link rel="shortcut icon" href="favicon.ico" ></head>

<body topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" style="background-color: #FFFFFF" >


<div class="table-responsive"><table width=788>
<tr>
<td clss=plaintext>
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

var memorycontent='<nobr><%=eml%></nobr>'


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
document.write('<div class="table-responsive"><table border="0" cellspacing="0" cellpadding="0" style="'+combinedcssTable+'"><td>')
write('<div style="position:relative;overflow:hidden;'+combinedcss+'" onMouseover="copyspeed=pausespeed" onMouseout="copyspeed=memoryspeed">')
write('<div id="memoryscroller" style="position:absolute;left:0px;top:0px;" '+divonclick+'></div>')
write('</div>')
document.write('</td></table></div>')
}
}
</script>
<%=market%></td></tr></table></div>
</body>
</html>