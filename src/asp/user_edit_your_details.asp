<%@ LANGUAGE="VBSCRIPT" %>
<!--#INCLUDE FILE="include_all.asp"-->
<% CHECKFOR = "USR" %>
<!--#INCLUDE FILE="member_check.asp"-->
<%
page_title = "myNSX - Edit User Details"
alow_robots = "no"
%>

<!--#INCLUDE FILE="header.asp"-->

<div style="background-color:#fff; padding-bottom:20px;">
<%
Server.Execute "user_side_menu.asp"
%>


<div style="margin-left:260px; margin-right:12px;" >
<div class="prop min600px"></div>
<div style="float:left;width:750px;">

  <div class="editarea">
    <h1>Change Your Details</h1>
    
    <p><b>Warning:</b> You are editing a live document.&nbsp; Any changes you submit will be over	written within the database and may adversely affect the way you access	protected pages.&nbsp; After submitting changes please be patient while the database updates.&nbsp; Password changes ONLY take effect when you log in again.</p>
    
<% 
Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdEditUser = Server.CreateObject("ADODB.Recordset")
ConnPasswords.Open Application("nsx_ReaderConnectionString") 
SQL = "SELECT * FROM uSubscribers WHERE (username ='" & session("username") & "')"
CmdEditUser.Open SQL, ConnPasswords
%>

 
<form method="POST" action="user_save_your_details.asp" cellpadding="3">
	<div class="table-responsive"><table width="100%">
    <tr>
      <td><b>Name:</b></td>
      <td>
        <input type="text" name="salutation" size="5" value="<%=CmdEditUser("salutation")%>">&nbsp;
        <input type="text" name="fname" size="15" value="<%=CmdEditUser("fname")%>">&nbsp;
        <input type="text" name="lname" size="15" value="<%=CmdEditUser("lname")%>">
      </td>
    </tr>
     <tr>
      <td><b>Address:</b></td>
      <td>
        <textarea rows="3" name="address" cols="30"><%=CmdEditUser("address")%></textarea>
      </td>
    </tr>
    <tr>
      <td><b>Suburb:</b></td>
      <td>
        <input type="text" name="suburb" size="30" value="<%=CmdEditUser("suburb")%>">
      </td>
    </tr>
    <tr>
      <td><b>City:</b></td>
      <td>
        <input type="text" name="city" size="30" value="<%=CmdEditUser("city")%>">
      </td>
    </tr>
    <tr>
      <td><b>State:</b></td>
      <td>
        <input type="text" name="state" size="30" value="<%=CmdEditUser("state")%>">
      </td>
    </tr>
    <tr>
      <td><b>Country:</b></td>
      <td>
        <input type="text" name="country" size="30" value="<%=CmdEditUser("country")%>">
      </td>
    </tr>
    <tr>
      <td><b>ZIP/Postcode:</b></td>
      <td>
        <input type="text" name="zip" size="30" value="<%=CmdEditUser("zip")%>">
      </td>
    </tr>
    <tr>
      <td><b>Phone:</b></td>
      <td>
        <input type="text" name="phone" size="30" value="<%=CmdEditUser("phone")%>">
      </td>
    </tr>
    <tr>
      <td><b>Fax:</b></td>
      <td>
        <input type="text" name="fax" size="30" value="<%=CmdEditUser("fax")%>">
      </td>
    </tr>
    <tr>
      <td><b>Email:</b></td>
      <td>
        <input type="text" name="email" size="30" value="<%=CmdEditUser("email")%>">
      </td>
    </tr>
    <tr>
      <td><b>Mobile:</b></td>
      <td>
        <input type="text" name="mobile" size="30" value="<%=CmdEditUser("mobile")%>">
      </td>
    </tr>
    <tr>
      <td><b>Username:</b></td>
      <td><%=CmdEditUser("USERNAME")%></td>
    </tr>
    <tr>
      <td><b>Password:</b></td>
      <td>
        <input type="text" name="PASSWORD" size="30" value="<%=CmdEditUser("PASSWORD")%>">
      </td>
    </tr>
    <tr>
      <td clospan="2">
        <input type="submit" value="Save User Info">
      </td>
    </tr>
  </table></div>
</form>

<%
CmdEditUser.Close
Set CmdEditUser = Nothing
ConnPasswords.Close
Set ConnPasswords = Nothing
%>

</div>
</div>

<div style="clear:both;"></div>
</div>
<div style="height:20px;background-color:#fff;clear:both;margin-bottom:8px;"></div>


<!--#INCLUDE FILE="footer.asp"-->

