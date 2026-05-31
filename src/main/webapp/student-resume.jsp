<%@ page contentType="text/html;charset=UTF-8" session="true" %>
<%@ page import="java.util.*, com.studentcareer.dao.StudentDAO, com.studentcareer.model.Student" %>
<%
    // session check
    String email = (String) session.getAttribute("studentEmail");
    if (email == null) {
        response.sendRedirect("student-login.html");
        return;
    }

    // Defensive fetch from DAO: wrap so JSP compiles even if DAO throws at runtime
    Student student = null;
    List<String> skills = new ArrayList<>();

    try {
        // these methods must exist in StudentDAO: getStudentByEmail(String) and getSkillsByEmail(String)
        student = StudentDAO.getStudentByEmail(email);
        List<String> tmp = StudentDAO.getSkillsByEmail(email);
        if (tmp != null) skills = tmp;
    } catch (Throwable t) {
        // If there's any problem (NoClassDefFoundError, NoSuchMethodError, SQLException, etc.)
        // log to server (use out.println only for debug; remove in production)
        t.printStackTrace();
        // leave student as null and skills empty so page still renders
    }

    // safe getters
    String studentName = (student != null && student.getName() != null) ? student.getName() : email;
    String studentCourse = (student != null && student.getCourse() != null) ? student.getCourse() : "";
    String studentContact = (student != null && student.getContact() != null) ? student.getContact() : "-";
    String studentAbout = (student != null && student.getAbout() != null) ? student.getAbout() : "A motivated student seeking opportunities to learn and grow. Add a short summary from your profile or edit this in backend.";
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <title>Resume Builder</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <!-- optional: bootstrap icons for download icon -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>
  <style>
    body { font-family: "Poppins", sans-serif; background: #f5f7fb; padding: 28px; }
    .resume-card { max-width: 900px; margin: 0 auto; background: #fff; border-radius: 10px; padding: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.08); }
    .profile { display:flex; gap:18px; align-items:center; }
    .avatar { width: 92px; height:92px; border-radius:10px; background: linear-gradient(90deg,#06b6d4,#4f46e5); color:#021024; display:flex;align-items:center;justify-content:center;font-weight:800; font-size:28px; }
    .btn-download { background: linear-gradient(90deg,#06b6d4,#4f46e5); color:#021024; border:none; }
    .skill-badge { margin: 4px 6px 4px 0; }
  </style>
</head>
<body>

<div class="resume-card">
  <div class="d-flex justify-content-between align-items-start mb-3">
    <h4>Resume Builder</h4>
    <div>
      <!-- Post to servlet to generate PDF -->
      <form action="generateResume" method="post" style="display:inline-block;">
        <input type="hidden" name="useSession" value="true" />
        <button type="submit" class="btn btn-download btn-sm"><i class="bi bi-download"></i> Download PDF</button>
      </form>
      <a href="student-dashboard.jsp" class="btn btn-light btn-sm ms-2">Back</a>
    </div>
  </div>

  <!-- Preview -->
  <div class="p-3 border rounded">
    <div class="profile mb-3">
      <div class="avatar"><%= (studentName != null && !studentName.isEmpty()) ? Character.toUpperCase(studentName.charAt(0)) : "S" %></div>
      <div>
        <h3 style="margin:0;"><%= studentName %></h3>
        <div style="color:#6b7280;"><%= studentCourse %> • <%= studentContact %></div>
        <div style="color:#6b7280;">Email: <%= email %></div>
      </div>
    </div>

    <hr/>

    <h5>Skills</h5>
    <div>
      <% if (skills != null && !skills.isEmpty()) {
            for (String sk : skills) { %>
              <span class="badge bg-secondary skill-badge"><%= sk %></span>
      <%      }
          } else { %>
            <small class="text-muted">No skills added yet. Add skills in dashboard to appear here.</small>
      <% } %>
    </div>

    <hr/>

    <h5>Summary</h5>
    <p class="text-muted"><%= studentAbout %></p>

    <hr/>

    <div class="row">
      <div class="col-md-6">
        <h6>Education</h6>
        <p class="mb-0"><strong><%= (studentCourse != null && !studentCourse.isEmpty()) ? studentCourse : "B.Tech (Information Technology)" %></strong></p>
        <small class="text-muted">Swami Vivekanand Subharti University</small>
      </div>
      <div class="col-md-6">
        <h6>Contact</h6>
        <p class="mb-0">Email: <%= email %></p>
        <p class="mb-0">Mobile: <%= studentContact %></p>
      </div>
    </div>
  </div>
</div>

</body>
</html>
