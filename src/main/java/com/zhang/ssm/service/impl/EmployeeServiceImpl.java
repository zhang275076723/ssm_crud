package com.zhang.ssm.service.impl;

import com.zhang.ssm.bean.Employee;
import com.zhang.ssm.bean.EmployeeExample;
import com.zhang.ssm.dao.EmployeeMapper;
import com.zhang.ssm.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author zsy
 * @Create 2020/3/25 12:17
 * @Description
 */
@Service("employeeService")
public class EmployeeServiceImpl implements EmployeeService {
    @Autowired
    private EmployeeMapper employeeMapper;

    @Override
    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }

    @Override
    public boolean checkEmpName(String empName) {
        EmployeeExample example = new EmployeeExample();
        example.createCriteria().andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(example);
        return count == 0;
    }

    @Override
    public void insertEmployee(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    @Override
    public Employee getEmployee(Integer id) {
        return employeeMapper.selectByPrimaryKeyWithDept(id);
    }

    @Override
    public boolean updateEmployee(Employee employee) {
        return employeeMapper.updateByPrimaryKeySelective(employee) == 1;
    }

    @Override
    public boolean deleteEmployee(Integer id) {
        return employeeMapper.deleteByPrimaryKey(id) == 1;
    }

    @Override
    public boolean batchDeleteEmployee(List<Integer> ids) {
        return employeeMapper.batchDelete(ids) == ids.size();
    }
}
