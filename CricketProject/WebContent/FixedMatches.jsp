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
<title>ReceivePage</title>
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
<form action="CurrentMatch.jsp" method="post">
<% session.setAttribute("match","accept"); %>
<%
%>
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
           <%  System.out.println("teamname -"+teamname);%>
<% session.setAttribute("acceptteam",teamname);%>			
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
					<li><a href="FixedMatches.jsp">Fixed Matchest</a></li>	
				
				</ul>
			</div>
</nav>
			<main>
			<div class="tube">
			
		<table id="tblData" border="1" align="center" cellspacing="15" bordercolor="black" class="raw-table raw-table-highlight-all" cellpadding="15">
			<div class="input-field">
			<tr>
		<th><b><center><font color="blue" size="4">Team Name</font></center></b></th>
		<th><b><center><font color="blue" size="4">Match Id</font></center></b></th>
		<th><b><center><font color="blue" size="4">Date</font></center></b></th>
		<th><b><center><font color="blue" size="4">Location</font></center></b></th>
		<th><b><center><font color="blue" size="4">Timing</font></center></b></th>
		<th><b><center><font color="blue" size="4">Details </font></center></b></th>
		<th><b><center><font color="blue" size="4">Contact Number</font></center></b></th>
		<th><b><center><font color="blue" size="4">Status</font></center></b></th>
	</tr>			 	
   <% Connection conn=DBconnection.getDBConnection(); 
		String location="";
		String requestedteam="";
		String time="";
		String description="";
		String number="";
		String mid="";
		String date="";		
		if(con!=null)
							{
								try
								{
							Statement st = conn.createStatement();
						    ResultSet rs=st.executeQuery( "select location,teamname,time,description,contactnumber,matchdate,id from fixing where teamname!='"+teamname+"' and status='Closed' ");
						    while(rs.next()) 
						    { 
						    	location=rs.getString(1);
						    	requestedteam=rs.getString(2);
							     time=rs.getString(3);
							     description=rs.getString(4);
							     number=rs.getString(5);
							     date=rs.getString(6);
							     mid=rs.getString(7);
	    	%>
      <tr>
      <td><center><input type="text" value="<%=requestedteam%>" name=<%= "teamname" %> style="border:0; border-color:transparent; text-align:center" size="10" readonly="value" ></center></td>
    <td><center><input type="text" value="<%=mid%>" name=<%= "mid" %> style="border:0; border-color:transparent; text-align:center" size="10" readonly="value" ></center></td>
    <td><center><input type="text" value="<%=date%>" name=<%= "date" %> style="border:0; border-color:transparent; text-align:center" size="10" readonly="value" ></center></td>
     <td><center><input type="text" value="<%=location%>" name=<%="location" %> style="border:0; border-color:transparent; text-align:center" size="10" readonly="value" ></center></td>
   <td><center><input type="text" value="<%=time%>" name=<%= "time" %> style="border:0; border-color:transparent; text-align:center" size="10" readonly="value" ></center></td>
   <td><center><input type="text" value="<%=description%>" name=<%= "desc" %> style="border:0; border-color:transparent; text-align:center" size="10" readonly="value" ></center></td>
  <td><center><input type="number" value="<%=number%>" name=<%= "number" %> style="border:0; border-color:transparent; text-align:center" size="10" readonly="value" ></center></td>
     <td><center><input type="text"  style="border:0; border-color:transparent; text-align:center" size="10" readonly="value" ><font color="Red">Matched</font></center></td>
     </tr> 
<% 
						    }
								}
		catch(Exception e)
	 	{
		System.out.println(e.toString()); 
		 }
						
}
	        
%>		
			</div>
			</table>	
			</div>	
		</main>
		</form>
</body>
</html>