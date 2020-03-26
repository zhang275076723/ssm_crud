<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%
    pageContext.setAttribute("cpt", request.getContextPath());
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>首页</title>
    <!--jQuery要放在Bootstrap之前-->
    <script type="text/javascript" src="${cpt}/static/js/jquery-3.1.1.js"></script>
    <link href="${cpt}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${cpt}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

    <!--员工添加模态框-->
    <div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel">员工添加</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label for="empName_input" class="col-sm-2 control-label">empName</label>
                            <div class="col-sm-10">
                                <input type="text" name="empName" class="form-control" id="empName_input" placeholder="请输入员工名">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="email_input" class="col-sm-2 control-label">email</label>
                            <div class="col-sm-10">
                                <input type="text" name="email" class="form-control" id="email_input" placeholder="请输入email">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">gender</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender_input_male" value="1" checked="checked">
                                    男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender_input_female" value="0">
                                    女
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="dept_add_select" class="col-sm-2 control-label">department</label>
                            <div class="col-sm-4">
                                <select class="form-control" name="dId" id="dept_add_select">

                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button id="emp_save_btn" type="button" class="btn btn-primary">保存</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>

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
                <button id="emp_add_modal_btn" class="btn btn-primary">新增</button>
                <button id="emp_delete" class="btn btn-danger">删除</button>
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
            <div id="page_info" class="col-md-6">

            </div>
            <div id="page_nav" class="col-md-6">

            </div>
        </div>
    </div>

    <script type="text/javascript">
        var totalPages;

        $(function () {
            pageChange(1);
        });

        //添加员工按钮，显示添加员工表单
        $("#emp_add_modal_btn").click(function () {
            //重置表单
            reset_form("#empAddModal form");

            //将查询到的部门信息显示在模态框中
            getDepartments("#dept_add_select");

            //显示模态框
            $("#empAddModal").modal({
                //点击模态框以外的地方，模态框不关闭
                backdrop:"static"
            });
        });

        //empName验证
        $("#empName_input").blur(function () {
            var empName = $("#empName_input").val();
            var regName = /(^[A-Za-z0-9_\u4e00-\u9fa5]{6,16}$)/;

            //清空提示信息
            $("#empName_input").next("span").empty();

            //清除错误红框
            $("#empName_input").parent().removeClass("has-error");

            if (empName == "") {
                $("#empName_input").parent().addClass("has-error");
                $("#empName_input").next("span").append("empName不能为空");
                $("#emp_save_btn").attr("empName_flag","0");
                return;
            }

            if (!regName.test(empName)) {
                $("#empName_input").parent().addClass("has-error");
                $("#empName_input").next("span").append("empName格式错误，必须是6-16位的汉字、英文、数字、下划线");
                $("#emp_save_btn").attr("empName_flag","0");
                return;
            }

            $.ajax({
                url:"${cpt}/checkEmpName",
                data:"empName=" + empName,
                type:"POST",
                success:function (result) {
                    if (result.code == 100) {
                        $("#emp_save_btn").attr("empName_flag","1");
                    }

                    if (result.code == 200) {
                        $("#empName_input").parent().addClass("has-error");
                        $("#empName_input").next("span").append("empName已存在");
                        $("#emp_save_btn").attr("empName_flag","0");
                    }
                },
                error:function () {
                    alert("系统错误");
                }
            });
        });

        //email验证
        $("#email_input").blur(function () {
            var email = $("#email_input").val();
            var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;

            //清空提示信息
            $("#email_input").next("span").empty();

            //清除错误红框
            $("#email_input").parent().removeClass("has-error");

            if (email == "") {
                $("#email_input").parent().addClass("has-error");
                $("#email_input").next("span").append("email不能为空");
                $("#emp_save_btn").attr("email_flag","0");
                return;
            }

            if (!regEmail.test(email)) {
                $("#email_input").parent().addClass("has-error");
                $("#email_input").next("span").append("email格式错误");
                $("#emp_save_btn").attr("email_flag","0");
                return;
            }

            $("#emp_save_btn").attr("email_flag","1");
        });

        //添加员工模态框保存按钮
        $("#emp_save_btn").click(function () {
            //验证表单数据
            if ($(this).attr("empName_flag") == "0" || $(this).attr("email_flag") == "0") {
                alert("表单输入不合法");
                return false;
            }

            $.ajax({
                url: "${pageScope.cpt}/saveEmployee",
                data: $("#empAddModal form").serialize(),
                type: "POST",
                success: function (result) {
                    if(result.code == 100){
                        //关闭模态框
                        $("#empAddModal").modal('hide');
                        //跳转到最后一页，显示新添加的员工
                        pageChange(totalPages);
                    }
                    if(result.code == 200){
                        alert("添加员工失败");
                    }
                },
                error: function () {
                    alert("系统错误");
                }
            });
        });

        /**
         * 页面跳转
         * @param pn 页码
         */
        function pageChange(pn) {
            $.ajax({
                url:"${pageScope.cpt}/getEmployeesByJson",
                data:"pn=" + pn,
                type:"GET",
                success:function (result) {
                    if(result.code == 100){
                        build_employees_table(result);
                        build_page_info(result);
                        build_employees_nav(result);
                    }
                    if(result.code == 200){
                        alert("失败");
                    }
                },
                error:function () {
                    alert("系统错误");
                }
            });
        }

        /**
         * 构建员工信息列表
         * @param result ajax返回的数据
         */
        function build_employees_table(result) {
            //清空
            $("#emps_table tbody").empty();

            var employees = result.extend.pageInfo.list;
            $(employees).each(function (index, element) {
                var empIdTd = $("<td></td>").append(element.empId);
                var empNameTd = $("<td></td>").append(element.empName);
                var genderTd = $("<td></td>").append(element.gender == "1" ? "男" : "女");
                var emailTd = $("<td></td>").append(element.email);
                var deptNameTd = $("<td></td>").append(element.department.deptName);
                var editBtn = $("<button></button>").
                    addClass("btn btn-primary btn-sm").
                    append($("<span></span>").addClass("glyphicon glyphicon-pencil")).
                    append("编辑");
                var deleteBtn = $("<button></button>").
                    addClass("btn btn-danger btn-sm").
                    append($("<span></span>").addClass("glyphicon glyphicon-trash")).
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

        /**
         * 构建总记录信息
         * @param result
         */
        function build_page_info(result) {
            //清空
            $("#page_info").empty();

            $("#page_info").append("当前第"
                + result.extend.pageInfo.pageNum
                + "页，总共"
                + result.extend.pageInfo.pages
                + "页，总共"
                + result.extend.pageInfo.total
                + "记录数");
            totalPages = result.extend.pageInfo.pages + 1;
        }

        /**
         * 构建导航栏信息
         * @param result
         */
        function build_employees_nav(result) {
            //清空
            $("#page_nav").empty();

            var ul = $("<ul></ul>").addClass("pagination");
            var firstPageLi = $("<li></li>").append($("<a></a>").append("首页"));
            var prevPageLi = $("<li></li>").append($("<a></a>").append($("<span></span>").append("&laquo;")));
            var nextPageLi = $("<li></li>").append($("<a></a>").append($("<span></span>").append("&raquo;")));
            var lastPageLi = $("<li></li>").append($("<a></a>").append("末页"));

            ul.append(firstPageLi).append(prevPageLi);

            if (result.extend.pageInfo.hasPreviousPage) {
                firstPageLi.click(function () {
                    pageChange(1);
                });
                prevPageLi.click(function () {
                    pageChange(result.extend.pageInfo.pageNum - 1);
                });
            }

            $(result.extend.pageInfo.navigatepageNums).each(function (index, element) {
                var elementLi = $("<li></li>").append($("<a></a>").append(element));
                if (result.extend.pageInfo.pageNum == element) {
                    elementLi.addClass("active");
                } else {
                    elementLi.click(function () {
                        pageChange(element);
                    });
                }
                ul.append(elementLi);
            });

            if (result.extend.pageInfo.hasNextPage) {
                nextPageLi.click(function () {
                    pageChange(result.extend.pageInfo.pageNum + 1);
                });
                lastPageLi.click(function () {
                    pageChange(result.extend.pageInfo.pages);
                });
            }

            ul.append(nextPageLi).append(lastPageLi).appendTo("<nav></nav>").appendTo("#page_nav");
        }

        /**
         * 发送ajax请求，查询部门信息，并显示在模态框中
         */
        function getDepartments(selectId) {
            //清空
            $(selectId).empty();

            $.ajax({
                url:"${pageScope.cpt}/getDepartmentsByJson",
                type:"GET",
                success:function (result) {
                    if (result.code == 100) {
                        $(result.extend.departments).each(function (index, element) {
                            $(selectId).append($("<option></option>").append(element.deptName).prop("value", element.deptId));
                        });
                    }
                    if (result.code == 200) {
                        alert("失败");
                    }
                },
                error:function () {
                }
            });
        }

        /**
         * 重置表单
         * @param ele
         */
        function reset_form(ele) {
            //清空表单数据
            $(ele)[0].reset();

            //删除提交按键中empName_flag和email_flag自定义属性
            $("#emp_save_btn").removeAttr("empName_flag");
            $("#emp_save_btn").removeAttr("email_flag");

            //清空提示信息
            $(ele).find(".help-block").empty();

            //清除错误红框
            $(ele).find("*").removeClass("has-error");
        }

    </script>
</body>
</html>
