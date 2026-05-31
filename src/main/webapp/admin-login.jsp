<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Login</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        :root {
            --bg: #0f172a;
            --glass: rgba(255,255,255,0.07);
            --btn-grad: linear-gradient(90deg, #06b6d4, #4f46e5);
        }

        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background:
                radial-gradient(800px 400px at 10% 10%, rgba(124,58,237,0.15), transparent),
                linear-gradient(135deg, var(--bg), #041024 70%);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #e6eef8;
        }

        .login-card {
            width: 360px;
            padding: 32px;
            background: var(--glass);
            border-radius: 18px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255,255,255,0.08);
            box-shadow: 0 10px 40px rgba(0,0,0,0.5);
            animation: fadeUp .6s ease;
            text-align: center;
        }

        h2 {
            font-weight: 700;
            margin-bottom: 22px;
            color: #fff;
        }

        label {
            display: block;
            text-align: left;
            margin-bottom: 6px;
            font-weight: 500;
            color: #dbeafe;
        }

        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 12px;
            border-radius: 10px;
            border: 1px solid rgba(255,255,255,0.2);
            background: rgba(255,255,255,0.12);
            color: #fff;
            margin-bottom: 14px;
        }

        input:focus {
            outline: none;
            border-color: #06b6d4;
            background: rgba(255,255,255,0.18);
            box-shadow: 0 0 0 2px rgba(6,182,212,0.3);
        }

        .btn-login {
            width: 100%;
            padding: 12px;
            border: none;
            background: var(--btn-grad);
            border-radius: 10px;
            color: #fff;
            font-weight: 600;
            margin-top: 15px;
            box-shadow: 0 8px 20px rgba(6,182,212,0.3);
            transition: 0.2s;
        }

        .btn-login:hover {
            transform: translateY(-2px);
            opacity: 0.95;
        }

        .error-msg {
            margin-top: 12px;
            color: #ff9e9e;
            font-weight: 500;
        }

        @keyframes fadeUp {
            from { opacity:0; transform: translateY(16px); }
            to { opacity:1; transform: translateY(0); }
        }
    </style>
</head>

<body>

<div class="login-card">
    <h2>Admin Login 🔐</h2>

    <!-- Login Form -->
    <form action="AdminLoginServlet" method="post">
        <label>Email</label>
        <input type="email" name="email" required>

        <label>Password</label>
        <input type="password" name="password" required>

        <button type="submit" class="btn-login">Login</button>
    </form>

    <!-- Error Message -->
    <p class="error-msg">
        <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage").toString() : "" %>
    </p>
</div>

</body>
</html>
