<%-- 
    Document   : index
    Created on : 19-mar-2014, 9:12:15
    Author     : Americo
--%>

<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="conn.*" %>
<!DOCTYPE html>
<!DOCTYPE html>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df3 = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<%java.text.DateFormat df = new java.text.SimpleDateFormat("HH:mm:ss"); %>
<%java.text.DateFormat df4 = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); %>
<%

    ConectionDB con = new ConectionDB();
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Entradas Censos Chiapas</title>
        <!-- Estilos CSS -->
        <link href="css/bootstrap.css" rel="stylesheet" media="screen">
        <link href="css/pie-pagina.css" rel="stylesheet" media="screen">
        <link href="css/topPadding.css" rel="stylesheet">
        <link href="css/datepicker3.css" rel="stylesheet">
        <link href="css/cupertino/jquery-ui-1.10.3.custom.css" rel="stylesheet">
        <!---->
    </head>
    <body>
        <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="main_menu.jsp">Entradas Censos Chiapas</a>
            </div>
            <div class="collapse navbar-collapse">
                <ul class="nav navbar-nav">

                    <!--li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Receta Electronica <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="receta/receta_farmacia.jsp">Captura de Receta</a></li>
                    <!--li class="divider"></li>
                    <li><a href="#rf">Reimpresión de Comprobantes</a></li>
                </ul>
            </li-->

                    <li>
                        <a href="index.jsp">Registro de Entradas</a>
                    </li>
                    <li>
                        <a href="borrarCensos.jsp">Baja de Censos</a>
                    </li>
                    <li>
                        <a href="comparativa.jsp">Comparativa</a>
                    </li>
                </ul>
            </div><!--/.nav-collapse -->
        </div>
        <div class="container-fluid">
            <div class="container">
                <h1>Comparativa Censos Chiapas</h1>
                <div class="panel panel-body">
                    <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered" id="datosProv">
                        <thead>
                            <tr>
                                <td>id</td>
                                <td>Nombre</td>
                                <td>Municipio</td>
                                <td>Cluess</td>
                                <td>Juris</td>
                                <td>Tipo</td>
                                <td>Censo</td>
                                <td>Fotos</td>
                                <td>Inventario</td>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                try {

                                    con.conectar();
                                    ResultSet rset = con.consulta("select id_uni, campo_1, campo_5, campo_7, campo_11, campo_15 from tb_a order by id_uni+0");
                                    while (rset.next()) {

                                        String ima = "", inv = "", cen = "", tot_img="";
                                        ResultSet rset2 = con.consulta("select id_uni from tb_imagenes where id_uni = '" + rset.getString(1) + "'");
                                        while (rset2.next()) {
                                            ima = "X";
                                        }

                                        rset2 = con.consulta("select id_uni from tb_a where id_uni = '" + rset.getString(1) + "' and campo_31 != '' and campo_30!= '' ");
                                        while (rset2.next()) {
                                            cen = "X";
                                        }

                                        rset2 = con.consulta("select count(id_uni) from tb_imagenes where id_uni = '" + rset.getString(1) + "'");
                                        while (rset2.next()) {
                                            inv = "X";
                                            tot_img=rset2.getString(1);
                                        }
                            %>
                            <tr class="odd gradeX">
                                <td><%=rset.getString(1)%></td>
                                <td><%=rset.getString(2)%></td>
                                <td><%=rset.getString(3)%></td>
                                <td><%=rset.getString(4)%></td>
                                <td><%=rset.getString(5)%></td>
                                <td><%=rset.getString(6)%></td>
                                <td><%=cen%></td>
                                <td><%=ima%> - <%=tot_img%></td>
                                <td><%=inv%></td>
                            </tr>
                            <%
                                    }
                                    con.cierraConexion();
                                } catch (Exception e) {
                                    System.out.println(e.getMessage());
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </body>

    <!-- 
    ================================================== -->
    <!-- Se coloca al final del documento para que cargue mas rapido -->
    <!-- Se debe de seguir ese orden al momento de llamar los JS -->
    <script src="js/jquery-1.9.1.js"></script>
    <script src="js/bootstrap.js"></script>
    <script src="js/jquery-ui-1.10.3.custom.js"></script>
    <script src="js/bootstrap-datepicker.js"></script>
    <script src="js/jquery.dataTables.js"></script>
    <script src="js/dataTables.bootstrap.js"></script>
    <script>
        $(document).ready(function() {
            $('#datosProv').dataTable();
        });
    </script>
</html>
