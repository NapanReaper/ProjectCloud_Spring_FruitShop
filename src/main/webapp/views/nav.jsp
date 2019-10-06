<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-sm bg-dark navbar-dark fixed-top">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="#">HM10</a>
            </div>
            <ul class="nav navbar-nav">
                <li class="active"><a href="${pageContext.request.contextPath}/index">Home</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li style="margin-right: 10px">
             
                </li>
                <li style="margin-right: 10px">
                <sec:authorize access="hasRole('ROLE_ADMIN')">
                    <a href="${pageContext.request.contextPath}/home/usermanagement"><span class="glyphicon glyphicon-user"></span>
                       Manage User
                    </a>
                </sec:authorize>
                </li>
                <li style="margin-right: 10px">
                <sec:authorize access="hasRole('ROLE_ADMIN')">
                    <a href="${pageContext.request.contextPath}/home/"><span class="glyphicon glyphicon-user"></span>
                       Admin Page
                    </a>
                </sec:authorize>
                </li>
                <li style="margin-right: 10px">
                    <sec:authentication var="principal" property="principal"/>
                <sec:authorize access="isAuthenticated()">
                    <a href="${pageContext.request.contextPath}/shop/history?user=${principal.username}"><span class="glyphicon glyphicon-user"></span>
                       History
                    </a>
                </sec:authorize>
                </li>
                <li style="margin-right: 10px">
                <sec:authorize access="isAuthenticated()">
                    <sec:authentication var="principal" property="principal"/>
                    <a href="#"><span class="glyphicon glyphicon-user"></span>
                        Hello: ${principal.username}
                    </a>
                </sec:authorize>
                <sec:authorize access="!isAuthenticated()">
                    <a href="${pageContext.request.contextPath}/auth/register"><span class="glyphicon glyphicon-user"></span>
                        Sign up
                    </a>
                </sec:authorize>
                </li>
                <li style="margin-left: 10px">
                <c:url value="/j_spring_security_logout" var="logoutUrl" />
                <sec:authorize access="isAuthenticated()">
                    <a href="${logoutUrl}"><span class="glyphicon glyphicon-log-in"></span>
                        Log Out
                    </a>
                </sec:authorize>
                <sec:authorize access="!isAuthenticated()">
                    <a href="${pageContext.request.contextPath}/auth/login"><span class="glyphicon glyphicon-log-in"></span>
                      Login
                    </a>
                </sec:authorize>
                </li>         
            </ul>
        </div>
        <!-- /.container -->
    </nav>
</html>
