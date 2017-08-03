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
<div class="table-responsive"><table align=center border="0" width="797" cellspacing="0" cellpadding="0">
  <tr>
    <td width="100%" class="bodylinks" bgcolor="white" valign="top" align=right>
    <p class=plaintext align="left"><font size="1"><br>
	page displayed on: <%=cnvddmmyyyy(date) & " " & time+daylightsaving%><br>
&nbsp;</font></td>
	</tr>
  <tr>
    <td width="100%" class="bodylinks" bgcolor="#005596" valign="top" align=right>
    <font color="#FFFFFF" size="1">&nbsp; South Pacific Stock Exchange ("SPSE")  
    <%
        daylight = Application("nsx_daylight_saving")
    if daylight then
    	response.write " | <a href=# class=bodylinks title='Fiji Daylight Saving Time'>FDST</a>"
    	else
    	response.write " | <a href=# class=bodylinks title='Fiji Standard Time'>FST</a>"
    end if
    %>
    </td>
	</tr>
	  </table></div>
   

