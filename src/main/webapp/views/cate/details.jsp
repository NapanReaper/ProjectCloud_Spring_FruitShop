<%-- 
    Document   : index
    Created on : Mar 5, 2019, 4:46:12 PM
    Author     : VuHH4
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>JSP Page</title>
            <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
            <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport'/>
            <meta name="viewport" content="width=device-width"/>
        </head>
        <body>
            <a href="index" style="color: red">Back</a>
            <h1>Thong Tin</h1>
            <table border="1">
                <tr>
                    <td>Id : </td>
                    <td>${category.id}</td>
            </tr>
            <tr>
                <td>Name : </td>
                <td>${category.name}</td>
            </tr>
        </table>
    </body>
</html>
