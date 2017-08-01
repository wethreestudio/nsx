<%
' The only real options to be changed are the two constants
' at the top.  The first represents the height of the barcode
' in pixels.  You can set this to whatever you want.  The
' second is the width of each bar section.  Setting it to 1
' produces the most compact barcodes, but depending on the
' quality of your printer and/or scanner, setting it to 2 or
' 3 may give you better scanning results.
Function Code39Barcode(strTextToEncode)
	Const intBarcodeHeight = 25
	Const intBarcodeWidthMultiplier = 1

	Dim dictEncoding

	Dim strDataToEncode
	Dim strEncodedData
	Dim strBarcodeImgs
	Dim I

	strDataToEncode = UCase(strTextToEncode)

	Set dictEncoding = Server.CreateObject("Scripting.Dictionary")
	dictEncoding.Add "0", "101001101101"
	dictEncoding.Add "1", "110100101011"
	dictEncoding.Add "2", "101100101011"
	dictEncoding.Add "3", "110110010101"
	dictEncoding.Add "4", "101001101011"
	dictEncoding.Add "5", "110100110101"
	dictEncoding.Add "6", "101100110101"
	dictEncoding.Add "7", "101001011011"
	dictEncoding.Add "8", "110100101101"
	dictEncoding.Add "9", "101100101101"
	dictEncoding.Add "A", "110101001011"
	dictEncoding.Add "B", "101101001011"
	dictEncoding.Add "C", "110110100101"
	dictEncoding.Add "D", "101011001011"
	dictEncoding.Add "E", "110101100101"
	dictEncoding.Add "F", "101101100101"
	dictEncoding.Add "G", "101010011011"
	dictEncoding.Add "H", "110101001101"
	dictEncoding.Add "I", "101101001101"
	dictEncoding.Add "J", "101011001101"
	dictEncoding.Add "K", "110101010011"
	dictEncoding.Add "L", "101101010011"
	dictEncoding.Add "M", "110110101001"
	dictEncoding.Add "N", "101011010011"
	dictEncoding.Add "O", "110101101001"
	dictEncoding.Add "P", "101101101001"
	dictEncoding.Add "Q", "101010110011"
	dictEncoding.Add "R", "110101011001"
	dictEncoding.Add "S", "101101011001"
	dictEncoding.Add "T", "101011011001"
	dictEncoding.Add "U", "110010101011"
	dictEncoding.Add "V", "100110101011"
	dictEncoding.Add "W", "110011010101"
	dictEncoding.Add "X", "100101101011"
	dictEncoding.Add "Y", "110010110101"
	dictEncoding.Add "Z", "100110110101"
	dictEncoding.Add "-", "100101011011"
	dictEncoding.Add ":", "110010101101"
	dictEncoding.Add " ", "100110101101"
	dictEncoding.Add "$", "100100100101"
	dictEncoding.Add "/", "100100101001"
	dictEncoding.Add "+", "100101001001"
	dictEncoding.Add "%", "101001001001"
	dictEncoding.Add "*", "100101101101"

	' Code 39 Symbology Barcodes always start and end with the "*" character.
	' The "0" appended after each character is a white separator space.
	strEncodedData = dictEncoding("*") & "0"
	For I = 1 To Len(strDataToEncode)
		strEncodedData = strEncodedData & dictEncoding(Mid(strDataToEncode, I, 1)) & "0"
	Next
	strEncodedData = strEncodedData & dictEncoding("*")

	' Output encoded data for troubleshooting:
	'Response.Write "<p>" & strEncodedData & "</p>"

	' Convert our encoded data to an image.  I simply stretch two
	' 1x1 pixel spacer gif files repeatedly.  The only real downside
	' is the bulky HTML it produces.
	strBarcodeImgs = ""
	For I = 1 To Len(strEncodedData)
		If Mid(strEncodedData, I, 1) = "1" Then
			strBarcodeImgs = strBarcodeImgs & "<img src=""images/bar_blk.gif"" " _
				& "width=""" & intBarcodeWidthMultiplier & """ " _
				& "height=""" & intBarcodeHeight & """ alt="""" />"
		Else
			strBarcodeImgs = strBarcodeImgs & "<img src=""images/bar_wht.gif"" " _
				& "width=""" & intBarcodeWidthMultiplier & """ " _
				& "height=""" & intBarcodeHeight & """ alt="""" />"
		End If
	Next

	Code39Barcode = strBarcodeImgs
End Function
%>

<p><strong>
Encoding &quot;TEST 123&quot;:
</strong></p>
<p>
<%= Code39Barcode("TEST 123")%>
</p>

<br />

<p><strong>
Encoding &quot;ASP 101&quot;:
</strong></p>
<p>
<%= Code39Barcode("ASP 101")%>
</p>

