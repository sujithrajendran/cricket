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
<title>HomePage</title>
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
<form action="Home.jsp" method="post">
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
 				
				<h3><font color="white">Team Name - </font><font color="#66ff1a"><%=teamname%>
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
			<div class="input-field">	
		</main>
		
	<nav id="nav">
			<div class="innertube">
				<h2>Coach</h2>
				<ul>
				    <li><a href="Profile.jsp">Profile</a></li>	
					<li><a href="AddPlayers.jsp">Add Player</a></li>
					<li><a href="RemovePlayer.jsp">Remove Player</a></li>
					<li><a href="Team.jsp">Team Players</a></li>	
					<li><a href="Match.jsp">Match Request</a></li>	
					<li><a href="Receive.jsp">Receive Request</a></li>
					<li><a href="Otherteam.jsp">View Other Team</a></li>	
				</ul>
			</div>
		</nav>
		</form>
</body>
</html>