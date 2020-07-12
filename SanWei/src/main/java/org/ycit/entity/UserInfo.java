package org.ycit.entity;

import lombok.*;
import org.hibernate.validator.constraints.NotBlank;
import org.json.JSONException;
import org.json.JSONObject;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class UserInfo {

	private Integer userId;
	@NotBlank(message = "昵称不能为空")
	private String userName;
	@NotBlank(message = "联系电话不能为空")
	private String userTel;
	@NotBlank(message = "密码不能为空")
	private String userPwd;
	@NotBlank(message = "电子邮箱不能为空")
	private String userEmail;
	@NotBlank(message = "出生日期不能为空")
	private String userBirthday;
	@NotBlank(message = "性别不能为空")
	private String userSex;
	@NotBlank(message = "联系地址不能为空")
	private String userAddress;
}
