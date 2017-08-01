<!--#INCLUDE FILE="functions.asp"-->
<!--#INCLUDE FILE="include/db_connect.asp"--><%
Response.CharSet = "UTF-8"
Response.ContentType = "text/plain"
nsxcode = request.querystring("nsxcode")
Set regEx = New RegExp 
regEx.Pattern = "^[a-zA-Z0-9]+$" 
isCodeValid = regEx.Test(nsxcode) 
If Not isCodeValid Then
  Response.Redirect "/"
  Response.End
End If
  
SQL = "SELECT REPLACE(CONVERT(VARCHAR(10), [tradedatetime], 111), '/', '-') AS dateformatted,[open],[last],[high],[low],[volume], [last]* [volume] as [value]  FROM [PricesDaily] WHERE tradingcode='" & nsxcode & "' AND YEAR(tradedatetime) >= YEAR(GETDATE())-1 ORDER BY tradedatetime DESC" ' AND YEAR(tradedatetime) >= YEAR(GETDATE())-1'
ChartRows = GetRows(SQL)
ChartRowsCount = 0
If VarType(ChartRows) <> 0 Then ChartRowsCount = UBound(ChartRows,2)
If ChartRowsCount > 0 Then
  For i = 0 To  ChartRowsCount
    open = CDbl(ChartRows(1,i))
    close = CDbl(ChartRows(2,i))
    high = CDbl(ChartRows(3,i))
    low = CDbl(ChartRows(4,i))
    volume = CDbl(ChartRows(5,i))
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
    Response.Write(ChartRows(0,i) & "," & volume & "," & FormatNumber(close,3,,,0) & vbCrLf)               
''    Response.Write(ChartRows(0,i) & "," & FormatNumber(open,3,,,0) & "," & FormatNumber(close,3,,,0) & "," & FormatNumber(high,3,,,0) & "," & FormatNumber(low,3,,,0) & "," & volume & vbCrLf)   
  Next
End If
%>
