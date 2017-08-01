<html>
<head>
</head>
<body>
<h1>Test COM objects exist</h1>
<%

sub TestObject(objName)
  dim obj
  set obj = CreateObject(objName)
  if (obj is nothing) then
    response.write(objName & " - FAIL<br>")
  else
    response.write(objName & " - OK<br>")
  end if 
end sub

' Success
TestObject("JMail.SMTPMail")
TestObject("ADODB.Command")
TestObject("ADODB.Connection")
TestObject("ADODB.Recordset")
TestObject("ADODB.Stream")
TestObject("CDO.Message")
TestObject("JRO.JetEngine")
TestObject("MSXML2.FreeThreadedDOMDocument")
TestObject("Msxml2.FreeThreadedDOMDocument.3.0")
TestObject("MSXML2.FreeThreadedDOMDocument.3.0") '4.0 seems to fail
TestObject("Msxml2.ServerXMLHTTP")
TestObject("Msxml2.XMLHTTP")
TestObject("Scripting.Dictionary")
TestObject("Scripting.FileSystemObject")
TestObject("SoftArtisans.FileUp")
TestObject("SoftArtisans.FileUpProgress")
TestObject("WinHttp.WinHttpRequest.5.1")
TestObject("CDO.Configuration")

' Fail
TestObject("IntrChart.Chart")
TestObject("JMail.SMTPMail")
TestObject("MSSOAP.SoapClient")
TestObject("Persits.PDF")


%>
</body>
</html>