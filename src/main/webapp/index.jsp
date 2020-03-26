<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%
    pageContext.setAttribute("cpt", request.getContextPath());
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>首页</title>
    <link href="${cpt}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${cpt}static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${cpt}/static/js/jquery-3.1.1.js"></script>
</head>
<body>
    <div class="container">
        <!--标题-->
        <div class="row">
            <div class="col-md-12">
                <h1>ssm_crud</h1>
            </div>
        </div>

        <!--按钮-->
        <div class="row">
            <div class="col-md-4 col-md-offset-8">
                <button class="btn btn-primary">新增</button>
                <button class="btn btn-danger">删除</button>
            </div>
        </div>

        <!--表格数据-->
        <div class="row">
            <div class="col-md-12">
                <table id="emps_table" class="table table-hover">
                    <thead>
                        <tr>
                            <th>id</th>
                            <th>empName</th>
                            <th>gender</th>
                            <th>email</th>
                            <th>deptName</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>

                    </tbody>
                </table>
            </div>
        </div>

        <!--分页条-->
        <div class="row">
            <div class="col-md-6">
                当前第 页，总共 页，总共 记录数
            </div>
            <div class="col-md-6">

            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(function () {
            $.ajax({
                url:"${pageScope.cpt}/getEmployeesByJson",
                data:"pn=1",
                type:"GET",
                success:function (result) {
                    build_employees_table(result);
                    build_employees_navigation(result);
                },
                error:function (result) {
                    if(result.code == 200){
                        alert("失败");
                    }
                }
            });
        });

        /**
         * 构建员工信息列表
         * @param result ajax返回的数据
         */
        function build_employees_table(result) {
            var employees = result.extend.pageInfo.list;
            $(employees).each(function (index, element) {
                var empIdTd = $("<td></td>").append(element.empId);
                var empNameTd = $("<td></td>").append(element.empName);
                var genderTd = $("<td></td>").append(element.gender == "1" ? "男" : "女");
                var emailTd = $("<td></td>").append(element.email);
                var deptNameTd = $("<td></td>").append(element.department.deptName);
                var editBtn = $("<button></button>").
                    addClass("btn btn-primary btn-sm").
                    append("<span></span>").
                    addClass("glyphicon glyphicon-pencil").
                    append("编辑");
                var deleteBtn = $("<button></button>").
                    addClass("btn btn-danger btn-sm").
                    append("<span></span>").
                    addClass("glyphicon glyphicon-trash").
                    append("删除");
                var btnTd = $("<td></td>").append(editBtn).append(" ").append(deleteBtn);
                $("<tr></tr>").
                    append(empIdTd).
                    append(empNameTd).
                    append(genderTd).
                    append(emailTd).
                    append(deptNameTd).
                    append(btnTd).
                    appendTo("#emps_table tbody");
            });
        }

        function build_page_info(result) {

        }

        function build_employees_navigation(result) {

        }
    </script>
</body>
</html>
