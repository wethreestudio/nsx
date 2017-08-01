<!--#INCLUDE FILE="functions.asp"-->
<!--#INCLUDE FILE="include/db_connect.asp"--><%
	Response.CharSet = "UTF-8"
	Response.ContentType = "text/xml"
  nsxcode = request.querystring("nsxcode")
  Set regEx = New RegExp 
  regEx.Pattern = "^[a-zA-Z0-9]+$" 
  isCodeValid = regEx.Test(nsxcode) 
  If Not isCodeValid Then
    Response.Redirect "/"
    Response.End
  End If	
%><?xml version="1.0" encoding="UTF-8"?>
<!-- Only the settings with values not equal to defaults are in this file. If you want to see the
full list of available settings, check the amstock_settings.xml file in the amstock folder. -->
<settings>
  <margins>0</margins>                                                   
  <redraw>true</redraw>
  <number_format>  
    <letters>
       <letter number="1000">K</letter>
       <letter number="1000000">M</letter>
       <letter number="1000000000">B</letter>
    </letters>      
  </number_format>
  <data_sets> 
    <data_set did="0">
       <title><%=nsxcode%></title>
       <short><%=nsxcode%></short>
       <color>7f8da9</color>
       <file_name>security_summary_data.asp?nsxcode=<%=nsxcode%></file_name>
       <csv>
         <reverse>true</reverse>
         <separator>,</separator>
         <date_format>YYYY-MM-DD</date_format>
         <decimal_separator>.</decimal_separator>
         <columns>
           <column>date</column>
           <column>volume</column>
           <column>close</column>
         </columns>
       </csv>
       
       <events>
          <%
SQL = "SELECT REPLACE(CONVERT(VARCHAR(10), [annRelease], 111), '/', '-') AS dateformatted, annid, annFile, annTitle, annPriceSensitive, annFile FROM coAnn WHERE nsxcode='" & nsxcode & "' AND YEAR(annRelease) >= YEAR(GETDATE())-1 AND annRelease IS NOT NULL ORDER BY annRelease DESC"
          
onlyps = (request.querystring("ps") = "1")
If true Then          
  SQL = "SELECT REPLACE(CONVERT(VARCHAR(10), [annRelease], 111), '/', '-') AS dateformatted, annid, annFile, annTitle, annPriceSensitive, annFile FROM coAnn WHERE nsxcode='" & nsxcode & "' AND YEAR(annRelease) >= YEAR(GETDATE())-1 AND annRelease IS NOT NULL AND annPriceSensitive = 1 ORDER BY annRelease DESC"
End If
NewsEventRows = GetRows(SQL)
NewsEventCount = 0
EventSummary = ""
If VarType(NewsEventRows) <> 0 Then NewsEventCount = UBound(NewsEventRows,2)
If NewsEventCount > 0 Then
  For i = 0 To  NewsEventCount
    dt = NewsEventRows(0,i)
    ps = NewsEventRows(4,i)
    desc = NewsEventRows(3,i)
    url = "/ftp/news/" & NewsEventRows(5,i)
    bgcolor = ""
    If ps = True Then 
      bgcolor = "FFBA00"
      t = "!"
      mtype = "sign"
    Else 
      bgcolor = "7CB1CC"
      t = "A"
      mtype = "pin"
    End If
    dashpos = InStr(1, desc, "-", vbTextCompare)
    If dashpos > 0 Then
      desc = Trim(Mid(desc, dashpos+1, Len(desc)-(dashpos)))
    End If          
        %><event>
            <date><%=dt%></date>
            <letter>A</letter>
            <color><%=bgcolor%></color>
            <url><%=url%></url>
            <description><![CDATA[<%=desc%>]]></description>
          </event>
        <%
  Next
End If
          %>                 
      </events>       
    </data_set>
  </data_sets>

  <charts>
  	<chart cid="first">
  		<height>60</height>
  		<title>Value</title>
      <border_color>#CCCCCC</border_color>
      <border_alpha>100</border_alpha>
      <values>
        <x>
          <bg_color>EEEEEE</bg_color>
        </x>   
      </values>
      <legend>
        <show_date>true</show_date>
      </legend>
      <column_width>100</column_width>
      <events>
        <color>fac622</color>        
      </events>
  		<graphs>
  			<graph gid="close">
  				<data_sources>
  				  <close>close</close>
          </data_sources>
  				<bullet>round_outline</bullet>
  		    <legend>
            <date key="false" title="false"><![CDATA[{close}]]></date>
            <period key="false" title="false"><![CDATA[open:<b>{open}</b> low:<b>{low}</b> high:<b>{high}</b> close:<b>{close}</b>]]></period>
          </legend>         
  			</graph>  			
  		</graphs>
  	</chart>  
  	<chart cid="second">
  		<height>30</height>
  		<title>Volume</title>  		
      <border_color>#CCCCCC</border_color>
      <border_alpha>100</border_alpha>
      <grid>
        <y_left>
          <approx_count>3</approx_count>
        </y_left>
      </grid>	
      <values>
        <x>
          <enabled>false</enabled>
        </x>
      </values>
      <legend>
        <show_date>false</show_date>
      </legend>
      <column_width>80</column_width>
      <events>
        <color>db4c3c</color>
      </events> 
  		<graphs>
  			<graph gid="volume">
  				<type>column</type>
  				<data_sources>
  				  <close>volume</close>
          </data_sources>
          <period_value>average</period_value>
          <corner_radius>100%</corner_radius>
  				<alpha>100</alpha>
  				<fill_alpha>20</fill_alpha>
  		    <legend>
            <date key="false" title="false"><![CDATA[{close}]]></date>
            <period key="false" title="false"><![CDATA[open:<b>{open}</b> low:<b>{low}</b> high:<b>{high}</b> close:<b>{close}</b>]]></period>
          </legend>         
  			</graph>  			
  		</graphs>
  	</chart>    
  </charts>
  <date_formats>
    <events>DD month YYYY</events>
  </date_formats>
  <data_set_selector>
    <enabled>false</enabled>
  </data_set_selector>
  <period_selector>
		<periods>		
      <period type="DD" count="10">10D</period>
    	<period type="MM" count="1">1M</period>
    	<period selected="true" type="MM" count="3">3M</period>
    	<period type="YYYY" count="1">1Y</period>
    	<period type="YTD" count="0">YTD</period>
    	<period type="MAX">MAX</period>
		</periods>
		<periods_title>Zoom:</periods_title>
		<custom_period_title>Custom period:</custom_period_title> 
  </period_selector>

  <header>
    <enabled>false</enabled>
  </header>

  <scroller>
    <graph_data_source>close</graph_data_source>
    <resize_button_style>dragger</resize_button_style>
    <playback>
      <enabled>true</enabled>
      <speed>3</speed>
    </playback>
  </scroller>
</settings>
