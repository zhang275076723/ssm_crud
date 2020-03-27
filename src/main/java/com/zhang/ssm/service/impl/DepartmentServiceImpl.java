package com.zhang.ssm.service.impl;

import com.zhang.ssm.bean.Department;
import com.zhang.ssm.dao.DepartmentMapper;
import com.zhang.ssm.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author zsy
 * @Create 2020/3/26 16:25
 * @Description
 */
@Service("departmentService")
public class DepartmentServiceImpl implements DepartmentService {
    @Autowired
    private DepartmentMapper departmentMapper;

    @Override
    public List<Department> getAll() {
        return departmentMapper.selectByExample(null);
    }
}
