<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
    <jsp:include page="../header.jsp"></jsp:include>

        <body>
        <jsp:include page="../nav.jsp"></jsp:include>
            <h1>Create category</h1>
        <form:form method="post" action="./create" modelAttribute="product">

            <div class="col-md-9">
                <table>
                    <tr>
                        <td><form:label path="id">ID</form:label></td>
                        <td><form:input path="id" readonly="true"/></td>
                    </tr>
                    <tr>
                        <td><form:label path="name">Name</form:label></td>
                        <td><form:input path="name"/><form:errors path="name" cssStyle="color:red;display:block"/></td>
                    </tr>
                    
                </table>
                    <input style="width: 150px; margin-left: 50px; margin-top: 20px; " type="submit" class="btn btn-outline-info btn-block" value="Xác Nhận">

            </form:form>
            <a style="width: 150px; margin-left: 50px;" href="../home/index" class="btn btn-outline-info btn-block">Hủy</a>
        </div>
    </body>
</html>
