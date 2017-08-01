<%
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Debug / Dummy Data
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Session("PASSWORDACCESS") = "yes"
' Session("FULL_NAME") = "Paul Hulskamp"

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Get IE Browser version to render correct CSS snippets
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
myUA = Request.ServerVariables("HTTP_USER_AGENT") 
ua = lcase(myUA) 
ie =  instr(ua,"msie 4") Or instr(ua,"msie 5") Or instr(ua,"msie 5") Or instr(ua,"msie 6") Or instr(ua,"msie 7") Or instr(ua,"msie 8") Or instr(ua,"msie 9")      
ie4 = instr(ua,"msie 4") 
ie5 = instr(ua,"msie 5") 
ie6 = instr(ua,"msie 6") 
ie7 = instr(ua,"msie 7") 
ie8 = instr(ua,"msie 8")
ie9 = instr(ua,"msie 9")

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Formatted current Date / Time String
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''' 
dt = Now()
systemTime = dateOrdinal(Day(dt)) & " <strong>" & monthAbbreviation(Month(dt)) 
systemTime = systemTime & " " & Year(dt) & "</strong> " & timeAMPM(dt) & " AEST"

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Additional Javascript
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''' 
Dim objJsIncludes ' For inline JS to header file
Set objJsIncludes = CreateObject("Scripting.Dictionary")

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Additional CSS 
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''' 
Dim objCssIncludes ' For inline JS to header file
Set objCssIncludes = CreateObject("Scripting.Dictionary")

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Page Title
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Dim page_title
page_title = "NSX National Stock Exchange of Australia"

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Page Meta Description
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Dim meta_description
meta_description = "Official site of the National Stock Exchange of Australia, the market of choice for innovative and growth style Australian and International companies."


''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Page Meta Keywords
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Dim meta_keywords
meta_keywords = "NSX, equities, company floats, IPO, investing, brokers, listed companies, stock exchange, Newcastle NSW"

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Page - Allow Robots to index
'   yes = Allow robots to visit and index page
'   no  = Disallow robots to visit or index page
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Dim alow_robots
alow_robots = "yes" ' | "no"
%>