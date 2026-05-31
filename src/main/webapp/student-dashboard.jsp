<%@ page contentType="text/html;charset=UTF-8" session="true" %>
<%@ page import="java.util.*, com.studentcareer.dao.StudentDAO" %>

<%
    // Disable browser caching
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    // Session check
    if (session == null || session.getAttribute("studentEmail") == null) {
        response.sendRedirect("student-login.html");
        return;
    }

    String email = (String) session.getAttribute("studentEmail");
    List<String> skills = StudentDAO.getSkillsByEmail(email);  // Will show skills from DB

    String success = request.getParameter("success");
    String error = request.getParameter("error");
    boolean hasSkills = (skills != null && !skills.isEmpty());
    int skillCount = hasSkills ? skills.size() : 0;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Student Dashboard</title>

    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" />

    <!-- Bootstrap Icons (working CDN) -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

    <style>
        /* Page Background */
        body {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: "Poppins", system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial;
            background: radial-gradient(1200px 600px at 10% 10%, rgba(255,255,255,0.06), transparent),
                        linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f84aa7 100%);
            padding: 40px 0;
        }

        /* Outer container */
        .dashboard-wrap {
            width: 100%;
            max-width: 1100px;
            margin: 20px;
        }

        /* Glass card */
        .glass {
            background: rgba(255,255,255,0.08);
            border-radius: 14px;
            padding: 22px;
            backdrop-filter: blur(8px) saturate(120%);
            border: 1px solid rgba(255,255,255,0.08);
            box-shadow: 0 10px 30px rgba(2,6,23,0.45);
            color: #fff;
        }

        .header-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
        }

        .user-chip {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            background: rgba(255,255,255,0.06);
            padding: 8px 12px;
            border-radius: 999px;
            font-weight: 600;
            color: #fff;
            box-shadow: 0 6px 18px rgba(0,0,0,0.25);
        }

        .user-chip .avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg,#ffd6a5,#fdc094);
            display:flex;
            align-items:center;
            justify-content:center;
            color:#2b2b2b;
            font-weight:700;
        }

        .card-panel {
            background: rgba(255,255,255,0.03);
            border-radius: 12px;
            padding: 18px;
        }

        /* Form styles */
        .form-control, .form-select {
            border-radius: 10px;
            padding: 12px 14px;
            background: rgba(255,255,255,0.06);
            color: #fff;
            border: 1px solid rgba(255,255,255,0.06);
        }
        label { color: rgba(255,255,255,0.9); font-weight:600; }

        .btn-primary-custom {
            background: linear-gradient(90deg,#00d4ff,#0077ff);
            border: none;
            font-weight:700;
            padding: 10px 16px;
            border-radius: 10px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
        }
        .btn-primary-custom:hover { transform: translateY(-2px); }

        /* Skills list */
        .skill-item {
            display:flex;
            align-items:center;
            justify-content:space-between;
            gap:10px;
            padding:10px 12px;
            border-radius:10px;
            background: linear-gradient(90deg, rgba(255,255,255,0.02), rgba(255,255,255,0.01));
            margin-bottom:10px;
            color: #fff;
            transition: box-shadow .25s, transform .18s;
        }
        .skill-item.highlight {
            box-shadow: 0 8px 30px rgba(255,215,125,0.14);
            transform: translateY(-4px);
            background: linear-gradient(90deg, rgba(255,255,255,0.04), rgba(255,255,255,0.02));
        }
        .skill-left { display:flex; align-items:center; gap:12px; }
        .skill-icon {
            width:44px;height:44px;border-radius:8px;
            display:flex;align-items:center;justify-content:center;font-weight:700;
            background: rgba(255,255,255,0.06);
        }

        .level-badge {
            padding:6px 10px;
            border-radius:999px;
            font-weight:700;
            font-size:0.85rem;
        }
        .lvl-beginner { background: rgba(255,255,255,0.12); color: #fff; }
        .lvl-intermediate { background: rgba(255,255,255,0.18); color: #fff; }
        .lvl-advanced { background: rgba(255,255,255,0.25); color: #fff; }

        /* small screens: stack */
        @media (max-width: 767px) {
            .header-row { flex-direction: column; align-items: flex-start; gap: 14px; }
        }

        /* subtle entrance */
        .fade-up { animation: fadeUp .6s ease both; }
        @keyframes fadeUp {
            from { opacity:0; transform: translateY(10px); }
            to { opacity:1; transform: translateY(0); }
        }

        /* Resume button style */
        .btn-resume {
            background: linear-gradient(90deg,#ffdd57,#ff7a7a);
            color: #041024;
            font-weight:700;
            border-radius:10px;
            border: none;
            padding: 8px 12px;
        }
        .btn-resume:hover { transform: translateY(-2px); }

        /* Hint box for unlock */
        .hint-unlock {
            background: rgba(255,255,255,0.04);
            border: 1px dashed rgba(255,255,255,0.06);
            padding: 10px 12px;
            border-radius: 8px;
            color: #ffe9b3;
            margin-bottom: 12px;
            display: flex;
            gap: 10px;
            align-items: center;
        }

        /* small skill-count badge */
        .skill-count {
            display:inline-flex;
            align-items:center;
            gap:8px;
            background: rgba(255,255,255,0.95);
            color: #041024;
            padding:6px 10px;
            border-radius: 999px;
            font-weight:700;
            box-shadow: 0 8px 20px rgba(2,6,23,0.25);
            margin-left:10px;
        }
    </style>
</head>
<body>
    <div class="dashboard-wrap">

        <div class="glass fade-up">
            <div class="header-row mb-3">
                <div>
                    <h3 class="mb-0" style="letter-spacing:0.2px">Student Dashboard
                        <!-- skill count badge -->
                        <span class="skill-count" title="Total skills"><i class="bi bi-award-fill" style="color:#ffb84d"></i> <%= skillCount %></span>
                    </h3>
                    <small style="color:rgba(255,255,255,0.85)">Manage your skills & view career suggestions</small>
                </div>

                <div class="d-flex align-items-center gap-3">
                    <div class="user-chip">
                        <div class="avatar"><%= Character.toUpperCase(email.charAt(0)) %></div>
                        <div style="text-align:right">
                            <div style="font-size:0.95rem"><%= email %></div>
                            <small style="opacity:0.85">Logged in</small>
                        </div>
                    </div>

                    <div class="d-flex gap-2">
                        <a href="ShowCareerSuggestionsServlet" class="btn btn-outline-light btn-sm">View Suggestions</a>

                        <!-- NEW: Build Resume button (conditional) -->
                        <% if (hasSkills) { %>
                            <a href="student-resume.jsp" class="btn btn-resume btn-sm" title="Build & download your resume">
                                <i class="bi bi-file-earmark-person-fill me-1"></i> Build Resume
                            </a>
                        <% } %>

                        <a href="studentLogout" class="btn btn-primary-custom btn-sm">Logout</a>
                    </div>
                </div>
            </div>

            <!-- Alerts -->
            <div id="alertsArea">
                <% if (success != null) { %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert" id="successAlert">
                        <i class="bi bi-check-circle-fill"></i> Skill added successfully!
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                <% } else if (error != null) { %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="bi bi-exclamation-triangle-fill"></i> Failed to add skill.
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                <% } %>
            </div>

            <div class="row g-4">
                <!-- Left: Add Skill -->
                <div class="col-lg-5">
                    <div class="card-panel">
                        <h5 class="mb-3">Add New Skill</h5>

                        <!-- Hint: show when no skills -->
                        <% if (!hasSkills) { %>
                            <div class="hint-unlock">
                                <i class="bi bi-info-circle-fill" style="font-size:18px;color:#ffd36b"></i>
                                <div>
                                    <strong>Add at least 1 skill</strong><br/>
                                    Add your skills to unlock the <em>Resume Builder</em> feature.
                                </div>
                            </div>
                        <% } %>

                        <form id="addSkillForm" action="addSkill" method="post">
                            <div class="mb-3">
                                <label for="skill">Skill</label>
                                <input type="text" id="skill" name="skill" class="form-control" placeholder="e.g. Java, SQL, HTML" required />
                                <div class="form-text text-white-50">Tip: you can enter level with the skill like <code>Java - Advanced</code> or <code>Python::Intermediate</code></div>
                            </div>

                            <div class="mb-3">
                                <label for="skill_level">Skill Level (optional)</label>
                                <select name="skill_level" id="skill_level" class="form-select">
                                    <option value="">-- Select level (or leave blank) --</option>
                                    <option value="Beginner">Beginner</option>
                                    <option value="Intermediate">Intermediate</option>
                                    <option value="Advanced">Advanced</option>
                                </select>
                            </div>

                            <button id="addSkillBtn" type="submit" class="btn btn-primary-custom w-100">
                                <i class="bi bi-plus-lg"></i> Add Skill
                            </button>
                        </form>
                    </div>
                </div>

                <!-- Right: Skills List -->
                <div class="col-lg-7">
                    <div class="card-panel" style="min-height:220px" id="skillsSection">
                        <h5 class="mb-3">Your Skills</h5>

                        <% if (skills != null && !skills.isEmpty()) { %>
                            <div id="skillsList">
                                <% for (String s : skills) {
                                        String skillName = s;
                                        String level = "";
                                        // Try to parse common delimiters: " - ", "::", "|"
                                        if (s.contains(" - ")) {
                                            String[] parts = s.split(" - ", 2);
                                            skillName = parts[0].trim();
                                            level = parts.length>1 ? parts[1].trim() : "";
                                        } else if (s.contains("::")) {
                                            String[] parts = s.split("::", 2);
                                            skillName = parts[0].trim();
                                            level = parts.length>1 ? parts[1].trim() : "";
                                        } else if (s.contains("|")) {
                                            String[] parts = s.split("\\|", 2);
                                            skillName = parts[0].trim();
                                            level = parts.length>1 ? parts[1].trim() : "";
                                        }
                                %>
                                    <div class="skill-item">
                                        <div class="skill-left">
                                            <div class="skill-icon">
                                                <i class="bi bi-code-slash" style="font-size:18px"></i>
                                            </div>
                                            <div>
                                                <div style="font-weight:700"><%= skillName %></div>
                                                <% if (level != null && !level.isEmpty()) { %>
                                                    <small style="opacity:0.85"><%= level %></small>
                                                <% } %>
                                            </div>
                                        </div>

                                        <div>
                                            <% String lvlClass = "lvl-beginner";
                                               if (level.equalsIgnoreCase("Intermediate")) lvlClass = "lvl-intermediate";
                                               else if (level.equalsIgnoreCase("Advanced")) lvlClass = "lvl-advanced";
                                               String displayLevel = (level == null || level.trim().isEmpty()) ? "—" : level;
                                            %>
                                            <span class="level-badge <%= lvlClass %>"><%= displayLevel %></span>
                                        </div>
                                    </div>
                                <% } %>
                            </div>
                        <% } else { %>
                            <div class="text-center text-white-50 py-5">
                                <i class="bi bi-emoji-smile" style="font-size:28px;"></i>
                                <div class="mt-2">No skills added yet. Add your first skill to get personalized suggestions!</div>
                            </div>
                        <% } %>
                    </div>
                </div>
            </div>

            <!-- Footer small actions -->
            <div class="mt-4 d-flex justify-content-between align-items-center">
                <small style="color:rgba(255,255,255,0.75)">Logged in as: <strong><%= email %></strong></small>
                <div>
                   <% if (hasSkills) { %>
                        <a href="student-resume.jsp" class="btn btn-outline-light btn-sm me-2">
                            <i class="bi bi-file-earmark-person"></i> Build Resume
                        </a>
                   <% } %>

                    <a href="student-signup.html" class="btn btn-outline-light btn-sm">Create Another Account</a>
                </div>
            </div>
        </div>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // If skill add was successful (server sets ?success=1), scroll to skills and highlight the last item
        (function() {
            const urlParams = new URLSearchParams(window.location.search);
            const success = urlParams.get('success');
            if (success) {
                const skillsSection = document.getElementById('skillsSection');
                if (skillsSection) {
                    // small delay so browser renders the list
                    setTimeout(() => {
                        skillsSection.scrollIntoView({ behavior: 'smooth', block: 'start' });
                        // highlight the last skill item briefly
                        const list = document.getElementById('skillsList');
                        if (list && list.lastElementChild) {
                            list.lastElementChild.classList.add('highlight');
                            // remove highlight after 2.5s
                            setTimeout(() => list.lastElementChild.classList.remove('highlight'), 2500);
                        }
                    }, 300);
                }
            }
        })();

        // Prevent double-submit by disabling the button after click
        document.getElementById('addSkillForm').addEventListener('submit', function(e) {
            const btn = document.getElementById('addSkillBtn');
            btn.disabled = true;
            btn.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Adding...';
        });
    </script>
</body>
</html>
