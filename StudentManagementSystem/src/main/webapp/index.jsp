<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Management System</title>
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
            background-color: var(--background);
            color: var(--text);
            min-height: 100vh;
            line-height: 1.6;
        }

        .navbar {
            background-color: var(--surface);
            padding: 1rem 2rem;
            box-shadow: 0 2px 8px rgba(255, 0, 0, 0.1);
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
        }

        .nav-links {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 2rem;
        }

        .nav-links a {
            color: var(--text);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            padding: 0.5rem 1rem;
            border-radius: 4px;
            position: relative;
            overflow: hidden;
        }

        .nav-links a:before {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            width: 0;
            height: 2px;
            background-color: var(--primary);
            transform: translateX(-50%);
            transition: width 0.3s ease-in-out;
        }

        .nav-links a:hover:before {
            width: 100%;
        }

        .nav-links a:hover {
            color: var(--primary);
            text-shadow: 0 0 8px rgba(255, 26, 26, 0.5);
            transform: translateY(-2px);
        }

        .hero {
            padding: 8rem 2rem 4rem;
            text-align: center;
            background: linear-gradient(to bottom, rgba(26, 26, 26, 0.9), rgba(26, 26, 26, 0.95)), 
                        url('https://source.unsplash.com/random/1920x1080?university') center/cover;
        }

        .hero h1 {
            font-size: 3.5rem;
            margin-bottom: 1.5rem;
            color: var(--primary);
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
            position: relative;
            display: inline-block;
            transition: all 0.3s ease;
        }

        .hero h1:hover {
            text-shadow: 0 0 20px rgba(255, 26, 26, 0.5),
                        0 0 40px rgba(255, 26, 26, 0.3),
                        0 0 60px rgba(255, 26, 26, 0.2);
            transform: scale(1.02);
        }

        .hero p {
            font-size: 1.2rem;
            color: var(--text-secondary);
            max-width: 800px;
            margin: 0 auto 2rem;
        }

        .cta-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
        }

        .cta-button {
            padding: 1rem 2rem;
            border: none;
            border-radius: 8px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            position: relative;
            overflow: hidden;
            z-index: 1;
        }

        .primary-btn {
            background-color: var(--primary);
            color: white;
        }

        .primary-btn:before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 300px;
            height: 300px;
            background: radial-gradient(circle, var(--primary-dark), transparent);
            transform: translate(-50%, -50%) scale(0);
            transition: transform 0.5s ease-out;
            z-index: -1;
        }

        .primary-btn:hover:before {
            transform: translate(-50%, -50%) scale(2);
        }

        .primary-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 15px rgba(255, 26, 26, 0.4),
                       0 0 30px rgba(255, 26, 26, 0.2);
            letter-spacing: 1px;
        }

        .secondary-btn {
            background-color: transparent;
            color: var(--text);
            border: 2px solid var(--primary);
            position: relative;
            z-index: 1;
        }

        .secondary-btn:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: var(--primary);
            transform: scaleX(0);
            transform-origin: right;
            transition: transform 0.5s ease-out;
            z-index: -1;
        }

        .secondary-btn:hover:before {
            transform: scaleX(1);
            transform-origin: left;
        }

        .secondary-btn:hover {
            color: white;
            transform: translateY(-3px);
            border-color: transparent;
            box-shadow: 0 6px 15px rgba(255, 26, 26, 0.4);
        }

        .features {
            padding: 4rem 2rem;
            background-color: var(--surface);
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            max-width: 1200px;
            margin: 0 auto;
        }

        .feature-card {
            background-color: var(--background);
            padding: 2rem;
            border-radius: 12px;
            text-align: center;
            transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
            border: 1px solid var(--border);
            position: relative;
            overflow: hidden;
            z-index: 1;
        }

        .feature-card:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(45deg, transparent, rgba(255, 26, 26, 0.1), transparent);
            transform: translateX(-100%);
            transition: transform 0.6s ease;
            z-index: -1;
        }

        .feature-card:hover:before {
            transform: translateX(100%);
        }

        .feature-card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: 0 10px 20px rgba(255, 26, 26, 0.2),
                       0 0 20px rgba(255, 26, 26, 0.1);
            border-color: var(--primary);
        }

        .feature-icon {
            font-size: 2.5rem;
            color: var(--primary);
            margin-bottom: 1rem;
            transition: all 0.8s cubic-bezier(0.4, 0, 0.2, 1);
            display: inline-block;
        }

        .feature-card:hover .feature-icon {
            transform: rotateY(360deg) scale(1.2);
            color: var(--hover);
        }

        .feature-card h3 {
            transition: all 0.3s ease;
        }

        .feature-card:hover h3 {
            transform: scale(1.05);
            color: var(--primary);
        }

        .about-section, .contact-section {
            padding: 4rem 2rem;
            background-color: var(--surface);
            margin-top: 2rem;
        }

        .section-title {
            color: var(--primary);
            font-size: 2.5rem;
            text-align: center;
            margin-bottom: 2rem;
            position: relative;
            display: inline-block;
            left: 50%;
            transform: translateX(-50%);
        }

        .section-title:after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 100%;
            height: 3px;
            background: linear-gradient(90deg, 
                transparent, 
                var(--primary), 
                transparent
            );
        }

        .card-container {
            display: flex;
            gap: 2rem;
            max-width: 1200px;
            margin: 0 auto;
            flex-wrap: wrap;
        }

        .info-card {
            flex: 1;
            min-width: 300px;
            background-color: var(--background);
            border-radius: 15px;
            padding: 2rem;
            border: 1px solid var(--border);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .info-card:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(45deg, transparent, rgba(255, 26, 26, 0.05), transparent);
            transform: translateX(-100%);
            transition: transform 0.6s ease;
        }

        .info-card:hover:before {
            transform: translateX(100%);
        }

        .info-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(255, 26, 26, 0.1);
            border-color: var(--primary);
        }

        .info-card h3 {
            color: var(--primary);
            font-size: 1.5rem;
            margin-bottom: 1rem;
        }

        .info-card p {
            color: var(--text-secondary);
            line-height: 1.6;
            margin-bottom: 1rem;
        }

        .contact-info {
            list-style: none;
            padding: 0;
        }

        .contact-info li {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
            color: var(--text);
        }

        .contact-info i {
            color: var(--primary);
            font-size: 1.2rem;
            width: 24px;
        }

        .social-links {
            display: flex;
            gap: 1rem;
            margin-top: 1.5rem;
        }

        .social-link {
            color: var(--text);
            font-size: 1.5rem;
            transition: all 0.3s ease;
        }

        .social-link:hover {
            color: var(--primary);
            transform: translateY(-3px);
        }

        footer {
            background-color: var(--surface);
            color: var(--text-secondary);
            text-align: center;
            padding: 2rem;
            margin-top: 4rem;
            border-top: 1px solid var(--border);
            position: relative;
            overflow: hidden;
        }

        footer:before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 200%;
            height: 1px;
            background: linear-gradient(90deg, 
                transparent, 
                rgba(255, 26, 26, 0.5), 
                var(--primary), 
                rgba(255, 26, 26, 0.5), 
                transparent
            );
            animation: footerGlow 3s linear infinite;
        }

        @keyframes footerGlow {
            0% {
                transform: translateX(-50%);
            }
            100% {
                transform: translateX(0%);
            }
        }

        html {
            scroll-behavior: smooth;
        }

        @media (max-width: 768px) {
            .hero h1 {
                font-size: 2.5rem;
            }

            .nav-links {
                gap: 1rem;
            }

            .features-grid {
                grid-template-columns: 1fr;
            }

            .card-container {
                flex-direction: column;
            }
            .info-card {
                min-width: 100%;
            }
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="nav-links">
            <a href="#about">About Us</a>
            <a href="#contact">Contact</a>
            <a href="login.jsp">Login</a>
        </div>
    </nav>

    <section class="hero">
        <h1>Student Management System</h1>
        <p>A comprehensive solution for managing student information, attendance, and academic performance with ease.</p>
        <div class="cta-buttons">
            <a href="login.jsp" class="cta-button primary-btn">
                <i class="fas fa-sign-in-alt"></i> Get Started
            </a>
        </div>
    </section>

    <section class="features">
        <div class="features-grid">
            <div class="feature-card">
                <i class="fas fa-user-graduate feature-icon"></i>
                <h3>Student Management</h3>
                <p>Efficiently manage student profiles, academic records, and personal information.</p>
            </div>
            <div class="feature-card">
                <i class="fas fa-calendar-check feature-icon"></i>
                <h3>Attendance Tracking</h3>
                <p>Track and manage student attendance with our user-friendly interface.</p>
            </div>
            <div class="feature-card">
                <i class="fas fa-chart-line feature-icon"></i>
                <h3>Performance Analytics</h3>
                <p>Monitor and analyze student performance with detailed reports and insights.</p>
            </div>
        </div>
    </section>

    <section id="about" class="about-section">
        <h2 class="section-title">About Us</h2>
        <div class="card-container">
            <div class="info-card">
                <h3>Our Mission</h3>
                <p>We strive to provide an efficient and user-friendly student management system that helps educational institutions streamline their administrative processes and enhance the learning experience.</p>
                <p>Our platform is designed to meet the evolving needs of modern education, incorporating the latest technologies and best practices in educational management.</p>
            </div>
            <div class="info-card">
                <h3>Our Vision</h3>
                <p>To be the leading provider of educational management solutions, empowering institutions worldwide to deliver quality education through innovative technology.</p>
                <p>We aim to continuously evolve and adapt our system to meet the changing needs of educational institutions and their stakeholders.</p>
            </div>
        </div>
    </section>

    <section id="contact" class="contact-section">
        <h2 class="section-title">Contact Us</h2>
        <div class="card-container">
            <div class="info-card">
                <h3>Get in Touch</h3>
                <ul class="contact-info">
                    <li>
                        <i class="fas fa-map-marker-alt"></i>
                        <span>123 Education Street, Knowledge City, IN 400001</span>
                    </li>
                    <li>
                        <i class="fas fa-phone"></i>
                        <span>+91 123 456 7890</span>
                    </li>
                    <li>
                        <i class="fas fa-envelope"></i>
                        <span>contact@studentms.com</span>
                    </li>
                </ul>
            </div>
            <div class="info-card">
                <h3>Connect With Us</h3>
                <p>Follow us on social media to stay updated with the latest news and updates about our student management system.</p>
                <div class="social-links">
                    <a href="#" class="social-link"><i class="fab fa-facebook"></i></a>
                    <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="social-link"><i class="fab fa-instagram"></i></a>
                    <a href="#" class="social-link"><i class="fab fa-linkedin"></i></a>
                </div>
            </div>
        </div>
    </section>

    <footer>
        <p>&copy; 2024 Student Management System. All rights reserved.</p>
    </footer>
</body>
</html>
