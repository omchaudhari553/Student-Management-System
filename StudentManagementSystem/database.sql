
-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS java_ee;

-- Use the database
USE java_ee;

-- Drop existing tables if they exist
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS users;

-- Create students table
CREATE TABLE students (
    sid INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Create users table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insert some sample data into students
INSERT INTO students (sid, name, age, email) VALUES
(1001, 'John Doe', 20, 'john.doe@example.com'),
(1002, 'Jane Smith', 22, 'jane.smith@example.com'),
(1003, 'Bob Wilson', 21, 'bob.wilson@example.com');

-- Insert a sample user (username: admin, password: admin123)
INSERT INTO users (username, password) VALUES
('admin', 'admin123');