package com.move.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.move.service.MoveImplement;

/**
 * Servlet implementation class MoveController
 */
@WebServlet("/MoveController")
public class MoveController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public MoveController() {
    }	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
	    HttpSession session = request.getSession();
	    RequestDispatcher dispatcher;

	    
	    
		String destination=request.getParameter("destination");
		String moveButton=request.getParameter("butn");

		MoveImplement moveImplement=new MoveImplement();
		request.setAttribute("title","a");
		
		
		if(moveButton.equalsIgnoreCase("Search & Move")) {
			try
			{				 		
						response.sendRedirect("Index.jsp");
			}
			catch (Exception e)
			{
				System.out.println("Exception");
				response.sendRedirect("Issue.jsp");
			}
			}
		
		
		if(moveButton.equalsIgnoreCase("Find Directions on Map")) {
			try
			{				 		
						response.sendRedirect("Index.jsp");
			}
			catch (Exception e)
			{
				System.out.println("Exception");
				response.sendRedirect("Issue.jsp");
			}
			}
		
		if(moveButton.equalsIgnoreCase("Go")) {
			try
			{		
				String[] title=moveImplement.searchLocation(destination);
				request.setAttribute("title",title);
				dispatcher= request.getRequestDispatcher("Index.jsp");
				dispatcher.forward(request,response);

			}
			catch (Exception e)
			{
				System.out.println("Exception");
			}
			}		
		
	}

}
