package com.zhang.ssm.controller;

import com.zhang.ssm.bean.Department;
import com.zhang.ssm.bean.Msg;
import com.zhang.ssm.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @Author zsy
 * @Create 2020/3/26 16:24
 * @Description
 */
@Controller
public class DepartmentController {
    @Autowired
    private DepartmentService departmentService;

    @ResponseBody
    @RequestMapping("getDepartmentsByJson")
    public Msg getDepartments() {
        List<Department> departments = departmentService.getAll();
        return Msg.success().add("departments", departments);
    }
}
