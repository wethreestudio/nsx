<div class="table-responsive"><table align=center border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr>
    <td width="100%" class="bodylinks" bgcolor="#005596" valign="top" align=right>
    <font color="#FFFFFF" size="1">&nbsp;Australian Market 
    Licencee: National Stock Exchange of Australia Limited ("NSX") | ABN 11 000 
	902 063 |</font> <a class="bodylinks" href="tc.asp">Terms &amp; Conditions</a> 
	<font color="#FFFFFF">|</font>
    <a class="bodylinks" href="privacy.asp">Privacy</a> 
    <%
        daylight = Application("nsx_daylight_saving")
    if daylight then
    	response.write " | <a href=# class=bodylinks title='Australian Eastern Daylight Saving Time'>ADST</a>"
    	else
    	response.write " | <a href=# class=bodylinks title='Australian Eastern Standard Time'>AEST</a>"
    end if
    
    ipadd=request.servervariables("local_addr")
    if ipadd = "203.210.116.180" then 
    	response.write " | <a href=# class=bodylinks title='1:" & ipadd & "'>NSX1</a>"
    end if
    if ipadd =  "203.210.116.212" then
    	response.write " | <a href=# class=bodylinks title='2:" & ipadd & "'>NSX2</a>"
    end if
    
    'response.write ipadd
    %>
    <script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
try {
var pageTracker = _gat._getTracker("UA-9560336-1");
pageTracker._trackPageview();
} catch(err) {}</script>
    
    
    
    </td>
  </tr>
  </table></div>
  <script type="text/javascript"><!--
google_ad_client = "pub-6491527947593959";
/* 468x60, created 7/2/09 */
google_ad_slot = "3450996625";
google_ad_width = 468;
google_ad_height = 60;
//-->
</script>
<script type="text/javascript"
src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
</script>
