
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
<title>AddPlayer</title>
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
<% session.setAttribute("add","player"); %>
<form action="AddPlayers.jsp" method="post">
<%--Getting Id,name,number from user--%>
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
			
<% 
Connection con=DBconnection.getDBConnection(); %>
<% if(con!=null)
{
	try
	{
	Statement st = con.createStatement();
    ResultSet rs=st.executeQuery("select mobilenumber,firstname,teamname from signup where id='"+id+"'");
    while(rs.next()) 
    { 
    	mobilenumber=rs.getString(1);
    	firstname=rs.getString(2);
    	teamname=rs.getString(3);
    }
} 
	catch(Exception e)
	 {
		System.out.println(e.toString()); 
	 }
} %>
			
			

<header id="header">
			<div id="logo">
				<h1>Cricket</h1>	
				<h3><font color="white">Team Name: <%= teamname.toUpperCase() %>
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
					<li><a href="AddPlayers.jsp">Add Player</a></li>
				
				</ul>
			</div>
</nav>
<main>

<div class="tube">
<div class="form-style-2">
<div class="form-style-2-heading">Add Player</h2></div>

<label><span>Team Name: <font color="red">*</font></span>
<input type="text" class="input-field"  name="TName" id="tname" value=<%=teamname%>  readonly="reado"  required autofocus/></label>

<label><span>Name: <font color="red">*</font></span>
<input type="text" class="input-field"  name="Name" id="name" onKeyup="capitalize(this)"   required autofocus/></label>

<label><span>Nick Name: <font color="red" >*</font></span>
<input type="text" class="input-field"  name="NickName" id="nickname" onKeyup="capitalize(this)"   required autofocus/></label>

<label><span>Age: <font color="red" >*</font></span>
<input type="number" class="input-field"  name="Age" id="age"    required autofocus/></label>

<label><span>Birth Place: <font color="red" >*</font></span>
<input type="text" class="input-field"  name="BirthPlace" id="birthplace" onKeyup="capitalize(this)"   required autofocus/></label>

<label><span> Role<font color="red" >*</font></span>
<select name="Role" id="role" class="select-field">
<option value="select">Select Role</option>
<option value="Batsman">BatsMan</option>
<option value="Bowler">Bowler</option>
<option value="AllRounder">All-Rounder</option></select></label>

<label><span> Batting Style<font color="red">*</font></span>
 <input type="radio" id="right"   name="bstyle" value="right" required autofocus>Right
 <input type="radio" id="left"  name="bstyle" value="left" required autofocus>Left
 </label>
  
<label><span> Bowling Style<font color="red" >*</font></span>
 <input type="radio" id="right"   name="bostyle" value="right" required autofocus>RightArm
 <input type="radio" id="left"  name="bostyle" value="left" required autofocus>LeftArm
 <input type="radio" id="none"  name="bostyle" value="none" required autofocus>None
 </label>
 <label><span> Wicket Keeper<font color="red" >*</font></span>
  <input type="radio" id="yes"   name="wicketkeeper" value="yes" required autofocus>Yes
  <input type="radio" id="no"  name="wicketkeeper" value="no" required autofocus>No
  </label>
  
<label><span> Rating<font color="red" >*</font></span>
<select name="Rating" id="rating" class="select-field">
<option value="select">Rating</option>
<option value="1">1</option>
<option value="2">2</option>
<option value="3">3</option>
<option value="4">4</option>
<option value="5">5</option>
<option value="6">6</option>
<option value="7">7</option>
<option value="8">8</option>
<option value="9">9</option>
<option value="10">10</option>
</select></label>

<div class="button"><input type="submit" onclick="form.action='PlayerServlet'" value="Save" />
<input type="button" onclick="window.location.href='Home.jsp'" value="Cancel"/></label></div>
</form>
</div>
</div>
</main>
</body>
</html>