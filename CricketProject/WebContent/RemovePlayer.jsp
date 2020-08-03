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
<title>RemovePage</title>
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
	
	//1st letter caps
	function capitalize(el) 
	{
	    var s = el.value;
	    el.value = s.substring(0,1).toUpperCase() + s.substring(1);
	} 
</script>
</head>
<body onload="checkcookie()">
<%session.setAttribute("add","delete"); %>
<form action="RemovePlayer.jsp" method="post">
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
				System.out.println("firstname -"+teamname.toUpperCase());
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

		<main>
		<div class="tube">
<div class="form-style-2">
<div class="form-style-2-heading">Delete Contact</h2></div>

<label><span>Player Name <font color="red"></font></span>
<input type="text" class="input-field" name="Name" id="name"  required autofocus onKeyup="capitalize(this)" ></label>

 <div class="button"><input type="submit" onclick="form.action='PlayerServlet'"  value="Delete" />
<input type="button" onclick="window.location.href='Home.jsp'" value="Cancel"/></label></div>
</div>
</main> 
	<nav id="nav">
			<div class="innertube">
				<h2>Coach</h2>
				<ul>
				    <li><a href="Home.jsp">Home</a></li>	
					<li><a href="RemovePlayer.jsp">Remove Player</a></li>
						
				</ul>
			</div>
		</nav>
		</form>
</body>
</html>