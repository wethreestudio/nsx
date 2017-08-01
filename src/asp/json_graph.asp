<%@ LANGUAGE="VBSCRIPT" %>
<!--#INCLUDE FILE="include/sql_functions.asp"-->
<%Server.ScriptTimeout=360%>
<!--#INCLUDE FILE="functions.asp"-->
<!--#INCLUDE FILE="include/db_connect.asp"-->
<%
On Error Resume Next

Response.Buffer = True 
Response.ContentType="application/json"
gt = Request.QueryString("type")
indexCode = Request.QueryString("indexcode")


If Not valid_security_code(indexCode) Then 
	Response.Write ("Invalid Security Code")
	Response.End
End If

indexname = Request.QueryString("indexname")
'days = 100
days = 365
errordesc = ""
errornum = ""
If Len(Request.QueryString("days")) > 0 Then
  If IsNumeric(Request.QueryString("days")) Then
    days = Request.QueryString("days")
    If days < 7 Then
      days = 7
    End If
  End If
End If

Dim graphData
If gt = "index" Then
  graphData = GetIndexChartData(indexCode,days)
Else
  graphData = GetCompanyChartData(indexCode,days)
End If

'NSXAEI

Rows = GetRows("SELECT last FROM IndexCurrent WHERE tradingCode='" & SafeSqlParameter(indexCode) & "'")
lastPrice = Rows(0,0)
Rows2 = GetRows("SELECT TOP 1 last FROM IndexDaily WHERE tradingCode='" & SafeSqlParameter(indexCode) & "' ORDER BY tradeDateTime DESC")
lastDaily = Rows2(0,0)
lastpricechange = ((lastPrice-lastDaily)/lastDaily)*100

' /charts_index.asp?tradingcode=NSXAEI&coname=NSX All Equities Index&size=700x350
linkurl = "/charts_index.asp?tradingcode=" & Server.URLEncode(Server.HTMLEncode(indexCode)) & "&coname=" & Server.URLEncode(Server.HTMLEncode(indexname)) & "&size=700x350"
If  Err.Number <> 0  Then   
  errordesc = Err.Description
  errornum = Err.Number
End If

'Notes
'Builds stats from functions.asp line 388; Function GetChartData(Sql, ChxIndex)...

'UpdateIndex("NSXAEI","NSX All Equities Index", 365,'index');

'response.Write("<script language=javascript>console.log('" & graphData(2) & "'); </script>")

'Response.Write(graphData(2))

%>{
"error": "<%=errordesc%>",
"errornum": "<%=errornum%>",
"graphchd": "<%=graphData(0)%>",
"graphchxl": "<%=graphData(1)%>",
"graphchxr": "<%=graphData(2)%>",
"last": "<%=lastPrice%>",
"change": "<%=lastpricechange%>",
"linkurl": "<%=linkurl%>"
}