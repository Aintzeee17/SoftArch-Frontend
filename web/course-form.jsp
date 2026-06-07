<%@page import="model.User"%>

<%
User user = (User) session.getAttribute("user");

// FIX 1: Benarkan "admin" ATAU "lecturer" untuk masuk ke page create course ni
if (user == null || (!"admin".equals(user.getRole()) && !"lecturer".equalsIgnoreCase(user.getRole()))) {
    response.sendRedirect(request.getContextPath() + "/index.jsp");
    return;
}

// FIX 2: Sediakan URL 'Back to List' dinamik mengikut role user yang login
String backUrl = request.getContextPath() + "/course-list.jsp"; // Default untuk Admin
if (user != null && "lecturer".equalsIgnoreCase(user.getRole())) {
    backUrl = request.getContextPath() + "/lecturer-dashboard.jsp"; // Untuk Lecturer kembali ke dashboard asal
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Create Course</title>
    <link rel="stylesheet" href="style.css">
</head>

<body class="course-form-body">

<div class="navbar">
    <h2>Create Course</h2>
</div>

<div class="container">
    <div class="course-form-card">
       
        <form action="<%=request.getContextPath()%>/CourseServlet" method="post">

            <input type="hidden" name="action" value="create">

            <label>Course Title</label>
            <input type="text" name="title" required>

            <label>Description</label>
            <textarea name="description" rows="5" required></textarea>

            <label>Course Code</label>
            <input type="text" name="courseCode" placeholder="CSF3433" required>

            <div class="button-group">
                <button type="submit">Create Course</button>
                <a href="<%=backUrl%>" class="edit-course-back-link">Back to List</a>
            </div>
        </form>

    </div>
</div>

</body>
</html>