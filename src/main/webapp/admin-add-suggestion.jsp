<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Career Suggestion</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

    <div class="container mt-5">
        <div class="card shadow-lg">
            <div class="card-header bg-primary text-white">
                <h4>Add Career Suggestion</h4>
            </div>
            <div class="card-body">
                <form action="AddSuggestionServlet" method="post">
                    <div class="mb-3">
                        <label class="form-label">Skill Name</label>
                        <input type="text" name="skillName" class="form-control" placeholder="e.g., Java, HTML, DSA" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Suggestion</label>
                        <textarea name="suggestion" class="form-control" rows="4" placeholder="Enter suggestion details..." required></textarea>
                    </div>
                    <button type="submit" class="btn btn-success">Add Suggestion</button>
                </form>
            </div>
        </div>

        <div class="mt-3">
            <a href="admin-dashboard.jsp" class="btn btn-secondary">⬅ Back to Dashboard</a>
        </div>
    </div>

</body>
</html>
