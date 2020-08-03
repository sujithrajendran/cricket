package com.cricket.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.cricket.bean.MailBean;
import com.cricket.util.DBconnection;

import com.cricket.servlet.EmailUtility;

public class MailDAO {

	Connection con=DBconnection.getDBConnection();

	public String generateid() {
			String result="";
			String match="Match";
			if(con!=null)
			{
				try 
				{
					Statement st = con.createStatement();
					ResultSet rs=st.executeQuery("select mid.nextval from dual");
					while(rs.next())
					{
						result=result+rs.getInt(1);
					}
				} 
				catch (SQLException e)
				{
					e.printStackTrace();
				}
				result=match+result;
				System.out.println("Matchsequence value" + result);
		}
			return result;
			
		}

	public String register(MailBean mbean) {
		System.out.println("user in dao : "+mbean);
		String output="Failed";	
		if(con!=null)
		{
			try
			{
				System.out.println("Mail Dao");
				PreparedStatement pst=con.prepareStatement("insert into fixing (location,teamname,time,description,contactnumber,status,matchdate,id,ScheduledTeam) values(?,?,?,?,?,?,?,?,?)");
				pst.setString(1,mbean.getLocation());
				pst.setString(2,mbean.getTeamname());
				pst.setString(3,mbean.getTime());
				pst.setString(4,mbean.getDescription());
				pst.setString(5,mbean.getContactNumber());
				pst.setString(6,mbean.getStatus());
				pst.setString(7,mbean.getMatchDate());
				pst.setString(8,mbean.getId());
				pst.setString(9,mbean.getScheduledTeam());
				if(pst.executeUpdate()>0)
					output="Success";
			}
			catch(Exception e)
			{
				
			}
			System.out.println("register output -" + output );
		}
		return output;
	}

	public String sendingemail(String host, String port, String user, String pass, String number, String description,String location, String matchdate, String time, String teamname, String id, String status)
	{
		String name="";
		String mail="";
		String date="";
		String result="";
		String emailid="";
		String tmname="";		
		if(con!=null)
		{
			try 
			{
				Statement st = con.createStatement();
				ResultSet rs=st.executeQuery("select firstname,emailid,teamname from signup where teamname!='"+teamname+"'");
				while(rs.next())
				{
					name=rs.getString(1);
					emailid=rs.getString(2);
					tmname=rs.getString(3);
					System.out.println("teamname-"+teamname);
					System.out.println("team id-"+id);
					System.out.println("name-"+name);
					System.out.println("emailid-"+emailid);
					System.out.println("tmname-"+tmname);
					System.out.println("--------");
		            			if(name!=null && emailid!=null && tmname!=null)
		            			{
		            				try
		            				{
		            				Statement st2 = con.createStatement();
		            				ResultSet rs2=st2.executeQuery("select location,teamname,time,description,contactnumber,matchdate,id from fixing where teamname='"+teamname+"' and id='"+id+"'");
		            				while(rs2.next()) 
		            				{ 
								     location=rs2.getString(1);
								     teamname=rs2.getString(2);
								     time=rs2.getString(3);
								     description=rs2.getString(4);
								     number=rs2.getString(5);
								     date=rs2.getString(6);
								     id=rs2.getString(7);
								    	String recipient=emailid;
								    	String subject =teamname+"  "+id+" - Requested For A Match";
								    	String content ="Hi "+name+","+"\n "
												+"\n"+" "
												+"\n"+"     "+"Match Details Are Given Below :)\n"
												+"     "+"Date- "+date+"\n"
												+"     "+"Location -"+location+"\n"
												+"     "+"Timing-"+time+"\n"
												+"     "+"Description-"+description+"\n"
												+"     "+"For Contact"+"\n"
												+"     "+"Number -"+number+"\n"
										        +"\n"+"If You Want To Play With Us Kindly Accept our Request That Has Been Send To The Site"+"\n" 
										        +"\n"+"Thank You!! Have a Good Day :)";
								    System.out.println("recipent-"+recipient);
								    System.out.println("subject-"+subject);
								    System.out.println("content-"+content);
										String resultMessage = "";

										try {
											EmailUtility.sendEmail(host, port, user, pass, recipient, subject,
													content);
											resultMessage = "The e-mail was sent successfully";
											} 
										catch (Exception ex) 
											{
											ex.printStackTrace();
											resultMessage = "There were an error: " + ex.getMessage();
											} 
										result=resultMessage;
		            				  }
		            				 }
		
		            				catch(Exception e)
		            					{
		            					System.out.println(e.toString()); 
		            					}
		            			}
		            		}
		            	 }
		            		catch (SQLException e)
		            			{
		            			e.printStackTrace();
		            			}
		              }
			 return result;
		}

