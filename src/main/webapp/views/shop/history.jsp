<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
                    <c:forEach var="row" items="${history}">
                        <div class="row align-items-center">
                            <div class="col-2">
                                <h4>Order's ${row.id}</h4>
                            </div>
                            <div class="col-2">
                                <h5>${row.dateCreate}</h4>
                            </div>
                            <sec:authorize access="hasRole('ROLE_ADMIN')">
                                <div class="col-2">
                                    <h5>Owner: ${row.user.username}</h4>
                                </div>
                            </sec:authorize>
                        </div>
                        <c:forEach var="item" items="${row.listOrderDetail}">
                            <div class="row align-items-center" >
                                <div class="col-2">
                                    <img alt="test" width="100%" height="100px"
                                         src="${item.product.thumnail}"> 
                                </div>
                                <div class="col-3">
                                    <h5>Product name: ${item.product.name}</h5>
                                </div>
                                <div class="col-3">
                                    <h5>Quantity: ${item.quantity}</h5>
                                </div>
                                <div class="col-4">
                                    <h5>Quantity: ${item.price}</h5>
                                </div>
                            </div>
                        </c:forEach>
                    </c:forEach>
                    <!-- END PRODUCT -->  
                </c:if>
            </div>
        </div>
        <c:if test="${not testHistory}">
            Buy something!
        </c:if>
    </body>
</html>
