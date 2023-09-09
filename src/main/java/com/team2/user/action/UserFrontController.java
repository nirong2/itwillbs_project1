package com.team2.user.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team2.util.Action;
import com.team2.util.ActionFoward;

public class UserFrontController extends HttpServlet {

	protected void doProcess(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ActionFoward af = null;
		
		////주소 계산//////////////////////////
		String uri = request.getRequestURI();
		System.out.println(uri);
		String ss = request.getContextPath();
		String command = uri.substring(ss.length());
		Action action = null;
		
		////이동 방식 계산////////////////////
		//로그인 페이지
		if( command.equals("/UserLogin.me") ) {
			af = new ActionFoward();
			af.setPath("./user/loginForm.jsp");
			af.setRedirect(false);
		}
		//로그인 처리
		else if( command.equals("/UserLoginAction.me") ) {
			action = new UserLoginAction();
			
			try {
				af =  action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		//로그인 아이디 중복 확인
		else if(command.equals("/UserIdCheckAction.me")) {
			action = new UserIdCheckAction();
			
			try {
				af =  action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		//비회원 로그인 처리
		else if( command.equals("/NonUserLoginAction.me") ) {
			action = new NonUserLoginAction();
			
			try {
				af =  action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		//메인 페이지
		else if( command.equals("/Main.me") ) {
			af = new ActionFoward();
			af.setPath("./main.jsp");
			af.setRedirect(false);
		}
		//로그아웃 처리
		else if( command.equals("/UserLogoutAction.me") ) {
			action = new UserLogoutAction();
			
			try {
				af = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		//아이디 찾기
		else if( command.equals("/UserFindId.me") ) {
			af = new ActionFoward();
			af.setPath("./user/findIdForm.jsp");
			af.setRedirect(false);
		}
		//아이디 찾기 처리
		else if( command.equals("/UserFindIdAction.me") ) {
			action = new UserFindIdAction();
			
			try {
				af = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//비밀번호 찾기	
		else if( command.equals("/UserFindPw.me") ) {
			af = new ActionFoward();
			af.setPath("./user/findPwForm.jsp");
			af.setRedirect(false);
		}
		//비밀번호 찾기 처리
		else if( command.equals("/UserFindPwAction.me") ) {
			action = new UserFindPwAction();
			try {
				af = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		//회원가입
		else if( command.equals("/UserJoin.me") ) {
			af = new ActionFoward();
			af.setPath("./user/joinForm.jsp");
			af.setRedirect(false);
		}
		//회원가입 처리
		else if( command.equals("/UserJoinAction.me") ) {
			action = new UserJoinAction();
			try {
				af = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		//이제부터 게시판-------------------------------------------------------------
		//게시판 메인
//		else if( command.equals("/BoardMain.me") ) {
//			action = new BoardMainAction();
//			try {
//				af = action.execute(request, response);
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//		}
//		//글 읽기
//		else if( command.equals("/BoardRead.me") ) {
//			action = new BoardReadAction();
//			try {
//				af = action.execute(request, response);
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//		}
		
		////3.주소로 이동////////////
		if( af != null ) {
			if( af.isRedirect() ) {
				System.out.println( af.getPath() +" ##"+ af.isRedirect() );     
				response.sendRedirect( af.getPath() );
			}else {
				System.out.println( af.getPath() +" ##"+ af.isRedirect() );
				RequestDispatcher dis = request.getRequestDispatcher(af.getPath());
				dis.forward(request, response);
			}
		}
		System.out.println();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doProcess(request, response);
		System.out.println("doGet()");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doProcess(request, response);
		System.out.println("doPost()");

	}

}
