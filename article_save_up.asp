<!-- #include virtual = "/include/mylib.asp" -->

<!-- #include virtual = "/include/auth.asp" -->
<!-- #include virtual = "/include/wsql.asp" -->


<%



'去掉字符串头尾的连续的回车和空格 
function trimVBcrlf(str) 
trimVBcrlf=rtrimVBcrlf(ltrimVBcrlf(str)) 
end function 

'去掉字符串开头的连续的回车和空格 
function ltrimVBcrlf(str) 
dim pos,isBlankChar 
pos=1 
isBlankChar=true 
while isBlankChar 
if mid(str,pos,1)=" " then 
pos=pos+1 
elseif mid(str,pos,2)=VBcrlf then 
pos=pos+2 
else 
isBlankChar=false 
end if 
wend 
ltrimVBcrlf=right(str,len(str)-pos+1) 
end function 

'去掉字符串末尾的连续的回车和空格 
function rtrimVBcrlf(str) 
dim pos,isBlankChar 
pos=len(str) 
isBlankChar=true 
while isBlankChar and pos>=2 
if mid(str,pos,1)=" " then 
pos=pos-1 
elseif mid(str,pos-1,2)=VBcrlf then 
pos=pos-2 
else 
isBlankChar=false 
end if 
wend 
rtrimVBcrlf=rtrim(left(str,pos)) 
end function 




        Function check_op(s_chr,d_chr)
 	POP = INSTR(s_chr,d_chr)
		IF POP >0 THEN
		check_op = "checked"
		ELSE
		check_op = ""
		END IF	
 End Function

 Function if_opa(s_chr,d_chr)
	POP = INSTR(s_chr,d_chr)
		IF POP >0 THEN
		if_opa = "checked"
		ELSE
		if_opa = ""
		END IF	
 End Function
 
 Function if_checkbox(s_chr,d_chr)
	POP = INSTR(s_chr,"PZ"&d_chr&"ED")
		IF POP >0 THEN
		if_checkbox = "checked"
		ELSE
		if_checkbox = ""
		END IF	
 End Function 
     
	IF REQUEST("HOME") <> "" THEN
	Response.Redirect ("default.asp")
	END IF
	IF REQUEST("search") <> "" THEN
	Response.Redirect ("article_main.asp")
	END IF
	set CONN = Server.CreateObject("ADODB.Connection")
    CONN.open CONNSTR,"",""  
	set RS = Server.CreateObject("ADODB.RecordSet")
	set RS1 = Server.CreateObject("ADODB.RecordSet")
	set RS2 = Server.CreateObject("ADODB.RecordSet")
	set RSLIB = Server.CreateObject("ADODB.RecordSet")
%>
<%

    
		 s_class_no = request("class_no")
		 s_info_title =  request("info_title")
		 s_info_desc = request("info_desc")
		 s_info_find =  request("info_find")
		' s_info_corre =  request("info_corre")
		 s_info_source =  request("info_source")
		 s_info_file =  request("info_file")
		 s_class_corre = request("class_corre")
		 s_if_bw = request("if_bw")
		 s_sp_url = request("sp_url")
		 s_sp_url_out = request("sp_url_out")
		 s_zhuanti= request("zhuanti")
		 s_if_tj = request("if_tj")
		 s_if_html =  request("if_html")
		 s_sub_title = request("sub_title")
		 s_re_date = request("re_date")
		 s_info_corre = request("class_no")
		
