package org.ycit.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.ycit.util.TpmIdentity;

/*
 *  Created by IntelliJ IDEA.
 *  User: 木木
 *  Date: 2020/4/14
 *  Time: 16:56
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class TeamProjectMember {

    private int tpmId;//tpm唯一标识id
    private int tpmTpId;//项目id
    private int tpmUserId;//项目成员id
    private String tpmIdentity;//项目成员身份
    private String tpmName;//项目成员在项目中的昵称
}
