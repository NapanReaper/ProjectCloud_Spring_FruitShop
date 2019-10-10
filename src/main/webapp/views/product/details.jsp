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
                <div class="col-md-9">
                    <div class="thumbnail">
                        <img class="img-responsive" src="${product.thumnail}" alt="Preview not available">
                        <div class="caption-full">
                            <h4 class="float-right">${product.price} $</h4>
                            <h4><b>${product.name}</b>
                            </h4>
                            <h4>Description:</h4>
                            <p>${product.description}</p>
                            <h4>Amount: ${product.amount} </h4>
                            <h4>Category: ${product.category.name} </h4>
                            <a href="${pageContext.request.contextPath}/shop/order?id=${product.id}&quantity=1" class="btn btn-outline-info btn-block">Add to card</a>
                            <a href="${pageContext.request.contextPath}/index" class="btn btn-outline-info btn-block">Return</a>
                        </div>

                    </div>

                </div>

            </div>

        </div>       
        <jsp:include page="../footer.jsp"></jsp:include>
    </body>
</html>
