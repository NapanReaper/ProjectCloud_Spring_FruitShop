<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <jsp:include page="../header.jsp"></jsp:include>
        <body style="background-color: yellowgreen">
        <center>
            <h4><a href="../index" style="color: #ffffff">Home page</a></h4>
            <div style="text-align: center;margin: 30px;padding: 30px;border: 2px;height: 300px;width: 400px; background-color: #ffffff">
                <form method="post" action="<c:url value='/j_spring_security_check'/>">
                <table>
                    <tr>
                        <td colspan="2" style="color: red">${message}</td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <input style="width: 300px; margin: 10px" type="username" name="username" class="form-control" id="username" placeholder="username"></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <input style="width: 300px; margin: 10px" type="password" name="password" class="form-control" id="password" placeholder="password">
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><button type="submit" class="btn btn-primary" style="width: 300px; margin: 10px">Submit</button></td>
                    </tr>
                </table>
            </form>
            Not registered?<a href="${pageContext.request.contextPath}/auth/register">Create an account</a>
        </div>
    </center>   
</body>
</html>
