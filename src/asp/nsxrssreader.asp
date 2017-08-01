<%

Function RemoveHTML( strText )
	Dim RegEx

	Set RegEx = New RegExp

	RegEx.Pattern = "<[^>]*>"
	RegEx.Global = True

	RemoveHTML = RegEx.Replace(strText, "")
End Function

'If DateDiff("h", Application("NSXUpdated"), Now()) >= .5 Or Request.QueryString("force") <> "" Then

    Dim objXML
    Dim objItemList
    Dim objItem
    Dim strHTML
    Dim jj
    Dim lap
    Dim cl
    Dim lnk
    Dim I
    
    
    lnk=trim(request("lnk") & " " )

    mmax=trim(request("maxx") & " " )
    if len(mmax) = 0  then 	mmax = 50
   	mmax = cint(mmax)
   	desc = trim(request("desc") & " ")
   	if len(desc)=0 then desc = false
   	if len(lnk)=0 then 
   		lnk = session("rsstr")
    	'lnk = Application("nsx_AdminSiteRootURL") & replace(lnk,"\","/")
    	'lnk = Application("nsx_AdminSiteRootURL") & replace(lnk,"\","/")
    	desc = session("rssdesc")
    	mmax= session("rssmaxx")
    	rssdate = session("rssdate")
    	rsstitle = session("rsstitle")
    end if
    

    'Set objXML = Server.CreateObject("MSXML2.FreeThreadedDOMDocument")
    Set objXML = Server.CreateObject("MSXML2.FreeThreadedDOMDocument.3.0") '4.0 seems to fail
    objXML.async = False

    objXML.setProperty "ServerHTTPRequest", True
    'objXML.Load(Application("nsx_SiteRootURL") & "/ftp/rss/nsx_rss_announcements.xml")
    'objXML.Load(server.mappath("ftp/rss/nsx_rss_announcements.xml"))

    if instr(lnk,"http")=0 then 
    	objXML.Load(Server.Mappath(lnk))
    else
   		objXML.Load(lnk)
    end if
    
    'response.write server.mappath(lnk)

    If objXML.parseError.errorCode <> 0 Then
       Response.Write "<pre>" & vbCrLf
       Response.Write "<strong>Error:</strong> " & objXML.parseError.reason
       Response.Write "<strong>Line:</strong>  " & objXML.parseError.line & vbCrLf
       Response.Write "<strong>Text:</strong>  " _
          & Server.HTMLEncode(objXML.parseError.srcText) & vbCrLf
       Response.Write "</pre>" & vbCrLf
    End If

    Set objItemList = objXML.getElementsByTagName("item")
    set objLinkList = objXML.getElementsByTagName("link")
    set objdesList = objXML.getElementsByTagName("description")
    set objtitleList = objXML.getElementsByTagName("title")
    set objpubList = objXML.getElementsByTagName("pubDate")
    set objcatList = objXML.getElementsByTagName("category")
    set objcomList = objXML.getElementsByTagName("comments")
    
    'response.write objXML.text
    Set objXML = Nothing
    
    cl = array("#EEEEEE","#FFFFFF")
    lap = 1
	

    
    strHTML = "<table bgcolor=white  cellspacing='0' cellpadding='3' width='100%'>"
 
	kk = 0
    For Each objItem In objItemList
    if kk >= mmax then 
    	exit for
    	else
    	kk = kk + 1
    end if
    
    for each objname in objitem.childnodes
    	strname = ucase(objname.nodename)
    	select case strname
    		case "LINK"
    			strlink = objname.text
    		case "DESCRIPTION"
    			strdesc = objname.text
    		case "TITLE"
    			strtitle = objname.text
    			strtitle = replace(strtitle,"[","<b><font color=navy>")
    			strtitle = replace(strtitle,"]","</font></b>")
    		case "PUBDATE"
    			strpubdate = objname.text
    			if len(strpubdate)>5 then strpubdate = mid(strpubdate,1,len(strpubdate)-5)
    		case "CATEGORY"
    			strcat = objname.text
    	end select  
    Next
    lap = (-lap)+1
    strHTML = strHTML & "<tr bgcolor='" & cl(lap) & "' onMouseOver=""this.bgColor='#CCCCDD'"" onmouseout=""this.bgColor='" & cl(lap) & "'"">"
	
   
       strHTML = strHTML & "<td class=plaintext><font size=1>" & vbcrlf
       strHTML = strHTML & "<img border=0 src='images/broker_page1_bullet.gif' width=20 height=15>"
       strHTML = strHTML & "<a href=""" & strlink & """"
       if rssTitle then 
       	strHTML = strHTML & " title = """ & trim(left(removeHTML(strDesc),100) & " ") & """"
       end if
       strHTML = strHTML & ">" & strtitle & "</a>&nbsp;" & vbcrlf
       if desc then 
       	strHTML = strHTML & "<br>" & strdesc & "<br>"
       end if
       if rssdate then strHTML = strHTML & "<font color=gray>" & strpubdate & "</font></font></td>"
        strHTML = strHTML & "</tr>"
    
   Next
    strHTML = strHTML & "</table>"
   


    Set objItemList = Nothing
    
    'Application.Lock
    'Application("NSXContent") = strHTML
    'Application("NSXUpdated") = Now()
    'Application.UnLock
'End If

response.write strHTML
%>

