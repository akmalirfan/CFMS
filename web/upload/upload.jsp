<%-- 
    Document   : upload
    Created on : Jul 29, 2015, 10:08:11 PM
    Author     : zavie_000
--%>

<%@page import="common.ResultList"%>
<%@page import="CourseFileManagementSystem.Delete"%>
<%@page import="java.nio.file.Paths"%>
<%@page import="java.nio.file.Path"%>
<%@page import="java.io.ByteArrayInputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.File"%>
<jsp:include page="../header.jsp"/>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*, common.DB, java.util.*, CourseFileManagementSystem.Upload" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>File Upload</title>
        <!-- bootstrap.js below is only needed if you wish to the feature of viewing details
             of text file preview via modal dialog -->       
        <style type="text/css">
            .fileUpload {
                position: relative;
                overflow: hidden;
                text-align: left;
            }           
            .fileUpload input.upload {
                position: absolute;
                top: 0;
                right: 0;
                margin: 0;
                padding: 0;
                font-size: 20px;
                cursor: pointer;
                opacity: 0;
                filter: alpha(opacity=0);
            }
            input[type="submit"] {
                display: block;
            }
            #uploadFile {
                line-height: 28px;
            }           
            
            table a:link {
            color: #666; //dark grey
            font-weight: bold;
            text-decoration:none;
            }
            table a:visited {
                    color: #999999;
                    font-weight:bold;
                    text-decoration:none;
            }
            table a:active,
            table a:hover {
                    color: #bd5a35; //moderate orange
                    text-decoration:underline;
            }
            table {
                    font-family:Arial, Helvetica, sans-serif;
                    color:#666;
                    font-size:14px;
                    text-shadow: 1px 1px 0px #fff;
                    background:#eaebec; //light grayish blue
                    margin:10px;
                    border:#ccc 1px solid;

                    -moz-border-radius:3px;
                    -webkit-border-radius:3px;
                    border-radius:3px;

                    -moz-box-shadow: 0 1px 2px #d1d1d1;
                    -webkit-box-shadow: 0 1px 2px #d1d1d1;
                    box-shadow: 0 1px 2px #d1d1d1;
            }
            table th {
                    padding:5px 10px 10px 10px;
                    border-top:1px solid #fafafa; //very light gray
                    border-bottom:1px solid #e0e0e0; //very light gray

                    background: #ededed; //very light gray
                    background: -webkit-gradient(linear, left top, left bottom, from(#ededed), to(#ebebeb));
                    background: -moz-linear-gradient(top,  #ededed,  #ebebeb);
            }
            table td {
                    padding:5px;
                    border-top: 1px solid #ffffff;
                    border-bottom:1px solid #e0e0e0;
                    border-left: 1px solid #e0e0e0;

                    background: #fafafa;
                    background: -webkit-gradient(linear, left top, left bottom, from(#fbfbfb), to(#fafafa));
                    background: -moz-linear-gradient(top,  #fbfbfb,  #fafafa);
            }
            
            .upload-drop-zone {
                height: 200px;
                border-width: 2px;
                 margin-bottom: 20px;
            }

/* skin.css Style*/
            .upload-drop-zone {
                color: #ccc;
                border-style: dashed;
                border-color: #ccc;
                line-height: 200px;
                text-align: center
            }
            
            .upload-drop-zone.drop {
                color: #222;
                border-color: #222;
            }
            .footer {
                position: absolute;
                bottom: 0;
                width: 100%;
                height: 30px;
                margin: auto;
                background-color: #ffffff;
            }
        </style>
    </head>
    <body>
        <script src="../javascript/jquery.ui.widget.js"></script>
        <script src="../javascript/jquery.iframe-transport.js"></script>
        <script src="../javascript/jquery.fileupload.js"></script>
        <script src="dist/bootstrap.fd.js"></script>
        <div class = "container">      
        <form method="post" action="<%=request.getContextPath()%>/Upload" enctype="multipart/form-data">
            <div class="">
                <% String sectionID = request.getParameter("sectionID"); %>               
                <% Upload.setID (sectionID); %>
                <% Delete.setID (sectionID); %>
                <% boolean owner = false;
                    ResultList rs3 = DB.query("SELECT * FROM section_lecturer WHERE sectionID="+sectionID+" AND username='"+session.getAttribute("User")+"'");
                    if(rs3.next()){
                        owner = true;
                    } %>
            </div>
            <table style = "width:100%">
                <thead>
                <th>No.</th>
                <th>Label</th>
                <th>Status</th>
                <% if (owner) {%>
                <th>Upload</th>
                <% } %>
                </thead>
                <tbody>
                <%
                    ResultList rs = DB.query("SELECT * FROM upload_checklist WHERE status='active'");
                    int cnt = 1;
                    while(rs.next()) {
                    ResultList rs2 = DB.query("SELECT * FROM files AS f, lecturer_upload AS lu, section AS s WHERE lu.sectionID = s.sectionID AND f.fileID = lu.fileID AND lu.sectionID="+sectionID+
                        " AND lu.checklistID="+rs.getString("checklistID"));
                %>
                <tr>
                    <td><%=cnt++%></td>
                    <td><%=rs.getString("label") %></td>
                    <td>
                    <%                                       
                    boolean found = false;
                    while(rs2.next()){
                        found = true;
                        %>                                                                          
                        <%String path = rs2.getString("fileDirectory");
                          Path path1 = Paths.get(path);%>
                          <p>  
                        <a href = "<%=rs2.getString("fileDirectory")%>" download ="<%=path1.getFileName()%>"> 
                            <button class="btn btn-primary btn-xs" type="button"><i class = "glyphicon glyphicon-download-alt"></i></button>                     
                        </a>
                        <% if(owner) { %>
                        <a href = "<%=request.getContextPath()%>/Delete?fileID=<%=rs2.getString("fileID")%>" name = "Delete" onclick = "return DeleteConfirmation();"> 
                            <button class="btn btn-danger btn-xs" type="button"><i class = "glyphicon glyphicon-trash" ></i></button>                     
                        </a> 
                        <% } %>
                        <%=path1.getFileName()%>
                        </p>
                        <%}%>
                        <% if(found) { %>       
                        <a role="button" class="btn btn-primary btn-sm glyphicon glyphicon-download-alt" href="<%=request.getContextPath()%>/DownloadAsZip?sectionID=<%=sectionID%>&zipAs=checklist&checklistID=<%=rs.getString("checklistID")%>"  target="_blank" style="float:right;">
                            <font color = "white">Checklist</font>
                        </a>
                        <% } %>
                        <% if(!found) { %>       
                        No upload yet
                        <% } %>
                    </td>
                    <% if (owner) {%>
                    <td>
                        <button type="button" class="open-AddBookDialog btn btn-success btn-md glyphicon glyphicon-upload" data-id=<%=rs.getString("checklistID")%> data-toggle="modal" data-target="#confirm-upload-<%=rs.getString("checklistID")%>"></button>
                        <!-- Modal -->
                        <div id="confirm-upload-<%=rs.getString("checklistID")%>" class="modal fade" role="dialog">
                            <div class="modal-dialog">
                                <!-- Modal content-->
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                        <h4 class="modal-title">Upload files</h4>   
                                    </div>
                                    <div class="modal-body">
                                        <h4>Select files from your computer</h4>
                                        <form method="post" action="<%=request.getContextPath()%>/Upload" enctype="multipart/form-data">
                                            <div class="form-inline">
                                                <div class="form-group">
                                                    <input name="checklist-<%=rs.getString("checklistID")%>" type="file" class="upload" multiple id = "file" accept = ".pdf"/> <br>                          
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <input type="submit" value="Submit" class="btn btn-primary"/>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </td>
                    <%} %>
                </tr>
            <% } %>
            </tbody>
            </table> <br>
        </form>
        <script type="text/javascript">    
            $(".upload").change(function (e, data) 
            {
                valid = true;
                for (var i = 0; i <$(this).prop("files").length; ++i) 
                {
                    var ext = $(this).prop("files")[i].name.match(/\.([^\.]+)$/)[1];
                    var ext = ext.toLowerCase();
                    switch(ext) 
                    {
                        case "pdf":
                            break;
                        default:
                            valid = false;
                            alert ("Only accept pdf files");
                            break;
                    }
                }
                if(!valid) 
                {
                    $(this).val("");
                }
                cl_id = $(this).attr("cl_id");
                $("#uploadFile-"+cl_id).val($(this).val().slice(12));
                console.log(this.value);

                output = $("#fileList-"+cl_id);
                output.html('<ul>');
                console.table($(this));
                for (var i = 0; i <$(this).prop("files").length; ++i) 
                {
                  output.append( '<li>' + $(this).prop("files")[i].name + " (" + ($(this).prop("files")[i].size/1000).toFixed(2) +'KiB) </li>');
                }
                output.append( '</ul>');                     
            });
            
            function DeleteConfirmation ()
            {
                var x = confirm("Are you sure you want to delete?");
                if (x)
                   return true;
                else
                  return false;
            };                                                
        </script>
        </div>
        <footer class="footer">
        <div class="navbar navbar-inverse navbar-fixed-bottom nav-right">
            <div class="navbar-inner">
                <div class="container">
                    <% if (owner) {%>
                    <a role="button" class="btn btn-primary pull-right" href="<%=request.getContextPath()%>/upload/uploadSearch.jsp">
                        Save Changes
                    </a>
                    <%} %>
                    <a role="button" class="btn btn-primary " href="<%=request.getContextPath()%>/DownloadAsZip?sectionID=<%=sectionID%>&zipAs=section" target="_blank">
                        Download Section
                    </a> 
                </div>
            </div>
            </div>
    </footer>
    </body>
    <jsp:include page="../footer.jsp"/>
</html>
