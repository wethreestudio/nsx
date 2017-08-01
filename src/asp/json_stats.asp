<%@ LANGUAGE="VBSCRIPT" %>
<%Server.ScriptTimeout=20%>
<!--#INCLUDE FILE="functions.asp"-->
<!--#INCLUDE FILE="include/db_connect.asp"-->

<!--#INCLUDE FILE="include_all.asp"-->
<!--#INCLUDE FILE="admin/merchtools.asp"-->

<%

Function FormatValue(value,decimalplaces)
  If IsNull(value) Then
    FormatValue = ""
  ElseIf Cdbl(value) = 0 Then
    FormatValue = ""
  Else
    'FormatValue = Replace(FormatNumber(value,decimalplaces),",","")
	FormatValue = FormatNumber(value,decimalplaces)
  End If
End Function

On Error Resume Next
Response.Buffer = True 
Response.ContentType="application/json"
%>{<%

i = 0
' Advances
SQL = "SELECT TOP 8 tradingcode, tradedatetime, [open], last, sessionmode, volume, prvclose, [bid], [offer], [last]-[prvclose] as change, [issuedescription], [bid], [offer] "
SQL = SQL & " FROM pricescurrent  "
SQL = SQL & " WHERE (issuestatus='Active') AND volume>0 AND ([last]-[prvclose]) > 0 AND exchid <> 'SIMV'"
SQL = SQL & " ORDER BY (last*volume) DESC, tradingcode ASC"
Set conn = GetReaderConn()
Set rs = conn.Execute(SQL)

If Not rs.EOF Then
%>
"advances": [
<%
  While Not rs.EOF
    BidPrice = CDbl(rs("bid")) 
    OfferPrice = CDbl(rs("offer"))
    ChangePrice = CDbl(rs("change"))
    If BidPrice = 0 Then
      BidPrice = "-"
    Else
      BidPrice = FormatNumber(BidPrice,3)
    End If 
    If OfferPrice = 0 Then
      OfferPrice = "-"
    Else
      OfferPrice = FormatNumber(OfferPrice,3)
    End If
    If ChangePrice = 0 Then
      ChangePrice = "-"
    Else
      ChangePrice = FormatNumber(ChangePrice,3)
    End If  
%>  {"code": "<%=rs("tradingcode")%>", "name": "<%=rs("issuedescription")%>", "bid": "<%=BidPrice%>", "offer": "<%=OfferPrice%>", "last": "<%=FormatNumber(rs("last"),3)%>", "volume": "<%=FormatNumber(rs("volume"),3)%>", "change": "<%=ChangePrice%>"}<%
    rs.MoveNext 
    If Not rs.EOF Then
      Response.Write(",")
    End If
    Response.Write(VbCrLf)
    
    i = i+1
  Wend
%>],
<% 
End If
rs.Close
Set rs = Nothing 
                 
                 
' Declines
SQL = "SELECT TOP 8 tradingcode, tradedatetime, [open], last, sessionmode, volume, prvclose, [bid], [offer], [last]-[prvclose] as change, [issuedescription], [bid], [offer] "
SQL = SQL & " FROM pricescurrent  "
SQL = SQL & " WHERE (issuestatus='Active') AND (last-prvclose)<0 AND volume>0 AND exchid <> 'SIMV'"
SQL = SQL & " ORDER BY (prvclose*(last-prvclose)) DESC, tradingcode ASC"
Set conn = GetReaderConn()
Set rs = conn.Execute(SQL)

i=0
If Not rs.EOF Then
%>
"decline": [
<%
  While Not rs.EOF
    BidPrice = CDbl(rs("bid")) 
    OfferPrice = CDbl(rs("offer"))
    ChangePrice = CDbl(rs("change"))
    If BidPrice = 0 Then
      BidPrice = "-"
    Else
      BidPrice = FormatNumber(BidPrice,3)
    End If 
    If OfferPrice = 0 Then
      OfferPrice = "-"
    Else
      OfferPrice = FormatNumber(OfferPrice,3)
    End If
    If ChangePrice = 0 Then
      ChangePrice = "-"
    Else
      ChangePrice = FormatNumber(ChangePrice,3)
    End If  
%>  {"code": "<%=rs("tradingcode")%>", "name": "<%=rs("issuedescription")%>", "bid": "<%=BidPrice%>", "offer": "<%=OfferPrice%>", "last": "<%=FormatNumber(rs("last"),3)%>", "volume": "<%=FormatNumber(rs("volume"),3)%>", "change": "<%=ChangePrice%>"}<%
    rs.MoveNext 
    If Not rs.EOF Then
      Response.Write(",")
    End If
    Response.Write(VbCrLf)
    
    i = i+1
  Wend 
%>],
<% 
End If
rs.Close
Set rs = Nothing


' Volume
SQL = "SELECT TOP 8 tradingcode, tradedatetime, [open], last, sessionmode, volume, prvclose, [bid], [offer], (1-([prvclose]/[last]))*100 as changep, [issuedescription] "
SQL = SQL & " FROM pricescurrent  "
SQL = SQL & " WHERE (issuestatus='Active') AND volume>0 AND exchid <> 'SIMV'"
SQL = SQL & " ORDER BY volume DESC, tradingcode ASC"
Set conn = GetReaderConn()
Set rs = conn.Execute(SQL)
If Not rs.EOF Then
%>
"volume": [
<%
  i=0
  While Not rs.EOF
%>  {"code": "<%=rs("tradingcode")%>", "name": "<%=rs("issuedescription")%>", "last": "<%=FormatNumber(FormatNumber(rs("last"),3),3)%>", "volume": "<%=FormatNumber(rs("volume"),0)%>", "changep": "<%=FormatNumber(rs("changep"),2)%>"}<%
    rs.MoveNext 
    If Not rs.EOF Then
      Response.Write(",")
    End If
    Response.Write(VbCrLf)
    i = i+1
  Wend 
%>],
<% 
End If
rs.Close
Set rs = Nothing 

' Value - used on home page

' SQL = "SELECT TOP 7 [marketcap],[tradingcode],[tradedatetime],[open],[high],[low],[last],[volume],[bid],[offer],[bidqty],[offerqty],[tradestatus],[exchid],[currentsharesonissue],[isin],[issuedescription],[issuetype],[industryclass],[sessionmode],[marketdepth],[quotebasis],[prvclose],[currenteps],[currentdps],[currentnta] "
' SQL = SQL & " FROM pricescurrent  "
' SQL = SQL & " WHERE issuestatus='Active' AND volume>0 AND exchid <> 'SIMV'"
' SQL = SQL & " ORDER BY [tradingcode] ASC"

SQL = "WITH CTE AS(SELECT ((coalesce([last],[prvclose],0) * currentsharesonissue)/1000000.0) as [marketcap], "
SQL = SQL & " [tradingcode],[tradedatetime],[open],[high],[low],[last],[volume],[issuestatus],[bid],[offer],[bidqty],[offerqty],[tradestatus],[exchid],[currentsharesonissue],[isin],[issuedescription],[issuetype],[industryclass],[sessionmode],[marketdepth],[quotebasis],[prvclose],[currenteps],[currentdps],[currentnta] "
SQL = SQL & " FROM pricescurrent) "
'SQL = SQL & " select top 7 * from cte WHERE issuestatus='Active' AND volume>0 AND exchid <> 'SIMV' order by [tradingcode] ASC "
SQL = SQL & " select top 7 * from cte WHERE issuestatus='Active'  AND exchid <> 'SIMV' order by [volume] DESC "

Set conn = GetReaderConn()
Set rs = conn.Execute(SQL)
If Not rs.EOF Then

%>
"value": [
<%
i=0
While Not rs.EOF

' MarketCap Calc
' If Not IsNull(rs("last")) Then
'     marketcap = 0
'     If Not IsNull(rs("currentsharesonissue")) And Cdbl(rs("last")) <> 0 Then marketcap = (CDbl(rs("last")) * CDbl(rs("currentsharesonissue")))/1000000.0
' End If
' 
' If marketcap = 0 And Not IsNull(rs("prvclose")) Then
'     If Not IsNull(rs("currentsharesonissue")) And CDbl(rs("prvclose")) > 0 Then marketcap = (CDbl(rs("prvclose")) * CDbl(rs("currentsharesonissue")))/1000000.0
' End If

%>  
    {"code": "<%=rs("tradingcode")%>", "volume": "<%=FormatNumber(rs("volume"),0)%>", "last": "<%=FormatNumber(FormatNumber(rs("last"),3),3)%>", "marketcap": "<%=FormatNumber(rs("marketcap"))%>"}<%
    '{"code": "<%=rs("tradingcode")% ", "name": " %=rs("issuedescription")%", "last": "%=FormatNumber(FormatNumber(rs("last"),3),3)%", "volume": "%=FormatNumber(rs("volume"),0)%", "value": "%=FormatNumber(rs("value"),0)%"}
        
    rs.MoveNext 
    If Not rs.EOF Then
      Response.Write(",")
    End If
    Response.Write(VbCrLf)
    i = i+1
  Wend
%>],
<% 
End If
rs.Close
Set rs = Nothing 

' Errors
If Err.Number <> 0  Then 
%>
"errordesc": "<%=Err.Description%>",
"errornum": "<%=Err.Number%>"
<%  
Else
%>
"errordesc": "",
"errornum": ""
<%
End If


%>}