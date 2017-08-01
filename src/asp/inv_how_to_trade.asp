<!--#INCLUDE FILE="include_all.asp"-->
<%
page_title = "Investors - How to trade"
' meta_description = ""
' alow_robots = "no"
' objJsIncludes.Add "marketdata", "js/marketdata.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"
%>
<!--#INCLUDE FILE="header.asp"-->
 
<div class="container_cont">   
  <table border="0" cellpadding="0" style="border-collapse: collapse" width="100%" id="table1"  bgcolor="#FFFFFF">   
    <tr>   
      <td class="plaintext" colspan="2" bgcolor="#FFFFFF">   
        <h1>How to trade</h1></td>   
      <td class="plaintext" align="right">   
        <p align="center">&nbsp;</td>   
    </tr>   
    <tr>   
      <td class="plaintext" valign="top"> 
        <!--#INCLUDE FILE="lmenu.asp"--></td>   
      <td class="plaintext" valign="top">   
  
          <p>For investors, trading on the NSX is a matter of contacting a registered broker.&nbsp; In some cases your existing broker may accept orders and pass these onto registered brokers.&nbsp; Once trades have been executed, then settlement is on a T+3 or trade today and settle in three business days hence.  
          </p>   
          <p>All trading on NSX is done by electronic means using NETS software in   
            <a href="broker_list.asp">broker participant offices</a>.  
          </p>   
          <p>Orders can be placed with brokers during normal offices hours, but that execution of trades takes place between 10.00am and 4.15pm Monday to Friday.&nbsp; National public holidays are non-business days.&nbsp; Settlement days follow the ASX Settlement CHESS Calendar.  
          </p> <h2>ASX Settlement CHESS Reports</h2>   
          <p>As all companies are registered with ASX Settlement CHESS, then investors receive holding statement reports whenever they trade in shares.  
          </p>   
          <p>More information on ASX Settlement CHESS see the   
            <a href="documents/chess/ASX%20CHESS%20Booklet.pdf">CHESS Brochure</a> 
          </p> <h2>Trading and Settlement Calendars</h2>   
          <% 
          jj = 0 
          enddate = year(date) 
          for jj = enddate to 2002 step -1 %>   
            <a href="documents/practice_notes/PN02-TradingDays<%=jj%>.pdf">  
              <%=jj%></a>&nbsp;   
            <% NEXT ' trading calendars%>   
   
        <p>&nbsp;</td>   
    </tr>   
  </table>
</div>
<!--#INCLUDE FILE="footer.asp"-->