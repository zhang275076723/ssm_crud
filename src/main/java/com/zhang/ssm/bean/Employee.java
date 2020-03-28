package com.zhang.ssm.bean;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.Email;
import javax.validation.constraints.Pattern;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Employee {
    private Integer empId;

    @Pattern(regexp = "(^[A-Za-z0-9_\\u4e00-\\u9fa5]{6,16}$)",
            message = "empName格式错误，必须是6-16位的汉字、英文、数字、下划线")
    private String empName;

    private String gender;

    @Email(regexp = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$",
            message = "email格式错误达")
    private String email;

    //防止传输json的大小写问题
    @JsonProperty("dId")
    private Integer dId;

    private Department department;

    public Employee(Integer empId, String empName, String gender, String email, Integer dId) {
        this.empId = empId;
        this.empName = empName;
        this.gender = gender;
        this.email = email;
        this.dId = dId;
    }
}