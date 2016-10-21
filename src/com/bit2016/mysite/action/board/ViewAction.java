package com.bit2016.mysite.action.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bit2016.mysite.dao.BoardDao;
import com.bit2016.mysite.vo.BoardVo;
import com.bit2016.mysite.vo.UserVo;
import com.bit2016.web.Action;
import com.bit2016.web.util.WebUtil;

public class ViewAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		long no = WebUtil.checkLongParam(request.getParameter("no"), 0L);
		int page = WebUtil.checkIntParam(request.getParameter("p"), 1);

		HttpSession session = request.getSession();

		UserVo authUser = (UserVo) session.getAttribute("authUser");

		BoardDao dao = new BoardDao();
		BoardVo boardVo = dao.view(no);
		
		if (boardVo == null) {
			WebUtil.redirect(request, response, "/board");
			return;
		}
		
		//조회수
		dao.updateHit(no);
		
		request.setAttribute("boardVo", boardVo);
		request.setAttribute("page", page);
		request.setAttribute("authUser", authUser);
		
		WebUtil.forward(request, response, "/WEB-INF/views/board/view.jsp");

	}

}
