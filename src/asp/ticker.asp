<%


cr=vbCRLF
qu=""""
tb=","

Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
ConnPasswords.Open Application("nsx_ReaderConnectionString")   
SQL = "SELECT tradingcode, tradedatetime, open, last, sessionmode, volume"
SQL = SQL & " FROM pricescurrent  "
SQL = SQL & " WHERE issuestatus='Active' and volume<>0 "
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
       	  	open = alldata(2,jj)
       	  	last = alldata(3,jj)
       	  	sessionmode = alldata(4,jj)
       	  	volume = alldata(5,jj)
       	  	if volume = 0 then
       	  		volume = ""
       	  		else
       	  		volume = "(" & formatnumber(volume,0) & ")"
       	  	end if
       	  	if open = 0 then open = last
 		 diff = last - open 
 		
 		 if diff >0 then diff2 ="<font color=green><img src=images/v2/up.gif border=0>&uarr;" & nsxcode & "&nbsp;" & formatnumber(last,3) & "&nbsp;+" & diff & "&nbsp;" & volume & "</font>"
		 if diff <0 then diff2 ="<font color=red><img src=images/v2/down.gif border=0>&darr;" & nsxcode & "&nbsp;" & formatnumber(last,3) & "&nbsp;" & diff & "&nbsp;" & volume & "</font>"
		 if diff = 0 then diff2 = nsxcode & "&nbsp;" & formatnumber(last,3) & "&nbsp;" & volume 
		 
		 'response.write nsxcode  & diff2 & "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
		 eml = eml & diff2 & "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
    		
    	  NEXT
     	  	
    	  'test display 
    	  if sessionmode = "NORMAL" then 
    	  	market = "&nbsp;&nbsp;&nbsp;&nbsp;<b>Market:</b> <font color=green><b>Trading ...</b></font>"
    	  	else
    	  	market = "&nbsp;&nbsp;&nbsp;&nbsp;<b>Market:</b> <font color=red><b>Closed ...</b></font>"  	
    	  end if
    	  
    	  
    	  
END IF

response.write market 
response.write "<marquee  width='670' loop='100' behavior='scroll' scrollamount='3' style='font-weight: bold' bgcolor='#ffffff'>" & eml & "</marquee>"


%>
