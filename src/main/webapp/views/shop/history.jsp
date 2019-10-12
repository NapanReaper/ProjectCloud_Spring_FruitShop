<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <jsp:include page="../header.jsp"></jsp:include>
        <title>History Admin Page</title>
        <script>
            $(document).ready(function () {
                update_amounts();
                update_total_amounts();
                loadDetail();
                hideDetail();
            });
            // Update subtotal price on quantity 
            function update_amounts() {
                $('.cart-row').each(function () {
                    var st = 0;
                    var i = $('.cart-variant--quantity_input', this);
                    var up = $(i).data('unit-price');
                    var q = $(i).val();
                    st = up * q;
                    $('.subPriceValue', this).val(st);
                    // Subtotal price
                    $(".subPriceShow", this).html("Total Price: $" + st);
                });
            }
            function update_total_amounts() {
                $('.cart-test').each(function () {
                    var tt = 0;
                    $('.cart-row', this).each(function () {
                        var i = $('.subPriceValue', this);
                        var q = parseFloat($(i).val());
                        tt = tt + q;
                    });
                    // Total price
                    $(".totalPrice", this).html("Total: $" + tt);
                });
            }
            function loadDetail() {
                $('.cart-test').each(function () {
                    $('.show-detail', this).click(function () {
                        $('.cart-test').each(function () {
                            var i = $('.cart-row', this);
                            var e = $('.hide-detail', this);
                            $(i).show();
                            $(e).show();
                            return false;
                        });
                    });
                });
            }
            function hideDetail() {
                $('.cart-test').each(function () {
                    $('.hide-detail', this).click(function () {
                        $('.cart-test').each(function () {
                            var i = $('.cart-row', this);
                            $(i).hide();
                            var e = $('.float-right', this);
                            $(e).hide();
                            return false;
                        });
                    });
                });
            }
        </script>
        <body>
        <jsp:include page="../nav.jsp"></jsp:include>
            <div class="container">
                <div class="card shopping-cart">
                    <div class="card-header bg-dark text-light">
                        <a href="../index" class="btn btn-outline-info btn-sm pull-right">Continue shopping</a>
                        <div class="clearfix"></div>
                    </div>
                <c:if test="${history != null}" var="testHistory">
                    <c:forEach var="row" items="${history}" varStatus="counter">
                        <div class="cart-test">
                            <div class="row align-items-center cart">
                                <div class="col-2 show-detail">
                                    <button type="button" class="btn btn-link">Order's ${row.id}</button>
                                </div>
                                <div class="col-4">
                                    <h4>
                                        Date: <fmt:formatDate type="both" value="${row.dateCreate}"/>
                                    </h4>
                                </div>
                                <div class="col-3">
                                    <h4 class="totalPrice">
                                    </h4>
                                </div>
                                <sec:authorize access="hasRole('ROLE_ADMIN')">
                                    <div class="col-2">
                                        <h5>Owner: ${row.user.username}</h4>
                                    </div>
                                </sec:authorize>
                                <div class="float-right hide-detail" style="display: none">
                                    <button type="button" class="btn btn-link">Hide</button>
                                </div>
                            </div>
                            <c:forEach var="item" items="${row.listOrderDetail}" varStatus="counter">
                                <div class="row align-items-center cart-row" style="display: none">
                                    <input type="hidden" value="${item.quantity}" 
                                           data-unit-price="${item.price}" 
                                           class="cart-variant--quantity_input">
                                    <div class="col-2" style="border-image: 1">
                                        <img alt="test" width="100px" height="100px"
                                             src="${item.product.thumnail}"> 
                                    </div>
                                    <div class="col-3">
                                        <h5>Product name: ${item.product.name}</h5>
                                    </div>
                                    <div class="col-2">
                                        <h5> Quantity: ${item.quantity}</h5>
                                    </div>
                                    <div class="col-2">
                                        <h5>Price: <fmt:formatNumber value="${item.price}" type="currency" /></h5>
                                    </div>
                                    <div class="col-3">
                                        <input class="subPriceValue" type="hidden"/>
                                        <h5 class="subPriceShow">
                                        </h5>
                                        <h6 class="totalPriceShow"></h6>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:forEach>
                    <!-- END PRODUCT -->  
                </c:if>
            </div>
        </div>
        <c:if test="${not testHistory}">
            <div>
                <h3>    
                    Buy something!
                </h3>
            </div>                
        </c:if>
    </body>
</html>
