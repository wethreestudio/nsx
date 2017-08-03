<%
'financial report calculator

function isleapyear(xx)
yy = xx mod 4
isleapyear = false
if yy = 0 then isleapyear = true else isleapyear = false
' special case for centuries
if right(xx,2) = "00" then
	yy = xx mod 400
	if yy = 0 then isleapyear = true else isleapyear = false
end if
end function


'balance dates
yr = year(date)
if isleapyear(yr) then 
	fb = "29-Feb-" 
	else
	fb = "28-Feb-"
end if

bal_mar = "31-mar-" & yr
bal_apr = "30-apr-" & yr
bal_jun = "30-jun-" & yr
bal_jul= "31-jul-" & yr
bal_sep = "30-sep-" & yr
bal_dec = "31-dec-"& yr

half_mar = "30-sep-" & yr
half_apr = "30-apr-" & yr
half_jun = "31-dec-" & yr
half_jul = "31-jan-" & yr
half_sep = "31-mar-" & yr
half_dec = "30-jun-" & yr

halfc_mar = cdate("30-sep-" & yr -1) + 75 
halfc_apr = cdate("30-oct-" & yr -1) + 76 
halfc_jun = cdate("31-dec-" & yr -1) + 75 
halfc_jul = cdate("31-jan-" & yr) + 75 
halfc_sep = cdate("31-mar-" & yr) + 75
halfc_dec = cdate("30-jun-" & yr) + 75

pre_mar = cdate("31-mar-" & yr) + 75 
pre_apr = cdate("30-apr-" & yr) + 75 
pre_jun = cdate("30-jun-" & yr) + 75
pre_jul= cdate("31-jul-" & yr) + 75
pre_sep = cdate("30-sep-" & yr - 1) + 75
pre_dec = cdate("31-dec-"& yr - 1) + 75 

ann_mar = "30-jun-" & yr
ann_apr = "31-july-" & yr
ann_jun = "30-sep-" & yr
ann_jul= "31-oct-" & yr
ann_sep = "31-dec-" & yr
ann_dec = "31-mar-"& yr

rep_mar = "31-jul-" & yr
rep_apr = "31-aug-" & yr
rep_jun = "31-oct-" & yr
rep_jul= "30-nov-" & yr
rep_sep = "31-jan-" & yr
rep_dec = "30-apr-"& yr

agm_mar = "31-aug-" & yr
agm_apr = "30-sep-" & yr
agm_jun = "30-nov-" & yr
agm_jul= "31-dec-" & yr
agm_sep = fb & yr
agm_dec = "31-may-"& yr

function fmtddmm(xx)
xd = day(xx)
xm = monthname(month(xx),true)
xf = xd & "-" & xm

' due now or soon?
curdte = date
fmtddmm = xf
xdd = datediff("d",date,xx)
if  xdd >=0 and xdd <= 11 then fmtddmm = "<span style='background-color:red'><font color=white><b>&nbsp;&nbsp;" & xf & "&nbsp;&nbsp;</b></font</span>"
if xdd > 11 and xdd <= 31 then fmtddmm = "<span style='background-color:green'><font color=white><b>&nbsp;&nbsp;" & xf & "&nbsp;&nbsp;</b></font</span>"
end function


if month(date)=3 or month(date)=9 then
%>

  
			<h2>Time Table for Financial Report Lodgments:</h2>
			<div class="table-responsive"><table  width="100%" id="table2" cellspacing="1" cellpadding="3" >
				<tr>
					<td class="plaintext" bgcolor="#666666" align="center">
					<b><font color="#FFFFFF">Balance <br>
					Date</font></b></td>
					<td class="plaintext" bgcolor="#666666" align="center">
					<b><font color="#FFFFFF">Half Yearly<br>75 days<br>
