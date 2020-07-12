package org.ycit.entity;


import lombok.Data;
/*
 *  Created by IntelliJ IDEA.
 *  User: 木木
 *  Date: 2020/4/28
 *  Time: 22:37
 */
@Data
public class SubmitRecord {

    private int srId;

    private int srUserId;

    private String srDate;

    private int srFileNumber;

    private int srRuleNumber;

    private String srFileSaveURL;



}
