package com.zhang.ssm.service;

import com.zhang.ssm.bean.Department;

import java.util.List;

/**
 * @Author zsy
 * @Create 2020/3/26 16:25
 * @Description
 */
public interface DepartmentService {
    //获取所有department
    List<Department> getAll();
}
