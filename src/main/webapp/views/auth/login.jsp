<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <jsp:include page="../header.jsp"></jsp:include>
        <body>
        <center>
            <h2>Login here</h2><br/>
            <div style="text-align: center;padding: 30px;border: 2px solid green;width: 400px;">
                <form method="post" action="<c:url value='/j_spring_security_check'/>">
                <table>
                    <tr>
                        <td colspan="2" style="color: red">${message}</td>
                    </tr>
                    <tr>
                        <td>Username: </td>
                        <td>
                            <input type="username" name="username" class="form-control" id="username" placeholder="username"></td>
                    </tr>
                    <tr>
                        <td>Password: </td>
                        <td>
                            <input type="password" name="password" class="form-control" id="password" placeholder="password">
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><button type="submit" class="btn btn-primary">Submit</button></td>
                    </tr>

                </table>
            </form>
        </div>
        <a href="${pageContext.request.contextPath}/auth/register">Create New Account !!!</a>
    </center>   
</body>
</html>
