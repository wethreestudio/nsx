<%@ LANGUAGE="VBSCRIPT" %>
<% ID = Request("ID") %>
<% CHECKFOR = "CSX" %>
<!--#INCLUDE FILE="include_all.asp"-->
<!--#INCLUDE FILE="admin/merchtools.asp"-->
<!--#INCLUDE FILE="admin/tools.asp"-->
<!--#INCLUDE FILE="member_check.asp"-->
<%
MerchID = Session("MerchID")
if len(MerchID)=0 then
	MerchID = request("MerchID")
end if
if len(MerchID)=0 then 
	Session("errmsg")="Logon Expired. Please logon on."
	response.redirect "default.asp"
end if

nsxcode = Session("nsxcode") 
' edit organisation details
errmsg=Session("errmsg")
if len(errmsg)>0 then
	LHScolor="red"
	else
	LHScolor="black"
end if

Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
ConnPasswords.Open Application("nsx_ReaderConnectionString")   
SQL = "SELECT * FROM coDetails WHERE (nsxcode='" & SafeSqlParameter(nsxcode) & "')"

CmdDD.Open SQL, ConnPasswords
%>


<!--#INCLUDE FILE="header.asp"-->
<div style="background-color:#fff; padding-bottom:20px;">
<%
Server.Execute "company_side_menu.asp"
%>


<div style="margin-left:260px; margin-right:12px;" >
<div class="prop min600px"></div>
<div style="float:left;width:750px;">
	
	<div class="editarea">
	
	
<h1>Change Company Details</h1>	
  <p>
    <b>Warning:</b> You are editing a live document. Any changes you submit will be over written within the database and may adversely affect the way you access protected pages. After submitting changes please be patient while the database updates.
  </p>
    
    	

<form method="POST" action="company_save_co_details.asp?ID=<%=nsxcode%>">
<div class="table-responsive"><table width=500 border="0" cellspacing="1" cellpadding="0" bgcolor="#FFFFFF" style="border: 1 solid #000000">

<tr>
<td align="left" colspan="2" class="textheader" width="625" bgcolor="#666666">
<font color="#FFFFFF">Company Details
</font>
</td>
</tr>

