<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
    <jsp:include page="../header.jsp"></jsp:include>

        <body>
        <jsp:include page="../nav.jsp"></jsp:include>
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <h1>Edit category</h1>
                    <form:form method="post" action="./edit" modelAttribute="product">
                        <table>
                            <tr>
                                <td></td>
                                <td><form:input path="id" readonly="true" type="hidden"/></td>
                            </tr>
                            <tr>
                                <td><form:label path="name">Name</form:label></td>
                                <td><form:input path="name"/><form:errors path="name" cssStyle="color:red;display:block"/></td>
                            </tr>
                        </table>
                        <input type="submit" style="margin-left: 10px;" class="btn btn-info" value="Save">
                        <a href="${pageContext.request.contextPath}/home/index" class="btn btn-secondary">Cancel</a>
                    </form:form>
                </div>
            </div>
        </div>
    </body>
</html>
