package org.ycit.entity;

import lombok.Data;

/*
 *  Created by IntelliJ IDEA.
 *  User: 木木
 *  Date: 2020/4/28
 *  Time: 22:35
 */
@Data
public class SubmitFileRecord {

    private int sfrId;

    private int sfrsrId;

    private String sfrFileName;

    //private String sfrRealName;
    private String sfrFilePath;

}