<tr>
<td align="left" width="225" class="textlabel" valign="middle" bgcolor="#EEEEEE">
<b><font size="2" face="Arial" color=<%=LHScolor%>>Company Name:</font></b>
</td>
<td width="400" class="plaintext" bgcolor="#EEEEEE"><%=CmdDD("coName")%>
</td>
</tr>
<tr>
<td align="left" width="225" class="textlabel" valign="top" bgcolor="#EEEEEE">
<b>
<font size="2" face="Arial" color=<%=LHScolor%>>Company Websites:
</font></b>
</td>
<td width="400" class="textbox" bgcolor="#EEEEEE">
<input type="text" name="agweb0" size="35" value="<%=CmdDD("agWeb0")%>" class="textbox">
<br>
<input type="text" name="agweb1" size="35" value="<%=CmdDD("agWeb1")%>" class="textbox">
<br>
<input type="text" name="agweb2" size="35" value="<%=CmdDD("agWeb2")%>" class="textbox">
<br>
<input type="text" name="agweb3" size="35" value="<%=CmdDD("agWeb3")%>" class="textbox">
<br>
<input type="text" name="agweb4" size="35" value="<%=CmdDD("agWeb4")%>" class="textbox">
<br>
<input type="text" name="agweb5" size="35" value="<%=CmdDD("agWeb5")%>" class="textbox">
<br>
<input type="text" name="agweb6" size="35" value="<%=CmdDD("agWeb6")%>" class="textbox">
<br>
<input type="text" name="agweb7" size="35" value="<%=CmdDD("agWeb7")%>" class="textbox">
<br>
<input type="text" name="agweb8" size="35" value="<%=CmdDD("agWeb8")%>" class="textbox">
<br>
<input type="text" name="agweb9" size="35" value="<%=CmdDD("agWeb9")%>" class="textbox">
</td>
</tr>
<tr>
<td align="left" width="225" class="textlabel" valign="top" bgcolor="#EEEEEE">
<b><font size="2" face="Arial" color=<%=LHScolor%>>Company Emails:</font></b>
</td>
<td width="400" class="textbox" bgcolor="#EEEEEE">
<input type="text" name="agemail0" size="35" value="<%=CmdDD("agEmail0")%>" class="textbox">
<br>
<input type="text" name="agemail1" size="35" value="<%=CmdDD("agEmail1")%>" class="textbox">
<br>
<input type="text" name="agemail2" size="35" value="<%=CmdDD("agEmail2")%>" class="textbox">
<br>
<input type="text" name="agemail3" size="35" value="<%=CmdDD("agEmail3")%>" class="textbox">
<br>
<input type="text" name="agemail4" size="35" value="<%=CmdDD("agEmail4")%>" class="textbox">
<br>
<input type="text" name="agemail5" size="35" value="<%=CmdDD("agEmail5")%>" class="textbox">
<br>
<input type="text" name="agemail6" size="35" value="<%=CmdDD("agEmail6")%>" class="textbox">&nbsp;
</td>
</tr>
<tr>
<td align="left" valign="middle" width="225" class="textlabel" bgcolor="#EEEEEE">
<font size="2" face="Arial" color=<%=LHScolor%>>Nature of Business:</font>
</td>
<td width="400" class="textbox" bgcolor="#EEEEEE">
<input type="text" name="agnature" size="35" value="<%=CmdDD("agNature")%>" class="textbox">
</td>
</tr>
<tr>
<td align="left" valign="middle" width="225" class="textlabel" bgcolor="#EEEEEE">
<b><font size="2" face="Arial" color=<%=LHScolor%>>Strap line:</font></b>
</td>
<td width="400" class="textbox" bgcolor="#EEEEEE">
<input type="text" name="agstrapline" size="35" value="<%=CmdDD("agStrapline")%>" class="textbox">
</td>
</tr>
<tr>
<td align="left" valign="middle" width="225" class="textlabel" bgcolor="#EEEEEE">
<b><font size="2" face="Arial" color=<%=LHScolor%>>Reg Office Phone:</font></b>
</td>
<td width="400" class="textbox" bgcolor="#EEEEEE">
<input type="text" name="agphone" size="35" value="<%=CmdDD("agPhone")%>" class="textbox">
</td>
</tr>
<tr>
<td align="left" valign="middle" width="225" class="textlabel" bgcolor="#EEEEEE">
<b><font size="2" face="Arial" color=<%=LHScolor%>>Reg Office Fax:</font></b>
</td>
<td width="400" class="textbox" bgcolor="#EEEEEE">
<input type="text" name="agfax" size="35" value="<%=CmdDD("agFax")%>" class="textbox">
</td>
</tr>
<tr>
<td align="left" valign="middle" width="625" class="textlabel" bgcolor="#EEEEEE" colspan="2">
Street Address</td>
</tr>
<tr>
<td align="left" valign="middle" width="225" class="textlabel" bgcolor="#EEEEEE">
<b><font size="2" face="Arial" color="<%=LHScolor%>">Building Name:</font></b>
</td>
<td width="400" class="textbox" bgcolor="#EEEEEE">
<input type="text" name="agbuild" size="20" value="<%=CmdDD("agBuild")%>" class="textbox">
</td>
</tr>
<tr>
<td align="left" valign="middle" width="225" class="textlabel" bgcolor="#EEEEEE"><b>
<font size="2" face="Arial" color=<%=LHScolor%>>Floor/Unit/Level:</font></b>
</td>
<td width="400" class="textbox" bgcolor="#EEEEEE">
<input type="text" name="aglevel" size="20" value="<%=CmdDD("agLevel")%>" class="textbox">
</td>
</tr>
<tr>
<td align="left" valign="middle" width="225" class="textlabel" bgcolor="#EEEEEE">
<b>
<font size="2" face="Arial" color=<%=LHScolor%>>Street Address:</font></b>
</td>
<td width="400" class="textbox" bgcolor="#EEEEEE">
<input type="text" name="agaddress" size="20" value="<%=CmdDD("agAddress")%>" class="textbox">
</td>
</tr>
<tr>
<td align="left" valign="middle" width="225" class="textlabel" bgcolor="#EEEEEE">
<font size="2" face="Arial" color=<%=LHScolor%>>Suburb:</font>
</td>
<td width="400" class="textbox" bgcolor="#EEEEEE">
<input type="text" name="agsuburb" size="20" value="<%=CmdDD("agSuburb")%>" class="textbox">
</td>
</tr>
<tr>
<td align="left" valign="middle" width="225" class="textlabel" bgcolor="#EEEEEE">
<b>
<font size="2" face="Arial" color=<%=LHScolor%>>Post Code/ZIP:</font></b>
</td>
<td width="400" class="textbox" bgcolor="#EEEEEE">
<input type="text" name="agpcode" size="20" value="<%=CmdDD("agPCode")%>" class="textbox">
</td>
</tr>
<tr>
<td align="left" valign="middle" width="625" class="textlabel" bgcolor="#EEEEEE" colspan="2">
Postal Address</td>
</tr>
<tr>
<td align="left" valign="middle" width="225" class="textlabel" bgcolor="#EEEEEE">
<b>
<font size="2" face="Arial" color=<%=LHScolor%>>PO Box:</font></b>
</td>
<td width="400" class="textbox" bgcolor="#EEEEEE">
<input type="text" name="agpobox" size="20" value="<%=CmdDD("agPOBOX")%>" class="textbox">
</td>
</tr>
<tr>
<td align="left" valign="middle" width="225" class="textlabel" bgcolor="#EEEEEE">
<b><font size="2" face="Arial" color=<%=LHScolor%>>PO Suburb:</font></b>
</td>
<td width="400" class="textbox" bgcolor="#EEEEEE">
<input type="text" name="agposuburb" size="20" value="<%=CmdDD("agPOSuburb")%>" class="textbox">
</td>
</tr>
<tr>
<td align="left" valign="middle" width="225" class="textlabel" bgcolor="#EEEEEE">
<b><font size="2" face="Arial" color=<%=LHScolor%>>PO BOX Post Code:</font></b>
</td>
<td width="400" class="textbox" bgcolor="#EEEEEE">
<input type="text" name="agpopcode" size="20" value="<%=CmdDD("agPOPCODE")%>" class="textbox">
</td>
</tr>
<tr>
<td align="left" valign="middle" width="225" class="textlabel" bgcolor="#EEEEEE">
<b>
<font size="2" face="Arial" color=<%=LHScolor%>>City:</font></b>
</td>
<td width="400" class="textbox" bgcolor="#EEEEEE">
<%=SelectCities(CmdDD("agCity"),"agCity")%>
</td>
</tr>
<tr>
<td align="left" valign="middle" width="225" class="textlabel" bgcolor="#EEEEEE">
<b>
<font size="2" face="Arial" color=<%=LHScolor%>>State/Province:</font>
</b>
</td>
<td width="400" class="textbox" bgcolor="#EEEEEE">
<%=SelectStates(CmdDD("agState"),"agState")%>
</td>
</tr>
<tr>
<td align="left" valign="middle" width="225" class="textlabel" bgcolor="#EEEEEE">
<b><font size="2" face="Arial" color=<%=LHScolor%>>Country:</font></b>
</td>
<td width="400" class="textbox" bgcolor="#EEEEEE">
<%=SelectCtry3(CmdDD("agCountry"),"agCountry")%>
</td>
<tr>
<td align="right" valign="top" colspan="2" bgcolor="#EEEEEE">
<p align="right">
<br>
&nbsp;</td>
</tr>
</table></div>

