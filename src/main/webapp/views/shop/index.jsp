<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                        <i class="fa fa-shopping-cart" aria-hidden="true"></i>
                        Shopping cart
                        <a href="../index" class="btn btn-outline-info btn-sm pull-right">Continue shopping</a>
                        <div class="clearfix"></div>
                    </div>
                <c:if test="${myCart != null}" var="testCart">
                    <!--<s:if test="myCart.size() > 0">-->
                    <fmt:setLocale value = "en_US"/>
                    <div class="card-body">
                        <c:forEach var="row" items="${myCart}">
                            <!-- PRODUCT -->
                            <div class="row">
                                <div class="col-md-2 text-center">
                                    <img class="img-responsive" src="${row.product.thumnail}" alt="prewiew" width="120" height="80">
                                </div>
                                <div class="col-md-5">
                                    <h4 class="product-name"><strong>${row.product.name}</strong></h4>
                                    <h4>
                                        <small>${row.product.description}</small>
                                    </h4>
                                </div>
                                <div class="col-md-5 text-md-right row">
                                    <div class="col-md-3 text-md-right">
                                        <h6>
                                            <strong>
                                                <fmt:formatNumber value = "${row.product.price}" type = "currency"/>
                                            </strong>
                                        </h6>
                                    </div>
                                    <div class="col-md-2">
                                        <h6>${row.quantity}</h6>
                                    </div>
                                    <div id="outer" class="col-md-7 text-right">
                                        <div class="inner"><a href="./order?productId=${row.product.id}&quantity=1" class="btn btn-primary">+</a></div> 
                                        <div class="inner"><a href="./order?productId=${row.product.id}&quantity=-1" class="btn btn-warning">-</a></div> 
                                        <div class="inner"><a href="./remove?productId=${row.product.id}" class="btn btn-danger">Remove</a></div>
                                    </div>
                                </div>
                                <!-- END PRODUCT -->  
                            </div>
                        </c:forEach>
                        <div class="card-footer">
                            <div class="pull-right" style="margin: 10px">
                                <sec:authentication var="principal" property="principal"/>
                                <a href="./payment?user=${principal.username}" class="btn btn-success pull-right">Checkout</a>
                                <div class="pull-right" style="margin: 5px">
                                    <b>Total price: <fmt:formatNumber value="${total}" type = "currency"/></b>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
                <c:if test="${not testCart}">
                    Buy something!
                </c:if>
            </div>
        </div>
    </body>
</html>
