<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Contacto - Guardado</title>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");
    String nombre = request.getParameter("nombre");
    String email = request.getParameter("email");
    String telefono = request.getParameter("telefono");
    String asunto = request.getParameter("asunto");
    String mensaje = request.getParameter("mensaje");

    Connection conn = null;
    PreparedStatement ps = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        String url = "jdbc:mysql://127.0.0.1:3306/contacto_db?useSSL=false&serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8";
        String user = "root";
        String pass = "";
        conn = DriverManager.getConnection(url, user, pass);

        String sql = "INSERT INTO mensajes_contacto (nombre, email, telefono, asunto, mensaje, fecha) VALUES (?, ?, ?, ?, ?, NOW())";
        ps = conn.prepareStatement(sql);
        ps.setString(1, nombre);
        ps.setString(2, email);
        ps.setString(3, telefono);
        ps.setString(4, asunto);
        ps.setString(5, mensaje);

        int filas = ps.executeUpdate();

        if(filas > 0){
            out.println("<script>alert('✅ Mensaje enviado con éxito.'); window.location='contacto.html';</script>");
        } else {
            out.println("<script>alert('⚠️ No se pudo guardar el mensaje.'); window.location='contacto.html';</script>");
        }

    } catch (Exception e) {
        out.println("<script>alert('❌ Error: " + e.getMessage() + "'); window.location='contacto.html';</script>");
    } finally {
        if(ps != null) try { ps.close(); } catch(Exception e) {}
        if(conn != null) try { conn.close(); } catch(Exception e) {}
    }
%>
</body>
</html>
