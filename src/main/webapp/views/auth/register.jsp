<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page language="java"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
    <jsp:include page="../header.jsp"></jsp:include>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Register form</title>
        </head>
        <body style="background-color: yellowgreen">
        <center>
            <div style="text-align: center;margin: 30px;padding: 30px;border: 2px;height: 450px;width: 400px; background-color: #ffffff">
            <form:form action="${pageContext.request.contextPath}/auth/register" method="POST" modelAttribute="user" enctype="multipart/form-data">
                <table>
                    <tr>
                    <div style="color: red">${error}</div>
                    </tr>
                    <tr>
                        <td><form:input path="username" class="form-control" placeholder="Username" style="width: 300px; margin: 10px"/></td>
                    </tr>
                    <tr>
                        <td><form:input type="password" placeholder="Password" path="password"  class="form-control" style="width: 300px; margin: 10px"/></td>
                    </tr>
                    <tr>
                        <td><form:input type="date" placeholder="Birthday" path="birthday"  class="form-control"  style="width: 300px; margin: 10px"/></td>
                    </tr>
                    <tr>
                        <td><form:input type="email" placeholder="Email" path="email"  class="form-control"  style="width: 300px; margin: 10px"/></td>
                    </tr>
                    <tr>
                        <td><form:input type="phone" placeholder="Phone" path="phone"  class="form-control"  style="width: 300px; margin: 10px"/></td>
                    </tr>
                    <td></td>
                    <tr>
                        <td><input style="width: 300px; margin: 10px" type="submit" name="Register" value="Register" class="btn btn-info btn-md"/></td>
                    </tr>
                </table>     
            </form:form>
            <a href="../auth/login">Login</a>
        </div>
    </center>   
</body>
</html>
