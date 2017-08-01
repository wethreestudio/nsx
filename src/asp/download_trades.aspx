<%@ OutputCache Duration="60" VaryByParam="nsxcode" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Data.OleDb" %>
<script language="VB" runat="server">

Private Shared Sub AddComma(item As String, strb As StringBuilder)
	strb.Append(item.Replace(","C, " "C))
	strb.Append(",")
End Sub

Sub Page_Load(sender as Object, e as EventArgs)
  Dim nsxCode As String = Request.QueryString("nsxcode")
  Dim formattype As String = Request.QueryString("format")
  Dim connString as String 
  connString = System.Configuration.ConfigurationManager.ConnectionStrings("nsx_ReaderConnectionString").ConnectionString()
   
  'Open a connection
  Dim objConnection as OleDbConnection
  objConnection = New OleDbConnection(connString)
  objConnection.Open()
  
  'Specify the SQL string
  Dim strSQL as String = "SELECT PricesTrades.SalePrice, PricesTrades.SaleVolume, PricesTrades.SaleValue, PricesTrades.TradeDateTime, PricesTrades.SettleDate, StockCodes.StockName, BrokerBuyers.BrokerName AS Buyer, BrokerSellers.BrokerName AS Seller, PricesTrades.TradeNumber, pricestrades.adddelete FROM BrokerSellers INNER JOIN (BrokerBuyers INNER JOIN (PricesTrades INNER JOIN StockCodes ON PricesTrades.TradingCode = StockCodes.StockCode) ON BrokerBuyers.BrokerId = PricesTrades.BuyerID) ON BrokerSellers.BrokerId = PricesTrades.SellerID WHERE tradingcode=? ORDER BY PricesTrades.TradeDateTime DESC, CAST(PricesTrades.TradeNumber AS INT) DESC"
  
  'Create a command object
  Dim objCommand as OleDbCommand
  objCommand = New OleDbCommand(strSQL, objConnection)
  objCommand.Parameters.Add("tradingcode", nsxCode)
  
  'Get a datareader
  Dim objDataReader as OleDbDataReader
  objDataReader = objCommand.ExecuteReader(CommandBehavior.CloseConnection)
  
  If formattype = "CSV" Then
    Dim attachment As String = "attachment; filename=" & nsxCode & "_trade_history.csv"
    HttpContext.Current.Response.AddHeader("content-disposition", attachment)
    HttpContext.Current.Response.ContentType = "text/csv"
    HttpContext.Current.Response.AddHeader("Pragma", "public")
  End If
  If formattype = "XMLSS" Then
    Dim attachment As String = "attachment; filename=" & nsxCode & "_trade_history.xml"
    'HttpContext.Current.Response.AddHeader("content-disposition", attachment)
    'HttpContext.Current.Response.ContentType = "application/xls"
    'HttpContext.Current.Response.AddHeader("Pragma", "public")
    HttpContext.Current.Response.ContentType = "text/plain"
  End If
  
  If formattype = "XLS" Then
    Response.ContentType = "application/vnd.ms-excel"
    Response.AddHeader("Content-Disposition", "attachment; filename=" & nsxCode & "_trade_history.xls")
  End If
      
  If objDataReader.HasRows Then
    If formattype = "XLS" Then
      Dim xls As New StringBuilder()
      xls.Append("<html>" & vbCrLf)
      xls.Append("<head>" & vbCrLf)
      xls.Append("<meta http-equiv=""Content-Type"" content=""text/html; charset=UTF-8"">" & vbCrLf)
      xls.Append("<style type=""text/css"">" & vbCrLf)
      xls.Append("html, body, table {" & vbCrLf)
      xls.Append("    margin: 0;" & vbCrLf)
      xls.Append("    padding: 0;" & vbCrLf)
      xls.Append("    font-size: 11pt;" & vbCrLf)
      xls.Append("}" & vbCrLf)
      xls.Append("table, th, td { " & vbCrLf)
      xls.Append("    border: 0.1pt solid #D0D7E5;" & vbCrLf)
      xls.Append("    border-collapse: collapse;" & vbCrLf)
      xls.Append("    border-spacing: 0;" & vbCrLf)
      xls.Append("}" & vbCrLf)
      xls.Append("</style>" & vbCrLf)
      xls.Append("</head>" & vbCrLf)
      xls.Append("<body>" & vbCrLf)
      xls.Append("<table>" & vbCrLf)
      xls.Append("<tr>" & vbCrLf)
      xls.Append("<td>SalePrice</td>" & vbCrLf)
      xls.Append("<td>SaleVolume</td>" & vbCrLf)
      xls.Append("<td>SaleValue</td>" & vbCrLf)
      xls.Append("<td>TradeDateTime</td>" & vbCrLf)
      xls.Append("<td>SettleDate</td>" & vbCrLf)
      xls.Append("<td>StockName</td>" & vbCrLf)
      xls.Append("<td>Buyer</td>" & vbCrLf)
      xls.Append("<td>Seller</td>" & vbCrLf)
      xls.Append("<td>TradeNumber</td>" & vbCrLf)
      xls.Append("<td>Status</td>" & vbCrLf)
      xls.Append("</tr>" & vbCrLf)
      While objDataReader.Read()
		Dim status As String
		Dim volume As Double
		Dim value As Double
		volume = objDataReader("SaleVolume")
		value = objDataReader("SaleValue")
		status = objDataReader("adddelete")
		If status = "D" Then
			status = "Cancelled"
			value = value * -1
			volume = volume * -1
		ElseIf status = "A" Then
			status = ""
		End If
        xls.Append("<tr>" & vbCrLf)
        xls.Append("<td>" & objDataReader("SalePrice") & "</td>" & vbCrLf)
        xls.Append("<td>" & volume & "</td>" & vbCrLf)
        xls.Append("<td>" & value & "</td>" & vbCrLf)
        xls.Append("<td>" & objDataReader("TradeDateTime") & "</td>" & vbCrLf)
        xls.Append("<td>" & objDataReader("SettleDate") & "</td>" & vbCrLf)
        xls.Append("<td>" & objDataReader("StockName") & "</td>" & vbCrLf)
        xls.Append("<td>" & objDataReader("Buyer") & "</td>" & vbCrLf)
        xls.Append("<td>" & objDataReader("Seller") & "</td>" & vbCrLf)
        xls.Append("<td>" & objDataReader("TradeNumber") & "</td>" & vbCrLf)
        xls.Append("<td>" & status & "</td>" & vbCrLf)
        xls.Append("</tr>" & vbCrLf)
      End While
      xls.Append("<body>" & vbCrLf)
      xls.Append("<table>" & vbCrLf)
      xls.Append("</table>" & vbCrLf)
      HttpContext.Current.Response.Write(xls.ToString())
    End If
    
    If formattype = "CSV" Then
      Dim strh As New StringBuilder()
  		AddComma("SalePrice",strh)
  		AddComma("SaleVolume",strh)
  		AddComma("SaleValue",strh)
  		AddComma("TradeDateTime",strh)
  		AddComma("SettleDate",strh)
  		AddComma("StockName",strh)
  		AddComma("Buyer",strh)
  		AddComma("Seller",strh)
  		AddComma("TradeNumber",strh)
  		strh.Append("Status")
  		HttpContext.Current.Response.Write(strh.ToString())
  		HttpContext.Current.Response.Write(Environment.NewLine)        
      While objDataReader.Read()
		Dim status As String
		Dim volume As Double
		Dim value As Double
		volume = objDataReader("SaleVolume")
		value = objDataReader("SaleValue")
		status = objDataReader("adddelete")
		If status = "D" Then
			status = "Cancelled"
			value = value * -1
			volume = volume * -1
		ElseIf status = "A" Then
			status = ""
		End If	  
        Dim strb As New StringBuilder()
    		AddComma(objDataReader("SalePrice"), strb)
    		AddComma(volume, strb)
    		AddComma(value, strb)
    		AddComma(objDataReader("TradeDateTime"), strb)
    		AddComma(objDataReader("SettleDate"), strb)
    		AddComma(objDataReader("StockName"), strb)
    		AddComma(objDataReader("Buyer"), strb)
    		AddComma(objDataReader("Seller"), strb)
    		AddComma(objDataReader("TradeNumber"), strb)
    		strb.Append(status)
    		HttpContext.Current.Response.Write(strb.ToString())
    		HttpContext.Current.Response.Write(Environment.NewLine)
      End While
    End If
    
    If formattype = "XMLSS" Then
      Dim xmlss As New StringBuilder()
      xmlss.Append("<?xml version=""1.0""?>" & vbLf)
      xmlss.Append("<?mso-application progid=""Excel.Sheet""?>" & vbLf)
      xmlss.Append("<Workbook xmlns=""urn:schemas-microsoft-com:office:spreadsheet"" ")
      xmlss.Append("xmlns:o=""urn:schemas-microsoft-com:office:office"" ")
      xmlss.Append("xmlns:x=""urn:schemas-microsoft-com:office:excel"" ")
      xmlss.Append("xmlns:ss=""urn:schemas-microsoft-com:office:spreadsheet"" ")
      xmlss.Append("xmlns:html=""http://www.w3.org/TR/REC-html40"">" & vbLf)
      xmlss.Append("<DocumentProperties xmlns=""urn:schemas-microsoft-com:office:office"">")
      xmlss.Append("</DocumentProperties>")
      xmlss.Append("<ExcelWorkbook xmlns=""urn:schemas-microsoft-com:office:excel"">" & vbLf)
      xmlss.Append("<ProtectStructure>False</ProtectStructure>" & vbLf)
      xmlss.Append("<ProtectWindows>False</ProtectWindows>" & vbLf)
      xmlss.Append("</ExcelWorkbook>" & vbLf)
      xmlss.Append("<Worksheet ss:Name=""" & nsxCode & """>" & vbLf)
      xmlss.Append("<Table>" & vbLf)
      xmlss.Append("<Row>" & vbLf)
      xmlss.Append("<Cell><Data ss:Type=""String"">SalePrice</Data></Cell>" & vbLf)
      xmlss.Append("<Cell><Data ss:Type=""String"">SaleVolume</Data></Cell>" & vbLf)
      xmlss.Append("<Cell><Data ss:Type=""String"">SaleValue</Data></Cell>" & vbLf)
      xmlss.Append("<Cell><Data ss:Type=""String"">TradeDateTime</Data></Cell>" & vbLf)
      xmlss.Append("<Cell><Data ss:Type=""String"">SettleDate</Data></Cell>" & vbLf)
      xmlss.Append("<Cell><Data ss:Type=""String"">StockName</Data></Cell>" & vbLf)
      xmlss.Append("<Cell><Data ss:Type=""String"">Buyer</Data></Cell>" & vbLf)
      xmlss.Append("<Cell><Data ss:Type=""String"">Seller</Data></Cell>" & vbLf)
      xmlss.Append("<Cell><Data ss:Type=""String"">TradeNumber</Data></Cell>" & vbLf)
      xmlss.Append("<Cell><Data ss:Type=""String"">Status</Data></Cell>" & vbLf)
      xmlss.Append("</Row>" & vbLf)
      While objDataReader.Read()
        xmlss.Append("<Row>" & vbLf)
        xmlss.Append("<Cell><Data ss:Type=""Number"">" & objDataReader("SalePrice") & "</Data></Cell>" & vbLf)
        xmlss.Append("<Cell><Data ss:Type=""Number"">" & objDataReader("SaleVolume") & "</Data></Cell>" & vbLf)
        xmlss.Append("<Cell><Data ss:Type=""Number"">" & objDataReader("SaleValue") & "</Data></Cell>" & vbLf)
        xmlss.Append("<Cell><Data ss:Type=""String"">" & objDataReader("TradeDateTime") & "</Data></Cell>" & vbLf)
        xmlss.Append("<Cell><Data ss:Type=""String"">" & objDataReader("SettleDate") & "</Data></Cell>" & vbLf)
        xmlss.Append("<Cell><Data ss:Type=""String"">" & objDataReader("StockName") & "</Data></Cell>" & vbLf)
        xmlss.Append("<Cell><Data ss:Type=""String"">" & objDataReader("Buyer") & "</Data></Cell>" & vbLf)
        xmlss.Append("<Cell><Data ss:Type=""String"">" & objDataReader("Seller") & "</Data></Cell>" & vbLf)
        xmlss.Append("<Cell><Data ss:Type=""Number"">" & objDataReader("TradeNumber") & "</Data></Cell>" & vbLf)
        xmlss.Append("<Cell><Data ss:Type=""String"">" & objDataReader("adddelete") & "</Data></Cell>" & vbLf)
        xmlss.Append("</Row>" & vbLf)
      End While
      xmlss.Append("</Table>" & vbLf)
      xmlss.Append("</Worksheet>" & vbLf)
      HttpContext.Current.Response.Write(xmlss.ToString())
    End If
  End If
  objDataReader.Close()
End Sub
</script> 