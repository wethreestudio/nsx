<%
	Dim NVcomp
	Set NVcomp = Server.CreateObject("Neevia.PDFcompress")

	NVcomp.CI = "jpx"
	NVcomp.CQ = 50

	NVcomp.GI = "jpx"
	NVcomp.GQ = 50

	NVcomp.MI = "jbig2"
	NVcomp.MQ = 5

	'For better compression uncomment the line below
	' NVcomp.CreateObjectStreams = true

	Dim retVal
'	retVal = NVcomp.CompressPDF("E:\Temp\in1.pdf","E:\Temp\out1.pdf")

	if retVal <> 0 then
		Response.Write "Error = " & CStr(retVal)
	else 
		Response.Write "Done"
	end if
%>