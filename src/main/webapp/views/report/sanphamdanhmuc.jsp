<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page  language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <jsp:include page="../header.jsp"></jsp:include>
        <body>
            <jsp:include page="../nav.jsp"></jsp:include>
            <h1>Thong Ke Danh muc</h1>
        <s:if test="listReportItem.size() > 0">
            <table border="1">
                <thead>
                    <tr>
                        <th>Danh muc</th>
                        <th>So luong</th>
                        <th>Tong Gia Tri</th>
                        <th>Gia Thap Nhat</th>
                        <th>Gia Cao Nhat</th>
                        <th>Trung binh</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach var="row" items="${listReportItem}">
                    <tr>
                        <td><c:out value="${row.group}"/></td>
                        <td><c:out value="${row.count}"/></td>
                        <td><c:out value="${row.sum}"/></td>
                        <td><c:out value="${row.min}"/></td>
                        <td><c:out value="${row.max}"/></td>
                        <td><c:out value="${row.avg}"/></td>

                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <hr/>
        <script type="text/javascript" src="https://www.google.com/jsapi"></script>
        <script type="text/javascript">
            google.load("visualization", "1", {packages: ["corechart"]});
            google.setOnLoadCallback(drawChart);
            function drawChart() {
                var data = google.visualization.arrayToDataTable([
                    ['danh muc', 'so luong'],
            <c:forEach var="row" items="${listReportItem}">
                    ['${row.group}',${row.count}],
            </c:forEach>
                ]);
                var options = {
                    title: 'So Luong',
                    is3D: true,
                }
                var chart = new google.visualization.PieChart(document.getElementById('piechart_count'));
                chart.draw(data, options);
            }
        </script>
        
        <script type="text/javascript">
            google.load("visualization", "1", {packages: ["corechart"]});
            google.setOnLoadCallback(drawChart);
            function drawChart() {
                var data = google.visualization.arrayToDataTable([
                    ['danh muc', 'tong so luong'],
            <c:forEach var="row" items="${listReportItem}">
                    ['${row.group}',${row.sum}],
            </c:forEach>
                ]);
                var options = {
                    title: 'Tong So Luong',
                    is3D: true,
                }
                var chart = new google.visualization.PieChart(document.getElementById('piechart_sum'));
                chart.draw(data, options);
            }
        </script>
        
        <script type="text/javascript">
            google.load("visualization", "1", {packages: ["corechart"]});
            google.setOnLoadCallback(drawChart);
            function drawChart() {
                var data = google.visualization.arrayToDataTable([
                    ['danh muc', 'max'],
            <c:forEach var="row" items="${listReportItem}">
                    ['${row.group}',${row.max}],
            </c:forEach>
                ]);
                var options = {
                    title: 'Gia tri lon nhat',
                    is3D: true,
                }
                var chart = new google.visualization.PieChart(document.getElementById('piechart_max'));
                chart.draw(data, options);
            }
        </script>
        
        <script type="text/javascript">
            google.load("visualization", "1", {packages: ["corechart"]});
            google.setOnLoadCallback(drawChart);
            function drawChart() {
                var data = google.visualization.arrayToDataTable([
                    ['danh muc', 'min'],
            <c:forEach var="row" items="${listReportItem}">
                    ['${row.group}',${row.min}],
            </c:forEach>
                ]);
                var options = {
                    title: 'Gia tri nho nhat',
                    is3D: true,
                }
                var chart = new google.visualization.PieChart(document.getElementById('piechart_min'));
                chart.draw(data, options);
            }
        </script>
        <script type="text/javascript">
            google.load("visualization", "1", {packages: ["corechart"]});
            google.setOnLoadCallback(drawChart);
            function drawChart() {
                var data = google.visualization.arrayToDataTable([
                    ['danh muc', 'avg'],
            <c:forEach var="row" items="${listReportItem}">
                    ['${row.group}',${row.avg}],
            </c:forEach>
                ]);
                var options = {
                    title: 'Gia tri trung binh',
                    is3D: true,
                }
                var chart = new google.visualization.PieChart(document.getElementById('piechart_avg'));
                chart.draw(data, options);
            }
        </script>
        <div id="piechart_count" style="width: 700px;height: 500px"></div>
        <div id="piechart_sum" style="width: 700px;height: 500px"></div>
        <div id="piechart_max" style="width: 700px;height: 500px"></div>
        <div id="piechart_min" style="width: 700px;height: 500px"></div>
        <div id="piechart_avg" style="width: 700px;height: 500px"></div>
    </s:if>
</body>
</html>
