/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.myshoppinglist;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Mitsos
 */
public class Calculate extends HttpServlet {

    private static String DB = "jdbc:mysql://localhost:3306/myshoppinglist";
    private static String DBUSER = "final";
    private static String DBPSW = "123456789";

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        Statement stmt = null;
        Connection conn = null;

        ResultSet rs = null;

        int i = 1;
        String prod = "prod" + i;
        String quant = "quant" + i;
        String price = "price" + i;
        

        double totalsuper1 = 0.0, totalsuper2 = 0.0, totalsuper3 = 0.0;
        double[] super1 = new double[8];
        double[] super2 = new double[8];
        double[] super3 = new double[8];
        String [] title = new String [8];

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(DB, DBUSER, DBPSW);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UserLogin.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(UserLogin.class.getName()).log(Level.SEVERE, null, ex);
        }

        while (request.getParameter(prod) != null) {
            try {
                stmt = conn.createStatement();
                rs = stmt.executeQuery("SELECT * FROM products WHERE name= '" + request.getParameter(prod) + "'");

            } catch (SQLException ex) {
                Logger.getLogger(AjaxRequest.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                if (rs.next()) {
                    request.setAttribute(quant, request.getParameter(quant));
                    super1[i] = (Double.valueOf(rs.getString("carrefour"))) * (Double.valueOf(request.getParameter(quant)));
                    super2[i] = (Double.valueOf(rs.getString("vasilopoulos"))) * (Double.valueOf(request.getParameter(quant)));
                    super3[i] = (Double.valueOf(rs.getString("galaxias"))) * (Double.valueOf(request.getParameter(quant)));
                    totalsuper1 = totalsuper1 + super1[i];
                    totalsuper2 = totalsuper2 + super2[i];
                    totalsuper3 = totalsuper3 + super3[i];
                    title[i]=rs.getString("name");

                }
            } catch (SQLException ex) {
                Logger.getLogger(Calculate.class.getName()).log(Level.SEVERE, null, ex);
            }
            i++;
            prod = "prod" + i;
            quant = "quant" + i;
            price = "price" + i;
        }
        double min = totalsuper1;
        if (min > totalsuper2) {
            min = totalsuper2;
        }
        if (min > totalsuper3) {
            min = totalsuper3;
        }
        if (min == totalsuper1) {
            request.setAttribute("minPrice", min);
            request.setAttribute("super", "Carrefour");
            for (i = 1; i < 8; i++) {
                price = "price" + i;
                prod = "prod" +i;
                request.setAttribute(price, String.valueOf(super1[i]));
                request.setAttribute(prod, String.valueOf(title[i]));
            }
        } else if (min == totalsuper2) {
            request.setAttribute("minPrice", min);
            request.setAttribute("super", "Basilopoulos");
            for (i = 1; i < 8; i++) {
                price = "price" + i;
                prod = "prod" +i;
                request.setAttribute(price, String.valueOf(super2[i]));
                request.setAttribute(prod, String.valueOf(title[i]));
                
            }
        } else if (min == totalsuper3) {
            request.setAttribute("minPrice", min);
            request.setAttribute("super", "Galaxias");
           
            for (i = 1; i < 8; i++) {
                price = "price" + i;
                prod = "prod" +i;
                request.setAttribute(price, String.valueOf(super3[i]));
                request.setAttribute(prod, String.valueOf(title[i]));
            }
        }

        RequestDispatcher requestDispatcher
                = request.getRequestDispatcher("result.jsp");

        requestDispatcher.forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
}
