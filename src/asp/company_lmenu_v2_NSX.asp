<div align="center">&nbsp;
<div class="table-responsive"><table border="0" style="border-left-width: 1px; border-right-width: 1px; border-top-width: 1px; border-bottom: 1px solid #666666" id="table1" width="165" cellspacing="0">
		<!-- MSTableType="layout" -->
		<tr>
			<td class="plaintext" height="49">
			<div class="table-responsive"><table cellpadding="0" cellspacing="0" border="0" width="100%" >
				<!-- MSCellFormattingTableID="2" -->
				<tr>
					<td width="10">
					<img alt="" src="images/border_images/MsoPnl_Cnr_tl_2D.gif" width="10" height="19"></td>
					<td class=plaintext bgcolor="#808080" nowrap width="100%">
					<!-- MSCellFormattingType="header" -->
					<b><font color="#FFFFFF">Company Menu</font></b></td>
					<td height="19" width="10">
					<img alt="" src="images/border_images/MsoPnl_Cnr_tr_2F.gif" width="10" height="19"></td>
				</tr>
				<tr>
					<td class=plaintext valign="middle" colspan="3" >
					<!-- MSCellFormattingType="content" -->
					<b>
			<font face="Arial, helvetica, sans-serif" size="2">
			<img name="home" border="0" src="images/v2/Dpoint1.jpg" width="20" height="10">
			</font></b>
			<a href="company_default.asp" onmouseover="spec('home','imgtdon')" onmouseout="spec('home','imgtdoff')">
			<span style="text-decoration: none">Company
Home</span></a><b> </b></td>
				</tr>
			</table></div>
			</td>
		</tr>
		<tr>
			<td class="plaintext" height="27">
			<img name="real" border="0" src="images/v2/Dpoint1.jpg" width="20" height="10">
<a href="company_annupnsx3.asp" onmouseover="spec('real','imgtdon')" onmouseout="spec('real','imgtdoff')"><span style="text-decoration: none">Lodge Announcement</span></a></td>
		</tr>
		<tr>
			<td class="plaintext" height="27"><b>
			<img name="del" border="0" src="images/v2/Dpoint1.jpg" width="20" height="10">
			</b>
			<a href="announcements_list.asp?group=yes&amp;nsxcode=<%
			comments=trim(session("comments") & " ")
			if len(comments)=0 then comments=trim(session("nsxcode") & " ")
			codes=replace(comments,";",",")
			response.write codes
			%>" onmouseover="spec('del','imgtdon')" onmouseout="spec('del','imgtdoff')">
			<span style="text-decoration: none">Your Announcements</span></a></td>
		</tr>
		<tr>
			<td class="plaintext" height="27"><b>
			<font face="Arial, helvetica, sans-serif" size="2">
			<img name="del0" border="0" src="images/v2/Dpoint1.jpg" width="20" height="10">
			</font></b>
			<a href="announcements_status.asp?group=yes&amp;nsxcode=<%
			comments=trim(session("comments") & " ")
			if len(comments)=0 then comments=trim(session("nsxcode") & " ")
			codes=replace(comments,";",",")
			response.write codes
			%>" onmouseover="spec('del0','imgtdon')" onmouseout="spec('del0','imgtdoff')">
			<span style="text-decoration: none">Lodgement Status</span></a></td>
		</tr>
		<tr>
			<td class="plaintext" height="27"><b>
			<font face="Arial, helvetica, sans-serif" size="2">
			<img name="del1" border="0" src="images/v2/Dpoint1.jpg" width="20" height="10">
			</font></b>
			<a href="company_trades.asp?nsxcodes=<%
			comments=trim(session("comments") & " ")
			if len(comments)=0 then comments=trim(session("nsxcode") & " ")
			codes=replace(comments,";",",")
			response.write codes
			%>" onmouseover="spec('del1','imgtdon')" onmouseout="spec('del1','imgtdoff')">
			<span style="text-decoration: none">Trades</span></a></td>
		</tr>
		<tr>
			<td class="plaintext" height="27"><b>
			<font face="Arial, helvetica, sans-serif" size="2">
			<img name="terms10" border="0" src="images/v2/Dpoint1.jpg" width="20" height="10">
			</font></b>
			<a href="user_portfolio_view.asp" style="text-decoration: none" onmouseover="spec('terms10','imgtdon')" onmouseout="spec('terms10','imgtdoff')">
			Portfolio Watch</a></td>
		</tr>
		<tr>
			<td class="plaintext" height="27">
			<font face="Arial, helvetica, sans-serif" size="2">
			<b>
			<img name="terms11" border="0" src="images/v2/Dpoint1.jpg" width="20" height="10">
			</b>
			</font>
			<a href="user_market_summaries.asp" style="text-decoration: none" onmouseover="spec('terms11','imgtdon')" onmouseout="spec('terms11','imgtdoff')">
			Market Summaries</a></td>
		</tr>
		<tr>
			<td class="plaintext" height="27"><b>
			<font face="Arial, helvetica, sans-serif" size="2">
			<img name="terms" border="0" src="images/v2/Dpoint1.jpg" width="20" height="10">
			</font></b>
			<a href="company_edit_your_details.asp" onmouseover="spec('terms','imgtdon')" onmouseout="spec('terms','imgtdoff')">
			<span style="text-decoration: none">Edit Your
