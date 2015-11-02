/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CourseFileManagementSystem;

import static CourseFileManagementSystem.Upload.sectionID;
import common.DB;
import common.ResultList;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.zeroturnaround.zip.ZipUtil;

/**
 *
 * @author Kiwi
 */
@WebServlet(name = "DownloadAsZip", urlPatterns = {"/DownloadAsZip"})
public class DownloadAsZip extends HttpServlet {

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
            String sectionID = request.getParameter("sectionID");
            ResultList rs = DB.query("SELECT * FROM course AS c, section AS s, year_semester AS ys, upload_checklist AS uc WHERE s.courseCode = c.courseCode "
                           + "AND s.semesterID = ys.semesterID AND s.courseID = c.courseID AND s.sectionID=" + sectionID);                                
            rs.next(); 
            
            String semester = rs.getString("year") + "-" + rs.getString("semester");
            String course = rs.getString("courseCode") + rs.getString("courseID") + "-" + rs.getString("courseName");
            String section = "section-" + rs.getString("sectionNo");
            String courseName = rs.getString("courseName");
            String shortForm = rs.getString ("shortForm");
            String folderPath = getServletContext().getRealPath("") + File.separator + "data" + File.separator + semester + File.separator;           
            String zipPath = "temp";
            File tempDirectory = new File(getServletContext().getRealPath("") + File.separator + zipPath);
            System.out.println("PATH = " + getServletContext().getRealPath("") + File.separator + zipPath);
            
            if (!tempDirectory.exists()) 
            {                
                tempDirectory.mkdir();
            }
            zipPath += File.separator;
            
            String zipAs = request.getParameter("zipAs");
            
            String name = "";

            if(zipAs.equals("course")) 
            {
                folderPath += course;
                zipPath += course + ".zip";
                name = course;
            }
            else if(zipAs.equals("section")) 
            {
                folderPath += course + File.separator + section;
                zipPath += course + " - " + section + ".zip";
                name = section;
            }
            else if(zipAs.equals("checklist")) 
            {
                String checklist_id = request.getParameter("checklistID");
                ResultList rs1 = DB.query ("SELECT * FROM upload_checklist WHERE checklistID=" + checklist_id);
                rs1.next();
                
                String checklist = rs1.getString("label");     
                folderPath += course + File.separator + section + File.separator + checklist;
                zipPath += course + " - " + section + " - " + checklist + ".zip";
                name = checklist;
            }
            String zipRealPath = getServletContext().getRealPath("") + File.separator + zipPath;
            String zipRealPath1 = zipRealPath.replace(courseName, shortForm);
            String zipContextPath = getServletContext().getContextPath() + File.separator + zipPath;
            String zipContextPath1 = zipContextPath.replace(courseName, shortForm);
            ZipUtil.pack(new File(folderPath), new File(zipRealPath1));            
            
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DownloadAsZip</title>");            
            out.println("<meta http-equiv=\"refresh\" content=\"0; url="+zipContextPath1+"\"/>"); 
            out.println("<script>setTimeout(\"window.close()\", 100);</script>"); 
            out.println("</head>");
            out.println("<body>");
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
