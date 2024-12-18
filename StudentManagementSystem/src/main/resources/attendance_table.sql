-- Create attendance_records table
CREATE TABLE attendance_records (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    class_id INT NOT NULL,
    date DATE NOT NULL,
    status VARCHAR(10) NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (class_id) REFERENCES classes(id)
);

-- Sample insert
INSERT INTO attendance_records (student_id, class_id, date, status) 
VALUES (1, 1, '2024-12-15', 'PRESENT');
