/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CourseFileManagementSystem;

import common.DB;
import common.ResultList;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author zavie_000
 */
@WebServlet(name = "Delete", urlPatterns = {"/Delete"})
public class Delete extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    static String sectionID = " ";
    
    public static void setID(String secID)
    {
        sectionID = secID;
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.write("<html><head></head><body>");
        String fileID = request.getParameter("fileID");
        ResultList rs = DB.query("SELECT * FROM files WHERE fileID =" + fileID);
        
        rs.next();
        String filePath = rs.getString("fileDirectory");
        String changeFilePath = filePath.replace('/','\\');
        String changeFilePath1 = changeFilePath.replace("Course_File_Management_System\\", "");
        String uploadFolder = getServletContext().getRealPath("") + changeFilePath1;
        System.out.println(uploadFolder);
        FileInputStream in = new FileInputStream(uploadFolder);
        in.close();
        File file = new File (uploadFolder);
        System.out.println (uploadFolder);
        boolean blnDeleted = file.delete();
        System.out.println("Was file deleted ? : " + blnDeleted);
        String query1 = "DELETE FROM lecturer_upload WHERE fileID=" + fileID;
        String query2 = "DELETE FROM files WHERE fileID=" + fileID;
        System.out.print(query1);
        System.out.print(query2);
        DB.update(query1);
        DB.update(query2);
        response.sendRedirect(request.getHeader("Referer"));       
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
