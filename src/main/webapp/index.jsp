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
                    <h4 class="modal-title" id="myEmpAddModalLabel">员工添加</h4>
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
                                <select class="form-control" name="dId" id="dept_add_select"></select>
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

    <!--员工修改模态框-->
    <div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="myEmpUpdateModalLabel">员工修改</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">empName</label>
                            <div class="col-sm-10">
                                <p class="form-control-static" id="empName_update"></p>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="email_update_input" class="col-sm-2 control-label">email</label>
                            <div class="col-sm-10">
                                <input type="text" name="email" class="form-control" id="email_update_input" placeholder="请输入email">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">gender</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender_update_male" value="1" checked="checked">
                                    男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender_update_female" value="0">
                                    女
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="dept_update_select" class="col-sm-2 control-label">department</label>
                            <div class="col-sm-4">
                                <select class="form-control" name="dId" id="dept_update_select"></select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button id="emp_update_btn" type="button" class="btn btn-primary">保存</button>
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
                <button id="emp_batch_delete_btn" class="btn btn-danger">删除</button>
            </div>
        </div>

        <!--表格数据-->
        <div class="row">
            <div class="col-md-12">
                <table id="emps_table" class="table table-hover">
                    <thead>
                        <tr>
                            <th>
                                <input type="checkbox" id="checkbox_all"/>
                            </th>
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
        var currentPage;//当前页码
        var totalPages;//总页码

        $(function () {
            pageChange(1);
        });

        //添加员工按钮，显示添加员工表单
        $("#emp_add_modal_btn").click(function () {
            //重置添加员工表单
            reset_add_form("#empAddModal form");

            //将查询到的部门信息显示在模态框中
            getDepartments("#dept_add_select");

            //显示模态框
            $("#empAddModal").modal({
                //点击模态框以外的地方，模态框不关闭
                backdrop:"static"
            });
        });

        //添加员工empName验证
        $("#empName_input").blur(function () {
            var empName = $("#empName_input").val();
            var regName = /(^[A-Za-z0-9_\u4e00-\u9fa5]{6,16}$)/;

            //清空提示信息
            $("#empName_input").next("span").empty();

            //清除错误红框
            $("#empName_input").parent().removeClass("has-error");

            if (empName == "") {
                show_validate_msg("#empName_input", "empName不能为空");
                $("#emp_save_btn").attr("empName_flag","0");
                return;
            }

            if (!regName.test(empName)) {
                show_validate_msg("#empName_input", "empName格式错误，必须是6-16位的汉字、英文、数字、下划线");
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
                        show_validate_msg("#empName_input", "empName已存在");
                        $("#emp_save_btn").attr("empName_flag","0");
                    }
                },
                error:function () {
                    alert("系统错误");
                }
            });
        });

        //添加员工email验证
        $("#email_input").blur(function () {
            var email = $("#email_input").val();
            var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;

            //清空提示信息
            $("#email_input").next("span").empty();

            //清除错误红框
            $("#email_input").parent().removeClass("has-error");

            if (email == "") {
                show_validate_msg("#email_input", "email不能为空");
                $("#emp_save_btn").attr("email_flag","0");
                return;
            }

            if (!regEmail.test(email)) {
                show_validate_msg("#email_input", "email格式错误");
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
                url: "${pageScope.cpt}/employee",
                data: $("#empAddModal form").serialize(),
                type: "POST",
                success: function (result) {
                    if (result.code == 100) {
                        //关闭模态框
                        $("#empAddModal").modal('hide');
                        //跳转到最后一页，显示新添加的员工
                        pageChange(totalPages);
                    }
                    if (result.code == 200) {
                        if (result.extend.errorInfo.empName != undefined) {
                            show_validate_msg("#empName_input", result.extend.errorInfo.empName);
                        }
                        if (result.extend.errorInfo.email != undefined) {
                            show_validate_msg("#email_input", result.extend.errorInfo.email);
                        }
                    }
                },
                error: function () {
                    alert("系统错误");
                }
            });
        });

        //为动态生成的edit_btn添加点击事件
        $(document).on("click", ".edit_btn", function () {
            //清空提示元素
            reset_update_form("#empUpdateModal form");

            //将查询到的部门信息显示在模态框中
            getDepartments("#dept_update_select");

            //将查询到的员工信息显示在模态框中
            getEmp($(this).attr("emp_id"));

            //将edit_btn添加的emp_id属性传递给更新按钮，用于更新
            $("#emp_update_btn").attr("emp_id", $(this).attr("emp_id"));

            //显示模态框
            $("#empUpdateModal").modal({
                //点击模态框以外的地方，模态框不关闭
                backdrop:"static"
            });
        });

        //修改员工email验证
        $("#email_update_input").blur(function () {
            var email = $("#email_update_input").val();
            var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;

            //清空提示信息
            $("#email_update_input").next("span").empty();

            //清除错误红框
            $("#email_update_input").parent().removeClass("has-error");

            if (email == "") {
                show_validate_msg("#email_update_input", "email不能为空");
                $("#emp_update_btn").attr("email_flag","0");
                return;
            }

            if (!regEmail.test(email)) {
                show_validate_msg("#email_update_input", "email格式错误");
                $("#emp_update_btn").attr("email_flag","0");
                return;
            }

            $("#emp_update_btn").attr("email_flag","1");
        });

        //修改员工模态框保存按钮
        $("#emp_update_btn").click(function () {
            //验证表单数据
            if ($(this).attr("email_flag") == "0") {
                alert("邮箱输入不合法");
                return false;
            }

            $.ajax({
                url: "${pageScope.cpt}/employee",
                data: $("#empUpdateModal form").serialize() + "&empId=" + $("#emp_update_btn").attr("emp_id") +"&_method=put",
                type: "POST",
                success: function (result) {
                    if (result.code == 100) {
                        //关闭模态框
                        $("#empUpdateModal").modal('hide');
                        //跳转到当前页，显示更新的员工信息
                        pageChange(currentPage);
                    }
                    if (result.code == 200) {
                        alert("修改失败")
                    }
                },
                error: function () {
                    alert("系统错误");
                }
            });
        });

        //为动态生成的delete_btn添加点击事件
        $(document).on("click", ".delete_btn", function () {
            if (confirm("确认删除[" + $(this).parents("tr").children("td").eq(2).text() + "]吗？")) {
                $.ajax({
                    url:"${cpt}/employee",
                    data:"empId=" + $(this).attr("emp_id") + "&_method=delete",
                    type:"POST",
                    success:function (result) {
                        if (result.code == 100) {
                            pageChange(currentPage);
                        }
                        if (result.code == 200) {
                            alert("删除失败");
                        }
                    },
                    error:function () {
                        alert("系统错误");
                    }
                });
            }
        });

        //为全选、全不选checkbox添加绑定事件
        $("#checkbox_all").click(function () {
            var flag = $(this).prop("checked");
            $(".checkbox_item").prop("checked", flag);
        });

        //因为每一个checkbox是动态添加的，所以需要使用on添加绑定事件
        $(document).on("click", ".checkbox_item", function () {
            var flag = $(".checkbox_item:checked").length == $(".checkbox_item").length;
            $("#checkbox_all").prop("checked", flag);
        });

        //批量删除
        $("#emp_batch_delete_btn").click(function () {
            if ($(".checkbox_item:checked").length == 0) {
                alert("请选择要删除的员工");
            } else {
                var empNames = "";
                var empIds = [];
                $(".checkbox_item:checked").each(function (index, element) {
                    empNames += $(element).parents("tr").children("td").eq(2).text() + ", ";
                    empIds[index] = parseInt($(element).parents("tr").children("td").eq(1).text());
                });
                if (confirm("确认删除["+ empNames.substring(0, empNames.length - 2) +"]吗？")) {
                    $.ajax({
                        url:"${cpt}/batchDelete",
                        type:"post",
                        data:"empIds="+empIds,
                        success:function (result) {
                            if (result.code == 100) {
                                pageChange(currentPage);
                            }
                            if (result.code == 200) {
                                alert("批量删除失败");
                            }
                        },
                        error:function () {
                            alert("系统错误");
                        }
                    });
                }
            }
        });

        /**
         * 页面跳转
         * @param pn 页码
         */
        function pageChange(pn) {
            //清空checkbox选择状态
            $("#checkbox_all").prop("checked", false);

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
                var checkboxTd = $("<td></td>").append($("<input type='checkbox' class='checkbox_item'/>"));
                var empIdTd = $("<td></td>").append(element.empId);
                var empNameTd = $("<td></td>").append(element.empName);
                var genderTd = $("<td></td>").append(element.gender == "1" ? "男" : "女");
                var emailTd = $("<td></td>").append(element.email);
                var deptNameTd = $("<td></td>").append(element.department.deptName);
                var editBtn = $("<button></button>").
                    addClass("btn btn-primary btn-sm edit_btn").
                    append($("<span></span>").addClass("glyphicon glyphicon-pencil")).
                    append("编辑").
                    attr("emp_id", element.empId);//添加自定义属性，便于通过员工id获取employee
                var deleteBtn = $("<button></button>").
                    addClass("btn btn-danger btn-sm delete_btn").
                    append($("<span></span>").addClass("glyphicon glyphicon-trash")).
                    append("删除").
                    attr("emp_id", element.empId);//添加自定义属性，便于通过员工id删除employee
                var btnTd = $("<td></td>").append(editBtn).append(" ").append(deleteBtn);

                $("<tr></tr>").
                    append(checkboxTd).
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
            currentPage = result.extend.pageInfo.pageNum;
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
         * @param ele 下拉框select元素
         */
        function getDepartments(ele) {
            //清空
            $(ele).empty();

            $.ajax({
                url:"${pageScope.cpt}/getDepartmentsByJson",
                type:"GET",
                async:false,//同步，必须先查询出部门信息之后，再继续执行后面的查询员工信息
                success:function (result) {
                    if (result.code == 100) {
                        $(result.extend.departments).each(function (index, element) {
                            $(ele).append($("<option></option>").append(element.deptName).prop("value", element.deptId));
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
         * 显示校验提示信息
         * @param ele 输入框元素
         * @param msg 校验信息
         */
        function show_validate_msg(ele, msg) {
            //清空提示信息
            $(ele).next("span").empty();

            //清除错误红框
            $(ele).parent().removeClass("has-error");

            $(ele).parent().addClass("has-error");
            $(ele).next("span").append(msg);
        }

        /**
         * 重置添加员工表单
         * @param ele 添加员工表单元素
         */
        function reset_add_form(ele) {
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

        /**
         * 重置更新员工表单
         * @param ele 更新员工表单元素
         */
        function reset_update_form(ele) {
            //删除提交按键中email_flag自定义属性
            $("#emp_update_btn").removeAttr("email_flag");

            //清空提示信息
            $(ele).find(".help-block").empty();

            //清除错误红框
            $(ele).find("*").removeClass("has-error");
        }

        /**
         * 通过empId获取employee,并将employee添加到模态框中
         * @param empId 员工id
         */
        function getEmp(empId) {
            $.ajax({
                url:"${cpt}/employee/" + empId,
                type:"GET",
                success:function (result) {
                    if (result.code == 100) {
                        var employee = result.extend.employee;

                        //清空radio和option元素的点击情况
                        $("#empUpdateModal input:radio").removeAttr("checked");
                        $("#dept_update_select option").removeAttr("selected");

                        //设置值到模态框中
                        $("#empName_update").empty().append(employee.empName);//设置前需要先清空
                        $("#email_update_input").val(employee.email);
                        $("#" + "empUpdateModal input[value='" + employee.gender + "']").prop("checked", "checked");
                        $("#" + "dept_update_select option[value='"+ employee.dId +"']").attr("selected","selected");
                    }
                    if (result.code == 200) {
                        alert("失败");
                    }
                },
                error:function () {
                    alert("系统错误");
                }
            });
        }

    </script>
</body>
</html>
