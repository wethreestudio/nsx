<% if session("USR") then%>

<div align="center">&nbsp;
<table border="0" cellpadding="2" style="border-left-width: 1px; border-right-width: 1px; border-top-width: 1px; border-bottom: 1px solid #666666" id="table1" width="165" height="323" cellspacing="0">
		<!-- MSTableType="layout" -->
		<tr>
			<td class="plaintext" height="49">

			<table cellpadding="0" cellspacing="0" border="0" width="100%" >
				<!-- MSCellFormattingTableID="2" -->
				<tr>
					<td width="10">
					<img alt="" src="images/border_images/MsoPnl_Cnr_tl_2D.gif" width="10" height="19" alt=""></td>
					<td class=plaintext bgcolor="#808080" nowrap width="100%">
					<!-- MSCellFormattingType="header" -->
					<font color="#FFFFFF"><b>User</b></font><b><font color="#FFFFFF"> Menu</font></b></td>
					<td height="19" width="10">
					<img alt="" src="images/border_images/MsoPnl_Cnr_tr_2F.gif" width="10" height="19" alt=""></td>
				</tr>
				<tr>
					<td class=plaintext valign="middle" colspan="3" >
					<!-- MSCellFormattingType="content" -->
					<b>
			<font face="Arial, helvetica, sans-serif" size="2">
			<img name="home" border="0" src="images/v2/Dpoint1.jpg" width="20" height="10" alt="">
			</font></b>
					<a href="user_default.asp" onmouseover="spec('home','imgtdon')" onmouseout="spec('home','imgtdoff')">
					<span style="text-decoration: none">User
Home</span></a><b> </b></td>
				</tr>
			</table>
			</td>
		</tr>
		<tr>
			<td class="plaintext" height="27"><b>
			<font face="Arial, helvetica, sans-serif" size="2">
			<img name="terms" border="0" src="images/v2/Dpoint1.jpg" width="20" height="10" alt="">
			</font></b>
			<a href="user_edit_your_details.asp" onmouseover="spec('terms','imgtdon')" onmouseout="spec('terms','imgtdoff')">
			<span style="text-decoration: none">Edit Your
Details</span></a></td>
		</tr>
		<tr>
			<td class="plaintext" height="27"><b>
			<font face="Arial, helvetica, sans-serif" size="2">
			<img name="terms6" border="0" src="images/v2/Dpoint1.jpg" width="20" height="10" alt="">
			</font></b>
			<a href="user_portfolio_view.asp" style="text-decoration: none">
			Portfolio Watch</a></td>
		</tr>
		<tr>
			<td class="plaintext" height="27">
			<font face="Arial, helvetica, sans-serif" size="2">
			<b>
			<img name="terms7" border="0" src="images/v2/Dpoint1.jpg" width="20" height="10" alt="">
			</b>
			</font>
			<a href="user_market_summaries.asp" style="text-decoration: none">
			Market Summaries</a></td>
		</tr>
		<tr>
			<td class="plaintext" height="27">
			<font face="Arial, helvetica, sans-serif" size="2">
			<b>
			<img name="terms2" border="0" src="images/v2/Dpoint1.jpg" width="20" height="10" alt="">
			</b>
			</font><a href="company_research_public.asp" style="text-decoration: none">
			Company Details</a></td>
		</tr>
		<tr>
			<td class="plaintext" height="27">
			<font face="Arial, helvetica, sans-serif" size="2">
			<b>
			<img name="terms9" border="0" src="images/v2/Dpoint1.jpg" width="20" height="10" alt="">
			</b>
			</font><a href="prices_alpha.asp" style="text-decoration: none" onmouseover="spec('terms9','imgtdon')" onmouseout="spec('terms9','imgtdoff')">
			Prices</a></td>
		</tr>
		<tr>
			<td class="plaintext" height="27">
			<font face="Arial, helvetica, sans-serif" size="2">
			<b>
			<img name="terms8" border="0" src="images/v2/Dpoint1.jpg" width="20" height="10" alt="">
			</b>
			</font><a href="announcements_list.asp" style="text-decoration: none" onmouseover="spec('terms8','imgtdon')" onmouseout="spec('terms8','imgtdoff')">
			News</a></td>
		</tr>
		<tr>
			<td class="plaintext" style="border-left-width: 1px; border-right-width: 1px; border-top-width: 1px; border-bottom: 1px solid #666666" height="29">
			<font face="Arial, helvetica, sans-serif" size="2">
			<b>
			<img name="terms3" border="0" src="images/v2/Dpoint1.jpg" width="20" height="10" alt="">
			</b>
			</font><a href="broker_list.asp" style="text-decoration: none">Find&nbsp; 
			a broker</a></td>
		</tr>
		<tr>
			<td class="plaintext" height="28" width="161"><b>
			<font face="Arial, helvetica, sans-serif" size="2">
			<img name="terms4" border="0" src="images/v2/Dpoint1.jpg" width="20" height="10" alt="">
			</font></b>
			<a href="member_end.asp" onmouseover="spec('terms4','imgtdon')" onmouseout="spec('terms4','imgtdoff')">
			<span style="text-decoration: none">Logout</span></a></td>
		</tr>
	</table>
</div>
<% else
server.execute "company_lmenu.asp"
end if
%>