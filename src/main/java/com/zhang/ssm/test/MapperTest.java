package com.zhang.ssm.test;

import com.zhang.ssm.bean.Department;
import com.zhang.ssm.bean.Employee;
import com.zhang.ssm.dao.DepartmentMapper;
import com.zhang.ssm.dao.EmployeeMapper;
import com.zhang.ssm.service.EmployeeService;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * @Author zsy
 * @Create 2020/3/25 10:22
 * @Description
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Test
    public void test1() {
        ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
//        Department department = ioc.getBean(Department.class);

//        System.out.println(departmentMapper);
//        departmentMapper.insertSelective(new Department(null, "开发部"));
//        departmentMapper.insertSelective(new Department(null, "测试部"));
//        employeeMapper.insertSelective(new Employee(null, "Tom", "1", "zhang@foxmail.com", 1));

        SqlSessionFactory sqlSessionFactory = (SqlSessionFactory) ioc.getBean("sqlSessionFactory");
        SqlSession sqlSession = sqlSessionFactory.openSession();
        EmployeeMapper employeeMapper = sqlSession.getMapper(EmployeeMapper.class);
//        for (int i = 1; i <= 100; i++) {
//            String str = UUID.randomUUID().toString().substring(0, 5) + i;
//            employeeMapper.insertSelective(new Employee(null, str, "1", str + "@foxmail.com", 1));
//        }
        System.out.println(employeeMapper.selectByPrimaryKeyWithDept(1));
        sqlSession.close();
    }
}