&nbsp;(s320)</font></b></td>
					<td class="plaintext" bgcolor="#666666" align="center">
					<b><font color="#FFFFFF">Preliminary&nbsp;<br>	Reports<br>
					75 days</font></b></td>
					<td class="plaintext" bgcolor="#666666" align="center">
					<b><font color="#FFFFFF">Annual<br>Reports&nbsp;<br>3 Months<br>
					(s319)</font></b></td>
					<td class="plaintext" bgcolor="#666666" align="center">
					<b><font color="#FFFFFF">Reporting to<br>members<br>4 Months<br>
					(s315)</font></b></td>
					<td class="plaintext" bgcolor="#666666" align="center">
					<b><font color="#FFFFFF">Hold AGM<br>5 Months<br>(s250N)</font></b></td>
				</tr>
				<tr>
					<td class="plaintext" bgcolor="#FFFFFF" align="right" nowrap><b>31 Mar</b></td>
					<td class="plaintext" align="center" nowrap bgcolor="#FFFFFF"><%=fmtddmm(halfc_mar)%></td>
					<td class="plaintext" align="center" nowrap bgcolor="#FFFFFF"><%=fmtddmm(pre_mar)%></td>
					<td class="plaintext" align="center" nowrap bgcolor="#FFFFFF"><%=fmtddmm(ann_mar)%></td>
					<td class="plaintext" align="center" nowrap bgcolor="#FFFFFF"><%=fmtddmm(rep_mar)%></td>
					<td class="plaintext" align="center" nowrap bgcolor="#FFFFFF"><%=fmtddmm(agm_mar)%></td>
				</tr>
				<tr>
					<td class="plaintext" bgcolor="#EEEEEE" align="right" nowrap><b>30 Apr</b></td>
					<td class="plaintext" align="center" nowrap bgcolor="#EEEEEE"><%=fmtddmm(halfc_apr)%></td>
					<td class="plaintext" align="center" nowrap bgcolor="#EEEEEE"><%=fmtddmm(pre_apr)%></td>
					<td class="plaintext" align="center" nowrap bgcolor="#EEEEEE"><%=fmtddmm(ann_apr)%></td>
					<td class="plaintext" align="center" nowrap bgcolor="#EEEEEE"><%=fmtddmm(rep_apr)%></td>
					<td class="plaintext" align="center" nowrap bgcolor="#EEEEEE"><%=fmtddmm(agm_apr)%></td>
				</tr>
				<tr>
					<td class="plaintext" bgcolor="#FFFFFF" align="right" nowrap><b>30 Jun</b></td>
					<td class="plaintext" align="center" bgcolor="#FFFFFF" nowrap><%=fmtddmm(halfc_jun)%></td>
					<td class="plaintext" align="center" bgcolor="#FFFFFF" nowrap><%=fmtddmm(pre_jun)%></td>
					<td class="plaintext" align="center" bgcolor="#FFFFFF" nowrap><%=fmtddmm(ann_jun)%></td>
					<td class="plaintext" align="center" bgcolor="#FFFFFF" nowrap><%=fmtddmm(rep_jun)%></td>
					<td class="plaintext" align="center" bgcolor="#FFFFFF" nowrap><%=fmtddmm(agm_jun)%></td>
				</tr>
				<tr>
					<td class="plaintext" bgcolor="#EEEEEE" align="right" nowrap>
					<b>31 Jul</b></td>
					<td class="plaintext" align="center" nowrap bgcolor="#EEEEEE"><%=fmtddmm(halfc_jul)%></td>
					<td class="plaintext" align="center" nowrap bgcolor="#EEEEEE"><%=fmtddmm(pre_jul)%></td>
					<td class="plaintext" align="center" nowrap bgcolor="#EEEEEE"><%=fmtddmm(ann_jul)%></td>
					<td class="plaintext" align="center" nowrap bgcolor="#EEEEEE"><%=fmtddmm(rep_jul)%></td>
					<td class="plaintext" align="center" nowrap bgcolor="#EEEEEE"><%=fmtddmm(agm_jul)%></td>
				</tr>
				<tr>
					<td class="plaintext" bgcolor="#FFFFFF" align="right" nowrap><b>30 Sep</b></td>
					<td class="plaintext" align="center" nowrap bgcolor="#FFFFFF"><%=fmtddmm(halfc_sep)%></td>
					<td class="plaintext" align="center" nowrap bgcolor="#FFFFFF"><%=fmtddmm(pre_sep)%></td>
					<td class="plaintext" align="center" nowrap bgcolor="#FFFFFF"><%=fmtddmm(ann_sep)%></td>
					<td class="plaintext" align="center" nowrap bgcolor="#FFFFFF"><%=fmtddmm(rep_sep)%></td>
					<td class="plaintext" align="center" nowrap bgcolor="#FFFFFF"><%=fmtddmm(agm_sep)%></td>
				</tr>
				<tr>
					<td class="plaintext" align="right"  bgcolor="#EEEEEE" nowrap ><b>31 Dec</b></td>
					<td class="plaintext" align="center" bgcolor="#EEEEEE" nowrap ><%=fmtddmm(halfc_dec)%></td>
					<td class="plaintext" align="center" bgcolor="#EEEEEE" nowrap ><%=fmtddmm(pre_dec)%></td>
					<td class="plaintext" align="center" bgcolor="#EEEEEE" nowrap ><%=fmtddmm(ann_dec)%></td>
					<td class="plaintext" align="center" bgcolor="#EEEEEE" nowrap ><%=fmtddmm(rep_dec)%></td>
					<td class="plaintext" align="center" bgcolor="#EEEEEE" nowrap ><%=fmtddmm(agm_dec)%></td>
				</tr>
			</table></div>
			<div class="table-responsive"><table border="0" id="table3" cellspacing="0" cellpadding="0">
				<tr>
					<td bgcolor="#FF3333" class="plaintext" align="center">
					<font color="#FFFFFF" size="1"><b>Due Now</b></font></td>
					<td bgcolor="#008000" class="plaintext" align="center">
					<font color="#FFFFFF" size="1"><b>Due Soon</b></font></td>
					<td bgcolor="#808080" class="plaintext" align="center">
					<b>
					<font color="#FFFFFF" size="1">&nbsp;
					<%
					if isleapyear(yr) then
					response.write "note: " & yr & " is a leap year"
					end if
					%> 
					</font>
					
					</td>

				</tr>
			</table></div>
			<a href="company_calendar.asp" title="Full reporting calendar and information">Reporting information</a> 
      <% end if ' month date%>