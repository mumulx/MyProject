package org.ycit.entity;/*
 *  Created by IntelliJ IDEA.
 *  User: 木木
 *  Date: 2020/4/13
 *  Time: 20:47
 */

import lombok.*;
import org.hibernate.validator.constraints.NotBlank;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class TeamProject {

    private int tpId;//项目唯一id
    @NotBlank(message = "项目名称不能为空")
    private String tpName;//项目名称
    @NotBlank(message = "项目描述不能为空")
    private String tpMsg;//项目描述
    private String tpDate;//项目创建日期


}
