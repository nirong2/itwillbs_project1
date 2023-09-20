package com.team2.board.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team2.util.Action;
import com.team2.util.ActionForward;

public class introduceMainAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {

		
		// 페이지이동
				ActionForward forward = new ActionForward();
				forward.setPath("./board/introduceMain.jsp");
				forward.setRedirect(false);
				
		return forward;
	}

}
