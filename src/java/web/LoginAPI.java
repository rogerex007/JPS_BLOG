/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Eslam
 */
@WebServlet(name = "LoginAPI", urlPatterns = {"/LoginAPI"})
public class LoginAPI extends HttpServlet {

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
        String action = request.getParameter("action");
        try {
            if (action != null) {
                switch (action) {
                    case "login":
                        login(request, response);
                        break;
                    case "logout":
                        logout(request, response);
                        break;
                    default:
                        response.sendRedirect("./login.jsp");
                }
            } else {
                response.sendRedirect("./login.jsp");
            }
        } catch (Exception e) {
            try {
                this.getServletConfig().getServletContext().getRequestDispatcher("/message.jsp").forward(request, response);
            } catch (Exception ex) {
                System.out.println("Error: " + e.getMessage());
            }
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

    private void login(HttpServletRequest request, HttpServletResponse response) {
        if (request.getParameter("btnLogin") != null) {
            HttpSession session;
            DbManager db;
            User user;
            user = this.getUser(request);
            db = new DbManager();
            if (db.Login(user.Username, user.Password) == 1) {
                user = db.GetUser(user.Username);
                if (user != null) {
                    session = request.getSession();
                    session.setAttribute("user", user.Username);

                    request.setAttribute("msg", "Welcome to the post manager");
                    try {
                        response.sendRedirect("./blog.jsp?access=allowed");
                    } catch (IOException ex) {
                        Logger.getLogger(LoginAPI.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
            } else {
                try {
                    response.sendRedirect("./login.jsp?access=denied");
                } catch (IOException ex) {
                    Logger.getLogger(LoginAPI.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        } else {
            try {
                response.sendError(503, "Error :You Must Login From Login Page !!!");
            } catch (IOException ex) {
                Logger.getLogger(LoginAPI.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    private void logout(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        session.setAttribute("user", null);
        session.invalidate();
        try {
            response.sendRedirect("./index.jsp");
        } catch (IOException ex) {
            Logger.getLogger(LoginAPI.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private User getUser(HttpServletRequest request) {
        User us = new User();
        us.setUsername(request.getParameter("txtUsername"));
        us.setPassword(request.getParameter("txtPassword"));
        return us;
    }

}
