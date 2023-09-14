package com.team2.user.action;

<<<<<<< HEAD
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.team2.user.DB.UserDAO;
import com.team2.util.Action;
import com.team2.util.ActionForward;

public class UserDeleteAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		System.out.println(" M : MemberDeleteAction_execute 호출! ");
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		ActionForward forward = new ActionForward();
		if(id == null) {
			forward.setPath("./Main.me");
			forward.setRedirect(true);
			return forward;
		}
		String pw = request.getParameter("pw");
		
		UserDAO dao = new UserDAO();
		dao.UserDelete(id, pw);
=======
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team2.user.DB.UserDAO;
import com.team2.user.DB.UserDTO;
import com.team2.util.Action;
import com.team2.util.ActionFoward;

public class UserDeleteAction implements Action {

	@Override
	public ActionFoward execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		UserDAO dao = new UserDAO();
		UserDTO dto = new UserDTO();
		
		dto.setUser_id(req.getParameter("user_id"));
		dto.setUser_pass(req.getParameter("user_pass"));
		System.out.println(dto.getUser_id());
		System.out.println(dto.getUser_pass());
		int result = dao.deleteUserInfo(dto);
		
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter out = resp.getWriter();
		
		if(result == 1) {
			out.println("<script>");
			out.println("alert('회원탈퇴 성공');");
			out.println("location.href='./UserLogout.me'");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('회원탈퇴 실패');");
			out.println("history.back();");
			out.println("</script>");
		}
>>>>>>> 963d24660cc8c19a1463f6ef1b624f80fb4dbb36
		
		return null;
	}

}
