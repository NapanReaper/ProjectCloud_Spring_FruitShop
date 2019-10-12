<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Detail Page</title>
    </head>
    <jsp:include page="../header.jsp"></jsp:include>
        <body>
        <jsp:include page="../nav.jsp"></jsp:include>
            <!-- Page Content -->
            <div class="container">

                <div class="row">

                    <div class="col-md-3">
                        <p class="lead">Shop Name</p>
                        <div class="list-group">
                        <c:forEach items="${listCate}" var="item">
                            <a href="./index?keyword=&id=${item.id}" class="list-group-item">${item.name}</a>
                        </c:forEach>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="thumbnail">
                        <h4><b>${product.name}</b></h4>
                    <div style="background-color: darkgray"><img style="margin: 1px; width: 348px;" src="${product.thumnail}" alt="Preview not available"></div>
                    </div>
                </div>
                    <div class="caption-full" style="width: 300px">
                    <h4 style="color: red">${product.price} $</h4>
                    <p style="color: blue">${product.description}</p>
                    <h4>Amount: ${product.amount} </h4>
                    <a href="${pageContext.request.contextPath}/shop/order?productId=${product.id}&quantity=1" class="btn btn-outline-success btn-block">Buy Now</a>
                    <a href="${pageContext.request.contextPath}/index" class="btn btn-outline-info btn-block">Continue Shopping</a>
                </div>
            </div>
        </div>       
    </body>
</html>
