<%@ page import="java.util.*" %>
<%@ page import="com.studentcareer.model.CareerSuggestion" %>
<%@ page session="true" %>
<%
    String adminName = (String) session.getAttribute("adminName");
    if (adminName == null) {
        response.sendRedirect("admin-login.jsp");
        return;
    }
    List<CareerSuggestion> list = (List<CareerSuggestion>) request.getAttribute("suggestions");
%>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>All Suggestions</title></head>
<body>
    <h2>All Career Suggestions</h2>
    <a href="admin-dashboard.jsp">Back to Dashboard</a>
    <table border="1" cellpadding="6" cellspacing="0">
        <tr>
            <th>ID</th><th>Skill</th><th>Suggestion</th><th>Action</th>
        </tr>
        <%
            if (list != null) {
                for (CareerSuggestion cs : list) {
        %>
        <tr>
            <td><%= cs.getId() %></td>
            <td><%= cs.getSkillName() %></td>
            <td><%= cs.getSuggestion() %></td>
            <td>
                <form action="DeleteSuggestionServlet" method="post" style="display:inline;">
                    <input type="hidden" name="id" value="<%= cs.getId() %>"/>
                    <button type="submit" onclick="return confirm('Delete this?')">Delete</button>
                </form>
            </td>
        </tr>
        <%      }
            }
        %>
    </table>
</body>
</html>
