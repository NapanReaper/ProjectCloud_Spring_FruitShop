<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                        <div class="list-group">
                            <a href="#" class="list-group-item active">Category 1</a>
                            <a href="#" class="list-group-item">Category 2</a>
                            <a href="#" class="list-group-item">Category 3</a>
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
                        </div>

                    </div>

                </div>

            </div>

        </div>       
        <jsp:include page="../footer.jsp"></jsp:include>
    </body>
</html>
