<%
Dim objXmlHttp
on error resume next

' This is the server safe version from MSXML3.
Set objXmlHttp = Server.CreateObject("Msxml2.ServerXMLHTTP")
' The old not so safe version!
'Set objXmlHttp = Server.CreateObject("Msxml2.XMLHTTP")


' URL, and authentication information for the request.
' Syntax:
'   .open(bstrMethod, bstrUrl, bAsync, bstrUser, bstrPassword)
'codes = array("FMI","IIC","PEQ","WPH","RVC")
'lbls = array("Florin Mining Inv Ltd","Illuminator Inv Co Ltd","Pritchard Equity Ltd","Winpar Holdings Ltd","Sugar Terminals Ltd")

'If Application("http_cache_nsxprices_expires") < Now() Then
If 1=1 Then
codes = array("FMI","IIC","PEQA","WPH")
lbls = array("Florin Mining","Illuminator Inv","Pritchard Equity","Winpar Holdings")
'codes = array("BFI","WPH")
'lbls = array("Bidgee Finance","Winpar Holdings")
eml = ""
fh = ubound(codes)
eml= eml & "<div class="table-responsive"><table width=90% align=center id=table1 background=images/prices/light-Row.png cellspacing=0 cellpadding=0>"

FOR jj = 0 to fh
	objXmlHttp.open "GET", "http://www.nsxa.com.au/prices_nsx.asp?group=NO&nsxcode=" & codes(jj) & "&fmt=txt", False
	objXmlHttp.send
	rst = objXmlHttp.responseText
	rst = split(rst,vbCRLF)


