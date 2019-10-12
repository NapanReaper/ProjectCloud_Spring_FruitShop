<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
    <jsp:include page="../header.jsp"></jsp:include>

        <body>
        <jsp:include page="../nav.jsp"></jsp:include>
            <div class="container" id="append-body">

                <div class="row">
<%--                    <div class="col-md-3">
                        <div class="lead">
                            <a href="${pageContext.request.contextPath}/add-user" 
                           class="btn btn-outline-info">Add User</a>
                        </div>
                    </div>--%>
                <div class="col-md-12">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">Username</th>
                                <th scope="col">Email</th>
                                <th scope="col">Phone</th>
                                <th scope="col">Registered date</th>
                                <th scope="col">Status</th>
                                <th scope="col">Option</th>
                            </tr>
                        </thead>
                        <tbody>
                        <s:if test="listuser.size() > 0">
                            <c:forEach var="row" items="${listuser}">
                                <tr>
                                    <th scope="row">${row.user_id.user_id}</th>
                                    <td>${row.user_id.username}</td>
                                    <td>${row.user_id.email}</td>
                                    <td>${row.user_id.phone}</td>
                                    <td>${row.user_id.birthday}</td>
                                    <c:if test="${row.user_id.enabled == 1}">
                                        <td>Active</td>
                                    </c:if>
                                    <c:if test="${row.user_id.enabled == 0}">
                                        <td>Banned</td>
                                    </c:if>
                                    <td>
                                        <div class="inner"><a href="${pageContext.request.contextPath}/edit-user?user_id=${row.user_id.user_id}" class="btn btn-info">Edit</a> </div>                       
                                        <div class="inner">
                                            <c:if test="${row.user_id.enabled == 1}">
                                                <button class="btn btn-danger" onclick="removeUser(${row.user_id.user_id})" style="margin-left: 10px;">Ban</button>
                                            </c:if>
                                            <c:if test="${row.user_id.enabled == 0}">
                                                <button class="btn btn-success" onclick="unbanUser(${row.user_id.user_id})" style="margin-left: 10px;">Unban</button>
                                            </c:if>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </s:if>
                        </tbody>
                    </table>
                        
                </div>
            </div>
    </body>
</html>

<script>
    function removeUser(user_id) {
        var c = confirm("Are you sure to ban this user");
        if (c) {
            $.ajax({
                type: 'POST',
                url: "../removeUser",
                data: {user_id: user_id},
                success: function (a) {
                    alert(a.message);
                    if (a.status) {
                        showUser();
                    }
                }
            });
        }
    }

    function unbanUser(user_id) {
        var c = confirm("Are you sure to unban this user");
        if (c) {
            $.ajax({
                type: 'POST',
                url: "../unbanUser",
                data: {user_id: user_id},
                success: function (a) {
                    alert(a.message);
                    if (a.status) {
                        showUser();
                    }
                }
            });
        }
    }

    function showUser() {
        $.ajax({
            url: '../usermanagement',
            type: 'GET',
            success: function (response) {
                $('#append-body').html(response);
            }
        });
    }
</script>