s_color_l =  ""
s_color_r = ""
			s_colorxz = Request("colorxz")
			if s_colorxz <>"" Then
			s_color_l = "<font color=red>"
			s_color_r = "</font>"
			
			else
		
			end if
		 	if s_info_corre = "" then
				s_info_corre = "无"
				end if
			
			if s_zhuanti = "" then
				s_zhunati = "无"
				end if
			
			if s_sp_url <> "" then
			pop = 0
			pop = instr(s_sp_url,"http")
			if pop <=0 then
			response.Write("视频URL非法")
			response.end 
			end if
			end if
			
			
				if s_sp_url_out  <> "" then
			pop = 0
			pop = instr(s_sp_url_out ,"http")
			if pop <=0 then
			response.Write("视频URL非法")
			response.end 
			end if
			end if
			
			 MHY_S = ""
	 EE = split(s_info_desc,chr(13))
		For EI = 0 To UBound(EE)
		
				if len(EE(EI)) >1 THEN
				
				ss_info_desc=trimVBcrlf(EE(EI))
				
				MHY_S = MHY_S & ss_info_desc &  chr(13)
				
				end if
		next
		

		s_info_desc= MHY_S
			MM = MONTH(DATE)
				IF MM <10 THEN
				MM = "0" & MM
				ELSE
				MM = MONTH(DATE)
				END IF
		
					'增加记录
	  			'处理字符
					XTH="<p style='text-indent: 2em; text-align: justify; line-height: 1.5em; margin-bottom: 15px; margin-top: 15px;'>    <span style='color: rgb(0, 0, 0); font-family: 微软雅黑, 'Microsoft YaHei';'>"
					XTHJW = "</span></p>"
					QTP="<center><img src='http://img.dakayi.cc/pic/" & year(date) & MM & "/"
					HTP="' width='100%'/></center>"
					 s_info_desc=replace(s_info_desc,"#TPT#",QTP)
					 s_info_desc=replace(s_info_desc,"#TPW#",HTP)
					  s_info_desc=replace(s_info_desc,"#BTT#","<b>")
					 s_info_desc=replace(s_info_desc,"#BTW#","</b>")
					 s_info_desc=replace(s_info_desc,"#SPT#","<a href='")
					 s_info_desc=replace(s_info_desc,"#SPW#","'>点击前往观看视频</a>")
					s_info_desc=replace(s_info_desc,chr(13),XTHJW & XTH)
					 s_info_desc = XTH & s_info_desc & XTHJW
					 
					 
	  				SQL = "SELECT top 1 * FROM A_ARTICLE WHERE INFO_NO='" & REQUEST("INFO_NO") & "'"
	  				RS1.Open SQL,CONN,adOpenKeyset ,adLockOptimistic 
	  				RS1.MoveFirst
	  				RS1("CLASS_NO") = s_class_no
	  				RS1("info_title") = s_info_title
	  				RS1("info_desc") = s_info_desc
	  				RS1("info_find") = "NO"
	  				RS1("INFO_FILE") = s_info_file
						RS1("SP_URL") = s_sp_url
						RS1("SP_URL_OUT") = s_sp_url_out
	  				'RS1("info_corre") = s_info_corre
	  				RS1("info_source") = s_info_source
						RS1("class_corre") = s_class_corre
						RS1("if_bw") = s_if_bw
						RS1("ZHUANTI") = s_zhuanti
						RS1("INFO_CORRE") = s_info_corre
						RS1("if_tj") = s_if_tj
						RS1("IF_HTML") = s_if_html
						RS1("sub_title") = s_sub_title
						RS1("re_date") = s_re_date
						RS1.UpdateBatch 
	  				RS1.Close 
	  					'处理相关信息
					
					SQL = "DELETE FROM D_CORRE WHERE INFO_NO = '" & REQUEST("INFO_NO") & "'"
					CONN.Execute(SQL)
					SQL = "SELECT TOP 5 INFO_NO,INFO_TITLE,INFO_FILE,RE_DATE FROM A_ARTICLE WHERE INFO_NO <> '" & REQUEST("INFO_NO") & "' AND INFO_CORRE LIKE '%" & s_info_corre & "%'"
					RS.Open SQL,CONN,1,1
						DO WHILE NOT RS.EOF 
								SQL = "SELECT top 1 * FROM D_CORRE"
								RS1.Open SQL,CONN,adOpenKeyset ,adLockOptimistic 
								RS1.AddNew 
								RS1("INFO_NO") = REQUEST("INFO_NO")
								RS1("XG_NO") = RS("INFO_NO")
								RS1("XG_TITLE") = RS("INFO_TITLE")
								RS1("XG_IMG") = RS("INFO_FILE")
								RS1("RE_DATE") = RS("RE_DATE")
								RS1.UpdateBatch 
							RS1.Close 
						RS.MoveNext
						LOOP
					RS.CLOSE 
					
			MYDESC = s_info_title & s_info_desc	
									XGNR = ""
    SQL = "SELECT NO,XM,CLASS_NO,HS_NO FROM D_DOCTOR ORDER BY NO "
			RS.Open SQL,CONN,1,1
				DO WHILE NOT RS.EOF 
				POP = 0
					POP = INSTR(MYDESC,RS("XM"))
						IF POP >0 THEN
						XGNR = XGNR & RS("NO") & "-"
							POP1 = 0
							POP1 = INSTR(XGNR,RS("CLASS_NO"))
							IF POP1 >0 THEN
								ELSE
								XGNR = XGNR & RS("CLASS_NO") & "-"
							END IF
							POP1 = 0
							POP1 = INSTR(XGNR,RS("HS_NO"))
							IF POP1 >0 THEN
								ELSE
								XGNR = XGNR & RS("HS_NO") & "-"
							END IF
						END IF
				
				RS.MoveNext
				LOOP
			RS.CLOSE 
		
		SQL = "SELECT JB_NO,JB_NAME FROM JIBING ORDER BY JB_NO"
			RS.Open SQL,CONN,1,1
				DO WHILE NOT RS.EOF 
					POP = 0
					'POP = INSTR(MYDESC,RS("JB_NAME"))
					POP = INSTR(S_INFO_TITLE,RS("JB_NAME"))
						IF POP  >0 THEN
							POP1 = 0
							POP1 = INSTR(XGNR,RS("JB_NO"))
								IF POP1>0 THEN
								ELSE
								XGNR = XGNR & RS("JB_NO") & "-"
								END IF
						END IF
				RS.MoveNext
				LOOP
			RS.CLOSE 
			
				
			SQL = "SELECT HS_NO,HS_NAME,ALICE_NAME FROM HOSPTIAL ORDER BY HS_NO"
			RS.Open SQL,CONN,1,1
				DO WHILE NOT RS.EOF 
			
					POP = 0
					POP = INSTR(MYDESC,RS("HS_NAME"))
						IF POP  >0 THEN
						
							POP1 = 0
							POP1 = INSTR(XGNR,RS("HS_NO"))
								IF POP1>0 THEN
								ELSE
								XGNR = XGNR & RS("HS_NO") & "-"
								END IF
						END IF
					A = Split(RS("ALICE_NAME"), "、")
					
							FOR I = 0 TO UBOUND(A)
								IF A(I) <> "无" THEN
									POP = 0
									POP = INSTR(MYDESC,A(I))
									IF POP  >0 THEN
										response.Write A(I) & "<p></p>"
									POP1 = 0
									POP1 = INSTR(XGNR,RS("HS_NO"))
										IF POP1>0 THEN
										ELSE
										XGNR = XGNR & RS("HS_NO") & "-"
										END IF
								   END IF
								END IF
							NEXT
				
				RS.MoveNext
				LOOP
			RS.CLOSE 
			
		
		SQL = "UPDATE A_ARTICLE SET XGNR = '" & XGNR & "' WHERE INFO_NO = '" & REQUEST("INFO_NO") & "'"
		CONN.Execute(SQL)
		
