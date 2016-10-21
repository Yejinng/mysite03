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

public class WriteAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if (session == null) {
			WebUtil.redirect(request, response, "/board");
			return;
		}

		UserVo authUser = (UserVo) session.getAttribute("authUser");
		if (authUser == null) {
			WebUtil.redirect(request, response, "/board");
			return;
		}

		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String gn = request.getParameter("gn");
		String on = request.getParameter("on");
		String dep = request.getParameter("dep");

		BoardDao dao = new BoardDao();
		BoardVo vo = new BoardVo();

		vo.setTitle(title);
		vo.setContent(content);
		vo.setUserNo(authUser.getNo());

		if (gn != null) {
			int groupNo = Integer.parseInt(gn);
			int orderNo = Integer.parseInt(on);
			int depth = Integer.parseInt(dep);

			dao.increaseGroupOrder(groupNo, orderNo);

			vo.setGroupNo(groupNo);
			vo.setOrderNo(orderNo + 1);
			vo.setDepth(depth + 1);
		}
		dao.insert(vo);


		WebUtil.redirect(request, response, "/board?a=list&write=success");
	}

}
