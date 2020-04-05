<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
    <jsp:include page="../header.jsp"></jsp:include>
        <script type="text/javascript">
            function processImage() {
                // **********************************************
                // *** Update or verify the following values. ***
                // **********************************************

                let subscriptionKey = '451041a04eed43e299bbc0ff29c0d89e';
                let endpoint = 'https://testforanalyzeimage.cognitiveservices.azure.com/';
                if (!subscriptionKey) {
                    throw new Error('Set your environment variables for your subscription key and endpoint.');
                }

                var uriBase = endpoint + "vision/v2.1/analyze";

                // Request parameters.
                var params = {
                    "visualFeatures": "Categories,Description,Color",
                    "details": "",
                    "language": "en"
                };

                // Display the image.
                var sourceImageUrl = $("#inputImage").val();
                $("#sourceImage").show();
                $("#sourceImage").attr("src", sourceImageUrl);

                // Make the REST API call.
                $.ajax({
                    url: uriBase + "?" + $.param(params),

                    // Request headers.
                    beforeSend: function (xhrObj) {
                        xhrObj.setRequestHeader("Content-Type", "application/json");
                        xhrObj.setRequestHeader(
                                "Ocp-Apim-Subscription-Key", subscriptionKey);
                    },

                    type: "POST",

                    // Request body.
                    data: '{"url": ' + '"' + sourceImageUrl + '"}',
                })

                        .done(function (data) {
                            // Show formatted JSON on webpage.
//                            $("#responseTextArea").val(JSON.stringify(data, null, 2));
                            if (data.description.tags.includes('fruit')) {
                                alert(data.description.tags);
                                alert("This is a fruit Image");
                                $("#saveProduct").prop('disabled', false);
                            } else {
                                alert(data.description.tags);
                                alert("This is not a fruit Image");
                                $("#saveProduct").prop('disabled', true);
                            }

                        })

                        .fail(function (jqXHR, textStatus, errorThrown) {
                            // Display error message.
                            var errorString = (errorThrown === "") ? "Error. " :
                                    errorThrown + " (" + jqXHR.status + "): ";
                            errorString += (jqXHR.responseText === "") ? "" :
                                    jQuery.parseJSON(jqXHR.responseText).message;
                            alert(errorString);
                        });
            }
            ;
        </script>
        <body>
        <jsp:include page="../nav.jsp"></jsp:include>
            <div class="container">
                <div class="row">
                    <div class="col-md-9">

                        <div class="thumbnail">
                        <form:form method="post" action="./create" modelAttribute="product" enctype="multipart/form-data">
                            <img src="${product.thumnail}" alt="" style="width: 110px !important; height: 100px">
                            <div class="caption-full">
                                <table>
                                    <tr>
                                        <td><form:label path="name">Name</form:label></td>
                                            <td>
                                            <form:input path="name"/>
                                            <form:errors path="name" cssStyle="color:red;display:block"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><form:label path="description">Description</form:label></td>
                                        <td><form:input path="description"/></td>
                                    </tr>
                                    <tr>
                                        <td><form:label path="price">Price</form:label></td>
                                            <td>
                                            <form:input path="price" type="number" step="0.01"/>
                                            <form:errors path="price" cssStyle="color:red;display:block"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><form:label path="amount">Amount</form:label></td>
                                            <td>
                                            <form:input path="amount" type="number"/>
                                            <form:errors path="amount" cssStyle="color:red;display:block"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><form:label path="thumnail">Thumbnail</form:label></td>
                                        <td><form:input path="thumnail" name="inputImage" id="inputImage" onchange="processImage()"/>
                                            <img id="sourceImage" width="200px" height="200px"  style="display: none"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><form:label path="category.id">Category</form:label><br/></td>
                                            <td>
                                            <form:select path="category.id">
                                        <option value="-1">Select a type</option>
                                        <c:forEach items="${listCate}" var="item">
                                            <c:choose>
                                                <c:when test="${item.id == product.category.id}">
                                                    <option value="${item.id}" selected="true">
                                                        ${item.name}
                                                    </option>
                                                </c:when>
                                                <c:otherwise>
                                                    <option value="${item.id}">
                                                        ${item.name}
                                                    </option>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </form:select>
                                    <span style="color: red">${errorCate}</span>
                                    </td>
                                    </tr>
                                </table>
                                <input type="submit" class="btn btn-info" value="Save" id="saveProduct">

                            </form:form>
                            <a href="${pageContext.request.contextPath}/home/index" class="btn btn-secondary">Cancel</a>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <!--</div>-->
        <jsp:include page="../footer.jsp"></jsp:include>
</html>
