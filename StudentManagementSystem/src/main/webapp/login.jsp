<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Student Management System</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary: #ff1a1a;
            --primary-dark: #cc0000;
            --background: #1a1a1a;
            --surface: #2d2d2d;
            --text: #ffffff;
            --text-secondary: #cccccc;
            --border: #404040;
            --hover: #ff3333;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Plus Jakarta Sans', sans-serif;
        }

        body {
            background: linear-gradient(135deg, var(--background) 0%, #000 100%);
            color: var(--text);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            line-height: 1.6;
        }

        /* Navy wave background */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: 
                linear-gradient(45deg, 
                    rgba(0, 0, 128, 0.3),
                    rgba(0, 0, 255, 0.1)
                );
            z-index: -2;
        }

        /* Add wave animations */
        @keyframes wave {
            0% { transform: translateX(-100%) translateZ(0) scaleY(1); }
            50% { transform: translateX(-50%) translateZ(0) scaleY(0.8); }
            100% { transform: translateX(0) translateZ(0) scaleY(1); }
        }

        @keyframes waveRotate {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Wave elements */
        .wave {
            position: fixed;
            bottom: 0;
            left: 0;
            width: 200%;
            height: 100%;
            background: url('data:image/svg+xml;utf8,<svg viewBox="0 0 1200 120" preserveAspectRatio="none" xmlns="http://www.w3.org/2000/svg"><path d="M321.39,56.44c58-10.79,114.16-30.13,172-41.86,82.39-16.72,168.19-17.73,250.45-.39C823.78,31,906.67,72,985.66,92.83c70.05,18.48,146.53,26.09,214.34,3V0H0V27.35A600.21,600.21,0,0,0,321.39,56.44Z" fill="rgba(0, 0, 128, 0.3)"/></svg>');
            background-repeat: repeat-x;
            animation: wave 15s linear infinite;
            z-index: -1;
            opacity: 0.5;
        }

        .wave:nth-child(2) {
            bottom: 0;
            animation: wave 30s linear reverse infinite;
            opacity: 0.3;
        }

        .wave:nth-child(3) {
            bottom: 0;
            animation: wave 20s linear infinite;
            opacity: 0.2;
        }

        /* Naval compass animation */
        .compass {
            position: fixed;
            width: 100px;
            height: 100px;
            border: 2px solid rgba(0, 0, 128, 0.3);
            border-radius: 50%;
            top: 20px;
            right: 20px;
            animation: waveRotate 10s linear infinite;
        }

        .compass::before {
            content: '↑';
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            color: rgba(0, 0, 128, 0.5);
            font-size: 24px;
        }

        .login-container {
            animation: floatEffect 3s ease-in-out infinite;
            background: linear-gradient(135deg, 
                rgba(0, 0, 128, 0.4),
                rgba(0, 0, 255, 0.2)
            );
            backdrop-filter: blur(10px);
            width: 90%;
            max-width: 360px;
            padding: 24px;
            border-radius: 16px;
            box-shadow: 0 4px 15px rgba(255, 26, 26, 0.1);
            border: 1px solid rgba(0, 0, 128, 0.3);
            animation: fadeIn 0.8s ease-out;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(0, 0, 128, 0.3);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .login-container::before {
            content: '';
            position: absolute;
            top: -2px;
            left: -2px;
            right: -2px;
            bottom: -2px;
           
            border-radius: 17px;
            z-index: -1;
            animation: glowingBorder 2s infinite, rotateGlow 3s linear infinite;
        }

        .login-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 40px rgba(255, 26, 26, 0.15);
        }

        .welcome-text {
            background: linear-gradient(90deg, var(--text), var(--primary), var(--text));
            background-size: 200% auto;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            animation: shimmer 3s linear infinite;
            text-align: center;
            margin-bottom: 20px;
            color: var(--primary);
            font-size: 1.8rem;
            font-weight: 600;
            text-shadow: 0 0 10px rgba(255, 26, 26, 0.3);
            position: relative;
            animation: pulse 2s infinite;
        }

        .welcome-text::after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 50%;
            width: 50px;
            height: 2px;
            background: var(--primary);
            transform: translateX(-50%);
            animation: glow 2s infinite;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }

        @keyframes slideIn {
            from { transform: translateX(-100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        @keyframes glow {
            0% { box-shadow: 0 0 5px rgba(255, 26, 26, 0.2); }
            50% { box-shadow: 0 0 20px rgba(255, 26, 26, 0.4); }
            100% { box-shadow: 0 0 5px rgba(255, 26, 26, 0.2); }
        }

        @keyframes floatEffect {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        @keyframes glowingBorder {
            0%, 100% { box-shadow: 0 0 10px rgba(255, 26, 26, 0.3); }
            50% { box-shadow: 0 0 20px rgba(255, 26, 26, 0.6); }
        }

        @keyframes shimmer {
            0% { background-position: -200% 0; }
            100% { background-position: 200% 0; }
        }

        @keyframes rotateGlow {
            0% { filter: hue-rotate(0deg); }
            100% { filter: hue-rotate(360deg); }
        }

        .toggle-container {
            display: flex;
            margin-bottom: 24px;
            background: rgba(26, 26, 26, 0.8);
            border: 1px solid rgba(255, 26, 26, 0.2);
            animation: glowingBorder 3s infinite;
            padding: 4px;
            gap: 4px;
            border-radius: 12px;
            position: relative;
            overflow: hidden;
        }

        .toggle-btn {
            flex: 1;
            padding: 12px;
            text-align: center;
            cursor: pointer;
            border-radius: 8px;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            color: var(--text);
            position: relative;
            overflow: hidden;
            z-index: 1;
        }

        .toggle-btn::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 300px;
            height: 300px;
            background: radial-gradient(circle, var(--primary), transparent);
            transform: translate(-50%, -50%) scale(0);
            transition: transform 0.5s ease-out;
            z-index: -1;
        }

        .toggle-btn:hover::before {
            transform: translate(-50%, -50%) scale(2);
        }

        .toggle-btn.active {
            background: linear-gradient(45deg, var(--primary-dark), var(--primary));
            animation: shimmer 3s linear infinite;
            background: var(--primary);
            color: white;
            box-shadow: 0 0 15px rgba(255, 26, 26, 0.3);
        }

        .form-container {
            display: none;
            opacity: 0;
            transform: translateX(-20px);
            transition: all 0.3s ease;
        }

        .form-container.active {
            display: block;
            opacity: 1;
            transform: translateX(0);
            animation: fadeIn 0.5s ease-out forwards;
        }

        .form-group {
            margin-bottom: 16px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--text);
            font-size: 14px;
        }

        .form-group input {
            background: rgba(26, 26, 26, 0.8);
            border: 1px solid rgba(255, 26, 26, 0.1);
            transition: all 0.3s ease;
            width: 100%;
            padding: 12px;
            border: 2px solid transparent;
            border-radius: 8px;
            font-size: 16px;
            outline: none;
            background: var(--background);
            color: var(--text);
        }

        .form-group input:focus {
            animation: glowingBorder 2s infinite;
            transform: translateY(-2px);
            background: rgba(26, 26, 26, 0.9);
            border-color: var(--primary);
            box-shadow: 0 0 15px rgba(255, 26, 26, 0.2);
        }

        .btn-login {
            background: linear-gradient(45deg, 
                navy,
                #0000cd,
                navy
            );
            background-size: 200% auto;
            animation: shimmer 3s linear infinite;
            width: 100%;
            padding: 12px;
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .btn-login::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(
                90deg,
                transparent,
                rgba(255, 255, 255, 0.2),
                transparent
            );
            transition: 0.5s;
        }

        .btn-login:hover::before {
            left: 100%;
        }

        .btn-login:hover {
            transform: translateY(-3px);
            animation: glowingBorder 2s infinite, shimmer 3s linear infinite;
            box-shadow: 0 6px 15px rgba(255, 26, 26, 0.4);
            background: linear-gradient(45deg, 
                #000080,
                #0000ff,
                #000080
            );
        }

        .error-message {
            animation: shake 0.5s ease-in-out;
            background: rgba(239, 68, 68, 0.1);
            color: #ef4444;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 16px;
            font-size: 14px;
            text-align: center;
            border: 1px solid rgba(239, 68, 68, 0.2);
            animation: fadeIn 0.5s ease-out;
            border-left: 4px solid #ef4444;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            10%, 30%, 50%, 70%, 90% { transform: translateX(-5px); }
            20%, 40%, 60%, 80% { transform: translateX(5px); }
        }

        .signup-link {
            text-align: center;
            margin-top: 16px;
            font-size: 14px;
            color: var(--text-secondary);
        }

        .signup-link a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            position: relative;
        }

        .signup-link a::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 100%;
            height: 1px;
            background: var(--primary);
            transform: scaleX(0);
            transform-origin: right;
            transition: transform 0.3s ease;
        }

        .signup-link a:hover::after {
            transform: scaleX(1);
            transform-origin: left;
        }

        .signup-link a:hover {
            color: var(--hover);
            text-shadow: 0 0 8px rgba(255, 26, 26, 0.5);
        }

        /* Back to Home Button */
        .back-home {
            position: fixed;
            top: 20px;
            left: 20px;
            padding: 10px 20px;
            background-color: var(--primary);
            color: var(--text);
            text-decoration: none;
            border-radius: 5px;
            font-weight: 500;
            transition: all 0.3s ease;
            z-index: 1000;
        }

        .back-home:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(255, 26, 26, 0.3);
        }
    </style>
