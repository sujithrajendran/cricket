package com.cricket.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cricket.bean.UserBean;
import com.cricket.dao.UserDAO;


/**
 * Servlet implementation class UserServlet
 */
@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HttpSession session=request.getSession();
		String page=(String) session.getAttribute("signup");
		UserDAO userdao=new UserDAO();
		String output="";
		String result = null;
		PrintWriter out = response.getWriter();
		if(page.equals("register"))
		{
			if(!request.getParameter("gender").equalsIgnoreCase("select") &&
					!request.getParameter("SecurityQuestion").equalsIgnoreCase("squestion")) 
			{			
			System.out.println("user Servlet");
			String firstname=request.getParameter("FirstName");
			String lastname=request.getParameter("LastName");
			String mobilenumber=request.getParameter("MobileNumber");
			String address=request.getParameter("Address");
			String gender=request.getParameter("gender");
			String emailId=request.getParameter("EmailId");
			String password=request.getParameter("Password");
			String confirmpassword=request.getParameter("ConformPassword");
			String securityquestion=request.getParameter("SecurityQuestion");
			String securityanswer=request.getParameter("SecurityAnswer");
			String teamname=request.getParameter("Teamname");
			System.out.println(firstname+"  "+lastname+"  "+mobilenumber+" "+address+" "+gender+" "+emailId+" "+password+" "+confirmpassword+" "+teamname+" "+securityquestion+" "+securityanswer);
			output=userdao.generateid();
			System.out.println("Serverlet - sequence output" + output);
				System.out.println("Inside servlet >8");
				UserBean user=new UserBean();
				System.out.println(user);
				user.setFirstName(firstname);
				user.setLastName(lastname);
				user.setMobileNumber(mobilenumber);
				user.setAddress(address);
				user.setGender(gender);
				user.setEmailID(emailId);
				user.setPassword(password);
				user.setConfirmPassword(confirmpassword);
				user.setTeamName(teamname);
				user.setSecurityQuestion(securityquestion);
				user.setSecurityAnswer(securityanswer);
				user.setId(output);
				result=userdao.register(user);
		        if(result.equalsIgnoreCase("Success"))
					{
					out.println("<script type=\"text/javascript\">");
					out.println("alert('User Created');");
					out.println("location='register.jsp';");
					out.println("</script>");
				}
		        else
				{
					out.println("<script type=\"text/javascript\">");
					out.println("alert('Invalid Creation');");
					out.println("location='register.jsp';");
					out.println("</script>");
				}
		        
			}
			else
			{
				out.println("<script type=\"text/javascript\">");
				out.println("alert('select Correct Options');");
				out.println("location='register.jsp';");
				out.println("</script>");
			}
		}
		else if(page.equals("changepass"))
		{
			System.out.println("forgetpass inside servlet");
			String MobileNumber=request.getParameter("MobileNumber");
			String SecurityQuestion=request.getParameter("SecurityQuestion");
			String SecurityAnswer=request.getParameter("SecurityAnswer");
			String Password=request.getParameter("Password");
			System.out.println(MobileNumber+ "--" +SecurityQuestion +"--"+SecurityAnswer +"--"+Password);
			output=userdao.changepass(Password,MobileNumber,SecurityQuestion,SecurityAnswer);
			System.out.println("serverlet output" + output);
		   if(output.equals("success"))	
		   {
			out.println("<script type=\"text/javascript\">");
			out.println("alert('Password changed successfully');");
			out.println("location='register.jsp';");
			out.println("</script>");
			
		}
		else
		{
			out.println("<script type=\"text/javascript\">");
			out.println("alert('incorrect Security name & Answer');");
			out.println("location='Forgetpassword.jsp';");
			out.println("</script>");
			
		}
		
		}
	   else if(page.equals("updateprofile"))
	   {
		   System.out.println("update profile");
		   String id=(String) (session.getAttribute("id"));
			String mobilenumber=request.getParameter("MobileNumber");
			String emailid=request.getParameter("EmailId");
			String teamname=request.getParameter("TeamName");
			String securityquestion=request.getParameter("SecurityQuestion");
			String securityanswer=request.getParameter("SecurityAnswer");
			System.out.println(mobilenumber+ "--" +securityquestion +"--"+securityanswer +"--"+emailid+"--"+id);
			output=userdao.updateprofile(mobilenumber,securityquestion,securityanswer,emailid,id);
			String val=id.substring(0,1);
			if(output.equalsIgnoreCase("success"))	
			   {
				out.println("<script type=\"text/javascript\">");
				out.println("alert('profile updated successfully');");
				out.println("location='Home.jsp';");
				out.println("</script>");
				 }
				 else
					 {
					out.println("<script type=\"text/javascript\">");
					out.println("alert('Enter valid Security question & Answer');");
					out.println("location='UpdateProfile.jsp';");
					out.println("</script>");
					 }
	}
}
}
