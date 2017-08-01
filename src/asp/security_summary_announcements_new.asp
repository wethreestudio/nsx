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
  
SQL = "SELECT annid, nsxcode, TradingCode, annPrecise, annUpload, annPriceSensitive, REPLACE(CONVERT(VARCHAR(10), [annUpload], 111), '/', '-') AS dateformatted, annFile, annTitle FROM coAnn WHERE nsxcode='" & nsxcode & "' AND annRelease IS NOT NULL ORDER BY annUpload ASC"
AnnRows = GetRows(SQL)
AnnRowsCount = 0
If VarType(AnnRows) <> 0 Then AnnRowsCount = UBound(AnnRows,2)
If AnnRowsCount > 0 Then
  Response.Write("[" & vbCrLf)
  For i = 0 To  AnnRowsCount
    annid = AnnRows(0,i)
    nsxcode = AnnRows(1,i)
    TradingCode = AnnRows(2,i)
    annPrecise = AnnRows(3,i)
    annUpload = AnnRows(4,i)
    annPriceSensitive = AnnRows(5,i)
    dateformatted = AnnRows(6,i)
    annFile = AnnRows(7,i)
    
    If annPriceSensitive = "True" Then
      annPriceSensitive = "1"
    Else
      annPriceSensitive = "0"
    End If

    Response.Write("[""" & dateformatted & """,""" & annPrecise & """,""" & annFile & """,""" & annPriceSensitive & """]")
    
    If i < ChartRowsCount Then Response.Write(",")
    Response.Write(vbCrLf)
 ''   Response.Write(ChartRows(0,i) & "," & volume & "," & FormatNumber(close,3,,,0) & vbCrLf)               
''    Response.Write(ChartRows(0,i) & "," & FormatNumber(open,3,,,0) & "," & FormatNumber(close,3,,,0) & "," & FormatNumber(high,3,,,0) & "," & FormatNumber(low,3,,,0) & "," & volume & vbCrLf)   
  Next
  Response.Write("]" & vbCrLf)
End If
%>