<div align="center">&nbsp;<table border="0" style="border-left-width: 1px; border-right-width: 1px; border-top-width: 1px; border-bottom: 1px solid #666666" id="table1" width="165" cellspacing="0">
		<!-- MSTableType="layout" -->
		<tr>
			<td class="plaintext" height="49">
			<table cellpadding="0" cellspacing="0" border="0" width="100%" >
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
			<a href="company_default_v2.asp" onmouseover="spec('home','imgtdon')" onmouseout="spec('home','imgtdoff')">
			<span style="text-decoration: none">Company Home</span></a><b> </b></td>
				</tr>
			</table>
			</td>
		</tr>
		<tr>
			<td class="plaintext" height="27">
			<img name="real" border="0" src="images/v2/Dpoint1.jpg" width="20" height="10">
<a href="company_annupnsx3_v2.asp" onmouseover="spec('real','imgtdon')" onmouseout="spec('real','imgtdoff')"><span style="text-decoration: none">Lodge Announcement</span></a></td>
		</tr>
		<tr>
			<td class="plaintext" height="27"><b>
			<font face="Arial, helvetica, sans-serif" size="2">
			<img name="del0" border="0" src="images/v2/Dpoint1.jpg" width="20" height="10">
			</font></b>
			<a href="company_announcements_status_v2.asp?group=yes&nsxcode=<%
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
			<a href="company_trades_v2.asp?nsxcodes=<%
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
			<img name="terms" border="0" src="images/v2/Dpoint1.jpg" width="20" height="10">
			</font></b>
			<a href="company_edit_your_details_v2.asp" onmouseover="spec('terms','imgtdon')" onmouseout="spec('terms','imgtdoff')">
			<span style="text-decoration: none">Edit Your
Details</span></a></td>
		</tr>
		<tr>
			<td class="plaintext" height="28" width="161"><b>
			<font face="Arial, helvetica, sans-serif" size="2">
			<img name="terms4" border="0" src="images/v2/Dpoint1.jpg" width="20" height="10">
			</font></b>
			<a href="member_end_v2.asp" onmouseover="spec('terms4','imgtdon')" onmouseout="spec('terms4','imgtdoff')">
			<span style="text-decoration: none">Logout</span></a></td>
		</tr>
	</table>
	<p>&nbsp;</div>
