package com.kh.runningdog.notice.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

@Component("noticeFiledown")
public class NoticeFileDownLoadView extends AbstractView{

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// 컨트롤러에서 뷰리졸버로 리턴한 model 정보가 자동 전달됨
		File downFile = (File)model.get("downFile");
		//한글 파일명 인코딩 처리를 위해 파일명만 추출함
		//String fileName = downFile.getName();
		String fileName = (String)model.get("fileName");	//기존 파일 이름
		
		response.setContentType("text/plain; charset=utf-8");
		response.addHeader("Content-Disposition", "attachment; filename=\"" + new String(fileName.getBytes("utf-8"), "ISO-8859-1") + "\"");
		response.setContentLength((int)downFile.length());
		
		OutputStream out = response.getOutputStream();
		FileInputStream fin = null;
		
		try {	//fin.close() 를 위해 별도로 예외처리함.
			fin = new FileInputStream(downFile);
			FileCopyUtils.copy(fin, out);	//read, write하는 거
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(fin != null) {
				try {
					fin.close();
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
		}
		out.flush();
		out.close();
	}


}
