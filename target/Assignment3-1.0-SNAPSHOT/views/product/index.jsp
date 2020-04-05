<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
    <jsp:include page="../header.jsp"></jsp:include>

    <body>
        <jsp:include page="../nav.jsp"></jsp:include>
            <!-- Page Content -->
            <div class="container">
                <div class="row">
                    <div class="col-md-3">
                        <p class="lead">Categories</p>
                        <div class="list-group">
                        <c:forEach items="${listCate}" var="item">
                            <a href="./index?keyword=&id=${item.id}" class="list-group-item">${item.name}</a>
                        </c:forEach>
                    </div>
                </div>
                <div class="col-md-9">
                    <div id="demo" class="carousel slide" data-ride="carousel">
                        <!-- Indicators -->
                        <ul class="carousel-indicators">
                            <li data-target="#demo" data-slide-to="0" class="active"></li>
                            <li data-target="#demo" data-slide-to="1"></li>
                            <li data-target="#demo" data-slide-to="2"></li>
                        </ul>

                        <!-- Left and right controls -->
                        <a class="carousel-control-prev" href="#demo" data-slide="prev">
                            <span class="carousel-control-prev-icon"></span>
                        </a>
                        <a class="carousel-control-next" href="#demo" data-slide="next">
                            <span class="carousel-control-next-icon"></span>
                        </a>
                    </div>
                    <!-- Search Filter -->
                    <div class="row">
                        <div class="col-md-12" style="margin-top:10px; margin-bottom: 10px;">
                            <form:form action="index" method="GET" modelAttribute="product" enctype="multipart/form-data">
                                <div class="col-md-6 float-left">
                                    <input class="form-control" id="keyword" name="keyword" value="${keyword}" placeholder="Nhập từ khóa..." >
                                </div>
                                <div class="col-md-4 float-left">
                                    <form:select path="id" class="form-control" >
                                        <option value="-1">Select a type</option>
                                        <c:forEach items="${listCate}" var="item">
                                            <c:if test="${item.id eq id}">
                                                <option value="${item.id}" selected>${item.name}</option>
                                            </c:if>
                                            <c:if test="${item.id gt id || item.id lt id}">
                                                <option value="${item.id}">${item.name}</option>
                                            </c:if>
                                        </c:forEach>
                                    </form:select>
                                </div>
                                <div class="col-md-2 float-left">
                                    <input type="submit" value="Search" class="btn btn-outline-primary btn-block"/>
                                </div> 
                            </form:form>
                        </div>
                        <!-- /Search Filter -->
                    </div>  
                    <!-- Show Items -->
                    <div class="row">
                        <div class="col-md-12">
                            <s:if test="listProduct.size() > 0">
                                <c:forEach var="row" items="${listProduct}">
                                    <div class="col-md-4 float-left" style="margin-bottom: 20px;">
                                        <div class="card" style=" padding: 0px;">
                                            <c:if test="${empty row.thumnail}">
                                                <img class="card-img-top product-row-thumbnail" alt="Preview not available" src="/image/800x400.png" width="100%" height="150px"/>
                                            </c:if>
                                            <c:if test="${not empty row.thumnail}">
                                                <a href="${pageContext.request.contextPath}/details?id=${row.id}"><img class="card-img-top product-row-thumbnail" alt="Preview not available" src="${row.thumnail}" width="100%" height="150px"/></a>
                                            </c:if>
                                            <div class="card-body" style="padding-bottom: 5px;">
                                                <h5><c:out value="${row.name}"/></h5>
                                                <h5 style="color: red; ">$<c:out value="${row.price}"/></h5>
                                                <input id="id" type="hidden" value="<c:out value="${row.id}"/>"/>
                                                <sec:authorize access="!hasRole('ROLE_ADMIN')">
                                                    <a href="${pageContext.request.contextPath}/shop/order?productId=${row.id}&quantity=1" class="btn btn-success">Buy Now</a>
                                                </sec:authorize>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                                <div class="col-md-12 d-flex justify-content-center">
                                    <c:if test="${(page eq 0) && (pageSize gt 1)}">
                                        <ul class="pagination">
                                            <li class="page-item"><a class="page-link" >${page+1}/${pageSize}</a></li>
                                            <li class="page-item"><a class="page-link" href="./index?page=${page+1}&keyword=${keyword}&id=${id}">Next</a></li>
                                        </ul>
                                    </c:if>        
                                    <c:if test="${(page gt 0) && (page+1 lt pageSize) && (pageSize gt 1)}">
                                        <ul class="pagination">
                                            <li class="page-item"><a class="page-link" href="./index?page=${page-1}&keyword=${keyword}&id=${id}">Previous</a></li>
                                            <li class="page-item"><a class="page-link" >${page+1}/${pageSize}</a></li>
                                            <li class="page-item"><a class="page-link" href="./index?page=${page+1}&keyword=${keyword}&id=${id}">Next</a></li>
                                        </ul>
                                    </c:if>
                                    <c:if test="${(page+1 == pageSize) && (pageSize gt 1)}">
                                        <ul class="pagination">
                                            <li class="page-item"><a class="page-link" href="./index?page=${page-1}&keyword=${keyword}&id=${id}">Previous</a></li>
                                            <li class="page-item"><a class="page-link" >${page+1}/${pageSize}</a></li>
                                        </ul>
                                    </c:if>
                                </div>
                            </s:if>
                            <c:if test="${listProduct.size() == 0}">
                                <p style="opacity: 5px; text-align: center; font-size: 40px">
                                    Have no product, try another one!
                                </p>
                            </c:if>
                        </div>
                    </div>
                    <!-- /Show Items -->
                </div>
            </div>
        </div>
        <!-- /.container -->
        <jsp:include page="../footer.jsp"></jsp:include>
</html>

