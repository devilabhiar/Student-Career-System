<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%
    // Disable browser caching
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    HttpSession currentSession = request.getSession(false);
    if (currentSession == null || currentSession.getAttribute("admin") == null) {
        response.sendRedirect("admin-login.jsp");
        return;
    }

    // If you saved admin object or name in session, use it. Fallback to 'Admin'.
    Object adminObj = currentSession.getAttribute("adminName");
    String adminName = adminObj != null ? adminObj.toString() : "Admin";
%>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Admin Dashboard</title>
  <!-- Bootstrap 5 CDN -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    :root{
      --brand: #2e8b57;
      --brand-dark: #1e633d;
    }
    body{ background: linear-gradient(180deg, #f7faf8 0%, #eef6f0 100%); font-family: Inter, system-ui, -apple-system, 'Segoe UI', Roboto, 'Helvetica Neue', Arial; }
    .hero{ padding: 40px 0; }
    .card-action{ border: 0; border-radius: 14px; box-shadow: 0 6px 22px rgba(46,139,87,0.08); transition: transform .14s ease, box-shadow .14s ease; }
    .card-action:hover{ transform: translateY(-6px); box-shadow: 0 12px 36px rgba(46,139,87,0.12); }
    .btn-logout{ background: crimson; border: none; }
    .btn-logout:hover{ background: darkred; }
    .small-note{ color: #5b6b5f; }
    .icon-box{ width:56px; height:56px; border-radius:12px; display:flex; align-items:center; justify-content:center; background: linear-gradient(135deg, rgba(46,139,87,0.12), rgba(46,139,87,0.06)); }
  </style>
</head>
<body>
  <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
    <div class="container">
      <a class="navbar-brand fw-bold" href="#">Student Career System</a>
      <div class="d-flex align-items-center">
        <span class="me-3 small-note">Signed in as <strong><%= adminName %></strong></span>
        <form action="adminLogout" method="post" class="m-0">
          <button type="submit" class="btn btn-logout btn-sm text-white">🚪 Logout</button>
        </form>
      </div>
    </div>
  </nav>

  <header class="container hero">
    <div class="row align-items-center">
      <div class="col-md-8">
        <h1 class="mb-2" style="color:var(--brand)">Welcome back, <span class="fw-semibold"><%= adminName %></span> 👋</h1>
        <p class="mb-0 small-note">Manage students, skills, suggestions and your profile from this admin panel.</p>
      </div>
      <div class="col-md-4 text-md-end mt-3 mt-md-0">
        <a href="admin-add-suggestion.jsp" class="btn btn-outline-success me-2">+ Add Suggestion</a>
        <a href="updateAdminProfile.jsp" class="btn btn-outline-secondary">Profile</a>
      </div>
    </div>
  </header>

  <main class="container">
    <div class="row g-4">

      <div class="col-sm-6 col-lg-4">
        <a href="viewStudents" class="text-decoration-none text-dark">
          <div class="card card-action p-3 h-100">
            <div class="d-flex gap-3 align-items-center">
              <div class="icon-box">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" stroke="var(--brand)" stroke-width="1.6" viewBox="0 0 24 24"><path d="M12 12a5 5 0 1 0 0-10 5 5 0 0 0 0 10z"></path><path d="M21 21v-2a4 4 0 0 0-4-4H7a4 4 0 0 0-4 4v2"></path></svg>
              </div>
              <div>
                <h5 class="mb-1">View All Registered Students</h5>
                <p class="mb-0 small-note">See student list, details and manage accounts.</p>
              </div>
            </div>
          </div>
        </a>
      </div>

      <div class="col-sm-6 col-lg-4">
        <a href="ViewStudentSkills" class="text-decoration-none text-dark">
          <div class="card card-action p-3 h-100">
            <div class="d-flex gap-3 align-items-center">
              <div class="icon-box">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" stroke="var(--brand)" stroke-width="1.6" viewBox="0 0 24 24"><path d="M3 12h18"></path><path d="M7 6h10"></path><path d="M7 18h4"></path></svg>
              </div>
              <div>
                <h5 class="mb-1">View Student Skills</h5>
                <p class="mb-0 small-note">Browse skills added by students and filter by level.</p>
              </div>
            </div>
          </div>
        </a>
      </div>

      <div class="col-sm-6 col-lg-4">
        <a href="updateStudent.jsp" class="text-decoration-none text-dark">
          <div class="card card-action p-3 h-100">
            <div class="d-flex gap-3 align-items-center">
              <div class="icon-box">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" stroke="var(--brand)" stroke-width="1.6" viewBox="0 0 24 24"><path d="M3 6h18"></path><path d="M8 6v14"></path></svg>
              </div>
              <div>
                <h5 class="mb-1">Delete / Update Student Info</h5>
                <p class="mb-0 small-note">Edit or remove student entries safely.</p>
              </div>
            </div>
          </div>
        </a>
      </div>

      <div class="col-sm-6 col-lg-4">
        <a href="admin-add-suggestion.jsp" class="text-decoration-none text-dark">
          <div class="card card-action p-3 h-100">
            <div class="d-flex gap-3 align-items-center">
              <div class="icon-box">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" stroke="var(--brand)" stroke-width="1.6" viewBox="0 0 24 24"><path d="M12 3v18"></path><path d="M3 12h18"></path></svg>
              </div>
              <div>
                <h5 class="mb-1">Add Career Suggestions</h5>
                <p class="mb-0 small-note">Create suggestions students will see on their dashboard.</p>
              </div>
            </div>
          </div>
        </a>
      </div>

      <div class="col-sm-6 col-lg-4">
        <a href="updateAdminProfile.jsp" class="text-decoration-none text-dark">
          <div class="card card-action p-3 h-100">
            <div class="d-flex gap-3 align-items-center">
              <div class="icon-box">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" stroke="var(--brand)" stroke-width="1.6" viewBox="0 0 24 24"><circle cx="12" cy="8" r="2"></circle><path d="M6 20c1-3 5-4 6-4s5 1 6 4"></path></svg>
              </div>
              <div>
                <h5 class="mb-1">Update Admin Profile</h5>
                <p class="mb-0 small-note">Change name, email or password for admin account.</p>
              </div>
            </div>
          </div>
        </a>
      </div>

    </div>

    <footer class="mt-5 text-center small-note">
      <p class="mb-1">Student Career System • Admin Panel</p>
      <p class="mb-0">Made with Abhi — Keep it simple, keep it usable.</p>
    </footer>
  </main>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
