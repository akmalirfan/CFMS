/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package user;

import common.DB;
import common.ResultList;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Kiwi
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

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
            String username = request.getParameter("inputUsername");
            String password = request.getParameter("inputPassword");
            HttpSession session = ((HttpServletRequest) request).getSession();
            String query = "SELECT * FROM user AS u, profile AS p WHERE u.username = p.username AND u.username='" + username + "'";
            System.out.println(query);
            ResultList rs = DB.query(query);
            if (rs.next()) {  
                String userTypeFromDB = rs.getString("usertype");
                if (rs.getString("password").equals(password)) { // If valid password
                    session.setAttribute("User", username); // Saves username string in the session object
                    session.setAttribute("name",  rs.getString("name"));
                    session.setAttribute("viewPermission",  rs.getString("viewPermission"));
                    if(userTypeFromDB.equals("super")) {
                        session.setAttribute("userType", "root");
                        session.setAttribute("isSuper", "true");
                    }
                    else {
                        session.setAttribute("userType", userTypeFromDB);
                    }
                    //out.println("password inputted = password in DB = username & pwd found in system");
                }
                else { // Password does not match, i.e., invalid user password
                    session.setAttribute("Login Error", "Invalid password.");
                    //out.println("password inputted != password in DB BUT username found in system");
                }
            } else { // No record in the result set, i.e., invalid username
                session.setAttribute("Login Error", "User not found.");
            }
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginServlet at " + request.getContextPath() + "</h1>");
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
