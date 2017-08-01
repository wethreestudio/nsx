<!--#INCLUDE FILE="functions.asp"-->
<!--#INCLUDE FILE="include/db_connect.asp"-->
<!--#INCLUDE FILE="include/sql_functions.asp"--><%
Response.CharSet = "UTF-8"
Response.ContentType = "text/plain"
nsxcode = request.querystring("nsxcode")
callback = request.querystring("callback")

' response.write nsxcode
' response.end

Set regEx = New RegExp 
regEx.Pattern = "^[a-zA-Z0-9]+$" 
isCodeValid = regEx.Test(nsxcode) 
If Not isCodeValid Then
  Response.Redirect "/"
  Response.End
End If

If Len(callback) > 0 Then Response.Write( callback & "(/* " & nsxcode & " historical price, volume, and announcement data */" & vbCrLf)
Response.Write("{") 
SQL = "SELECT REPLACE(CONVERT(VARCHAR(10), [tradedatetime], 111), '/', '-') AS dateformatted,[open],[last],[high],[low],[volume], [last]* [volume] as [value]  FROM [PricesDaily] WHERE tradingcode='" & nsxcode & "' AND [last] > 0.0 AND tradedatetime >= DATEADD(mm, -36, GETDATE()) ORDER BY tradedatetime ASC"

' Response.Write SQL : Response.End
Set conn = GetReaderConn()
Set rs = conn.Execute(SQL)

min_date = Now()
have_min_date = 0

If Not rs.EOF Then
  Response.Write("""pricedata"": [" & vbCrLf)
  While Not rs.EOF
    open = CDbl(rs("open")) 
    close = CDbl(rs("last")) 
    high = CDbl(rs("high")) 
    low = CDbl(rs("low")) 
    volume = CDbl(rs("volume")) 
    If open = 0 Then
      open = close
    End If
    If high = 0 Then
      high = close
      If open > close Then high = open 
    End If
    If low = 0 Then
      low = close
      If open < close Then low = open 
    End If


    ' date-time, close price, volume
    dt = Split(rs("dateformatted"), "-")
    dtd = CDate(dt(2) & "/" & dt(1) & "/" & dt(0))      
    
    If dtd < min_date Then
      min_date = CDate(dt(2) & "/" & dt(1) & "/" & dt(0))
    End If


    Response.Write("[""" & rs("dateformatted") & """," & FormatNumber(close,3,,,0) & "," & volume & "]")
    
    rs.MoveNext 
     
	If Not rs.EOF Then
		Response.Write(",")
	End If
    Response.Write(vbCrLf)
  Wend
  rs.Close()
  Set rs = Nothing
  
  Response.Write("]" & vbCrLf)
End If


SQL = "SELECT annid, nsxcode, TradingCode, annPrecise, annUpload, annPriceSensitive, REPLACE(CONVERT(VARCHAR(10), [annUpload], 111), '/', '-') AS dateformatted, annFile, annTitle FROM coAnn WHERE tradingcode='" & nsxcode & "' AND annRelease IS NOT NULL AND annRelease >= DATEADD(mm, -24, GETDATE()) AND annRelease >= '" & FormatSQLDate(min_date, False) &  "'  ORDER BY annUpload ASC"
'Response.Write SQL
'Response.End

Set rs = conn.Execute(SQL)

'AnnRows = GetRows(SQL)
'AnnRowsCount = 0
'If VarType(AnnRows) <> 0 Then AnnRowsCount = UBound(AnnRows,2)
'If AnnRowsCount > 0 Then
If Not rs.EOF Then
  Response.Write(", ""announcements"": [" & vbCrLf)
  'For i = 0 To  AnnRowsCount
  While Not rs.EOF
    annid = rs("annid") ' AnnRows(0,i)
    nsxcode = rs("nsxcode") 'AnnRows(1,i)
    TradingCode =  rs("TradingCode") 'AnnRows(2,i)
    annPrecise = rs("annPrecise") ' AnnRows(3,i)
    annUpload = rs("annUpload") ' AnnRows(4,i)
    annPriceSensitive = rs("annPriceSensitive") ' AnnRows(5,i)
    dateformatted = rs("dateformatted") ' AnnRows(6,i)
    annFile = rs("annFile") ' AnnRows(7,i)
    
    annPrecise = Replace(annPrecise, vbCrLf, "")
    annPrecise = Replace(annPrecise, vbCr, "")
    annPrecise = Replace(annPrecise, vbLf, "")
    
    If annPriceSensitive = "True" Then
      annPriceSensitive = "1"
    Else
      annPriceSensitive = "0"
    End If

    Response.Write("[""" & dateformatted & """,""" & annPrecise & """,""" & annFile & """,""" & annPriceSensitive & """]")
    
    rs.MoveNext 
     
	If Not rs.EOF Then
		Response.Write(",")
	End If	
    ' If i < AnnRowsCount Then Response.Write(",")
    Response.Write(vbCrLf)
 ''   Response.Write(ChartRows(0,i) & "," & volume & "," & FormatNumber(close,3,,,0) & vbCrLf)               
''    Response.Write(ChartRows(0,i) & "," & FormatNumber(open,3,,,0) & "," & FormatNumber(close,3,,,0) & "," & FormatNumber(high,3,,,0) & "," & FormatNumber(low,3,,,0) & "," & volume & vbCrLf)   
  Wend
  Response.Write("]" & vbCrLf)
End If
Response.Write("}")
If Len(callback) > 0 Then Response.Write( vbCrLf & ");")
%>