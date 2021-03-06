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
                <h1>Entradas Censos Chiapas</h1>
                <div class="panel panel-body">
                    <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered" id="datosProv">
                        <thead>
                            <tr>
                                <td>id</td>
                                <td>Nombre</td>
                                <td>Fecha</td>
                                <td>Hora</td>
                                <td>Status</td>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                try {
                                    Calendar calendar = Calendar.getInstance();
                                    con.conectar();
                                    ResultSet rset = con.consulta("select * from entradas order by (id+0) desc");
                                    while (rset.next()) {
                                        calendar.setTime(df.parse(rset.getString(4)));
                                        calendar.add(Calendar.HOUR, 6);
                                        Date hora = calendar.getTime();

                            %>
                            <tr class="odd gradeX">
                                <td><%=rset.getInt(1)%></td>
                                <td><%=rset.getString(2)%></td>
                                <td><%=df3.format(df2.parse(rset.getString(3)))%></td>
                                <td><%=df.format(hora)%></td>
                                <td><%=rset.getString(5)%></td>
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