	public String search(String tname, String matchid, String date, String mlocation, String timing, String details,
			String tnumber, String acceptteam ) {
		String output="Failed";	
		if(con!=null)
		{
			try
			{
				System.out.println("Mail Dao");
				PreparedStatement pst=con.prepareStatement("update fixing set status='Closed', SCHEDULEDTEAM='"+acceptteam+"' where id='"+matchid+"' and location='"+mlocation+"' and description='"+details+"' and contactnumber='"+tnumber+"'");
				if(pst.executeUpdate()>0)
					output="Success";
			}
			catch(Exception e)
			{
				
			}
			System.out.println("Update output -" + output );
		}
		return output;
	}

	public String receiveemail(String host, String port, String user, String pass, String tnumber, String details,
			String mlocation, String date, String timing, String tname, String acceptteam, String matchid) {
		String name="";
		String mail="";
		String result="";
		String emailid="";
		String tmname="";	
		String location="";
		String teamname="";
		String description="";
		String time="";
		String number="";
		String id="";
		String otherteam="";
		if(con!=null)
		{
			try 
			{
				Statement st = con.createStatement();
				ResultSet rs=st.executeQuery("select firstname,emailid,teamname from signup where teamname!='"+acceptteam+"'");
				while(rs.next())
				{
					name=rs.getString(1);
					emailid=rs.getString(2);
					otherteam=rs.getString(3);
					System.out.println("name-"+name);
					System.out.println("Acceptteamname-"+otherteam);
					System.out.println("emailid-"+emailid);
					System.out.println("--------");
		            			if(name!=null && emailid!=null && otherteam!=null)
		            			{
		            				try
		            				{
		            				Statement st2 = con.createStatement();
		            				ResultSet rs2=st2.executeQuery("select location,teamname,time,description,contactnumber,matchdate,id from fixing where teamname='"+tname+"'");
		            				while(rs2.next()) 
		            				{ 
								     location=rs2.getString(1);
								     teamname=rs2.getString(2);
								     time=rs2.getString(3);
								     description=rs2.getString(4);
								     number=rs2.getString(5);
								     date=rs2.getString(6);
								     id=rs2.getString(7);
								    	String recipient=emailid;
								    	String subject =teamname+"  "+id+" - Match has been Fixed ";
								    	String content ="Hi "+name+","+"\n "
												+"\n"+" "
												+"\n"+"     "+"Match has been Fixed Between\n"
												+"     "+tname+"Vs"+acceptteam+"\n"
												+"     "+"Date- "+date+"\n"
												+"     "+"Location -"+location+"\n"
												+"     "+"Timing-"+time+"\n"
												+"     "+"Description-"+description+"\n"
												+"     "+"For Contact"+"\n"
												+"     "+"Number -"+number+"\n"
										        +"\n"+"Thank You!! Have a Good Day :)";
								    System.out.println("recipent-"+recipient);
								    System.out.println("subject-"+subject);
								    System.out.println("content-"+content);
										String resultMessage = "";

										try {
											EmailUtility.sendEmail(host, port, user, pass, recipient, subject,
													content);
											resultMessage = "The e-mail was sent successfully";
											} 
										catch (Exception ex) 
											{
											ex.printStackTrace();
											resultMessage = "There were an error: " + ex.getMessage();
											} 
										result=resultMessage;
		            				  }
		            				 }
		
		            				catch(Exception e)
		            					{
		            					System.out.println(e.toString()); 
		            					}
		            			}
		            		}
		            	 }
		            		catch (SQLException e)
		            			{
		            			e.printStackTrace();
		            			}
		              }
			 return result;
		}
}