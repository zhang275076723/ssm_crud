package com.zhang.ssm.service;

import com.zhang.ssm.bean.Employee;

import java.util.List;

/**
 * @Author zsy
 * @Create 2020/3/25 12:10
 * @Description
 */
public interface EmployeeService {
    //获取所有employee
    List<Employee> getAll();

    //查询数据库中empName是否重复
    boolean checkEmpName(String empName);

    //新增employee
    void insertEmployee(Employee employee);

    //获取employee
    Employee getEmployee(Integer id);

    //更新employee
    boolean updateEmployee(Employee employee);

    //删除employee
    boolean deleteEmployee(Integer id);

    //批量删除employee
    boolean batchDeleteEmployee(List<Integer> ids);
}
