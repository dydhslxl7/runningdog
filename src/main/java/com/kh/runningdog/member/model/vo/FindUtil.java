package com.kh.runningdog.member.model.vo;

import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FindUtil {
	
	public FindUtil() {}
	
	//인증코드 보내기 클래스
	@Autowired
	public static String createKey() {
		StringBuffer key = new StringBuffer();
		Random random = new Random();
		
		for(int i = 0; i < 10; i++) {
			int index = random.nextInt(3);
			
			switch(index) {
			case 0 : key.append((char) ((int) (random.nextInt(26)) + 97)); break;
			case 1 : key.append((char) ((int) (random.nextInt(26)) + 65)); break;
			case 2 : key.append(random.nextInt(10)); break;
			}	
		}
		return key.toString();
	}
}
