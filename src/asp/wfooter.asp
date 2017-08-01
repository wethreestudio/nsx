<%
daylightsaving=0
if application("nsx_daylight_saving")=true then
	daylightsaving = 1/24
	else
	daylightsaving = 0
end if

Function cnvddmmyyyy(xx)
' convert dates in dd-mmm-yyyy format
dd = day(xx)
mm = monthname(month(xx),1)
yy = year(xx)
cnvddmmyyyy = dd &"-"& mm & "-" & yy
End Function
%>
<table align=center border="0" width="100%" cellspacing="0" cellpadding="0">
<tr>
    <td width="100%" class="bodylinks" bgcolor="white" valign="top" align="right">
    <p class=plaintext align="right"><font size="1"><br>
	page displayed on: <%=cnvddmmyyyy(date) & " " & time+daylightsaving%><br>
&nbsp;</font></td>
	</tr>
  <tr>
    <td width="100%" class="bodylinks" bgcolor="#005596" valign="top" align="right">
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
    if ipadd = "210.247.170.63" then 
    	response.write " | <a href=# class=bodylinks title='1:" & ipadd & "'>NSX1</a>"
    end if
    if ipadd =  "210.247.170.31" then
    	response.write " | <a href=# class=bodylinks title='2:" & ipadd & "'>NSX2</a>"
    end if
    'response.write " | <a href=# class=bodylinks title='3:" & ipadd & "'>N3</a>"
    'response.write ipadd
    %>
    </td>
  </tr>
   </table>

    
    <script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
try {
var pageTracker = _gat._getTracker("UA-9560336-1");
pageTracker._trackPageview();
} catch(err) {}</script>
    
    


