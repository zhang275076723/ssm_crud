package com.zhang.ssm.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zhang.ssm.bean.Employee;
import com.zhang.ssm.bean.Msg;
import com.zhang.ssm.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @Author zsy
 * @Create 2020/3/25 12:08
 * @Description
 */
@Controller
public class EmployeeController {
    @Autowired
    private EmployeeService employeeService;

    @RequestMapping("/getEmployees")
    public String getEmployees(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
        //页码，每页大小
        PageHelper.startPage(pn, 5);
        //startPage后面必须紧跟查询
        List<Employee> employees = employeeService.getAll();
        //PageInfo封装查询结果
        PageInfo<Employee> pageInfo = new PageInfo<>(employees, 5);
        model.addAttribute("pageInfo", pageInfo);
        return "list";
    }

    @ResponseBody
    @RequestMapping("/getEmployeesByJson")
    public Msg getEmployeesByJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        //页码，每页大小
        PageHelper.startPage(pn, 5);
        //startPage后面必须紧跟查询
        List<Employee> employees = employeeService.getAll();
        //PageInfo封装查询结果
        PageInfo<Employee> pageInfo = new PageInfo<>(employees, 5);
        return Msg.success().add("pageInfo", pageInfo);
    }

}
