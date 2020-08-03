<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

</head>
<body>

<head>
  <meta charset="UTF-8">
  <title>ForgetPassword</title>
  <link href='https://fonts.googleapis.com/css?family=Titillium+Web:400,300,600' rel='stylesheet' type='text/css'><link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
<link rel="stylesheet" href="./style.css">

</head>
<body>
<% session.setAttribute("operation","changepass"); %>
  <div class="form">
      
      <ul class="tab-group">
    <h1>Forget Password</h1>
        </vr>
      </ul>
      
      <div class="tab-content">
        <div id="signup"> 
         <form name="val" action="Forgetpassword.jsp" method="post">
     
   	<div class="field-wrap">
            <label>
              Mobile Number<span class="req">*</span>
            </label>
            <input type="number" name="MobileNumber" required autocomplete="off"/>
          </div>
        
          
          <div class="field-wrap size">
            <label>
             Security Question <span class="req">*</span>
              </label>
         <select class="field-wrap drop-down" name="SecurityQuestion">
		<option>Select Security Question</option>
		<option value="fathername">what is your father's name?</option>
		<option value="mothername">what is your mother's name?</option>
		<option value="friendname">what is your friend's name?</option>
		<option value="DOB">what is your DOB?</option>
		</select>
          </div>
          
           <div class="field-wrap">
            <label>
            Security Answer<span class="req">*</span>
            </label>
            <input type="text" name="SecurityAnswer" required autocomplete="off"/>
          </div>
          
          <div class="field-wrap">
            <label>
              Password<span class="req">*</span>
            </label>
            <input type="password" name="Password" required autocomplete="off"/>
          </div>

          <button type="submit" class="button button-block" onclick="form.action='UserServlet'"/>SAVE</button>
          
          </form>

        </div><br>
          <button class="button button-block" onclick="window.location.href='register.jsp'"/>CANCEL</button>
          
          </form>

        </div>
        
      </div><!-- tab-content -->
      
</div> <!-- /form -->
    <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
    <script src="registerjs.js"></script>

</body>
</html>