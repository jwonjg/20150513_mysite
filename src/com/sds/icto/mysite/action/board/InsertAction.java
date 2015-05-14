package com.sds.icto.mysite.action.board;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sds.icto.mysite.dao.BoardDao;
import com.sds.icto.mysite.servlet.action.Action;
import com.sds.icto.mysite.vo.BoardVo;
import com.sds.icto.mysite.vo.MemberVo;

public class InsertAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response)
			throws ClassNotFoundException, SQLException, ServletException,
			IOException {
		BoardDao dao = new BoardDao();
		MemberVo authUser = (MemberVo)request.getSession().getAttribute("authUser");
		
		if(authUser != null){
			dao.insert(new BoardVo(authUser.getNo(), request.getParameter("title"), request.getParameter("content")));
			response.sendRedirect("board");
		}else{
			request.getRequestDispatcher("/views/user/loginform.jsp").forward(request, response);
		}
	}

}
