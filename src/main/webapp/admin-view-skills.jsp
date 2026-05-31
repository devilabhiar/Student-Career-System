<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.studentcareer.model.Skill" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");

    List<Skill> skills = (List<Skill>) request.getAttribute("skills");
%>

<!DOCTYPE html>
<html>
<head>
    <title>All Student Skills</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"/>
</head>
<body class="bg-light">
<div class="container mt-4">
    <h2 class="mb-3">All Student Skills</h2>

    <%
        if (skills == null || skills.isEmpty()) {
    %>
        <div class="alert alert-warning">No student skills found.</div>
    <%
        } else {
    %>
    <table class="table table-bordered">
        <thead class="thead-dark">
            <tr>
                <th>Student ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Skill</th>
                <th>Level</th>
            </tr>
        </thead>
        <tbody>
        <%
            for (Skill s : skills) {
        %>
            <tr>
                <td><%= s.getStudentId() %></td>
                <td><%= s.getStudentName() %></td>
                <td><%= s.getEmail() %></td>
                <td><%= s.getSkillName() %></td>
                <td><%= s.getSkillLevel() == null ? "N/A" : s.getSkillLevel() %></td>
            </tr>
        <%
            }
        %>
        </tbody>
    </table>
    <%
        }
    %>

    <a href="admin-dashboard.jsp" class="btn btn-secondary mt-3">⬅ Back to Dashboard</a>
</div>
</body>
</html>