<!--
<div class="table-responsive"><table width=500 border="0" cellspacing="1" bgcolor="#FFFFFF" style="border: 1 solid #000000">
<tr>
<td bgcolor="#808080" colspan="2" class="textheader" width="625">



<font color="#FFFFFF">Officer Details
</font>
</td>
</tr>

<tr>
<td bgcolor="#EEEEEE" align="left" width="225" class="textlabel" valign="middle">
<b><font size="2" face="Arial" color="<%=LHScolor%>">Chairman:</font></b>
</td>
<td bgcolor="#EEEEEE" width="400" class="plaintext">
<input type="text" name="agChairman" size="35" value="<%=CmdDD("agChairman")%>" class="textbox">
Name<br>
<input type="text" name="agemail7" size="35" value="<%=CmdDD("agEmail7")%>" class="textbox">
Email</td>
</tr>
<tr>
<td bgcolor="#EEEEEE" align="left" width="225" class="textlabel" valign="top">
<font size="2" face="Arial" color=<%=LHScolor%>>MD/CEO:</font>
</td>
<td bgcolor="#EEEEEE" width="400" class="plaintext">
<input type="text" name="agMD" size="35" value="<%=CmdDD("agMD")%>" class="textbox">
Name<br>
<input type="text" name="agemail8" size="35" value="<%=CmdDD("agEmail8")%>" class="textbox">
Email</td>
</tr>
<tr>
<td bgcolor="#EEEEEE" align="left" width="225" class="textlabel" valign="top">
<font size="2" face="Arial" color=<%=LHScolor%>>Secretary:</font>
</td>
<td bgcolor="#EEEEEE" width="400" class="plaintext">
<input type="text" name="agSecretary" size="35" value="<%=CmdDD("agSecretary")%>" class="textbox">
Name<br>
<input type="text" name="agemail9" size="35" value="<%=CmdDD("agEmail9")%>" class="textbox">
Email</td>
</tr>
<tr>
<td bgcolor="#EEEEEE" align="left" width="225" class="textlabel" valign="top">
<font size="2" face="Arial" color=<%=LHScolor%>>Directors:</font>
<br>
<span style="font-weight: 400">(new line for each director)</span></td>
<td bgcolor="#EEEEEE" width="400" class="textbox">
<textarea rows="10" name="agDirectors" cols="35"><%=CmdDD("agDirectors")%></textarea>
</td>
</tr>
</table></div>
-->


