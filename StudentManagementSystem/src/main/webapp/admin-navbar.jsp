<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

<nav>
    <div class="nav-brand">
        <i class="fas fa-graduation-cap"></i>
        <span>SMS</span>
    </div>
    <button class="menu-toggle" aria-label="Toggle menu" onclick="toggleMenu()">
        <i class="fas fa-bars"></i>
    </button>
    <div class="nav-links">
        <a href="admin-dashboard.jsp"><i class="fas fa-home"></i> <span>Home</span></a>
        <a href="add-student.jsp"><i class="fas fa-user-plus"></i> <span>Add Student</span></a>
        <a href="delete.jsp"><i class="fas fa-user-minus"></i> <span>Delete Student</span></a>
        <a href="update-student.jsp"><i class="fas fa-user-edit"></i> <span>Update Student</span></a>
        <a href="ViewAllStudentsServlet"><i class="fas fa-users"></i> <span>View Students</span></a>
        <a href="search-student.jsp"><i class="fas fa-search"></i> <span>Search Student</span></a>
        <a href="logout"><i class="fas fa-sign-out-alt"></i> <span>Logout</span></a>
    </div>
</nav>

<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Inter', sans-serif;
        -webkit-tap-highlight-color: transparent;
    }

    :root {
        --primary-color: #2563eb;
        --hover-color: #1d4ed8;
        --text-dark: #1e293b;
        --shadow-color: rgba(0, 0, 0, 0.05);
        --nav-height: 64px;
        --nav-bg: #ffffff;
        --nav-mobile-bg: #f8fafc;
    }

    body {
        padding-top: var(--nav-height);
    }

    nav {
        height: var(--nav-height);
        padding: 0 1rem;
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        z-index: 9999;
        display: flex;
        align-items: center;
        background-color: var(--nav-bg);
        box-shadow: 0 2px 4px -1px var(--shadow-color);
    }

    .nav-brand {
        font-size: 1.25rem;
        font-weight: 600;
        margin-right: 1rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .nav-brand i {
        font-size: 1.5rem;
    }

    .nav-links {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        margin-left: auto;
    }

    nav a {
        color: var(--text-dark);
        text-decoration: none;
        padding: 0.75rem 1rem;
        border-radius: 0.5rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
        font-size: 0.875rem;
        font-weight: 500;
        transition: all 0.2s ease;
        white-space: nowrap;
    }

    nav a:hover {
        background-color: rgba(37, 99, 235, 0.1);
        color: var(--primary-color);
    }

    nav a i {
        font-size: 1.125rem;
    }

    .menu-toggle {
        display: none;
        background: none;
        border: none;
        font-size: 1.5rem;
        color: var(--text-dark);
        cursor: pointer;
        padding: 0.5rem;
        margin-right: 0.5rem;
        border-radius: 0.375rem;
        transition: background-color 0.2s ease;
    }

    .menu-toggle:hover {
        background-color: rgba(0, 0, 0, 0.05);
    }

    @media (max-width: 1024px) {
        .menu-toggle {
            display: block;
        }

        .nav-links {
            position: fixed;
            top: var(--nav-height);
            left: 0;
            right: 0;
            bottom: 0;
            background-color: var(--nav-mobile-bg);
            flex-direction: column;
            padding: 1rem;
            gap: 0.5rem;
            transform: translateX(-100%);
            transition: transform 0.3s ease;
            margin-left: 0;
            overflow-y: auto;
        }

        .nav-links.active {
            transform: translateX(0);
        }

        nav a {
            width: 100%;
            padding: 1rem;
            border-radius: 0.5rem;
        }

        nav a i {
            width: 24px;
            text-align: center;
        }
    }

    @media (max-width: 480px) {
        nav {
            padding: 0 0.75rem;
        }

        .menu-toggle {
            padding: 0.375rem;
        }

        nav a {
            padding: 0.875rem;
            font-size: 0.8125rem;
        }

        nav a i {
            font-size: 1rem;
        }
    }
</style>

<script>
    function toggleMenu() {
        const navLinks = document.querySelector('.nav-links');
        navLinks.classList.toggle('active');
    }

    document.addEventListener('click', (e) => {
        const nav = document.querySelector('nav');
        const navLinks = document.querySelector('.nav-links');
        const menuToggle = document.querySelector('.menu-toggle');
        
        if (!nav.contains(e.target) && navLinks.classList.contains('active')) {
            navLinks.classList.remove('active');
        }
    });
</script>
