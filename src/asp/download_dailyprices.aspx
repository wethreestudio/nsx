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
  
  ' test if exist
  if len(nsxCode) = 0 then 
	response.write ("no code")
	response.end
  end if
  if len(formattype) = 0 then 
	response.write ("no format")
	response.end
  end if
  
    ' test code is OK
   if instr(nsxcode,"-") > 0 or instr(nsxcode,")") > 0 or instr(nsxcode,"@") > 0 then
   	response.write ("invalid code")
	response.end
	end if
  
  
  Dim connString as String 
  connString = System.Configuration.ConfigurationManager.ConnectionStrings("nsx_ReaderConnectionString").ConnectionString()
   
  'Open a connection
  Dim objConnection as OleDbConnection
  objConnection = New OleDbConnection(connString)
  objConnection.Open()
  
  'Specify the SQL string
  'Dim strSQL as String = "SELECT PricesTrades.SalePrice, PricesTrades.SaleVolume, PricesTrades.SaleValue, PricesTrades.TradeDateTime, PricesTrades.SettleDate, StockCodes.StockName, BrokerBuyers.BrokerName AS Buyer, BrokerSellers.BrokerName AS Seller, PricesTrades.TradeNumber, pricestrades.adddelete FROM BrokerSellers INNER JOIN (BrokerBuyers INNER JOIN (PricesTrades INNER JOIN StockCodes ON PricesTrades.TradingCode = StockCodes.StockCode) ON BrokerBuyers.BrokerId = PricesTrades.BuyerID) ON BrokerSellers.BrokerId = PricesTrades.SellerID WHERE tradingcode=? ORDER BY PricesTrades.TradeDateTime DESC, CAST(PricesTrades.TradeNumber AS INT) DESC"
  
   Dim strSQL as String = "SELECT DISTINCT [tradingcode], [tradedatetime] , [open], [high], [low], [last], [volume], [bid], [offer]"
		strSQL = strSQL & " FROM pricesdaily"
		strSQL = strSQL & " WHERE tradingcode=? "
		strSQL = strSQL & " ORDER BY [tradedatetime] ASC"
  
  
  
  'Create a command object
  Dim objCommand as OleDbCommand
  objCommand = New OleDbCommand(strSQL, objConnection)
  objCommand.Parameters.Add("tradingcode", nsxCode)
  
  'Get a datareader
  Dim objDataReader as OleDbDataReader
  objDataReader = objCommand.ExecuteReader(CommandBehavior.CloseConnection)
  
  If formattype = "CSV" Then
    Dim attachment As String = "attachment; filename=dailyprice_history_" & nsxCode & ".csv"
    HttpContext.Current.Response.AddHeader("content-disposition", attachment)
    HttpContext.Current.Response.ContentType = "text/csv"
    HttpContext.Current.Response.AddHeader("Pragma", "public")
  End If
  If formattype = "XMLSS" Then
    Dim attachment As String = "attachment; filename=dailyprice_history_" & nsxCode & ".xml"
    'HttpContext.Current.Response.AddHeader("content-disposition", attachment)
    'HttpContext.Current.Response.ContentType = "application/xls"
    'HttpContext.Current.Response.AddHeader("Pragma", "public")
    HttpContext.Current.Response.ContentType = "text/plain"
  End If
  
  If formattype = "XLS" Then
    Response.ContentType = "application/vnd.ms-excel"
    Response.AddHeader("Content-Disposition", "attachment; filename=dailyprice_history_" & nsxCode & ".xls")
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
      xls.Append("<td>Date</td>" & vbCrLf)
      xls.Append("<td>OpenPrice</td>" & vbCrLf)
      xls.Append("<td>HighPrice</td>" & vbCrLf)
      xls.Append("<td>LowPrice</td>" & vbCrLf)
      xls.Append("<td>LastPrice</td>" & vbCrLf)
      xls.Append("<td>Volume</td>" & vbCrLf)
	  xls.Append("<td>Bid</td>" & vbCrLf)
	  xls.Append("<td>Offer</td>" & vbCrLf)
      xls.Append("</tr>" & vbCrLf)
      While objDataReader.Read()
		Dim Volume As Double
		
		Dim tradedate = objDataReader("tradedatetime")
		DIm OpenPrice = objDataReader("open")
		Dim HighPrice = objDataReader("high")
		Dim LowPrice = objDataReader("low")
		Dim LastPrice = objDataReader("last")
		Volume = objDataReader("volume")
		Dim BidPrice = objDataReader("bid")
		Dim OfferPrice = objDataReader("offer")
	
		
        xls.Append("<tr>" & vbCrLf)
        xls.Append("<td>" & tradedate & "</td>" & vbCrLf)
        xls.Append("<td>" & OpenPrice & "</td>" & vbCrLf)
        xls.Append("<td>" & HighPrice & "</td>" & vbCrLf)
        xls.Append("<td>" & LowPrice & "</td>" & vbCrLf)
        xls.Append("<td>" & LastPrice & "</td>" & vbCrLf)
        xls.Append("<td>" & Volume & "</td>" & vbCrLf)
        xls.Append("<td>" & BidPrice & "</td>" & vbCrLf)
        xls.Append("<td>" & OfferPrice & "</td>" & vbCrLf)
        xls.Append("</tr>" & vbCrLf)
      End While
      xls.Append("<body>" & vbCrLf)
      xls.Append("<table>" & vbCrLf)
      xls.Append("</table>" & vbCrLf)
      HttpContext.Current.Response.Write(xls.ToString())
    End If
    
    If formattype = "CSV" Then
      Dim strh As New StringBuilder()
  		AddComma("Date",strh)
  		AddComma("OpenPrice",strh)
  		AddComma("HighPrice",strh)
  		AddComma("LowPrice",strh)
  		AddComma("LastPrice",strh)
  		AddComma("Volume",strh)
  		AddComma("Bid",strh)
  		strh.Append("Offer")
  		HttpContext.Current.Response.Write(strh.ToString())
  		HttpContext.Current.Response.Write(Environment.NewLine)        
      While objDataReader.Read()

		Dim volume As Double

		Dim tradedate = objDataReader("tradedatetime")
		Dim OpenPrice = objDataReader("open")
		Dim HighPrice = objDataReader("high")
		Dim LowPrice = objDataReader("low")
		Dim LastPrice = objDataReader("last")
		Volume = objDataReader("volume")
		Dim BidPrice = objDataReader("bid")
		Dim OfferPrice = objDataReader("offer")

		
        Dim strb As New StringBuilder()
    		AddComma(tradedate, strb)
    		AddComma(OpenPrice, strb)
    		AddComma(HighPrice, strb)
    		AddComma(LowPrice, strb)
    		AddComma(LastPrice, strb)
    		AddComma(Volume, strb)
    		AddComma(BidPrice, strb)
    		strb.Append(OfferPrice)
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
      xmlss.Append("<Cell><Data ss:Type=""String"">Date</Data></Cell>" & vbLf)
      xmlss.Append("<Cell><Data ss:Type=""String"">OpenPrice</Data></Cell>" & vbLf)
      xmlss.Append("<Cell><Data ss:Type=""String"">HighPrice</Data></Cell>" & vbLf)
      xmlss.Append("<Cell><Data ss:Type=""String"">LowPrice</Data></Cell>" & vbLf)
      xmlss.Append("<Cell><Data ss:Type=""String"">LastPrice</Data></Cell>" & vbLf)
      xmlss.Append("<Cell><Data ss:Type=""String"">Volume</Data></Cell>" & vbLf)
      xmlss.Append("<Cell><Data ss:Type=""String"">Bid</Data></Cell>" & vbLf)
      xmlss.Append("<Cell><Data ss:Type=""String"">Offer</Data></Cell>" & vbLf)
      xmlss.Append("</Row>" & vbLf)
      While objDataReader.Read()
        xmlss.Append("<Row>" & vbLf)
        xmlss.Append("<Cell><Data ss:Type=""String"">" & objDataReader("tradedatetime") & "</Data></Cell>" & vbLf)
        xmlss.Append("<Cell><Data ss:Type=""Number"">" & objDataReader("open") & "</Data></Cell>" & vbLf)
        xmlss.Append("<Cell><Data ss:Type=""Number"">" & objDataReader("high") & "</Data></Cell>" & vbLf)
        xmlss.Append("<Cell><Data ss:Type=""Number"">" & objDataReader("low") & "</Data></Cell>" & vbLf)
        xmlss.Append("<Cell><Data ss:Type=""Number"">" & objDataReader("last") & "</Data></Cell>" & vbLf)
        xmlss.Append("<Cell><Data ss:Type=""Number"">" & objDataReader("volume") & "</Data></Cell>" & vbLf)
        xmlss.Append("<Cell><Data ss:Type=""Number"">" & objDataReader("bid") & "</Data></Cell>" & vbLf)
        xmlss.Append("<Cell><Data ss:Type=""Number"">" & objDataReader("offer") & "</Data></Cell>" & vbLf)
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