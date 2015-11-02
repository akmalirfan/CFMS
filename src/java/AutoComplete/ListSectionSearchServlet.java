/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package AutoComplete;

import common.DB;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import common.ViewPermission;
import java.util.Enumeration;

/**
 *
 * @author Kiwi
 */
@WebServlet(name = "ListSectionSearchServlet", urlPatterns = {"/ListSectionSearchServlet"})
public class ListSectionSearchServlet extends HttpServlet {

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
            try {
                String viewPermission = request.getParameter("viewPermission");
                HttpSession session = ((HttpServletRequest) request).getSession();
                ViewPermission userPermission = ViewPermission.valueOf((String)session.getAttribute("viewPermission"));
                ViewPermission requestPermission = ViewPermission.valueOf(viewPermission);
                String query = "SELECT";
                
                if(userPermission.ordinal() >= requestPermission.ordinal()) {
                    String value = request.getParameter("value");
                    String label = request.getParameter("label");
                    String term = request.getParameter("term");
                    String[] cols = request.getParameterValues("col[]");
                    String semesterID = request.getParameter("semesterID");
                    String username = request.getParameter("username");
                    String courseID = request.getParameter("courseID");
                    String courseCode = request.getParameter("courseCode");
                    String departmentID = request.getParameter("departmentID");
                    
                    if(cols == null) {
                        String[] temp = {"*"};
                        cols = temp;
                    }
                    else if(cols[0] == null || cols[0].equals(""))
                        cols[0] = "*";
                    else
                        for(int i = 0; i < cols.length-1; ++i) {
                            cols[i] += ", ";
                        }
                    
                    query = "SELECT DISTINCT ";
                    for(String col: cols) {
                        query += col;
                    }
                    query +=" FROM year_semester AS y, department AS d, section AS s, profile AS p, course AS c WHERE " +
                            "y.semesterID = s.semesterID AND s.username = p.username AND s.courseCode = c.courseCode AND " +
                            "s.courseID = c.courseID AND d.departmentID = p.departmentID ";
                    if(departmentID!=null && !departmentID.equals("")) {
                        query += "AND d.departmentID = '" + departmentID + "' ";
                    }
                    if(courseID != null && courseCode != null && !courseID.equals("") && !courseCode.equals("")) {
                        query += "AND c.courseID = " + courseID + " AND c.courseCode = '" + courseCode + "' ";
                    }
                    if(username != null && !username.equals("")) {
                        query += "AND s.username ='" + username + "' ";
                    }
                    if(semesterID != null && !semesterID.equals("")) {
                        query += "AND s.semesterID = " + semesterID + " ";
                    }
                    out.print(DB.createJson(query, label, value, term));
                }
                else {
                    out.print("{\"label\":\"You Don't have Permission To Do So\"}");
                }
            } catch(Exception e) {
                e.printStackTrace();
            }
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