</head>
<body>
    <a href="index.jsp" class="back-home">
        <i class="fas fa-home"></i> Back to Home
    </a>
    <div class="wave"></div>
    <div class="wave"></div>
    <div class="wave"></div>
    <div class="compass"></div>
    <div class="login-container">
        <h2 class="welcome-text">Welcome Back!</h2>
        
        <div class="toggle-container">
            <div class="toggle-btn active" onclick="toggleForm('user')">User Login</div>
            <div class="toggle-btn" onclick="toggleForm('admin')">Admin Login</div>
        </div>

        <% if(request.getAttribute("error") != null) { %>
            <div class="error-message">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <div class="form-container active" id="userForm">
            <form action="LoginServlet" method="post">
                <input type="hidden" name="userType" value="user">
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" required>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <button type="submit" class="btn-login">Login</button>
            </form>
        </div>
        
        <div class="form-container" id="adminForm">
            <form action="LoginServlet" method="post">
                <input type="hidden" name="userType" value="admin">
                <div class="form-group">
                    <label for="adminUsername">Admin Username</label>
                    <input type="text" id="adminUsername" name="username" required>
                </div>
                <div class="form-group">
                    <label for="adminPassword">Password</label>
                    <input type="password" id="adminPassword" name="password" required>
                </div>
                <button type="submit" class="btn-login">Login as Admin</button>
            </form>
        </div>

        <div class="signup-link">
            New User? <a href="signup.jsp">Sign Up</a>
        </div>
    </div>

    <script>
        function toggleForm(type) {
            const userBtn = document.querySelector('.toggle-btn:first-child');
            const adminBtn = document.querySelector('.toggle-btn:last-child');
            const userForm = document.getElementById('userForm');
            const adminForm = document.getElementById('adminForm');

            if (type === 'user') {
                userBtn.classList.add('active');
                adminBtn.classList.remove('active');
                userForm.classList.add('active');
                adminForm.classList.remove('active');
            } else {
                adminBtn.classList.add('active');
                userBtn.classList.remove('active');
                adminForm.classList.add('active');
                userForm.classList.remove('active');
            }
        }
    </script>
</body>
</html>
