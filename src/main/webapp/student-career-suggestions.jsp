<%@ page import="java.util.*" %>
<%@ page import="com.studentcareer.model.CareerSuggestion" %>
<%@ page contentType="text/html;charset=UTF-8" session="true" %>

<%
    // Prevent caching after logout
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    // Session check
    Integer sid = (Integer) session.getAttribute("studentId");
    String email = (String) session.getAttribute("studentEmail");
    if (sid == null) {
        response.sendRedirect("student-login.html");
        return;
    }

    // Retrieve suggestions map from servlet
    Map<String, List<CareerSuggestion>> suggestionsMap =
        (Map<String, List<CareerSuggestion>>) request.getAttribute("suggestionsMap");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Career Suggestions</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        :root{
            --bg-1: #0f172a;
            --accent-1: #06b6d4;
            --accent-2: #7c3aed;
            --card-bg: rgba(255,255,255,0.03);
        }

        body {
            min-height: 100vh;
            margin: 0;
            font-family: "Inter", system-ui, -apple-system, "Segoe UI", Roboto, Arial;
            background:
                radial-gradient(800px 400px at 10% 10%, rgba(124,58,237,0.12), transparent 10%),
                linear-gradient(135deg, var(--bg-1), #071024 60%);
            color: #e6eef8;
            padding: 36px 16px;
        }

        .wrap { max-width: 1100px; margin: 0 auto; }

        .topbar { display:flex; align-items:center; justify-content:space-between; gap:12px; margin-bottom:18px; }
        .page-title { display:flex; align-items:center; gap:12px; }
        .page-title h2 { margin:0; font-size:1.35rem; font-weight:700; }
        .chip { display:inline-flex; align-items:center; gap:10px; background: linear-gradient(90deg,var(--accent-1), var(--accent-2)); padding:8px 12px; border-radius:999px; color:#021024; font-weight:700; box-shadow: 0 8px 30px rgba(12,18,35,0.6); }

        .card-plain { background: var(--card-bg); border: 1px solid rgba(255,255,255,0.04); border-radius:12px; padding:18px; box-shadow: 0 10px 30px rgba(2,6,23,0.5); color: #e6eef8; }
        .skill-card { border-radius:10px; overflow:hidden; transition: transform .16s ease, box-shadow .16s ease; }
        .skill-card:hover { transform: translateY(-6px); box-shadow: 0 18px 40px rgba(2,6,23,0.6); }
        .card-header-info { background: linear-gradient(90deg,#06b6d4,#7c3aed); color: #021024; font-weight:700; }

        .list-group-item { background: transparent; border: 0; padding-left: 0; padding-right: 0; }
        .suggestion-line { display:flex; align-items:flex-start; gap:12px; padding:10px 12px; border-radius:8px; background: rgba(255,255,255,0.02); margin-bottom:10px; color: #021024; }
        .suggestion-icon { width:42px;height:42px;border-radius:8px; display:flex;align-items:center;justify-content:center; background: rgba(255,255,255,0.85); color: #071024; font-weight:700; box-shadow: 0 8px 20px rgba(2,6,23,0.45); }

        .empty-state { text-align:center; padding:30px; background: rgba(255,255,255,0.02); border-radius:10px; color: rgba(230,238,248,0.95); }
        a.btn-back { background: rgba(255,255,255,0.04); color: #e6eef8; border: 1px solid rgba(255,255,255,0.04); }

        @media (max-width: 768px) { .topbar { flex-direction: column; align-items:flex-start; gap:12px; } }
    </style>
</head>
<body>
    <div class="wrap">
        <div class="topbar">
            <div class="page-title">
                <div class="chip"><i class="bi bi-lightbulb-fill"></i> Suggestions</div>
                <div>
                    <h2>Your Career Suggestions</h2>
                    <small style="opacity:0.85">Personalized suggestions based on your skills</small>
                </div>
            </div>

            <div class="d-flex align-items-center gap-2">
                <a href="student-dashboard.jsp" class="btn btn-back btn-sm me-2"><i class="bi bi-arrow-left-circle me-1"></i> Back</a>
                <a href="studentLogout" class="btn btn-outline-light btn-sm"><i class="bi bi-box-arrow-right me-1"></i> Logout</a>
            </div>
        </div>

        <div class="card-plain">
            <%
                if (suggestionsMap == null || suggestionsMap.isEmpty()) {
            %>
                <div class="empty-state">
                    <i class="bi bi-emoji-frown" style="font-size:34px; opacity:0.95;"></i>
                    <h5 class="mt-3">No suggestions found</h5>
                    <p style="opacity:0.9">Admin hasn't added suggestions for your skills yet. Contact admin or add more skills to get suggestions.</p>
                </div>
            <%
                } else {
                    for (Map.Entry<String, List<CareerSuggestion>> entry : suggestionsMap.entrySet()) {
                        String skill = entry.getKey();
                        List<CareerSuggestion> list = entry.getValue();
            %>

                <div class="card mb-3 skill-card">
                    <div class="card-header card-header-info d-flex align-items-center justify-content-between">
                        <div style="display:flex; gap:12px; align-items:center;">
                            <div style="width:44px;height:44px;border-radius:8px;background:rgba(255,255,255,0.85);display:flex;align-items:center;justify-content:center;color:#071024;">
                                <i class="bi bi-gear-fill"></i>
                            </div>
                            <div>
                                <div style="font-weight:800; color:#fff;"><%= skill %></div>
                                <small style="opacity:0.95; color: rgba(255,255,255,0.9);">Suggestions for <strong><%= skill %></strong></small>
                            </div>
                        </div>
                        <div>
                            <button class="btn btn-sm btn-light" type="button" data-bs-toggle="collapse" data-bs-target="#collapse-<%= Math.abs(skill.hashCode()) %>">
                                <i class="bi bi-chevron-down"></i> Toggle
                            </button>
                        </div>
                    </div>

                    <div id="collapse-<%= Math.abs(skill.hashCode()) %>" class="collapse show">
                        <div class="card-body">
                            <%
                                if (list == null || list.isEmpty()) {
                            %>
                                <p class="text-muted mb-0">No suggestion available for this skill yet.</p>
                            <%
                                } else {
                            %>
                                <ul class="list-group list-group-flush">
                                    <% for (CareerSuggestion cs : list) { %>
                                        <li class="list-group-item">
                                            <div class="suggestion-line">
                                                <div class="suggestion-icon">
                                                    <i class="bi bi-arrow-right-circle"></i>
                                                </div>
                                                <div style="flex:1">
                                                    <!-- Only using cs.getSuggestion() because other getters are not present -->
                                                    <div style="font-weight:700;">Suggestion</div>
                                                    <div style="margin-top:6px; color:#0b1220;"><%= cs.getSuggestion() %></div>
                                                </div>
                                            </div>
                                        </li>
                                    <% } %>
                                </ul>
                            <%
                                }
                            %>
                        </div>
                    </div>
                </div>

            <%
                    }
                }
            %>
        </div>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
