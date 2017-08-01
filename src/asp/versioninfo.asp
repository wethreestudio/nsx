<% 
    set conn = CreateObject("ADODB.Connection") 
    response.write conn.version 
    set conn = nothing 
%>