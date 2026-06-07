<%@page import="model.User"%>
<%@page import="java.sql.*"%>
<%@page import="db.DBConnection"%>

<%
User user = (User) session.getAttribute("user");

// FIX: Guna equalsIgnoreCase untuk elakkan isu huruf besar/kecil role dalam DB
if (user == null || !"lecturer".equalsIgnoreCase(user.getRole())) {
    response.sendRedirect(request.getContextPath() + "/index.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Lecturer Dashboard</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>

<div class="navbar">
    <h2>Lecturer Dashboard (Hi, <%= user.getName() %>!)</h2>
    <a href="logout" class="logout-btn">Logout</a>
</div>

<div class="container">

<div class="card">

<h2>My Teaching Courses</h2>

<a href="course-form.jsp" class="add-btn">+ Add Course</a>

<br><br>

<%
Connection con = DBConnection.getConnection();

PreparedStatement ps = con.prepareStatement(
    "SELECT courseId, title, courseCode FROM courses WHERE lecturerId=?"
);

ps.setInt(1, user.getUserId());

ResultSet rs = ps.executeQuery();

boolean hasCourse = false;

// FIX: Cipta pembilang turutan bermula dari 1
int no = 1;

while(rs.next()){
    hasCourse = true;
%>

<div class="course-card">

    <h3><%= no++ %>. <%= rs.getString("title") %></h3>
    <p>Course Code: <%= rs.getString("courseCode") %></p>

    <a href="edit-course.jsp?id=<%= rs.getInt("courseId") %>" class="btn edit-btn" style="text-decoration:none;">
        Edit
    </a>

    <form action="CourseServlet" method="post" style="display:inline;">
        <input type="hidden" name="action" value="delete">
        <input type="hidden" name="courseId" value="<%= rs.getInt("courseId") %>">

        <button class="btn delete-btn" type="submit"
                onclick="return confirm('Delete this course?')">
            Delete
        </button>
    </form>

</div>

<%
}

if(!hasCourse){
%>
    <p>No courses available.</p>
<%
}
%>

</div>

</div>

</body>
</html>