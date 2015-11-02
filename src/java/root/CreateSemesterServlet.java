/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package root;

import common.DB;
import common.ResultList;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Kiwi
 */
@WebServlet(name = "CreateSemesterServlet", urlPatterns = {"/CreateSemesterServlet"})
public class CreateSemesterServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.sql.SQLException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String year = request.getParameter("year");
            int semester = Integer.parseInt(request.getParameter("semester"));
            String query = "INSERT INTO year_semester (year, semester) VALUES (\'"+year+"\', "+semester+")";
            
            DB.update(query);
            
            if(semester!=3){
            
            ResultList rs1 = DB.query("SELECT courseCode, courseID FROM batch_courses WHERE label=1");
            ResultList rs2 = DB.query("SELECT semesterID FROM year_semester ORDER BY semesterID DESC LIMIT 1");
            rs2.next();
            while(rs1.next())
            {
              int rs3 = DB.update("INSERT INTO course_offered (semesterID, courseCode, courseID) VALUES ("+rs2.getString("semesterID")+", '"+rs1.getString("courseCode")+"', "+rs1.getString("courseID")+")");

           }
            
        //    int rs4 = DB.update("UPDATE batch_courses SET label= label - 1 WHERE label > 0");
            
            }
            
            response.sendRedirect(request.getHeader("Referer"));
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet BMIServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Result</h1>");
            out.println(query+"<br>");
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(CreateSemesterServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(CreateSemesterServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
