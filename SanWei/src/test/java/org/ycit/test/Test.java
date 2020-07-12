package org.ycit.test;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Source;

import org.apache.commons.io.IOUtils;
import org.json.JSONException;
import org.json.JSONObject;
import org.json.XML;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.ycit.util.HelpDev;

public class Test {
	public static String xml2jsonString() throws IOException {
		//InputStream in = Test.class.getResourceAsStream("C:\\Users\\26069\\Desktop\\nx项目\\结果\\_model1.xml");

		FileInputStream in = new FileInputStream(new File("C:\\Users\\26069\\Desktop\\nx项目\\结果\\解析\\file\\2020Apr28101820.xml")) ;
		String xml = IOUtils.toString(in,"utf-8");
		JSONObject object =  XML.toJSONObject(xml);
		return  object.toString();
	}
	
	public static void textGetDom() throws Exception{
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = factory.newDocumentBuilder();
		Document dom = builder.parse(new File("C://Users//26069//Desktop//nx项目//结果//_model1.xml"));
		
		NodeList ele = dom.getElementsByTagName("chk:CheckMessageInfo");
		System.out.println(ele.item(0).getTextContent());

		
	}

	public static void test1() {
		HelpDev helpDev = new HelpDev();
		try {
			//helpDev.dosCheckXmlUtil(null,null);
			String prtFilePath = "D:\\workplace\\nx\\_model1.prt";

			String jpgFilePath = "D:\\test.jpg";

			helpDev.dosJpgExeUtil(prtFilePath,jpgFilePath);


		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static void test2() {

		String sfrFileName = "sjdfksd.prt";

		sfrFileName = sfrFileName.substring(0, sfrFileName.lastIndexOf("."))+".jpg";

		System.out.println(sfrFileName);

	}

	public static void test3() {

		HelpDev helpDev = new HelpDev();

		String prtFilePath = "C:\\workplace\\IDEA\\MyProject\\fileUpload\\9\\16b47ca0-9e03-4d65-a004-0248551c617e\\a1.prt";
		String logSavePath = "C:\\workplace\\IDEA\\MyProject\\fileUpload\\9\\16b47ca0-9e03-4d65-a004-0248551c617e\\";
		List<String> checkRules = new ArrayList<>();
		checkRules.add("mqc_check_invalid_product_interface_objects");
		checkRules.add("mqc_report_boolean_operation");

		try {
			helpDev.dosCheckXmlUtil(prtFilePath,logSavePath,checkRules);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) throws Exception {

		//test2();
		System.out.println(xml2jsonString());
		//test3();
		//textGetDom();
	}


}
