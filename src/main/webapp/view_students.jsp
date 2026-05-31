<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%@ page import="java.util.List" %>
<%@ page import="com.studentcareer.model.Student" %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    HttpSession currentSession = request.getSession(false);
    if (currentSession == null || currentSession.getAttribute("admin") == null) {
        response.sendRedirect("admin-login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>All Registered Students</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 30px;
            background-color: #f5f5f5;
        }
        h2 {
            color: #2e8b57;
        }
        table {
            border-collapse: collapse;
            width: 90%;
            background-color: white;
        }
        th, td {
            border: 1px solid #555;
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #2e8b57;
            color: white;
        }
        .back-btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 15px;
            background-color: #2e8b57;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .back-btn:hover {
            background-color: #1e633d;
        }
        .no-data {
            margin-top: 20px;
            font-weight: bold;
            color: crimson;
        }
    </style>
</head>
<body>

    <h2>List of Registered Students</h2>

    <%
        List<Student> students = (List<Student>) request.getAttribute("studentList");
        if (students != null && !students.isEmpty()) {
    %>
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
            </tr>
            <% for (Student s : students) { %>
            <tr>
                <td><%= s.getId() %></td>
                <td><%= s.getName() %></td>
                <td><%= s.getEmail() %></td>
            </tr>
            <% } %>
        </table>
    <%
        } else {
    %>
        <p class="no-data">⚠️ No students found in the system.</p>
    <%
        }
    %>

    <a class="back-btn" href="admin-dashboard.jsp">⬅️ Back to Dashboard</a>

</body>
</html>
