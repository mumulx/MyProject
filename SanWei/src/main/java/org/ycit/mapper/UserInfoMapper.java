package org.ycit.mapper;

import org.ycit.entity.UserInfo;

public interface UserInfoMapper {
	

/*�ͻ���ajax��ʽ�ύ����û���Ϣ*/
    void addUserInfo(UserInfo userInfo );
    /*�����ֻ��Ż�ȡ�û���Ϣ*/
    UserInfo getUserInfoByUserTel(String userTel);

    /*�����û�id��ȡ�û���Ϣ*/
    UserInfo getUserInfoByUserId(int userId);
    /* ǰ̨�û���¼����û���Ϣ */
    String checkLogin(String user_name);


    void updateUserInfoByUserId(UserInfo userInfo);






}
