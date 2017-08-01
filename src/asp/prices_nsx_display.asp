<%
'on error resume next
Dim objXmlHttp


Set objXmlHttp = Server.CreateObject("Msxml2.serverXMLHTTP")


' URL, and authentication information for the request.
' Syntax:
'   .open(bstrMethod, bstrUrl, bAsync, bstrUser, bstrPassword)

sec=trim(ucase(request.querystring("sec")) & " ")
if sec="" then sec="PEQ"
sec = array(sec)
group=ucase(request.querystring("group"))
if group<>"YES" then group="no"


eml = ""
fh = ubound(sec)
eml= eml & "<table  align=center id=table1 background=images/prices/light-Row.png cellspacing=0 cellpadding=0>"

jj=0
FOR jj = 0 to fh
'response.write sec(jj) & "<br>" & jj & fh & group
opn =  Application("nsx_AdminSiteRootURL") & "/prices_nsx.asp?group=" & group & "&nsxcode=" & sec(jj) & "&fmt=txt"
	objXmlHttp.open "GET",opn,false
	objXmlHttp.send
	rst = objXmlHttp.responseText
	rst = split(rst,vbCRLF)

ii=0
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
	eml= eml &"<font color=white face=Arial size=1><b>" & "<a href=" & Application("nsx_SiteRootURL") & "/prices_alpha.asp?nsxcode=" & code & " class=ftlinks>" & code & "</a></b></font>"
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
	eml= eml & "<font color=#CCCCCC face=Arial size=1><b>" 
	pp=left(ucase(coname),18)
	eml = eml & pp & "</b></font>"
	eml= eml & "</td></tr>" & vbcrlf
	NEXT
NEXT

    eml= eml & "</table>"
		


response.write eml  
Set objWinHttp = Nothing
Set objXmlHttp = nothing
%>




