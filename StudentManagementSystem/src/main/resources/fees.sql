USE java_ee;

DROP TABLE IF EXISTS fees;

CREATE TABLE IF NOT EXISTS fees (
    fee_id INT PRIMARY KEY AUTO_INCREMENT,
    s_id INT NOT NULL,
    fee_type VARCHAR(50) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    due_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Pending',
    FOREIGN KEY (s_id) REFERENCES students(sid)
);
