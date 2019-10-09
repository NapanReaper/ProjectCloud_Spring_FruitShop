<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <jsp:include page="../header.jsp"></jsp:include>
        <body>
        <jsp:include page="../nav.jsp"></jsp:include>
            <div class="container">
                <div class="card shopping-cart">
                    <div class="card-header bg-dark text-light">
                        <a href="../index" class="btn btn-outline-info btn-sm pull-right">Continue shopping</a>
                        <div class="clearfix"></div>
                    </div>
                <%--<c:if test="${sessionScope.history != null}">--%>     
                <c:if test="${history != null}" var="testHistory">
                    <div>
                        <c:forEach var="row" items="${history}">
                            <strong>Order's ${row.id}</strong>
                            <small>${row.dateCreate}</small>
                            <c:forEach var="item" items="${row.listOrderDetail}">
                                <p>Product name: ${item.product.name}</p>
                                <p>Price: ${item.price}</p>
                                <p>Quantity: ${item.quantity}</p>
                            </c:forEach>
                        </c:forEach>
                        <!-- END PRODUCT -->  
                    </div>
                </div>
            </div>
        </c:if>
        <c:if test="${not testHistory}">
            Buy something!
        </c:if>
    </body>
</html>
