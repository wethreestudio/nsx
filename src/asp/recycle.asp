<%

CHECKFOR = "NSX" 
%>
<!--#INCLUDE FILE="member_check.asp"-->

<%
' recycle connection pooling
strComputer = "." 
Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\MicrosoftIISv2") 
Set colItems = objWMIService.ExecQuery("SELECT * FROM IIsWebVirtualDirSetting WHERE Name = 'W3SVC/1/ROOT'",,48) 

Dim AppPoolID 
For Each objItem in colItems 
   AppPoolID = objItem.AppPoolId 
Next 


Set objShare = objWMIService.Get("IIsApplicationPool.Name='" & AppPoolID & "'") 

' no InParameters to define 

' Execute the method and obtain the return status. 
' The OutParameters object in objOutParams 
' is created by the provider. 
Set objOutParams = objWMIService.ExecMethod("IIsApplicationPool.Name='" & AppPoolID & "'", "Recycle") 


' No outParams 
response.write "recycle done check:<a href=http://www.nsxa.com.au target =_blank>NSXA</a>"
%>
