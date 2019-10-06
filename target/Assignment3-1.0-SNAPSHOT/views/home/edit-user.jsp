<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
    <jsp:include page="../header.jsp"></jsp:include>
        <body>
        <jsp:include page="../nav.jsp"></jsp:include>


            <div class="container">

                <div class="row">

                    <div class="col-md-3">
                        <p class="lead">Update User</p>
                        <div class="list-group">
                        </div>
                    </div>

                    <div class="col-md-5">
                        <div style="color: red">${error}</div>
                    
                    <form:form method="post" action="${pageContext.request.contextPath}/edit-user" modelAttribute="user">
                        <form:hidden path="user_id"/>
                        <form:hidden path="password"/>
                        <form:hidden path="birthdate"/>
                        <form:hidden path="enabled"/>
                        <div class="form-group">
                            <label><b>Username</b></label>
                            <form:input type="text" maxlength="50" path="username"
                                        class="form-control" placeholder="Username"/>
                            <form:errors path="username" cssStyle="color:red;display:block"/>
                        </div>
                        <div class="form-group">
                            <label><b>Email</b></label>
                            <form:input type="text" maxlength="50" path="email" 
                                        class="form-control" placeholder="Email"/>
                        </div>
                        <div class="form-group">
                            <label><b>Phone</b></label>
                            <form:input type="text" maxlength="50" path="phone" 
                                        class="form-control" placeholder="Phone"/>
                        </div>
                        
                        <div class="form-group">
                            <button type="submit" class="btn btn-primary">Submit Button</button>

                            <a href="#" class="btn btn-primary">Reset Button</a>
                        </div>
                    </form:form>
                </div>

            </div>

        </div>
        <jsp:include page="../footer.jsp"></jsp:include>
    </body>
</html>

