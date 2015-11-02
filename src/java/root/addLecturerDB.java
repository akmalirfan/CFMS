/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package root;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import common.DB;

/**
 *
 * @author Yansheng
 */
@WebServlet(name = "addLecturerDB", urlPatterns = {"/addLecturerDB"})
public class addLecturerDB extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String name = request.getParameter("name");
            String emailAdd = request.getParameter("emailAdd");
            String phoneNo = request.getParameter("phoneNo");
            String department = request.getParameter("department");
            String status = request.getParameter("status");
            String view = request.getParameter("view");

	int rs = DB.update("INSERT INTO user (`username`, `password`, `usertype`, `viewPermission`) VALUES ('" + username + "', '" + password + "', 'lecturer', '" + view + "')");

	int rs2 = DB.update("INSERT INTO profile (`name`, `emailAdd`, `phoneNo`, `departmentID`, `status`, `username`) VALUES ('"+ name+ "', '"+ emailAdd +"', '"+ phoneNo +"', '"+ department +"', '"+ status +"', '"+ username +"')");

	response.sendRedirect("root/viewLecturers.jsp");
        
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet addLecturerDB</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet addLecturerDB at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
