/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package root;

import common.DB;
import common.ResultList;
import common.ViewPermission;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Kiwi
 */
@WebServlet(name = "UpdatePenyelarasServlet", urlPatterns = {"/UpdatePenyelarasServlet"})
public class UpdatePenyelarasServlet extends HttpServlet {

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
            String co_ID = request.getParameter("course_offered_ID");
            String query1 = "SELECT * FROM course_offered AS co WHERE co.course_offered_ID = " + co_ID;
            ResultList rs1 = DB.query(query1);
            rs1.next();
            
            String query2 = "UPDATE course_offered SET username = '"+username+"' WHERE course_offered_ID="+ co_ID;
            DB.update(query2);
            query2 = "SELECT * FROM user WHERE username = '" + username + "'";
            ResultList rs2 = DB.query(query2);
            rs2.next();
            ViewPermission permission2 = ViewPermission.valueOf(rs2.getString("viewPermission"));
            if(permission2.ordinal() <= ViewPermission.PENYELARAS.ordinal()) {
                query2 = "UPDATE user SET viewPermission='" + ViewPermission.PENYELARAS.name() + "' WHERE username='" + username + "'";
                DB.update(query2);
            }
            if(rs1.getString("username") != null && !rs1.getString("username").equals("")) {
                String previous = rs1.getString("username");
                query1 = "SELECT * FROM user WHERE username = '" + previous + "'";
                rs1 = DB.query(query1);
                rs1.next();
                ViewPermission permission1 = ViewPermission.valueOf(rs1.getString("viewPermission"));
                if(permission1.ordinal() <= ViewPermission.PENYELARAS.ordinal()) {
                    query1 = "SELECT * FROM course_offered WHERE username = '" + previous + "'";
                    rs1 = DB.query(query1);
                    if(!rs1.next()){
                        query1 = "UPDATE user SET viewPermission='" + ViewPermission.LECTURER.name() + "' WHERE username='" + previous + "'";
                            out.println(query1);
                        DB.update(query1);
                    }
                }
            }
            response.sendRedirect(request.getHeader("Referer"));
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddPenyelarasServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>"+query1+"</h1>");
            out.println("</body>");
            out.println("</html>");
        }    }

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