<div class="table-responsive"><table width=500 border="0" cellspacing="1" bgcolor="#FFFFFF" style="border: 1 solid #000000">
<tr>
<td bgcolor="#808080" colspan="2" class="textheader" width="625">
<font color="#FFFFFF">Corporate Details</font>
</td>
</tr>

<!-- tr>
<td bgcolor="#EEEEEE" align="left" width="225" class="textlabel" valign="middle">
<b><font size="2" face="Arial" color="<%=LHScolor%>">ACN:</font></b>
</td>
<td bgcolor="#EEEEEE" width="400" class="textbox">
<input type="text" name="agACN" size="35" value="<%=CmdDD("agACN")%>" class="textbox">
</td>
</tr>
<tr>
<td bgcolor="#EEEEEE" align="left" width="225" class="textlabel" valign="top">
<font size="2" face="Arial" color=<%=LHScolor%>>ABN:</font>
</td>
<td bgcolor="#EEEEEE" width="400" class="textbox">
<input type="text" name="agABN" size="35" value="<%=CmdDD("agABN")%>" class="textbox">
</td>
</tr>


<tr>
<td bgcolor="#EEEEEE" align="left" width="225" class="textlabel" valign="top">
<font size="2" face="Arial" color=<%=LHScolor%>>Principal Activities:</font>
</td>
<td bgcolor="#EEEEEE" width="400" class="textbox">
<textarea rows="6" name="agPactivities" cols="35"><%=CmdDD("agPactivities")%></textarea>
</td>
</tr>
<tr>
<td bgcolor="#EEEEEE" align="left" width="225" class="textlabel" valign="top">
<font size="2" face="Arial" color=<%=LHScolor%>>Share Registry:</font>
</td>
<td bgcolor="#EEEEEE" width="400" class="textbox">
<textarea rows="6" name="agregistry" cols="35"><%=CmdDD("agregistry")%></textarea>
</td>
</tr -->
<tr>
<td bgcolor="#EEEEEE" align="left" width="225" class="textlabel" valign="top">
<font size="2" face="Arial" color=<%=LHScolor%>>Banker:</font>
</td>
<td bgcolor="#EEEEEE" width="400" class="textbox">
<textarea rows="6" name="agbankers" cols="35"><%=CmdDD("agBankers")%></textarea>
</td>
</tr>
<tr>
<!-- td bgcolor="#EEEEEE" align="left" width="225" class="textlabel" valign="top">
<font size="2" face="Arial" color=<%=LHScolor%>>Sponsoring Broker:</font>
</td>
<td bgcolor="#EEEEEE" width="400" class="textbox">
<textarea rows="6" name="agbrokers" cols="35"><%=CmdDD("agbrokers")%></textarea>
</td -->
</tr>
<tr>
<td bgcolor="#EEEEEE" align="left" width="225" class="textlabel" valign="top">
<font size="2" face="Arial" color=<%=LHScolor%>>Nominated Adviser:</font>
</td>
<td bgcolor="#EEEEEE" width="400" class="textbox">
<textarea rows="6" name="agadvisers" cols="35"><%=CmdDD("agadvisers")%></textarea>
</td>
</tr>
<tr>
<!--td bgcolor="#EEEEEE" align="left" width="225" class="textlabel" valign="top">
<font size="2" face="Arial" color=<%=LHScolor%>>Facilitator:</font></td>
<td bgcolor="#EEEEEE" width="400" class="textbox">
<textarea rows="6" name="agfacilitators" cols="35"><%=CmdDD("agfacilitators")%></textarea></td>
</tr-->
<tr>
<td bgcolor="#EEEEEE" align="left" width="225" class="textlabel" valign="top">
<font size="2" face="Arial" color=<%=LHScolor%>>Solicitor:</font>
</td>
<td bgcolor="#EEEEEE" width="400" class="textbox">
<textarea rows="6" name="agSolicitors" cols="35"><%=CmdDD("agSolicitors")%></textarea>
</td>
</tr>
<tr>
<td bgcolor="#EEEEEE" align="left" width="225" class="textlabel" valign="top">
<font size="2" face="Arial" color=<%=LHScolor%>>Auditor:</font>
</td>
<td bgcolor="#EEEEEE" width="400" class="textbox">
<textarea rows="6" name="agaccountants" cols="35"><%=CmdDD("agaccountants")%></textarea>
</td>
</tr>
<tr>
<td bgcolor="#EEEEEE" align="left" width="225" class="textlabel" valign="top">
<font size="2" face="Arial" color=<%=LHScolor%>>Trustee, Responsible Entity:</font>
</td>
<td bgcolor="#EEEEEE" width="400" class="textbox">
<textarea rows="6" name="agtrustee" cols="35"><%=CmdDD("agtrustee")%></textarea>
</td>
</tr>
</table></div>
<div class="table-responsive"><table width=500 border="0" cellspacing="1" bgcolor="#FFFFFF" style="border: 1 solid #000000">
<tr>
<td bgcolor="#808080" class="textheader" width="625">
<font color="#FFFFFF">Profile Details
</font>
</td>
</tr>
<tr>
<td bgcolor="#EEEEEE" align="left" valign="middle" width="625" class="textlabel">
<font size="2" face="Arial" color=<%=LHScolor%>>Company Profile Text</font><br>
<textarea rows="20" name="agwho" cols="55"><%=CmdDD("agwho")%></textarea>
</td>
</tr>
<tr>
<td bgcolor="#EEEEEE" align="left" valign="middle" width="625" class="textlabel">
<input type="submit" value="Save details" name="B1" style="background-color: #FFFFFF; color: #808080; font-family: Verdana; font-size: 10pt; font-weight: bold"></td>
</tr>
</table></div>
</form>

<%
ConnPasswords.Close
Set ConnPasswords = Nothing
%>




</div>
</div>
</div>

<div style="clear:both;"></div>
</div>
<div style="height:20px;background-color:#fff;clear:both;margin-bottom:8px;"></div>
<!--#INCLUDE FILE="footer.asp"-->