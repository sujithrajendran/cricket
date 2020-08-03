package com.cricket.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cricket.bean.MailBean;
import com.cricket.dao.MailDAO;
import com.cricket.dao.UserDAO;

/**
 * Servlet implementation class UserServlet
 */
@WebServlet("/MailServlet")
public class MailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HttpSession session=request.getSession();
		String page=(String) session.getAttribute("match");
		MailDAO maildao=new MailDAO();
		String output="";
		String result = null;
		RequestDispatcher rd;
		PrintWriter out = response.getWriter();
		if(page.equals("fixing"))
		{			
			System.out.println("Mail Servlet");
			String location=request.getParameter("Location");
			String teamname=request.getParameter("TeamName");
			String time=request.getParameter("Timing");
			String description=request.getParameter("Desc");
			String matchdate=request.getParameter("Date");
			String number=request.getParameter("Number");
			String status="open";
			String scheduledteam="";
			output=maildao.generateid();
			MailBean mbean=new MailBean();
			mbean.setContactNumber(number);
			mbean.setDescription(description);
			mbean.setLocation(location);
			mbean.setMatchDate(matchdate);
			mbean.setStatus(status);
			mbean.setTime(time);
			mbean.setTeamname(teamname);
			mbean.setId(output);
			mbean.setScheduledTeam(scheduledteam);
			result=maildao.register(mbean);	
			String email="";
			if(result.equalsIgnoreCase("Success"))
			{
				ServletContext context = getServletContext();
				String host = context.getInitParameter("host");
				String port = context.getInitParameter("port");
				String user = context.getInitParameter("user");
				String pass = context.getInitParameter("pass");
				System.out.println("email Servlet");
				System.out.println("host--"+host);
				System.out.println("port--"+port);
				System.out.println("user--"+user);
				System.out.println("pass--"+pass);
				email=maildao.sendingemail(host,port,user,pass,number,description,location,matchdate,time,teamname,output,status);
				if(email.equalsIgnoreCase("The e-mail was sent successfully"))
				{
					 out.println("<script type=\"text/javascript\">");
					 out.println("alert('Match requested & email Sent successfully');");
					 out.println("location='Home.jsp';");
					 out.println("</script>");
			    }
			    else 
			    {
				out.println("<script type=\"text/javascript\">");
				out.println("alert('Email Failed to send!!');");
				out.println("location='Match.jsp';");
				out.println("</script>");
			    }
			}
			}
			if(page.equals("accept"))
			{
				String email="";
				System.out.println("Accept Match Servlet");
				String acceptteam=(String) session.getAttribute("acceptteam");
				System.out.println("acceptteam-"+acceptteam);
				String index = request.getParameter("Accept").substring(6);
				System.out.println("index-"+index);
				String tname=request.getParameter("teamname"+index);
		        String matchid=request.getParameter("mid"+index);
		        String date=request.getParameter("date"+index);
		        String mlocation=request.getParameter("location"+index);
		        String timing=request.getParameter("time"+index);
		        String details=request.getParameter("desc"+index);
		        String tnumber=request.getParameter("number"+index);
		        System.out.println("tname--"+tname+"matchid--"+matchid+"date--"+date+"mlocation--"+mlocation+"timing--"+timing+"details--"+details+"tnumber--"+tnumber);
		        result=maildao.search(tname,matchid,date,mlocation,timing,details,tnumber,acceptteam);
		        System.out.println("result-"+result);
		        if(result.equalsIgnoreCase("Success"))
		        		{
		        		 System.out.println("servlet");
		        ServletContext context = getServletContext();
				String host = context.getInitParameter("host");
				String port = context.getInitParameter("port");
				String user = context.getInitParameter("user");
				String pass = context.getInitParameter("pass");
				System.out.println("email Servlet");
				System.out.println("host--"+host);
				System.out.println("port--"+port);
				System.out.println("user--"+user);
				System.out.println("pass--"+pass);
				email=maildao.receiveemail(host,port,user,pass,tnumber,details,mlocation,date,timing,tname,acceptteam,matchid);
				if(email.equalsIgnoreCase("The e-mail was sent successfully"))
				{
					 out.println("<script type=\"text/javascript\">");
					 out.println("alert('Match Accepted & email Sent successfully');");
					 out.println("location='Home.jsp';");
					 out.println("</script>");
			    }
			    else 
			    {
				out.println("<script type=\"text/javascript\">");
				out.println("alert('Email Failed to send!!');");
				out.println("location='CurrentMatch.jsp';");
				out.println("</script>");
			    }
			}
			}
	}
}


