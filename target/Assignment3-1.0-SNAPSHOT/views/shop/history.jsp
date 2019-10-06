<%-- 
    Document   : index
    Created on : Mar 22, 2019, 7:25:15 PM
    Author     : Duylm
--%>

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
                    <s:if test="history.size() > 0">

                    <c:forEach var="row" items="${history}">
                        <div class="card-body">
                            <!-- PRODUCT -->
                            <div class="row">
                                <div class="col-md-5">
                                    <h4 class="product-name"><strong>${row.product.name}</strong></h4>
                                    <h4>
                                        <small>${row.order.datepay}</small>
                                    </h4>
                                </div>
                                <div class="col-md-5 text-md-right row">
                                    <div class="col-md-3 text-md-right">
                                        <h6><strong>${row.product.price}$ x</strong></h6>
                                    </div>
                                    <div class="col-md-2">
                                        <h6>${row.quantity}</h6>
                                    </div>

                                </div>
                            </div>
                            <hr>
                            <!-- END PRODUCT -->  
                        </c:forEach>
                    </div>

                </s:if>
            </div>
        </div>

    </body>
</html>
