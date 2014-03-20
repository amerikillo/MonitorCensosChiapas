/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Clases;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import conn.ConectionDB;

/**
 *
 * @author Americo
 */
public class EliminaCenso extends HttpServlet {

    ConectionDB con = new ConectionDB();

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
        PrintWriter out = response.getWriter();
        try {
            String id_uni = request.getParameter("accion");
            con.conectar();
            try {
                con.borrar2("delete from tb_a where id_uni = '" + id_uni + "'");
                con.borrar2("delete from tb_b where id_uni = '" + id_uni + "'");
                con.borrar2("delete from tb_c where id_uni = '" + id_uni + "'");
                con.borrar2("delete from tb_d where id_uni = '" + id_uni + "'");
                con.borrar2("delete from tb_e where id_uni = '" + id_uni + "'");
                con.borrar2("delete from tb_f where id_uni = '" + id_uni + "'");
            } catch (Exception e) {
                out.println("<script>alert('No se pudo borrar la unidad, reintente')</script>");
                out.println("<script>window.location='borrarCensos.jsp'</script>");
            }
            out.println("<script>alert('Datos borrados exitosamente')</script>");
            out.println("<script>window.location='borrarCensos.jsp'</script>");
            con.cierraConexion();
        } catch (Exception e) {
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
