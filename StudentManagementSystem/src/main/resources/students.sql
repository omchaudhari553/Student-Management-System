CREATE TABLE students (
    sid INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    age INT NOT NULL,
);

-- Insert some sample data
INSERT INTO students (name, email, age) VALUES
('John Doe', 'john@example.com', 20),
('Jane Smith', 'jane@example.com', 22),
('Bob Wilson', 'bob@example.com', 21);
