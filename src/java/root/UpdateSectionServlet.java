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
@WebServlet(name = "UpdateSectionServlet", urlPatterns = {"/UpdateSectionServlet"})
public class UpdateSectionServlet extends HttpServlet {

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
            if(request.getParameter("username") == null) {
                HttpSession session = request.getSession();
                session.setAttribute("Form Error", "You missed some field.");
                response.sendRedirect(request.getHeader("Referer"));
                return;
            }
            String username[] = request.getParameterValues("username");
            String sectionNo = request.getParameter("sectionNo");
            String sectionID = request.getParameter("sectionID");
            String sectionMajor = request.getParameter("sectionMajor");
            String query = "UPDATE section SET username = '"+username[0]+"', sectionNo = " + sectionNo +", sectionMajor='" + sectionMajor +"' " +
                    "WHERE sectionID="+ sectionID;
            DB.update(query);
            //Delete current list
            String query2 = "DELETE FROM section_lecturer WHERE sectionID="+sectionID;
            DB.update(query2);
            for(String name: username) {
                out.println("Username:" + name + "<br>");
                String query3 = "INSERT INTO section_lecturer(username, sectionID) VALUES('"+name+"', "+sectionID+")";
                DB.update(query3);
            }
            query = "SELECT * from section where sectionID=" + sectionID;
            ResultList rs = DB.query(query);
            rs.next();
            response.sendRedirect("root/sections.jsp?semesterID="+rs.getString("semesterID")+"&course_offered_ID="+rs.getString("course_offered_ID"));
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateSectionServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>" +query+ "</h1>");
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
