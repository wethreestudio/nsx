<%
nsxcode = request.querystring("nsxcode")
Set regEx = New RegExp 
regEx.Pattern = "^[a-zA-Z0-9]+$" 
isCodeValid = regEx.Test(nsxcode) 
If Not isCodeValid Then
  Response.Redirect "/"
  Response.End
End If

%><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>amCharts Example</title>
    </head>
    
    <body style="background-color:#FFFFFF">
        <!-- saved from url=(0013)about:internet -->
        <!-- amcharts script-->
        <!-- swf object (version 2.2) is used to detect if flash is installed and include swf in the page -->
        <script type="text/javascript" src="amcharts/swfobject.js"></script>
        
        <!-- chart is placed in this div. if you have more than one chart on a page, give unique id for each div -->
        <div id="chartdiv"></div>
        
        <script type="text/javascript">
        
            var params = 
            {
                bgcolor:"#FFFFFF"
            };
            
            var flashVars = 
            {
                settings_file: "security_summary_settings.asp?nsxcode=<%=nsxcode%>",
            };
            
            swfobject.embedSWF("amcharts/amstock.swf", "chartdiv", "100%", "600", "8.0.0", "amcharts/expressInstall.swf", flashVars, params);
            
        </script>
        
        <!-- end of amcharts script -->
        
        <!-- other parameters which can be passed with flashVars:
        
            chart_settings - settings in xml format;
            additional_chart_settings - settings in xml format which will be appended to chart_settings or settings loaded from a file;
            loading_settings - string displayed while loading settings;
            loading_data - string displayed while loading data;
            preloader_color - hex color (#CC0000 for example) of a preloader bar;
            error_loading_file - string displayed if indicated file was not found.
        
         -->
    
    </body>
</html>

