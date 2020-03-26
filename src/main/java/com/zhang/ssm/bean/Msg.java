package com.zhang.ssm.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.HashMap;
import java.util.Map;

/**
 * @Author zsy
 * @Create 2020/3/25 22:38
 * @Description
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Msg {
    private int code;
    private String msg;
    private Map<String, Object> extend = new HashMap<>();

    public static Msg success() {
        Msg msg = new Msg();
        msg.setCode(100);
        msg.setMsg("success");
        return msg;
    }

    public static Msg fail() {
        Msg msg = new Msg();
        msg.setCode(200);
        msg.setMsg("fail");
        return msg;
    }

    public Msg add(String key, Object value) {
        extend.put(key, value);
        return this;
    }
}
