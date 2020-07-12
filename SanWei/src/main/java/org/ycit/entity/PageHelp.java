package org.ycit.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/*
 *  Created by IntelliJ IDEA.
 *  User: 木木
 *  Date: 2020/4/14
 *  Time: 21:26
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class PageHelp {

    /*当前页数*/
    private int currentPage;
    /*总的页数*/
    private int totalPage;
    /* 保存查询到的总记录数 */
    private int recordNumber;
    /* 每页显示记录数目 */
    public static final int pageSize = 7;

    //public static final int RECORDPAGESIZE = 7;

    //计算总的页数
    public void computeTotalPag() {
        int mod = this.recordNumber % this.pageSize;
        this.totalPage = this.recordNumber / this.pageSize;
        if(mod != 0) this.totalPage++;
    }

}
