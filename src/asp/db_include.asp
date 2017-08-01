<%
Class cPager
  Private m_ItemCount
  Private m_PageSize
  Private m_CurrentPage
  
  Public Sub Class_Initialize
    m_ItemCount = 0
    m_PageSize = 30
  End Sub  

  Public Property Get PageSize()
    PageSize = m_PageSize
  End Property
  
  Public Property Get PageCount()
    If m_ItemCount <= m_PageSize Then
      PageCount = 1
    Else
      PageCount = Cint((m_ItemCount/m_PageSize)+0.5)
    End If
  End Property

  Public Property Let PageSize(p_PageSize)
    m_PageSize = p_PageSize
  End Property 
  
  Public Property Get CurrentPage()
    CurrentPage = m_CurrentPage
  End Property

  Public Property Let CurrentPage(p_CurrentPage)
    m_CurrentPage = p_CurrentPage
  End Property   

  Public Property Get ItemCount()
    ItemCount = m_ItemCount
  End Property

  Public Property Let ItemCount(p_ItemCount)
    m_ItemCount = p_ItemCount
  End Property 

  Public Property Get PageStartIndex(p_PageNumber)
    Dim startItem
    startItem = 0
    If p_PageNumber > 1 Then startItem = ((p_PageNumber-1) * m_PageSize)
    PageStartIndex = startItem
  End Property
  
  Public Property Get PageEndIndex(p_PageNumber)
    Dim endItem
    endItem = m_ItemCount-1
    If m_ItemCount > ((p_PageNumber) * m_PageSize) Then endItem = ((p_PageNumber) * m_PageSize)-1
    PageEndIndex = endItem
  End Property
  
  Public Property Get CanMoveNext()
    If PageCount > 1 And CurrentPage < PageCount Then
      CanMoveNext = true
    Else
      CanMoveNext = false
    End If  
  End Property
   
  Public Property Get CanMovePrev()
    If PageCount > 1 And CurrentPage > 1 Then
      CanMovePrev = true
    Else
      CanMovePrev = false
    End If 
  End Property
  
  Public Property Get PageNumPlaceholder()
    PageNumPlaceholder = "[PAGENUM]" 
  End Property  
  
  Public Sub PrintPager(urlTemplate)
    If PageCount > 1 Then
      Response.Write "<div class=""ks-pagination-links"" align=""center""><ul>"
      If db.Pager.CanMovePrev Then
        Response.Write "<li><a href=""" & Replace(urlTemplate,PageNumPlaceholder,m_CurrentPage-1) & """>Prev</a></li>"
      End If
      For i = 0 To PageCount-1
        If i+1 = CInt(currentpage) Then
          Response.Write "<li class=""current"">" & i+1 & "</li>" 
        Else
          Response.Write "<li><a href=""" & Replace(urlTemplate,PageNumPlaceholder,i+1) & """>" & i+1 & "</a></li>"
        End If
      Next
      If db.Pager.CanMoveNext Then
        Response.Write "<li><a href=""" & Replace(urlTemplate,PageNumPlaceholder,m_CurrentPage+1) & """>Next</a></li>"
      End If
      Response.Write "</ul><span class=""total"">(" & m_ItemCount & "&nbsp;records)</span></div>"
    End If
  End Sub
  
  Public Sub PrintDebug
    Response.Write "<p><b>Class cPager</b><br>"
    Response.Write "&nbsp;&nbsp;ItemCount: " & m_ItemCount & "<br>" & vbCrLf
    Response.Write "&nbsp;&nbsp;PageSize: " & m_PageSize & "<br>" & vbCrLf
    Response.Write "&nbsp;&nbsp;CurrentPage: " & m_CurrentPage & "<br>" & vbCrLf
    Response.Write "&nbsp;&nbsp;PageCount: " & PageCount & "<br>" & vbCrLf
    Response.Write "&nbsp;&nbsp;PageStartIndex(1): " & PageStartIndex(1) & "<br>" & vbCrLf
    Response.Write "&nbsp;&nbsp;PageEndIndex(1): " & PageEndIndex(1) & "<br>" & vbCrLf
    Response.Write "</p>" 
  End Sub  

End Class

Class cDB
  'Private, class member variable
  Private m_SQL
  Private m_ConnectionString
  Private m_Rows
  Private m_pager
  Private m_RecordCount
  
  Public Sub Class_Initialize
    ' m_ConnectionString = Application("nsx_ReaderConnectionString")
    Set m_pager = new cPager
    m_pager.PageSize = 30
  End Sub   
  
  Public Property Get Pager()
    Set Pager = m_pager
  End Property 

  Public Property Get RecordCount()
    RecordCount = m_RecordCount
  End Property

  Function GetRows (p_SQL)
    Dim returnData
    Dim conn
    Dim cmd
    m_SQL = p_SQL
    Set conn = GetReaderConn() ' Server.CreateObject("ADODB.Connection")
    Set cmd = Server.CreateObject("ADODB.Recordset") 
    ' conn.Open m_ConnectionString
    cmd.Open p_SQL, conn
    If Not cmd.EOF Then 
      returnData = cmd.getrows
    End If
    cmd.Close
    Set cmd = Nothing
    ' conn.Close
    Set conn = Nothing
    If IsEmpty(returnData) Then
      m_pager.ItemCount = 0
      m_RecordCount = 0 
    Else
      m_pager.ItemCount = Ubound(returnData,2)
      m_RecordCount = Ubound(returnData,2)
    End If
    m_Rows = returnData
    GetRows = m_Rows
  End Function
  
  Public Sub PrintDebug
    Response.Write "<p><b>Class cDb</b><br>"
    Response.Write "&nbsp;&nbsp;SQL: " & m_SQL & "<br>" & vbCrLf
    Response.Write "&nbsp;&nbsp;ConnectionString: " & m_ConnectionString & "<br>" & vbCrLf
    Response.Write "</p>" 
    m_pager.PrintDebug    
  End Sub   
End Class
%>
