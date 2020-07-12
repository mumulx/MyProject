package org.ycit.test;// NX 12.0.0.27
// Journal created by 26069 on Thu Apr 23 23:09:36 2020 中国标准时间

//
import nxopen.*;

import java.rmi.RemoteException;

public class a1
{
  public static void main(String [] args) throws NXException, RemoteException
  {


    nxopen.Session theSession = (nxopen.Session)nxopen.SessionFactory.get("Session");

    nxopen.Part workPart = theSession.parts().work();
    nxopen.Part displayPart = theSession.parts().display();

    nxopen.validate.Parser [] parsers1 ;
    parsers1 = theSession.validationManager().findParser("Validation Gadget");
    
    parsers1[0].clearResultObjects();
    
    parsers1[0].setDataSource(nxopen.validate.Parser.DataSourceTypes.MOST_RECENT_RUN);
    
    parsers1[0].setMaxDisplayObjects(10);
    
    nxopen.validate.Parser [] parsers2 ;
    parsers2 = theSession.validationManager().findParser("Validation Gadget");
    
    parsers1[0].commit();
    
    nxopen.validate.Parser [] parsers3 ;
    parsers3 = theSession.validationManager().findParser("Validation Gadget");
    
    nxopen.validate.Parser [] parsers4 ;
    parsers4 = theSession.validationManager().findParser("Validation Gadget");
    
    nxopen.validate.Parser [] parsers5 ;
    parsers5 = theSession.validationManager().findParser("Validation Gadget");
    
    nxopen.validate.Parser [] parsers6 ;
    parsers6 = theSession.validationManager().findParser("Validation Gadget");
    
    nxopen.validate.Validator [] validators1 ;
    validators1 = theSession.validationManager().findValidator("Check-Mate");
    
    nxopen.validate.ValidatorOptions validatorOptions1;
    validatorOptions1 = validators1[0].validatorOptions();
    
    validatorOptions1.setSkipChecking(false);
    
    validatorOptions1.setSkipCheckingDontLoadPart(false);
    
    nxopen.validate.Validator [] validators2 ;
    validators2 = theSession.validationManager().findValidator("Check-Mate");
    
    validators1[0].clearPartNodes();
    
    nxopen.validate.Validator [] validators3 ;
    validators3 = theSession.validationManager().findValidator("Check-Mate");
    
    validators1[0].appendPartNode("D:\\workplace\\nx\\a2.prt");
    
    nxopen.validate.Validator [] validators4 ;
    validators4 = theSession.validationManager().findValidator("Check-Mate");
    
    nxopen.validate.ValidatorOptions validatorOptions2;
    validatorOptions2 = validators1[0].validatorOptions();
    
    validatorOptions2.setSaveResultInTeamcenter(nxopen.validate.ValidatorOptions.SaveModeTypes.DO_NOT_SAVE);
    
    validatorOptions2.setSavePartFile(nxopen.validate.ValidatorOptions.SaveModeTypes.DO_NOT_SAVE);
    
    validatorOptions2.setSaveResultInPart(false);
    
    // ----------------------------------------------
    //   对话开始 设置测试
    // ----------------------------------------------

    nxopen.validate.Validator [] validators5 ;
    validators5 = theSession.validationManager().findValidator("Check-Mate");
    
    validators1[0].appendCheckerNode("%mqc_report_feature_count");
    
    nxopen.validate.Validator [] validators6 ;
    validators6 = theSession.validationManager().findValidator("Check-Mate");
    
    validators1[0].appendCheckerNode("%mqc_report_feature_type");
    
    nxopen.validate.Validator [] validators7 ;
    validators7 = theSession.validationManager().findValidator("Check-Mate");
    
    validators1[0].appendCheckerNode("%mqc_report_feature_alert_message");
    
    nxopen.validate.Validator [] validators8 ;
    validators8 = theSession.validationManager().findValidator("Check-Mate");
    
    nxopen.validate.ValidatorOptions validatorOptions3;
    validatorOptions3 = validators1[0].validatorOptions();
    
    validatorOptions3.setGenerateLogFile(true);
    
    validatorOptions3.setLogFileDirectory("C:\\Program Files\\Siemens\\NX 12.0\\UGII");
    
    nxopen.validate.Validator [] validators9 ;
    validators9 = theSession.validationManager().findValidator("Check-Mate");
    
    nxopen.validate.ValidatorOptions validatorOptions4;
    validatorOptions4 = validators1[0].validatorOptions();
    
    validatorOptions4.setLogFileDirectory("C:\\Users\\26069\\Desktop\\");
    
    nxopen.validate.Validator [] validators10 ;
    validators10 = theSession.validationManager().findValidator("Check-Mate");
    
    nxopen.validate.ValidatorOptions validatorOptions5;
    validatorOptions5 = validators1[0].validatorOptions();
    
    nxopen.validate.Validator [] validators11 ;
    validators11 = theSession.validationManager().findValidator("Check-Mate");
    
    nxopen.Validation.Result status1;
    status1 = validators1[0].commit();
    
    nxopen.validate.Parser [] parsers7 ;
    parsers7 = theSession.validationManager().findParser("Validation Gadget");
    
    parsers1[0].clearResultObjects();
    
    parsers1[0].setDataSource(nxopen.validate.Parser.DataSourceTypes.RESULT_FROM_PART);
    
    parsers1[0].setMaxDisplayObjects(10);
    
    nxopen.validate.Parser [] parsers8 ;
    parsers8 = theSession.validationManager().findParser("Validation Gadget");
    
    parsers1[0].commit();
    
    nxopen.validate.Parser [] parsers9 ;
    parsers9 = theSession.validationManager().findParser("Validation Gadget");
    
    nxopen.validate.Parser [] parsers10 ;
    parsers10 = theSession.validationManager().findParser("Validation Gadget");
    
    nxopen.validate.Parser [] parsers11 ;
    parsers11 = theSession.validationManager().findParser("Validation Gadget");
    
    // ----------------------------------------------
    //   菜单：工具(T)->操作记录(J)->停止录制(S)
    // ----------------------------------------------
  
  }
  
  public static final int getUnloadOption() { return nxopen.BaseSession.LibraryUnloadOption.IMMEDIATELY; }
  
}
