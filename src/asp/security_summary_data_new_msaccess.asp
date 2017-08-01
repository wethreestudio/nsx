<%
Response.CharSet = "UTF-8"
Response.ContentType = "text/plain"
nsxcode = request.querystring("nsxcode")
callback = request.querystring("callback")

DATA_PATH = Server.Mappath("newsxdb\nsxprices.mdb")

//response.write nsxcode
//response.end

Set regEx = New RegExp 
regEx.Pattern = "^[a-zA-Z0-9]+$" 
isCodeValid = regEx.Test(nsxcode) 
If Not isCodeValid Then
  Response.Redirect "/"
  Response.End
End If

If Len(callback) > 0 Then Response.Write( callback & "(" & vbCrLf)
Response.Write("{") 

SQL = "SELECT Format(tradedatetime,'yyyy-mm-dd') AS dateformatted, PricesDaily.[open], PricesDaily.[last], PricesDaily.[high], PricesDaily.[low], PricesDaily.[volume], [last]*[volume] AS [value] FROM PricesDaily WHERE (((PricesDaily.[tradingcode])='" & nsxcode & "') AND ((DateDiff('d',[tradedatetime],Now()))<365)) ORDER BY PricesDaily.tradedatetime"

connString = "DBQ=" & DATA_PATH &   ";Driver={Microsoft Access Driver (*.mdb)};UID=" & ConnPasswords_RuntimeUserName & ";PASSWORD=" & ConnPasswords_RuntimePassword
'Response.Write SQL

Set conn = Server.CreateObject("ADODB.Connection")
Set rs = Server.CreateObject("ADODB.Recordset")
conn.Open connString
rs.CacheSize=100 
rs.Open SQL,conn,1,3



min_date = Now()
have_min_date = 0

If Not rs.EOF Then
  Response.Write("""pricedata"": [" & vbCrLf)
  Do While Not rs.eof
    open = rs("open")
    close = rs("last")
    high = rs("high")
    low = rs("low")
    volume = rs("volume")
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

    Response.Write("[""" & rs("dateformatted") & """," & FormatNumber(close,3,,,0) & "," & volume & "]" & vbCrLf)
    rs.movenext
    If Not rs.EOF Then Response.Write(",")
  Loop
  Response.Write("]" & vbCrLf) 
End If

rs.close
set rs = nothing
Set rs = Server.CreateObject("ADODB.Recordset")


Response.Write(",""announcements"": [] " & vbCrLf)

Response.Write("}")
If Len(callback) > 0 Then Response.Write( vbCrLf & ");")


conn.Close
set conn = nothing 

Response.End

SQL = "SELECT annid, nsxcode, TradingCode, annPrecise, annUpload, annPriceSensitive, Format([annUpload],'yyyy-mm-dd') AS dateformatted, annFile, annTitle FROM coAnn WHERE nsxcode='" & nsxcode & "' AND annRelease IS NOT NULL AND annRelease >= DATEADD(mm, -24, GETDATE()) AND annRelease >= '" & FormatSQLDate(min_date, False) &  "'  ORDER BY annUpload ASC"
'Response.Write SQL
'Response.End
rs.CacheSize=100 
rs.Open SQL,conn,1,3


AnnRows = GetRows(SQL)
AnnRowsCount = 0
If VarType(AnnRows) <> 0 Then AnnRowsCount = UBound(AnnRows,2)
If AnnRowsCount > 0 Then
  Response.Write(", ""announcements"": [" & vbCrLf)
  For i = 0 To  AnnRowsCount
    annid = AnnRows(0,i)
    nsxcode = AnnRows(1,i)
    TradingCode = AnnRows(2,i)
    annPrecise = AnnRows(3,i)
    annUpload = AnnRows(4,i)
    annPriceSensitive = AnnRows(5,i)
    dateformatted = AnnRows(6,i)
    annFile = AnnRows(7,i)
    
    annPrecise = Replace(annPrecise, vbCrLf, "")
    annPrecise = Replace(annPrecise, vbCr, "")
    annPrecise = Replace(annPrecise, vbLf, "")
    
    If annPriceSensitive = "True" Then
      annPriceSensitive = "1"
    Else
      annPriceSensitive = "0"
    End If

    Response.Write("[""" & dateformatted & """,""" & annPrecise & """,""" & annFile & """,""" & annPriceSensitive & """]")
    
    If i < AnnRowsCount Then Response.Write(",")
    Response.Write(vbCrLf)
 ''   Response.Write(ChartRows(0,i) & "," & volume & "," & FormatNumber(close,3,,,0) & vbCrLf)               
''    Response.Write(ChartRows(0,i) & "," & FormatNumber(open,3,,,0) & "," & FormatNumber(close,3,,,0) & "," & FormatNumber(high,3,,,0) & "," & FormatNumber(low,3,,,0) & "," & volume & vbCrLf)   
  Next
  Response.Write("]" & vbCrLf)
End If
Response.Write("}")
If Len(callback) > 0 Then Response.Write( vbCrLf & ");")


conn.Close
set conn = nothing 

%>