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
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.List;
import java.util.Scanner;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
/**
 *
 * @author zavie_000
 */
@WebServlet(name = "Upload", urlPatterns = {"/Upload"})
public class Upload extends HttpServlet 
{       
    private static final long serialVersionUID = 1L;
    private static final String DATA_DIRECTORY = "data";
    private static final int MAX_FILE_SIZE = 1024 * 1024 * 400; // 400MB
    private static final int MAX_MEMORY_SIZE = 1024 * 1024 * 5; //5MB
    private static final int MAX_REQUEST_SIZE = 1024 * 1024 * 500; //500MB
    
    String fileName = "";
    static String sectionID = "";
    
    public static void setID(String secID)
    {
        sectionID = secID;
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.write("<html><head></head><body>");
        // Check that we have a file upload request
        if (!ServletFileUpload.isMultipartContent(request)) 
        {
            // if not, we stop here
            PrintWriter writer = response.getWriter();
            writer.println("Error: Form must has enctype=multipart/form-data.");
            writer.flush();
            return;
        }
       
        // Create a factory for disk-based file items
        DiskFileItemFactory factory = new DiskFileItemFactory();

        // Sets the size threshold beyond which files are written directly to
        // disk.
        factory.setSizeThreshold(MAX_MEMORY_SIZE);

        // Sets the directory used to temporarily store files that are larger
        // than the configured size threshold. We use temporary directory for
        // java
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

        // constructs the folder where uploaded file will be stored
        String temp_folder = " ";
         try {
            String dataFolder  = getServletContext().getRealPath("") + File.separator + DATA_DIRECTORY;
            temp_folder = dataFolder;
            File uploadD = new File(dataFolder);
            if (!uploadD.exists()) 
            {
                uploadD.mkdir();
            }     
            
            ResultList rs5 = DB.query("SELECT * FROM course AS c, section AS s, year_semester AS ys, upload_checklist AS uc WHERE s.courseCode = c.courseCode "
                           + "AND s.semesterID = ys.semesterID AND s.courseID = c.courseID AND s.sectionID=" + sectionID);                                
            rs5.next();           
            
        // Create a new file upload handler
        ServletFileUpload upload = new ServletFileUpload(factory);
        
        // Sets maximum size of upload file
        upload.setFileSizeMax(MAX_FILE_SIZE);
        
        // Set overall request size constraint
        upload.setSizeMax(MAX_REQUEST_SIZE);
        
        // creates the directory if it does not exist
        String path1 = getServletContext().getContextPath()+ "/" + DATA_DIRECTORY + "/";
        String temp_semester = rs5.getString("year") + "-" + rs5.getString("semester");
        String real_path = temp_folder + File.separator + temp_semester;
        File semester = new File (real_path); 

        if (!semester.exists()) 
        {
            semester.mkdir();           
        }
        path1 += temp_semester + "/";
        real_path += File.separator;       
    
        String temp_course = rs5.getString("courseCode") + rs5.getString("courseID") + "-" + rs5.getString("courseName");
        String real_path1 = real_path + temp_course;
        File course = new File (real_path1);
        if (!course.exists()) 
        {
            course.mkdir();           
        }
         path1 += temp_course + "/";
         real_path1 += File.separator;       
        
        String temp_section = "section-" + rs5.getString("sectionNo");
        String real_path2 = real_path1 + temp_section;
        File section = new File (real_path2); 
        if (!section.exists()) 
        {
            section.mkdir();
        }
        path1 += temp_section + "/";
        real_path2 += File.separator;         
        String sectionPath = path1;
        
            // Parse the request
            List<FileItem> items = upload.parseRequest(request);
            if (items != null && items.size() > 0) 
            {
                // iterates over form's fields
                for (FileItem item : items) 
                {                    
                    // processes only fields that are not form fields
                    if (!item.isFormField() && !item.getName().equals("")) 
                    {
                        String DBPath = "";
                        System.out.println(item.getName()+" file is for " + item.getFieldName());
                        Scanner field_name = new Scanner(item.getFieldName()).useDelimiter("[^0-9]+");
                        int id = field_name.nextInt();
                        fileName = new File(item.getName()).getName();
                        ResultList rs = DB.query("SELECT * FROM upload_checklist WHERE checklistID =" + id);
                        rs.next();
                        String temp_file = rs.getString ("label");
                        String real_path3 = real_path2 + temp_file;
                        File file_type = new File (real_path3); 
                        if (!file_type.exists()) 
                            file_type.mkdir();
                        DBPath = sectionPath + "/" + temp_file + "/";
                        String context_path = DBPath;
                        real_path3 += File.separator;  
                        String filePath = real_path3 + fileName;                        
                        DBPath += fileName;                                               
                        String temp_DBPath = DBPath;
                        
                        int count = 0;
                        File f = new File (filePath);
                        String temp_fileName = f.getName();
                        String fileNameWithOutExt = FilenameUtils.removeExtension(temp_fileName);
                        String extension = FilenameUtils.getExtension(filePath);
                        String newFullPath = filePath;
                        String tempFileName = " ";

                        while(f.exists()) 
                        {
                            ++count;
                            tempFileName = fileNameWithOutExt + "_(" + count + ").";
                            newFullPath = real_path3 + tempFileName + extension;
                            temp_DBPath = context_path + tempFileName + extension;
                            f = new File (newFullPath);
                        } 
                                              
                        filePath = newFullPath;
                        System.out.println ("New path: " + filePath);
                        DBPath = temp_DBPath;
                        String changeFilePath = filePath.replace('/','\\'); 
                        String changeFilePath1 = changeFilePath.replace("Course_File_Management_System\\", "");                                                                      
                        File uploadedFile = new File(changeFilePath1);
                        System.out.println("Change filepath = "+changeFilePath1); 
                        System.out.println("DBPath = " +DBPath);
                        // saves the file to upload directory
                        item.write(uploadedFile); 
                        String query = "INSERT INTO files (fileDirectory) values('"+DBPath+"')";
                        DB.update(query);
                        ResultList rs3 = DB.query("SELECT label FROM upload_checklist WHERE id=" + id);
                        while(rs3.next()) 
                        { 
                            String label = rs3.getString("label");
                            out.write("<a href=\"Upload?fileName=" + changeFilePath1 + "\">Download "+ label +"</a>");
                            out.write("<br><br>");                            
                        }
                        ResultList rs4 = DB.query("SELECT * FROM files ORDER BY fileID DESC LIMIT 1");
                        rs4.next();
                        String query2 = "INSERT INTO lecturer_upload (fileID, sectionID, checklistID) values("+rs4.getString("fileID")+", "+sectionID+", "+id+")";
                        DB.update(query2);
                    }
                }    
            }           
        } 
        catch (FileUploadException ex) 
        {
            throw new ServletException(ex);
        } 
        catch (Exception ex) 
        {
            throw new ServletException(ex);
        }
        response.sendRedirect(request.getHeader("Referer"));
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        String filePath = request.getParameter("fileName");

        if(filePath == null || filePath.equals(""))
        {
            throw new ServletException("File Name can't be null or empty");
        }

        File file = new File(filePath);

        if(!file.exists())
        {
            throw new ServletException("File doesn't exists on server.");
        }

        ServletContext ctx = getServletContext();

        try (InputStream fis = new FileInputStream(file))
        {
            String mimeType = ctx.getMimeType(file.getAbsolutePath());
            
            response.setContentType(mimeType != null? mimeType:"application/octet-stream");
            response.setContentLength((int) file.length());
            response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
            
            try (ServletOutputStream os = response.getOutputStream()) 
            {
                byte[] bufferData = new byte[1024];
                int read = 0;
                
                while((read = fis.read(bufferData))!= -1)
                {
                    os.write(bufferData, 0, read);
                }
                os.flush();
                os.close();
                fis.close();
            }
        }
    }
}