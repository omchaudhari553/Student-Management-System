-- Drop table if exists
DROP TABLE IF EXISTS students;

-- Create students table
CREATE TABLE students (
    sid INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(15),
    address TEXT,
    gender VARCHAR(10),
    course VARCHAR(50),
    status VARCHAR(20) DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Add some sample data
INSERT INTO students (name, age, email, phone, address, gender, course) VALUES
('John Doe', 20, 'john@example.com', '1234567890', '123 Main St', 'Male', 'Computer Science'),
('Jane Smith', 22, 'jane@example.com', '9876543210', '456 Oak Ave', 'Female', 'Information Technology'),
('Bob Wilson', 21, 'bob@example.com', '5555555555', '789 Pine Rd', 'Male', 'Data Science');