%>
<html>
<head>
<title>内容与文章修改成功</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="font.css">
<style type="text/css">
<!--
.main {  font-size: 9pt}
-->
</style>
</head>

<body bgcolor="white">
<div align="center"><font color="#0000FF" class="main">（内部资料系统管理）内容与文章系统修改 </font></div>
<hr>
<form method="POST" action="article_main.asp" name="un" >
  <table width="580" border="0" bordercolordark="#99CCFF" bordercolorlight="#99CCFF" cellspacing="1" align="center" cellpadding="6" bgcolor="#000000">
    <tr bgcolor="#FFFFFF"> 
      <td width="32%" class="main">类别：</td>
      <td width="68%" class="main"> 
          <%=DISPLAY_NAME("A_CLASS",s_class_no,"CLASS_NO","CLASS_NAME")
        %> 
        </select>
      </td>
    </tr>
    
    <tr bgcolor="#FFFFFF"> 
      <td width="32%" class="main">资料标题：</td>
      <td width="68%" class="main">
      <%=s_info_title%>
       </td>
    </tr>
	  <tr bgcolor="#FFFFFF"> 
      <td width="32%" class="main">副标题：</td>
      <td width="68%" class="main">
      <%=s_sub_title%>
       </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="32%" class="main">简介：</td>
      <td width="68%" class="main"> 
		  <img src="http://img.dakayi.cc/pic/<%=s_info_file%>" width="640px">
		<%
		IF s_if_html = "是" THEN
		Response.Write s_info_desc
		ELSE
		%>&nbsp;&nbsp;&nbsp;&nbsp;
        <%body = replace(s_info_desc,chr(10),"<br>&nbsp;&nbsp;&nbsp;&nbsp;")%>
        <%=body%>&nbsp; 
        <%
        END IF
        %>
      </td>
    </tr>
      <tr bgcolor="#FFFFFF">
      <td width="32%" class="main">查找字符串：</td>
      <td width="68%" class="main">
      <%=s_info_find%>
        
      </td>
    </tr>
  
    <tr bgcolor="#FFFFFF"> 
      <td width="32%" class="main">资料来源：</td>
      <td width="68%" class="main"> 
      <%=s_info_source%>
        
      </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="21%" class="main">相关栏目：</td>
      <td width="79%" class="main"> 
		 <%
			SQL = "SELECT * FROM A_CLASS ORDER BY CLASS_NO"
			RS1.Open SQL,CONN,adOpenKeyset ,adLockReadOnly
				DO WHILE NOT RS1.EOF 
				%>
				<input type="checkbox" name="class_corre" value="<%=RS1("class_no")%>"  <%=IF_OPA(s_class_corre,RS1("CLASS_NO"))%>><%=RS1("Class_NAME")%>
				<%
				RS1.MoveNext 
				LOOP
			RS1.Close 
		%>
		 
		 
		 
       </td>
		 </tr>
		 <tr bgcolor="#FFFFFF"> 
      <td width="21%" class="main">手机图片：</td>
      <td width="79%" class="main"> 
		 <img src="http://img.dakayi.cc/pic/<%=s_info_file%>">
       </td>
    </tr>
		  <tr bgcolor="#FFFFFF"> 
      <td width="21%" class="main">所属专题：</td>
      <td width="79%" class="main"> 
		 <%
			SQL = "SELECT * FROM A_ZHUANTI ORDER BY NUM"
			RS1.Open SQL,CONN,adOpenKeyset ,adLockReadOnly
				DO WHILE NOT RS1.EOF 
				%>
				<input type="checkbox" name="zhuanti" value="<%=RS1("zt_name")%>"  <%=IF_OPA(s_zhuanti,RS1("zt_name"))%>><%=RS1("ZT_NAME")%>
				<%
				RS1.MoveNext 
				LOOP
			RS1.Close 
		%>
		 
		 
		 
       </td>
		 </tr>
     <tr bgcolor="#FFFFFF"> 
      <td width="32%" class="main">是否备忘：</td>
      <td width="68%" class="main"> 
      <%=s_if_bw%>
        
      </td>
    </tr>
	  <tr bgcolor="#FFFFFF"> 
      <td width="32%" class="main">推广地址：</td>
      <td width="68%" class="main"> 
     http://www.dakayi.cc/article/X<%=REQUEST("INFO_NO")%>.html
        
      </td>
    </tr>
	 <tr bgcolor="#FFFFFF"> 
	 <td width="32%" class="main">现在推广:</td>
      <td width="68%" class="main"> 
     <a href="http://zhanzhang.baidu.com/linksubmit/url" target='_blank'>打开百度推广</a> （复制上面的网址进行提交）
        
      </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td colspan="2"> 
        <div align="center"><br>
          <input type="button" name="add" value="关闭窗口" onclick=self.close();> 
        </div>
      </td>
  </table>
</form>
</body>
</html>
