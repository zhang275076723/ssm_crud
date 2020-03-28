package com.zhang.ssm.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zhang.ssm.bean.Employee;
import com.zhang.ssm.bean.Msg;
import com.zhang.ssm.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.*;

/**
 * @Author zsy
 * @Create 2020/3/25 12:08
 * @Description
 */
@Controller
public class EmployeeController {
    @Autowired
    private EmployeeService employeeService;

    //list.jsp
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

    @ResponseBody
    @RequestMapping("/checkEmpName")
    public Msg checkEmpName(@RequestParam("empName") String empName) {
        if (employeeService.checkEmpName(empName)) {
            return Msg.success();
        }
        return Msg.fail();
    }

    @ResponseBody
    @RequestMapping(value = "/employee", method = RequestMethod.POST)
    public Msg saveEmployee(@Valid Employee employee, BindingResult result) {
        if (result.hasErrors()) {
            Map<String, Object> errorInfo = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError error : errors) {
                //将错误信息封装到map中
                errorInfo.put(error.getField(), error.getDefaultMessage());
            }
            return Msg.fail().add("errorInfo", errorInfo);
        }
        employeeService.insertEmployee(employee);
        return Msg.success();
    }

    @ResponseBody
    @RequestMapping(value = "/employee/{empId}", method = RequestMethod.GET)
    public Msg getEmployee(@PathVariable("empId") Integer id) {
        return Msg.success().add("employee", employeeService.getEmployee(id));
    }

    @ResponseBody
    @RequestMapping(value = "/employee", method = RequestMethod.PUT)
    public Msg updateEmployee(Employee employee) {
        if (employeeService.updateEmployee(employee)) {
            return Msg.success();
        }
        return Msg.fail();
    }

    @ResponseBody
    @RequestMapping(value = "/employee", method = RequestMethod.DELETE)
    public Msg deleteEmployee(@RequestParam("empId") Integer id) {
        if (employeeService.deleteEmployee(id)) {
            return Msg.success();
        }
        return Msg.fail();
    }

    @ResponseBody
    @RequestMapping("/batchDelete")
    public Msg batchDelete(@RequestParam("empIds") Integer[] ids) {
        List<Integer> list = new ArrayList<>(Arrays.asList(ids));
        if (employeeService.batchDeleteEmployee(list)) {
            return Msg.success();
        }
        return Msg.fail();
    }
}
