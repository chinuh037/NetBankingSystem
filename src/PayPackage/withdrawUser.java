package PayPackage;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "withdrawUser")
public class withdrawUser extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession sess=request.getSession();
        int amount=Integer.parseInt(request.getParameter("amount"));
       //Account User= (Account) sess.getAttribute("User");
        Account User=null;
        String Username=sess.getAttribute("uname").toString();
        User=TestArrayInit.getDetails(Username);
        if(User.getBalance() >= amount)
        {
            //It is possible to withdraw
            User.setBalance(User.getBalance()-amount);
            TestArrayInit.UpdateList(User);
            //sess.removeAttribute("User");
            //sess.setAttribute("User",User);
            //Show success message(maybe popup)
            //PrintWriter out=response.getWriter();
            //out.println("Success");
            response.sendRedirect("home.jsp");
        }
        else
        {
            //Show failure message(maybe popup)
            //PrintWriter out=response.getWriter();
            //out.println("Failure");
            response.sendRedirect("withdrawError.html");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
