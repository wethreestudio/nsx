<!--#INCLUDE FILE="functions.asp"-->
<!--#INCLUDE FILE="include/db_connect.asp"--><%
Response.ContentType="application/x-javascript"
code = request.querystring("code")
%>
AmCharts.ready(function () {
	generateChartData();
	createStockChart();
});

var chartData = [];


function generateChartData() {
<%
SQL = "SELECT REPLACE(CONVERT(VARCHAR(10), [tradedatetime], 111), '/', '-') AS dateformatted,[open],[last],[high],[low],[volume], [last]* [volume] as [value]  FROM [PricesDaily] WHERE tradingcode='" & code & "' AND YEAR(tradedatetime) >= YEAR(GETDATE())-1 ORDER BY tradedatetime DEC"
ChartRows = GetRows(SQL)
ChartRowsCount = 0
If VarType(ChartRows) <> 0 Then ChartRowsCount = UBound(ChartRows,2)
If ChartRowsCount > 0 Then
  For i = 0 To  ChartRowsCount
    open = CDbl(ChartRows(1,i))
    close = CDbl(ChartRows(2,i))
    high = CDbl(ChartRows(3,i))
    low = CDbl(ChartRows(4,i))
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
%>chartData.push({date: new Date('<%=ChartRows(0,i)%>'), open: <%=open%>, close: <%=close%>, high: <%=high%>, low: <%=low%>, volume: <%=ChartRows(5,i)%>, value: <%=ChartRows(6,i)%>});
<%
  Next
End If
%>
}

			var chart;

			function createStockChart() {
				chart = new AmCharts.AmStockChart();
				chart.pathToImages = "../amcharts/images/";

				// DATASETS //////////////////////////////////////////
				var dataSet = new AmCharts.DataSet();
				dataSet.color = "#013A6F";
				
				dataSet.fieldMappings = [{
					fromField: "open",
					toField: "open"
				}, {
					fromField: "close",
					toField: "close"
				}, {
					fromField: "high",
					toField: "high"
				}, {
					fromField: "low",
					toField: "low"
				}, {
					fromField: "volume",
					toField: "volume"
				}, {
					fromField: "value",
					toField: "value"
				}];				
				
				
				dataSet.dataProvider = chartData;
				dataSet.categoryField = "date";

				// set data sets to the chart
				chart.dataSets = [dataSet];

				// PANELS ///////////////////////////////////////////                                                  
				// first stock panel
				var stockPanel1 = new AmCharts.StockPanel();
				stockPanel1.showCategoryAxis = false;
				stockPanel1.title = "Price";
				stockPanel1.percentHeight = 70;

				// graph of first stock panel
				var graph1 = new AmCharts.StockGraph();
				graph1.valueField = "close";
				graph1.legendValueText = "open:[[open]] close:[[close]] low:[[low]] high:[[high]]";
				stockPanel1.addStockGraph(graph1);

				// create stock legend                
				var stockLegend1 = new AmCharts.StockLegend();
				stockLegend1.valueTextRegular = " ";
				stockLegend1.markerType = "none";
				stockPanel1.stockLegend = stockLegend1;


				// second stock panel
				var stockPanel2 = new AmCharts.StockPanel();
				stockPanel2.title = "Volume";
				stockPanel2.percentHeight = 30;
				var graph2 = new AmCharts.StockGraph();
				graph2.valueField = "volume";
				graph2.type = "column";
				graph2.fillAlphas = 1;
				stockPanel2.addStockGraph(graph2);

				// create stock legend                
				var stockLegend2 = new AmCharts.StockLegend();
				stockLegend2.valueTextRegular = " ";
				stockLegend2.markerType = "none";
				stockPanel2.stockLegend = stockLegend2;

				// set panels to the chart
				chart.panels = [stockPanel1, stockPanel2];


				// OTHER SETTINGS ////////////////////////////////////
				var scrollbarSettings = new AmCharts.ChartScrollbarSettings();
				scrollbarSettings.graph = graph1;
				scrollbarSettings.updateOnReleaseOnly = true;
				chart.chartScrollbarSettings = scrollbarSettings;

				var cursorSettings = new AmCharts.ChartCursorSettings();
				cursorSettings.valueBalloonsEnabled = true;
				chart.chartCursorSettings = cursorSettings;


				// PERIOD SELECTOR ///////////////////////////////////
				var periodSelector = new AmCharts.PeriodSelector();
				periodSelector.periods = [{
					period: "DD",
					count: 10,
					label: "10 days"
				}, {
					period: "MM",
					count: 1,
					label: "1 month"
				}, {
					period: "YYYY",
					count: 1,
					label: "1 year"
				}, {
					period: "YTD",
					label: "YTD"
				}, {
					period: "MAX",
					label: "MAX"
				}];
				chart.periodSelector = periodSelector;


				var panelsSettings = new AmCharts.PanelsSettings();
				panelsSettings.usePrefixes = true;
				chart.panelsSettings = panelsSettings;


<%
if false then
'  annPriceSensitive=1 AND
SQL = "SELECT REPLACE(CONVERT(VARCHAR(10), [annRelease], 111), '/', '-') AS dateformatted, annid, annFile, annTitle, annPriceSensitive FROM coAnn WHERE nsxcode='" & code & "' AND annRelease IS NOT NULL ORDER BY annRelease ASC"
NewsEventRows = GetRows(SQL)
NewsEventCount = 0
EventSummary = ""
If VarType(NewsEventRows) <> 0 Then NewsEventCount = UBound(NewsEventRows,2)
If NewsEventCount > 0 Then
  lastdt = ""
  For i = 0 To  NewsEventCount
    dt = NewsEventRows(0,i)
    ps = NewsEventRows(4,i)
    desc = NewsEventRows(3,i)
    bgcolor = ""
    mtype=""
    t = ""
    If ps = "1" Then 
      bgcolor = "#FF0000"
      t = "!"
      mtype = "sign"
    Else 
      bgcolor = "#0000FF"
      t = "A"
      mtype = "pin"
    End If
    
    desc = Replace(desc, vbCr, "")
    desc = Replace(desc, vbLf, "")
    
    If lastdt <> dt Then
%>
var e<%=i%> = {
					date: new Date('<%=dt%>'),
					type: "<%=mtype%>",
					backgroundColor: "<%=bgcolor%>",
					graph: graph1,
					text: "<%=t%>",
					description: "<%=desc%>"
				};
<%
      EventSummary = EventSummary & "e" & i & ","
    End If
    lastdt = dt
  Next
End If
If Len(EventSummary) > 0 Then
  EventSummary = Left(EventSummary,Len(EventSummary)-1) 
%>
dataSet.stockEvents = [<%=EventSummary%>];
<%
End If
End If ' False'
%>
				chart.write('chartdiv');
			}

