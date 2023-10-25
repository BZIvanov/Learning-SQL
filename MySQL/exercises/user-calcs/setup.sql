CREATE DATABASE user_calcs;

USE user_calcs;

CREATE TABLE calculations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    income DECIMAL(7, 2),
    work_days INT
);

INSERT INTO calculations (first_name, last_name, income, work_days) VALUES 
('Iva', 'Ivanova', 3870.12, 21), ('Simona', 'Ivanova', 2850.00, 15), ('Petar', 'Petrov', 4772.99, 22);

SELECT * FROM calculations;