Details</span></a></td>
		</tr>
		<tr>
			<td class="plaintext" height="27"><b>
			<font face="Arial, helvetica, sans-serif" size="2">
			<img name="terms6" border="0" src="images/v2/Dpoint1.jpg" width="20" height="10">
			</font></b>
			<a href="company_details.asp?nsxcode=<%=Session("nsxcode")%>" onmouseover="spec('terms6','imgtdon')" onmouseout="spec('terms6','imgtdoff')">
			<span style="text-decoration: none">Check Co Details</span></a></td>
		</tr>
		<tr>
			<td class="plaintext" height="27"><b>
			<font face="Arial, helvetica, sans-serif" size="2">
			<img name="terms7" border="0" src="images/v2/Dpoint1.jpg" width="20" height="10">
			</font></b>
			<a onmouseover="spec('terms7','imgtdon')" onmouseout="spec('terms7','imgtdoff')" href="company_edit_co_details.asp">
			<span style="text-decoration: none">Edit Co Details</span></a></td>
		</tr>
		<tr>
			<td class="plaintext" height="27"><b>
			<font face="Arial, helvetica, sans-serif" size="2">
			<img name="terms2" border="0" src="images/v2/Dpoint1.jpg" width="20" height="10">
			</font></b>
			<a href="rules_listing.asp" onmouseover="spec('terms2','imgtdon')" onmouseout="spec('terms2','imgtdoff')">
			<span style="text-decoration: none">Listing
Rules</span></a></td>
		</tr>
		<tr>
			<td class="plaintext" height="27">
			<font face="Arial, helvetica, sans-serif" size="2">
			<b>
			<img name="terms9" border="0" src="images/v2/Dpoint1.jpg" width="20" height="10">
			</b>
			</font><a href="rules_practicenotes.asp" style="text-decoration: none" onmouseover="spec('terms9','imgtdon')" onmouseout="spec('terms9','imgtdoff')">
			Practice Notes</a></td>
		</tr>
		<tr>
			<td class="plaintext" height="27">
			<font face="Arial, helvetica, sans-serif" size="2">
			<b>
			<img name="terms8" border="0" src="images/v2/Dpoint1.jpg" width="20" height="10">
			</b>
			</font><a href="company_forms.asp" style="text-decoration: none" onmouseover="spec('terms8','imgtdon')" onmouseout="spec('terms8','imgtdoff')">
			Forms</a></td>
		</tr>
		<tr>
			<td class="plaintext" style="border-left-width: 1px; border-right-width: 1px; border-top-width: 1px; border-bottom: 1px solid #666666" height="29">
			<b><font face="Arial, helvetica, sans-serif" size="2">
			<img name="terms3" border="0" src="images/v2/Dpoint1.jpg" width="20" height="10">
			</font></b>
			<a href="company_help.asp" onmouseover="spec('terms3','imgtdon')" onmouseout="spec('terms3','imgtdoff')">
			<span style="text-decoration: none">Help</span></a></td>
		</tr>
		<tr>
			<td class="plaintext" height="28" width="161"><b>
			<font face="Arial, helvetica, sans-serif" size="2">
			<img name="terms4" border="0" src="images/v2/Dpoint1.jpg" width="20" height="10">
			</font></b>
			<a href="member_end.asp" onmouseover="spec('terms4','imgtdon')" onmouseout="spec('terms4','imgtdoff')">
			<span style="text-decoration: none">Logout</span></a></td>
		</tr>
	</table></div>
	<p>&nbsp;</div>
