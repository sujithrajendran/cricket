<%@page import="java.awt.Window"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*" %>
    <%@ page import="com.cricket.util.DBconnection" %> 
    <%@ page import="java.sql.Connection" %>  
    <%@ page import="java.sql.ResultSet" %>
    <%@page import="javax.servlet.http.HttpSession"%>
    <%@page import="java.text.SimpleDateFormat" %>
    <%@page import=" java.text.ParseException" %>
<html>
<head>
<meta charset="ISO-8859-1">
<title>view Team</title>
<link rel="stylesheet" type="text/css" href="mainstyle.css">
<script type="text/javascript">
//refresh page
	function checkcookie() 
	{
		var refreshadminpage= getCookie("refreshadmin");
		if(refreshadminpage == null)
			{
			window.location.reload(true);
			document.cookie="refreshadmin=sampleadmin"
			}
	}
</script>
</head>
<body onload="checkcookie()">
<% session.setAttribute("add","othersearch"); %>
<form action="Otherteam.jsp" method="post">
<%--get Id,name,number --%>
<% String id="";
   String mobilenumber="";
   String firstname="";
   String teamname="";
			Cookie[] cc = request.getCookies();
			for(int i=0;i<cc.length;i++)
			{
				if(cc[i].getName().equals("id"))
				{
				 id=cc[i].getValue(); 
			    }
			}
			System.out.println("id -"+id);
			%>
<header id="header">
			<div id="logo">
				<h1>Cricket</h1>
				 
<%Connection con=DBconnection.getDBConnection(); %>
            <%
            if (con != null) {
				try {
					Statement st = con.createStatement();
					ResultSet rs = st.executeQuery("select mobilenumber,firstname,teamname from signup where id='"+id+"'");
					while (rs.next()) {
						mobilenumber = rs.getString(1);
						firstname=rs.getString(2);
						teamname=rs.getString(3);
					}
				} catch (Exception e) {
					System.out.println(e.toString());
				}
				System.out.println("mobilenumber -"+mobilenumber);
				System.out.println("firstname -"+firstname.toUpperCase());
				System.out.println("teamname -"+teamname.toUpperCase());
			}
        
            %>				
				<h3><font color="white">Team Name:<%=teamname.toUpperCase() %>
				</font></h3>
				<label class="calendar">
		<img src="cricket1.png" height="15%" width="30%" id="img">
			
			
			<label class="logoutLblPos">
			<img src="logout.png" onclick="window.location.href='register.jsp'" height="60%" width="60%" id="img">
  </label>
			</div>
</header>
	<nav id="nav">
			<div class="innertube">
				<h2>Coach</h2>
				<ul>
				    <li><a href="Home.jsp">Home</a></li>	
					<li><a href="Otherteam.jsp">Other Teams</a></li>	
				</ul>
			</div>
		</nav>
<main>
</br>
<table id="tblData" border="1" align="center" cellspacing="15" bordercolor="black" class="raw-table raw-table-highlight-all" cellpadding="15">
<tr>
		<th><b><center><font color="blue" size="4">TeamName</font></center></b></th>
		<th><b><center><font color="blue" size="4">View profile</font></center></b></th> 
		<%
		String ateamname="";
		int i=0;
            if (con != null) {
				try {
					Statement st = con.createStatement();
					ResultSet rs = st.executeQuery("select teamname from signup where teamname!='"+teamname+"'");
					while (rs.next()) {
						ateamname=rs.getString(1);
						if(ateamname!=null)
						  { 	%>
						  <tr>                               
                            <td><center> <input type="text" value="<%=ateamname%>" name=<%="teamname"+i %> style="border:0;font-weight: bold; border-color:transparent;text-align:center" size="10"  readonly="value" ></center></td>
			 			     <td><button name="Accept" class="new" value=<%="Accept"+i%> onclick="form.action='PlayerServlet'" />View</button></td>
						    				     
						     </tr>	     
				<%	  
			
				i++;} }
				} catch (Exception e) {
					System.out.println(e.toString());
				}
				System.out.println("all team name -"+ateamname);
			}
            %>			
		
		
						     </table>
						     </main>
			

		</form>
</body>
</html>