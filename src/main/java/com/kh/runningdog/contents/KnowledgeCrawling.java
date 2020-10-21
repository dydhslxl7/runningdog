package com.kh.runningdog.contents;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.python.core.PyFunction;
import org.python.core.PyInteger;
import org.python.core.PyObject;
import org.python.core.PyString;
import org.python.util.PythonInterpreter;

public class KnowledgeCrawling {
	
	private static PythonInterpreter intPre;
	
	//반려동물 지식 리스트 크롤링
	public static JSONObject knowledgeList(String animal, int page, String keyfield, String keyword) {

		//검색 문자열 unicode로 변환
		 StringBuffer ostr = new StringBuffer();
		 for (int i = 0; i < keyword.length(); i++) {
		        char ch = keyword.charAt(i);
		        if ((ch >= 0x0020) && (ch <= 0x007e)) { 
		            ostr.append(ch); // 아닌 경우.
		 } else { // 변경해야 하는 경우.
		    ostr.append("\\u");
		    String hex = Integer.toHexString(keyword.charAt(i) & 0xFFFF); // 문자의 Hex 값
		 
		        // 네 자리를 맞추기 위해 0 추가
		    for (int j = 0; j < 4 - hex.length(); j++)
		        ostr.append("0");
		            ostr.append(hex.toLowerCase());
		       }
		 }
		 
		 String keywordUnicode = new String(ostr);
		 
		 intPre = new PythonInterpreter();
		 intPre.execfile("C:\\gaenasona_workspace\\runningdog\\src\\main\\webapp\\resources\\contents_pythonFiles\\knowledgeList2.py");
		
		 PyFunction pyFunction = (PyFunction) intPre.get("knowledgeList", PyFunction.class);
		
		 PyObject pyobj = pyFunction.__call__(new PyString(animal), new PyInteger(page), new PyString(keyfield), new PyString(keywordUnicode));
		
		 String result = pyobj.toString();
		 
		//크롤링해서 받은 결과값 JSONObject로 변환
		JSONParser parser = new JSONParser();
		JSONObject jobj = new JSONObject();
		try {
			jobj = (JSONObject) parser.parse(result);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return jobj;

	}
	
	
	//반려동물 지식 상세정보 크롤링
	public static String knowledgeDetal(String link) {
		intPre = new PythonInterpreter();
		intPre.execfile("C:\\gaenasona_workspace\\runningdog\\src\\main\\webapp\\resources\\contents_pythonFiles\\knowledgeDetail.py");
		
		PyFunction pyFunction = (PyFunction) intPre.get("knowledgeDetail", PyFunction.class);

		PyObject pyobj = pyFunction.__call__(new PyString(link));
		
		String result = pyobj.toString();
		
		JSONParser parser = new JSONParser();
		
		JSONObject jobj = new JSONObject();
		try {
			jobj = (JSONObject) parser.parse(result);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String content = jobj.get("content").toString();
		
		return content; 
	}
	

}
