<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-sm bg-dark fixed-top">
        <div class="container-fluid">
            <div class="navbar-header">
                <img style="width: 50px; height: 50px" src="https://cdn4.vectorstock.com/i/1000x1000/35/93/fruit-shop-showcase-stand-with-fruits-vector-12633593.jpg">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/index">Fruit Shop</a>
            </div>
            <ul class="nav navbar-nav mr-auto">
                <li class="nav-link" style="margin-right: 10px">
                    <sec:authorize access="hasRole('ROLE_ADMIN')">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home/usermanagement"><span class="glyphicon glyphicon-user"></span>
                            Manage User
                        </a>
                    </sec:authorize>
                </li>
                <li class="nav-link" style="margin-right: 10px">
                    <sec:authorize access="hasRole('ROLE_ADMIN')">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home/"><span class="glyphicon glyphicon-user"></span>
                            Admin Page
                        </a>
                    </sec:authorize>
                    <sec:authorize access="hasRole('ROLE_USER')">
                        <a class="nav-link" href="${pageContext.request.contextPath}/shop/index">
                            <span class="glyphicon glyphicon-user"></span>
                            Cart
                        </a>
                    </sec:authorize>
                </li>
                <li class="nav-link" style="margin-right: 10px">
                    <sec:authentication var="principal" property="principal"/>
                    <sec:authorize access="hasRole('ROLE_USER')">
                        <a class="nav-link" href="${pageContext.request.contextPath}/shop/history?user=${principal.username}"><span class="glyphicon glyphicon-user"></span>
                            History
                        </a>
                    </sec:authorize>
                    <sec:authorize access="hasRole('ROLE_ADMIN')">
                        <a class="nav-link" href="${pageContext.request.contextPath}/shop/historyAdmin"><span class="glyphicon glyphicon-user"></span>
                            History
                        </a>
                    </sec:authorize>

                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">

                <li class="nav-link" style="margin-right: 10px; ">
                    <sec:authorize access="isAuthenticated()">
                        <sec:authentication var="principal" property="principal"/>
                        <a class="nav-link" href="#"><span class="glyphicon glyphicon-log-in"></span>
                            ${principal.username}
                        </a>
                    </sec:authorize>
                    <sec:authorize access="!isAuthenticated()">
                        <a style="color: #333" class="nav-link" href="${pageContext.request.contextPath}/auth/register"><span class="glyphicon glyphicon-user"></span>
                            Sign up
                        </a>
                    </sec:authorize>
                </li>
                <li class="nav-link" style="margin-left: 10px">
                    <c:url value="/j_spring_security_logout" var="logoutUrl" />
                    <sec:authorize access="isAuthenticated()">
                        <a class="nav-link" href="${logoutUrl}"><span class="glyphicon glyphicon-log-in"></span>
                            Log Out
                        </a>
                    </sec:authorize>
                    <sec:authorize access="!isAuthenticated()">
                        <a class="nav-link" href="${pageContext.request.contextPath}/auth/login"><span class="glyphicon glyphicon-log-in"></span>
                            Login
                        </a>
                    </sec:authorize>
                </li>         
            </ul>
        </div>
        <!-- /.container -->
    </nav>
</html>
