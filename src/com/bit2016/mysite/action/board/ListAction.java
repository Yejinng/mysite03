package com.bit2016.mysite.action.board;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bit2016.mysite.dao.BoardDao;
import com.bit2016.mysite.vo.BoardVo;
import com.bit2016.web.Action;
import com.bit2016.web.util.WebUtil;

public class ListAction implements Action {

	private static final int LIST_SIZE = 5;
	private static final int PAGE_SIZE = 5;

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int page = WebUtil.checkIntParam(request.getParameter("p"), 1);

		BoardDao dao = new BoardDao();

		List<BoardVo> list = dao.getList(page, LIST_SIZE);

		int totalCount = dao.TotalCount();
		int pageCount = (int) Math.ceil((double)totalCount / LIST_SIZE);

		//page
		int totalBlock = (int)((pageCount - 1)/PAGE_SIZE + 1);
		int currentBlock = (int)((page - 1)/PAGE_SIZE + 1);
		int endPage = (int)((PAGE_SIZE * currentBlock));
		int startPage = (int)(endPage - (PAGE_SIZE - 1));
		int nextPage = (int)((currentBlock  *PAGE_SIZE) +1);
		int prevPage = (int)((currentBlock -1)* PAGE_SIZE);
		
		request.setAttribute("list", list);
		request.setAttribute("totalCount", totalCount);
		request.setAttribute("currentPage", page);
		request.setAttribute("listSize", LIST_SIZE);
		request.setAttribute("totalBlock", totalBlock);
		request.setAttribute("currentBlock", currentBlock);
		request.setAttribute("endPage", endPage);
		request.setAttribute("startPage", startPage);
		request.setAttribute("pageCount", pageCount);
		request.setAttribute("nextPage", nextPage);
		request.setAttribute("prevPage", prevPage);
		
		WebUtil.forward(request, response, "/WEB-INF/views/board/list.jsp");
	}

}
