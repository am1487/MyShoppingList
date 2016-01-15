package com.myshoppinglist;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import com.uthldap.Uthldap;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.simple.JSONObject;

public class UserLogin extends HttpServlet {

    private static String DB = "jdbc:mysql://localhost:3306/myshoppinglist";
    private static String DBUSER = "final";
    private static String DBPSW = "123456789";

    @Override
    public void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws IOException, ServletException {

        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(DB, DBUSER, DBPSW);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UserLogin.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(UserLogin.class.getName()).log(Level.SEVERE, null, ex);
        }

        String user = request.getParameter("user");
        String pass = request.getParameter("pass");
        try {
            stmt = conn.createStatement();
            Uthldap ldap = new Uthldap(user, pass);

            response.setContentType("text/plain");

            PrintWriter pw = response.getWriter();

            JSONObject obj = new JSONObject();

            if (ldap.auth()) {

                rs = stmt.executeQuery("SELECT * FROM user WHERE username='" + user + "'");
                if (!rs.next()) {
                    PreparedStatement pstmt = conn.prepareStatement("INSERT INTO user(username, fullname, email, lastLo) VALUES (?,?,?,?)");
                    pstmt.setString(1, user);
                    pstmt.setString(2, ldap.getName());
                    pstmt.setString(3, ldap.getMail());
                    pstmt.setString(4, currentTime());
                    boolean result = pstmt.execute();

                    if (!result) { System.out.println("ERROR: Wrong Query"); }
   
                    
                } else {
                    PreparedStatement pstmt = conn.prepareStatement("UPDATE user SET lastLo= '" + currentTime() + "'");
                    
                     boolean result = pstmt.execute();

                    if (!result) { System.out.println("ERROR: Wrong Query"); }
                }

                HttpSession session;
                session = request.getSession();
                session.setAttribute("user", user);
                //setting session to expiry in 30 mins
                session.setMaxInactiveInterval(60 * 60);
                Cookie userName = new Cookie("user", user);
                userName.setMaxAge(24 * 60 * 60);
                response.addCookie(userName);

                //TODO for security reasons
                int cookieID = 0;
                obj.put("user", user);
                obj.put("fullname",ldap.getName());
                obj.put("name", ((ldap.getName()).split(" "))[1]);
                obj.put("email", ldap.getMail());
            } else {
                obj.put("error", "1");
            }

            pw.write(obj.toString());
        } catch (SQLException ex) {
            Logger.getLogger(UserLogin.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public String currentTime() {
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
        System.out.println(sdf.format(cal.getTime()));
        return (sdf.format(cal.getTime())).toString();
    }
}
