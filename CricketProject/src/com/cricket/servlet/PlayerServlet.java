package com.cricket.servlet;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.cricket.bean.PlayerBean;
import com.cricket.dao.PlayerDAO;
/**
 * Servlet implementation class PlayerServlet
 */
@WebServlet("/PlayerServlet")
public class PlayerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		System.out.println("Player servlet");
		HttpSession session=request.getSession();
		String page=(String) session.getAttribute("add");
		PlayerDAO playerdao=new PlayerDAO();
		String result = null;
		String output="";
		PrintWriter out = response.getWriter();
		if(page.equals("player"))
		{
			System.out.println("Player Servlet---");
			String name =request.getParameter("Name");
			String nickname=request.getParameter("NickName");
			String age =request.getParameter("Age");
			String birthplace=request.getParameter("BirthPlace");
			String role =request.getParameter("Role");
			String battingstyle=request.getParameter("bstyle");
			String bowlingstyle =request.getParameter("bostyle");
			String wicketkeeper=request.getParameter("wicketkeeper");
			String rating=request.getParameter("Rating");
			String teamname=request.getParameter("TName");
			output=playerdao.id(name);
			System.out.println(name+" "+nickname+" "+age+" "+birthplace+" "+role+" "+battingstyle+" "+bowlingstyle+" "+wicketkeeper+" "+rating+" "+teamname);
			PlayerBean playerbean=new PlayerBean();
			playerbean.setName(name);
			playerbean.setNickname(nickname);
			playerbean.setAge(age);
			playerbean.setBirthplace(birthplace);
			playerbean.setRole(role);
			playerbean.setBattingstyle(battingstyle);
			playerbean.setBowlingstyle(bowlingstyle);
			playerbean.setWicketkeeper(wicketkeeper);
			playerbean.setRating(rating);
			playerbean.setTeamName(teamname);;
			playerbean.setId(output);
			result=playerdao.insertplayer(playerbean);
			 if(result.equalsIgnoreCase("Success"))
				{
				out.println("<script type=\"text/javascript\">");
				out.println("alert('Player Added Successfully');");
				out.println("location='AddPlayers.jsp';");
				out.println("</script>");
			}
	        else
			{
				out.println("<script type=\"text/javascript\">");
				out.println("alert('Player Not Added');");
				out.println("location='AddPlayers.jsp';");
				out.println("</script>");
			}
		}
		else if(page.equalsIgnoreCase("delete"))
		{
			 System.out.println("delete");
				String name=request.getParameter("Name");
				result=playerdao.delete(name);
				if(result.equalsIgnoreCase("success"))	
				   {
					out.println("<script type=\"text/javascript\">");
					out.println("alert('player deleted successfully');");
					out.println("location='Home.jsp';");
					out.println("</script>");
					 }
					 else
						 {
						out.println("<script type=\"text/javascript\">");
						out.println("alert('player not found');");
						out.println("location='RemovePlayer.jsp';");
						out.println("</script>");
						 }
		}
		else if(page.equalsIgnoreCase("search"))
		{
			 System.out.println("searchplayer");
			 System.out.println(request.getParameter("Accept"));
			 String index = request.getParameter("Accept").substring(6);
			String pid=request.getParameter("id"+index);
			String name=request.getParameter("name"+index);
			System.out.println("index-"+index);
			System.out.println("pid-"+pid);
			System.out.println("name-"+name);
				result=playerdao.search(pid,name);
				
				if(result.equalsIgnoreCase("fail"))	
				   {
					out.println("<script type=\"text/javascript\">");
					out.println("alert('error in displaying playerinfo');");
					out.println("location='Home.jsp';");
					out.println("</script>");
					 }
					 else
						 {
						 out.println("<script type=\"text/javascript\">");
						out.println("location='DisplayProfile.jsp';");
						session.setAttribute("id",pid);
						session.setAttribute("name",name);
						session.setAttribute("role",result);
						out.println("</script>");
						 }
		}
		else if(page.equalsIgnoreCase("othersearch"))
		{
			 System.out.println("search-player");
			 System.out.println(request.getParameter("Accept"));
			 String index = request.getParameter("Accept").substring(6);
			String teamname=request.getParameter("teamname"+index);
			System.out.println("index-"+index);
			System.out.println("teamname-"+teamname);
				
				if(teamname!=null)	
				   {
					out.println("<script type=\"text/javascript\">");
					session.setAttribute("teamname",teamname);
					out.println("location='Teamplayer.jsp';");
					out.println("</script>");
					 }
					 else
						 {
						 out.println("<script type=\"text/javascript\">");
						out.println("location='OtherProfile.jsp';");
						out.println("alert('error in displaying team player info');");
						out.println("</script>");
						 }

		}
		}
	}