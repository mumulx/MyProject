package org.ycit.entity;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/*
 *  Created by IntelliJ IDEA.
 *  User: 木木
 *  Date: 2020/4/25
 *  Time: 20:24
 */
@Getter
@Setter
public class Rule implements Serializable {
    private Integer ruleId;
    private String ruleName;
    private Integer parentId;
    private String rulePath;
    private Boolean enabled;
    private Boolean isParent;
    private String englishName;
    private String checker;
    private List<Rule> children = new ArrayList<>();

    @Override
    public boolean equals(Object o) {

        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Rule that = (Rule) o;
        return Objects.equals(ruleName, that.ruleName);
    }
    @Override
    public int hashCode() {

        return Objects.hash(ruleName);
    }
}
