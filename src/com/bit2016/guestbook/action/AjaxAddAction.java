package com.bit2016.guestbook.action;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bit2016.mysite.dao.GuestbookDao;
import com.bit2016.mysite.vo.GuestbookVo;
import com.bit2016.web.Action;

import net.sf.json.JSONObject;

public class AjaxAddAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name");
		String password = request.getParameter("pass");
		String content = request.getParameter("content");
		
		GuestbookVo vo = new GuestbookVo();
		vo.setName(name);
		vo.setPassword(password);
		vo.setContent(content);
		
		GuestbookDao dao = new GuestbookDao();
		Long result = dao.insert(vo);
		
		Map<String, Object> map = new HashMap<String, Object>();
		if( result == null) {
			map.put("result", "fail");
			map.put("message", "방명록 등록 실패");
		} else {
			GuestbookVo returnVo = dao.get(result);
			
			if( returnVo == null ) {
				map.put("result", "fail");
				map.put("message", "불러오기 실패");
			} else {
				map.put("result", "success");
				map.put("data", returnVo);
			}
		}
		response.setContentType("application/json; charset=utf-8");
		JSONObject jsonObject = JSONObject.fromObject(map);
		response.getWriter().println(jsonObject.toString());

	}

}
