package Servlet;

import Dao.UserDAO;
import Dao.UserDAOImpl;
import Enum.Gender;
import Model.User;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;

public class RegisterServlet extends HttpServlet {

    private boolean isMultipart;
    private String filePath;
    private int maxFileSize = 5000 * 1024;
    private int maxMemSize = 5000 * 1024;
    private File file;

    private String imagePath;

    public void init() {
        // Get the file location where it would be stored.
        filePath
                = getServletContext().getInitParameter("file-upload");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {

            isMultipart = ServletFileUpload.isMultipartContent(request);
            response.setContentType("text/html");

            DiskFileItemFactory factory = new DiskFileItemFactory();
            // maximum size that will be stored in memory
            factory.setSizeThreshold(maxMemSize);
            // Location to save data that is larger than maxMemSize.
            factory.setRepository(new File("c:\\temp"));

            // Create a new file upload handler
            ServletFileUpload upload = new ServletFileUpload(factory);
            // maximum file size to be uploaded.
            upload.setSizeMax(maxFileSize);

            // Parse the request to get file items.
            List fileItems = upload.parseRequest(request);

            // Process the uploaded file items
            Iterator i = fileItems.iterator();
            Random random = new Random();

            while (i.hasNext()) {
                FileItem fi = (FileItem) i.next();
                if (!fi.isFormField()) {

                    String fieldName = fi.getName() + " " + fi.getFieldName();
                    String fileName = fi.getName();
                    String contentType = fi.getContentType();
                    boolean isInMemory = fi.isInMemory();
                    long sizeInBytes = fi.getSize();

                    String extention = FilenameUtils.getExtension(fileName);
                    String imageName = FilenameUtils.removeExtension(fileName);

                    if (fileName.lastIndexOf("\\") >= 0) {
                        fileName = imageName + random.nextInt() + "." + extention;
                        imagePath = fileName;

                        file = new File(filePath
                                + fileName.substring(fileName.lastIndexOf("\\")));

                    } else {

                        fileName = imageName + random.nextInt() + "." + extention;
                        imagePath = fileName;

                        file = new File(filePath
                                + fileName.substring(fileName.lastIndexOf("\\") + 1));

                    }
                    try {
                        fi.write(file);
                    } catch (Exception ex) {
                        Logger.getLogger(addFoodServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }

                }
            }
            request.setCharacterEncoding("UTF-8");
            Hashtable table = new Hashtable();

            Iterator<FileItem> iter = fileItems.iterator();
            while (iter.hasNext()) {

                FileItem item = iter.next();
                if (!item.getFieldName().equals("file")) {
                    table.put(item.getFieldName(), item.getString());

                }
            }

            String name1 = (String) table.get("name");
            byte namebytes[] = name1.getBytes("ISO-8859-1");
            String name = new String(namebytes, "UTF-8");

            String surname1 = (String) table.get("surname");
            byte surnamebytes[] = surname1.getBytes("ISO-8859-1");
            String surname = new String(surnamebytes, "UTF-8");

            String username1 = (String) table.get("username");
            byte usernamebytes[] = username1.getBytes("ISO-8859-1");
            String username = new String(usernamebytes, "UTF-8");
            
            String password1 = (String) table.get("password");
            byte passwordbytes[] = password1.getBytes("ISO-8859-1");
            String password = new String(passwordbytes, "UTF-8");
            
            String gen = (String) table.get("gender");
            Gender gender = Gender.valueOf(gen);
            
            if (name.isEmpty() || surname.isEmpty() || username.isEmpty() || password.isEmpty()) {
                request.setAttribute("registrationFailed", true);
                RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
                rd.forward(request, response);
            } else if (!name.isEmpty() || !surname.isEmpty() || !username.isEmpty() || !password.isEmpty()) {
                User user = new User(name, surname, username, password, gender, imagePath);
                UserDAO userDao = new UserDAOImpl();
                userDao.addUser(user);
                RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
                rd.forward(request, response);
            }
            
        } catch (FileUploadException ex) {
            Logger.getLogger(RegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