fh2 = ubound(rst)-1
for ii = 0 to fh2

	rst2 = split(rst(ii),",")
	chn = replace(rst2(3),"""","")
	code = replace(rst2(0),"""","")
	tme = replace(rst2(2),"""","")
	price = rst2(1)
	coname = replace(rst2(5),"""","")
	pchn = replace(rst2(4),"""","")
	'mktcap = rst(10)
	
	if 	chn > 0 then
		dchn = formatnumber(chn,2)
		clr ="green"
		bul = "background=images/prices/up.png"
	end if
	if chn < 0 then
		dchn = formatnumber(abs(chn),2)
		clr = "red"
		bul = "background=images/prices/down.png"
	end if
	if chn = 0 then
		dchn = formatnumber(abs(chn),2)
		clr = "black"
		bul = "background=images/prices/up.png"
	end if
	eml= eml &"<tr>"
	eml= eml & "<td height=8 width=100 class=ftlinks>"
	eml= eml &"<font color=white face=Arial size=1><b>" & "<a href=http://www.nsxa.com.au/prices_alpha.asp?nsxcode=" & code & " class=ftlinks>" & code & "</a></b></font>"
	eml= eml & "</td>"
	eml= eml & "<td height=8 width=29 align=right>"
	eml= eml & "<font color=white face=Arial size=1><b>" & price & "&nbsp;</b></font>"
	eml= eml & "</td>"
	eml= eml & "<td height=8 width=61 rowspan=2 align=right " & bul & ">" 
	eml= eml & "<font color=white face=Arial size=2><b>" & dchn &  "&nbsp;</b></font>"
	eml= eml & "</td>"
	eml= eml & "</tr>" & vbcrlf
	eml= eml & "<tr>"
	eml= eml & "<td height=16 width=129 colspan=2>" 
	eml= eml & "<font color=#CCCCCC face=Arial size=1><b>" & ucase(lbls(jj)) & "</b></font>"
	eml= eml & "</td></tr>" & vbcrlf
	NEXT
NEXT

    code = "IMB"
    chn = 0
  
	dchn = formatnumber(abs(chn),2)
	clr = "black"
	bul = "background=images/prices/up.png"

	lbls = "IMB Limited"

	price = 0 


	eml= eml &"<tr>"
	eml= eml & "<td height=8 width=100 class=ftlinks>"
	eml= eml &"<font color=white face=Arial size=1><b>" & "<a href=http://www.imb.com.au/shares.asp class=ftlinks>" & code & "</a></b></font>"
	eml= eml & "</td>"
	eml= eml & "<td height=8 width=29 align=right>"
	eml= eml & "<font color=white face=Arial size=1><b>" & price & "&nbsp;</b></font>"
	eml= eml & "</td>"
	eml= eml & "<td height=8 width=61 rowspan=2 align=right " & bul & ">" 
	eml= eml & "<font color=white face=Arial size=2><b>" & dchn &  "&nbsp;</b></font>"
	eml= eml & "</td>"
	eml= eml & "</tr>" & vbcrlf
	eml= eml & "<tr>"
	eml= eml & "<td height=16 width=129 colspan=2>" 
	eml= eml & "<font color=#CCCCCC face=Arial size=1><b>" & lbls & "</b></font>"
	eml= eml & "</td></tr>" & vbcrlf
	
	
' get gold price and convert to USD/oz



Set objWinHttp = Server.CreateObject("WinHttp.WinHttpRequest.5.1")
	objWinHttp.open "GET", "http://dgcsc.org/goldprices.xml",false
	'objWinHttp.SetRequestHeader "Cookie", "Workaround for MS Bug KB234486"  
	'objWinHttp.SetRequestHeader "Cookie", "NGSESSIONM=%7BF7B00314%2DBE2B%2D4C13%2D8F59%2DBC6ECE415BC8%7D; path=/" 
	'objWinHttp.Option(0) = "Mozilla/4.0+(compatible;+MSIE+6.0;+Windows+NT+5.0)" ' UserAgent
	'objWinHttp.Option(4) = 0 ' intIgnoreCertErrors
	'objWinHttp.Option(6) = False ' redirects
  	'objWinHttp.Option(12) = True


	objWinHttp.Send
    imb2 = objWinHttp.ResponseText
    code = "GOLD"
    chn = 0
  
	dchn = formatnumber(abs(chn),2)
	clr = "black"
	bul = "background=images/prices/up.png"

	lbls = "Gold USD/oz"

	priceval_start = instr(imb2,"USD")	
	priceval=mid(imb2,priceval_start+5,priceval_start+15)

	priceval_end=instr(priceval,"</Price>")

	priceval=mid(priceval,1,priceval_end-1)

	price = trim(priceval & " ")
	if isnumeric(price) then 
		price=formatnumber(ccur(price) * 31.103477,3)
	else
		price=0
	end if

	eml= eml &"<tr>"
	eml= eml & "<td height=8 width=100 class=ftlinks>"
	eml= eml &"<font color=white face=Arial size=1><b>" & "<a href=http://dgcsc.org/goldprices.htm class=ftlinks>" & code & "</a></b></font>"
	eml= eml & "</td>"
	eml= eml & "<td height=8 width=29 align=right>"
	eml= eml & "<font color=white face=Arial size=1><b>" & price & "&nbsp;</b></font>"
	eml= eml & "</td>"
	eml= eml & "<td height=8 width=61 rowspan=2 align=right " & bul & ">" 
	eml= eml & "<font color=white face=Arial size=2><b>" & dchn &  "&nbsp;</b></font>"
	eml= eml & "</td>"
	eml= eml & "</tr>" & vbcrlf
	eml= eml & "<tr>"
	eml= eml & "<td height=16 width=129 colspan=2>" 
	eml= eml & "<font color=#CCCCCC face=Arial size=1><b>" & lbls & "</b></font>"
	eml= eml & "</td></tr>" & vbcrlf



	eml= eml & "</table></div>"
		If objXmlHttp.Status = "200" Then
				Application.Lock
		
				' Save the response to an application level variable
				Application("http_cache_nsxprices_content") = eml
		
				' Set the expiration time.  
				' the current time + 30 minutes
				Application("http_cache_nsxprices_expires") = DateAdd("n", 10, Now())
		
				Application.UnLock
				strcached = "not cached: "
		End If

	else
	strcached = "cached: "
	 

end if
eml = Application("http_cache_nsxprices_content")
response.write eml  
Set objWinHttp = Nothing
Set objXmlHttp = nothing
%>




