package com.kh.runningdog.contents;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.python.core.PyFunction;
import org.python.core.PyObject;
import org.python.core.PyString;
import org.python.util.PythonInterpreter;

public class IssueCrawling {
	
	private static PythonInterpreter intPre;
	
	//오늘의 이슈 발행순 크롤링
	public static JSONObject issueListLatest() {

		intPre = new PythonInterpreter();
		intPre.execfile("C:\\gaenasona_workspace\\runningdog\\src\\main\\webapp\\resources\\contents_pythonFiles\\issueList.py");
		
		PyFunction pyFunction = (PyFunction) intPre.get("issueListLatest", PyFunction.class);

		PyObject pyobj = pyFunction.__call__();
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
	
	
	//오늘의 이슈 인기순 크롤링
	public static JSONObject issueListPopular() {
		intPre = new PythonInterpreter();
		intPre.execfile("C:\\gaenasona_workspace\\runningdog\\src\\main\\webapp\\resources\\contents_pythonFiles\\issueList.py");
		
		PyFunction pyFunction = (PyFunction) intPre.get("issueListPopular", PyFunction.class);

		PyObject pyobj = pyFunction.__call__();
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
	
	
	//오늘의 이슈 상세보기 크롤링
	public static JSONObject issueDetail(String link) {
		intPre = new PythonInterpreter();
		intPre.execfile("C:\\gaenasona_workspace\\runningdog\\src\\main\\webapp\\resources\\contents_pythonFiles\\issueDetail2.py");
		
		PyFunction pyFunction = (PyFunction) intPre.get("issueDetail", PyFunction.class);
		
		PyObject pyobj = pyFunction.__call__(new PyString(link));
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
	
	
}
