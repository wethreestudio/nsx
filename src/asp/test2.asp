<%@ Language="VBScript" %>
<% Option Explicit %>
<% Response.Charset = "UTF-8" %>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<link rel="shortcut icon" href="favicon.ico" >
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="ROBOTS" content="INDEX">
<META NAME="revisit-after" content="4 days">
<META NAME="robots" CONTENT="all">
<meta http-equiv="Expiry" content="0">
<meta http-equiv="expires" content="0">
<meta name="description" content="The National Stock Exchange of Australia - Operates a Stock Exchange in Australia focussing on small to medium and high technology companies.  Australia's second official stock exchange.">
<meta name="keywords" content="australian stock exchange, public listing, listed, official list, prices, ipo, float, floats, ipos, investing in innovation, small, medium, company, companies, companys, australia, Australia, Newcastle, enterprises, high technology, stock, exchange, stock exchange, Australian, NSX, nsx">
<link rel="stylesheet" href="newsx2.css" type="text/css">

<head>
<title>NSX RSS Feed Reader</title>
</head>
<body>

<%
'If DateDiff("h", Application("NSXUpdated"), Now()) >= .5 Or Request.QueryString("force") <> "" Then

    Dim objXML
    Dim objItemList
    Dim objItem
    Dim strHTML
    Dim jj
    Dim lap
    Dim cl

    Set objXML = Server.CreateObject("MSXML2.FreeThreadedDOMDocument")
    objXML.async = False

    objXML.setProperty "ServerHTTPRequest", True
    'objXML.Load( Application("nsx_SiteRootURL") & "/ftp/rss/nsx_rss_announcements.xml")
    objXML.Load(server.mappath("ftp/rss/nsx_rss_announcements.xml"))

    If objXML.parseError.errorCode <> 0 Then
       Response.Write "<pre>" & vbCrLf
       Response.Write "<strong>Error:</strong> " & objXML.parseError.reason
       Response.Write "<strong>Line:</strong>  " & objXML.parseError.line & vbCrLf
       Response.Write "<strong>Text:</strong>  " _
          & Server.HTMLEncode(objXML.parseError.srcText) & vbCrLf
       Response.Write "</pre>" & vbCrLf
    End If

    Set objItemList = objXML.getElementsByTagName("item")
    Set objXML = Nothing
    
    cl = array("#EEEEEE","#FFFFFF")
    lap = 0
	

    
    strHTML = "<table bgcolor=white  cellspacing='0' cellpadding='3' width='100%'>"
   

    For Each objItem In objItemList
    
    lap = (-lap)+1
    strHTML = strHTML & "<tr bgcolor='" & cl(lap) & "' onMouseOver=""this.bgColor='#CCCCDD'"" onmouseout=""this.bgColor='" & cl(lap) & "'"">"

   
       ' MegaTokyo Feed childNodes: 0=title, 1=description, 2=link
       strHTML = strHTML & "<td class=plaintext><font size=1>"
       strHTML = strHTML & "<img border=0 src='images/broker_page1_bullet.gif' width=20 height=15>"
       strHTML = strHTML & "<a href=""" & objItem.childNodes(2).text & """  title=""" & objItem.childNodes(1).text & """>"
       strHTML = strHTML &  objItem.childNodes(0).text
       strHTML = strHTML & "</a>&nbsp;" 
       strHTML = strHTML & "<font color=gray>" & objItem.childNodes(4).text 
        strHTML = strHTML & "</font></font></td>"
         strHTML = strHTML & "</tr>"
    Next
    strHTML = strHTML & "</table>"
   


    Set objItemList = Nothing
    
    Application.Lock
    Application("NSXContent") = strHTML
    Application("NSXUpdated") = Now()
    Application.UnLock
'End If
%>

<%= Application("NSXContent") %>
<!--<%= Application("NSXUpdated") %>-->

</body>
</html>

</body>

</html>
