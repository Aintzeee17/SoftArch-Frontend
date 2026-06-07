<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<%
    try {
        Class.forName("model.User");
        out.println("Tahniah! Class model.User berjaya dijumpai oleh Tomcat.");
    } catch (ClassNotFoundException e) {
        out.println("Ralat: Class model.User TIDAK dijumpai. Masalah pada Classpath/Build Path.");
    }
%>
<%
    model.User user = (User) session.getAttribute("user");
    
    String name = (user != null) ? user.getName() : "Guest";
    String role = (user != null) ? user.getRole() : "";
%>
<!DOCTYPE html>
<html>
<head>
    <title>SMARTLEARN</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
</head>

<body>
    <div class="navbar">
        <h2>SMARTLEARN: CLOUD-NATIVE LEARNING MANAGEMENT SYSTEM</h2>
    </div>

    <div class="container">
        <div class="card">
            <% if (user == null) { %>
                <h2>Welcome, Guest</h2>
                <p>Please login or register to continue.</p>
                <a href="${pageContext.request.contextPath}/Login.jsp"><button class="login-btn">Login</button></a>
                <a href="${pageContext.request.contextPath}/Register.jsp"><button class="register-btn">Register</button></a>
            <% } else { %>
                <h2>Welcome, <%= name %> (<%= role %>)</h2>
                <a href="${pageContext.request.contextPath}/logout"><button class="logout-btn">Logout</button></a>
                <br><br>

                <%-- Menu Admin & Lecturer --%>
                <% if ("admin".equalsIgnoreCase(role) || "lecturer".equalsIgnoreCase(role)) { %>
                    <a href="${pageContext.request.contextPath}/course-form.jsp"><button class="create-btn">+ Create Course</button></a>
                    <a href="${pageContext.request.contextPath}/course-list.jsp"><button class="manage-btn">Manage Courses</button></a>
                <% } %>

                <%-- Menu Student --%>
                <% if ("student".equalsIgnoreCase(role)) { %>
                    <a href="${pageContext.request.contextPath}/student-dashboard.jsp"><button class="student-btn">My Courses</button></a>
                <% } %>

                <%-- Dashboard Khusus --%>
                <% if ("lecturer".equalsIgnoreCase(role)) { %>
                    <a href="${pageContext.request.contextPath}/lecturer-dashboard.jsp"><button class="lecturer-btn">Lecturer Dashboard</button></a>
                <% } %>

                <% if ("admin".equalsIgnoreCase(role)) { %>
                    <a href="${pageContext.request.contextPath}/student-dashboard.jsp"><button class="student-btn">Student Dashboard</button></a>
                <% } %>
            <% } %>
        </div>
    </div>
</body>
</html>