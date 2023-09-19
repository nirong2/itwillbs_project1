package com.team2.board.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team2.board.db.ENFBoardDAO;
import com.team2.board.db.ENFBoardDTO;
import com.team2.util.Action;
import com.team2.util.ActionForward;
import com.team2.util.JSMethod;

public class ENFBoardSearchAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		request.setCharacterEncoding("UTF-8");
		// DB - BoardDAO 객체- M
		ENFBoardDAO dao = new ENFBoardDAO();
		Byte category = (byte) Integer.parseInt(request.getParameter("category"));
//		System.out.println("category : "+category );
		String searchField = request.getParameter("searchField");
//		System.out.println("searchField : "+searchField);
		String searchText = request.getParameter("searchText");
//		System.out.println("searchText : "+searchText);
		// 작성되어 있는 전체 글의 개수 계산(DB메서드) -M
		if (searchField.equals("0")) {
			JSMethod.alertBack(response, "선택해주세요!");
			return null;
		} else if (searchText.equals("")) {
			JSMethod.alertBack(response, "검색할내용을 입력하세요!");
			return null;
		}
		int count = dao.getBoardCount(category, searchField, searchText);
		System.out.println(" M : 전체 글 개수 : " + count + "개");
		// 페이징처리-1 -M
		//////////////// 페이징처리 -1 /////////////////

		int pageSize = 5; // 한페이지에 5개씩 출력

		// 페이지의 정보(몇페이지인지 확인하는 정보)
		String pageNum = request.getParameter("pageNum");
		if (pageNum == null) {
			pageNum = "1"; // 페이지가 없을경우
		}

		// 시작행 번호 계산 1 11 21 31 ...
		int currentPage = Integer.parseInt(pageNum);

		int startRow = (currentPage - 1) * pageSize + 1;

		// 끝행 번호 계산 10 20 30 40
		int endRow = currentPage * pageSize;
		//////////////// 페이징처리 -1 /////////////////

		// 페이징처리 글 데이터를 가져오기(DB메서드) -M
		List<ENFBoardDTO> boardList = null;
		if (count > 0) {
			boardList = dao.searchGetBoardListPage(category, searchField, searchText, startRow, pageSize);
		}
		// 테이블에 출력(반복문) ->view

		// 페이징 처리-2 -M
		// 전체 페이지 수 => 글 / 페이지당 출력 개수
		// 50 / 10 => 5 55 / 10 => 6
		int pageCount = count / pageSize + (count % pageSize != 0 ? 1 : 0);

		// 한 화면에서 보여줄 페이지번호 개수(block) 1....10
		int pageBlock = 4;

		// 페이지 블럭의 시작번호 1~10 => 1 11~20 => 11 21~30 => 21
		int startPage = ((currentPage - 1) / pageBlock) * pageBlock + 1;

		// 페이지 블럭의 끝 번호 1~10 => 10 11~20 => 20 21~30 => 30
		int endPage = startPage + pageBlock - 1;
		if (endPage > pageCount) {
			endPage = pageCount;
		}

		// 페이징처리 블럭출력 ->view

		// Model -> 데이터 처리동작(DB사용, 계산동작들....)
		// View -> 정보 전달받아서 출력

		// 계산된 정보를 view 페이지로 전달(request 영역에 저장)
		// boardList, 페이징처리 정보

		request.setAttribute("boardList", boardList);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("count", count);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("pageBlock", pageBlock);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("searchField", searchField);
		request.setAttribute("searchText", searchText);
		// 페이지이동
		ActionForward forward = new ActionForward();
		forward.setPath("./enfSearchBoard.jsp");
		forward.setRedirect(false);

		return forward;

	}

}
