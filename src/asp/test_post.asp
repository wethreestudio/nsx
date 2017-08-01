<html>
<head>
</head>
<body>
<h1>POST</h1>
<p>
<%
if Request.Form.Count > 0 then 
    For x = 1 to Request.Form.Count
        Response.Write Request.Form.Key(x) & " = " & Request.Form.Item(x) & "<br>"
    Next 
end if  
%>
</p>
</body>
</html>  
