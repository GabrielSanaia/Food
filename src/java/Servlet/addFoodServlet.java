package Servlet;

import Dao.FoodDAO;
import Dao.FoodDAOImpl;
import Enum.FoodType;
import Enum.QuantityType;
import Model.Food;
import Model.Ingredient;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;

@WebServlet("/Relay")
@MultipartConfig
public class addFoodServlet extends HttpServlet {

    private boolean isMultipart;
    private String filePath;
    private int maxFileSize = 5000 * 1024;
    private int maxMemSize = 5000 * 1024;
    private File file;

    private String imagePath;

//    private String name;
//    private String cookingway;
    public void init() {
        // Get the file location where it would be stored.
        filePath
                = getServletContext().getInitParameter("file-upload");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
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

            String cookingway1 = (String) table.get("cookingway");
            byte cookingwaybytes[] = cookingway1.getBytes("ISO-8859-1");
            String cookingway = new String(cookingwaybytes, "UTF-8");

            String typeStr = (String) table.get("type");
            FoodType type = FoodType.valueOf(typeStr);
            String inQuantity = (String) table.get("quantity");

            int quan = Integer.parseInt(inQuantity);

            ArrayList<Ingredient> ins = new ArrayList<>();

            for (int n = 1; n < quan + 1; n++) {

                String iname1 = (String) table.get("name_" + n);
                byte inamebytes[] = iname1.getBytes("ISO-8859-1");
                String iname = new String(inamebytes, "UTF-8");

                String iquantitystr = (String) table.get("quantity_" + n);
                int iquantity = Integer.parseInt(iquantitystr);
                String itypeStr = (String) table.get("type_" + n);

                String icomment1 = (String) table.get("comment_" + n);
                byte commentbytes[] = icomment1.getBytes("ISO-8859-1");
                String icomment = new String(commentbytes, "UTF-8");

                if (iname.isEmpty() || iquantitystr.isEmpty() || icomment.isEmpty()) {
                    request.setAttribute("addFoodFailed", true);
                    RequestDispatcher rd = request.getRequestDispatcher("addfood.jsp");
                    rd.forward(request, response);
                }

                QuantityType itype = QuantityType.valueOf(itypeStr);

                Ingredient in = new Ingredient(iname, iquantity, itype, icomment);
                ins.add(in);
            }
            if (name.isEmpty() || cookingway.isEmpty()) {
                request.setAttribute("addFoodFailed", true);
                RequestDispatcher rd = request.getRequestDispatcher("addfood.jsp");
                rd.forward(request, response);

            } else {
                int user_id = (int) request.getSession().getAttribute("id");
                Food food = new Food(ins, name, type, cookingway, imagePath, user_id);
                FoodDAO dao = new FoodDAOImpl();
                dao.addFood(food);
                RequestDispatcher rd = request.getRequestDispatcher("Interface.jsp?page=1");
                rd.forward(request, response);
            }

        } catch (NumberFormatException ex) {
            request.setAttribute("addFoodFailed", true);
            RequestDispatcher rd = request.getRequestDispatcher("addfood.jsp");
            rd.forward(request, response);
        } catch (FileUploadException ex) {
            Logger.getLogger(addFoodServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

}
