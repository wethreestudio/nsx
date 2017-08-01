<%@ LANGUAGE="VBSCRIPT" %>
<!--#INCLUDE FILE="include_all.asp"-->
<% CHECKFOR = "CSX" %>
<!--#INCLUDE FILE="member_check.asp"-->
<%


page_title = "myNSX Portfolio Edit"
alow_robots = "no" 
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
    <h1>Portfolio Edit</h1>
    <p>You can track up to 20 NSX or SIMVSE securities. Enter in the a valid NSX or SIMVSE security code. If you also enter in the number of securities held and purchase price the portfolio calculator will calculate the change in value.  Select SMS if you would like a trade or price alert for that security sent to your phone.  Select Email if you would like trade, price and news alerts for that security sent to your email address.  Deleting a security code will remove that security from your portfolio.</p>
<%
portfolioname=trim(request("portfolioname") & " ")
if len(portfolioname="") then portfolioname="default"
username = session("username")

Set ConnPasswords = GetReaderConn() 'Server.CreateObject("ADODB.Connection")
Set CmdEditUser = Server.CreateObject("ADODB.Recordset")

SQL = "SELECT username,tradingcode,pholding,pprice,smstrade,emailtrade,smsnews,emailnews,smspricechange,emailpricechange "
SQL = SQL & "FROM nsx_portfolio "
SQL = SQL & "WHERE username='" & SafeSqlParameter(username) & "' AND (portfolioname='" & SafeSqlParameter(portfolioname) & "' OR portfolioname IS NULL) AND LEN(tradingcode) > 0 AND tradingcode IS NOT NULL "
SQL = SQL & "ORDER BY tradingcode ASC"
'Response.Write SQL
'Response.End

Set conn = GetReaderConn()
Set rs = conn.Execute(sql)
%>
    <form method="POST" action="user_portfolio_save.asp?portfolioname=<%=portfolioname%>">
      <input type="hidden" name="returnurl" id="returnurl" value="user_portfolio_view1.asp">
      <p><input type="submit" value="Save and View Portfolio"></p>
	  <div class="f-w-table" >
    	<table >
		<thead>
        <tr>
          <th>Security<br>Code</th>
          <th align="center">Number of<br>Securities Held</th>
          <th align="center">Purchase<br>Price / Security</th>
          <th align="center">SMS<br>Trades</th>
          <th align="center">SMS<br>News</th>
          <th align="center">SMS<br>Price</th>
          <th align="center">Email<br>Trades</th>
          <th align="center">Email<br>News</th>
          <th align="center">Email<br>Price</th>
        </tr>
		</thead>
		<tbody>
<%

Set regEx = New RegExp 
regEx.Pattern = "^[a-zA-Z0-9]+$" 

ii=1
alt = true

If Not rs.EOF Then
  While Not rs.EOF
    tradingcode = rs("tradingcode")
    pholding = rs("pholding")
    pprice=rs("pprice")
    smstrade=rs("smstrade")
    emailtrade=rs("emailtrade")
    smsnews=rs("smsnews")
    emailnews=rs("emailnews")
    smspricechange=rs("smspricechange")
    emailpricechange=rs("emailpricechange")		
%>
	        <tr<%
  If alt = True Then 
    Response.Write " class=""alt"""
  End If
        %>>
			<td >
			<input value="<%
			isCodeValid = regEx.Test(tradingcode) 
			If Not isCodeValid Then
				tradingcode = ""
			End If
			response.write ucase(tradingcode)
			%>" type="text" name="tradingcode<%=ii%>" size="6"  ></td>
			<td align="center" >
			<input value="<%=pholding%>" type="text" name="pholding<%=ii%>" size="6"  ></td>
			<td align="center" >
			<input value="<%=pprice%>" type="text" name="pprice<%=ii%>" size="6"  ></td>
			<td align="center" >
			<input type="checkbox" name="smstrade<%=ii%>" value="true"
			<% if smstrade then response.write " CHECKED"%>
			></td>
			<td align="center" >
			<input type="checkbox" name="smsnews<%=ii%>" value="true"
			<% if smsnews then response.write " CHECKED"%>
			></td>
			<td align="center" >
			<input type="checkbox" name="smspricechange<%=ii%>" value="true"
			<% if smspricechange then response.write " CHECKED"%>
			></td>
			<td align="center" >
			<input type="checkbox" name="emailtrade<%=ii%>" value="true"
			<% if emailtrade then response.write " CHECKED"%>></td>
			<td align="center" >
			<input type="checkbox" name="emailnews<%=ii%>" value="true"
			<% if emailnews then response.write " CHECKED"%>></td>
			<td align="center" >
			<input type="checkbox" name="emailpricechange<%=ii%>" value="true"
			<% if emailpricechange then response.write " CHECKED"%>></td>
		</tr>
<%
     alt = Not alt 
    ii = ii+1
    rs.MoveNext
  Wend
End If
  For i = 0 to 19-lap
    tradingcode=""
    pholding=""
    pprice=""
    smstrade=false
    emailtrade=false
    smsnews=false
    emailnews=false
    smspricechange=false
    emailpricechange=false
%>
			        <tr<%
  If alt = True Then 
    Response.Write " class=""alt"""
  End If
        %>>
			<td  >
			<input value="<%=ucase(tradingcode)%>" type="text" name="tradingcode<%=ii%>" size="6"  ></td>
			<td align="center" >
			<input value="<%=pholding%>" type="text" name="pholding<%=ii%>" size="6"  ></td>
			<td align="center" >
			<input value="<%=pprice%>" type="text" name="pprice<%=ii%>" size="6" ></td>
			<td align="center" >
			<input type="checkbox" name="smstrade<%=ii%>" value="true" 
			<% if smstrade then response.write " CHECKED"%>
			></td>
			<td align="center" >
			<input type="checkbox" name="smsnews<%=ii%>" value="true"
			<% if smsnews then response.write " CHECKED"%>
			></td>
			<td align="center" >
			<input type="checkbox" name="smspricechange<%=ii%>" value="true"
			<% if smspricechange then response.write " CHECKED"%>
			></td>
			<td align="center" >
			<input type="checkbox" name="emailtrade<%=ii%>" value="true"
			<% if emailtrade then response.write " CHECKED"%>></td>
			<td align="center" >
			<input type="checkbox" name="emailnews<%=ii%>" value="true"
			<% if emailnews then response.write " CHECKED"%>></td>
			<td align="center" >
			<input type="checkbox" name="emailpricechange<%=ii%>" value="true"
			<% if emailpricechange then response.write " CHECKED"%>></td>
		</tr>
<%
    ii = ii+1
	alt = Not alt 
  Next
%>        
      </tbody>
	  </table>
	  </div>
      <p><input type="submit" value="Save and View Portfolio"></p>
    </form>    

  </div>
</div>
</div>

<div style="clear:both;"></div>
</div>
<div style="height:20px;background-color:#fff;clear:both;margin-bottom:8px;"></div>
<!--#INCLUDE FILE="footer.asp"-->

