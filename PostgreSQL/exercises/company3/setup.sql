CREATE TABLE company (
	employee VARCHAR(50) NOT NULL,
	salary INT NOT NULL,
	department VARCHAR(50) NOT NULL
);

INSERT INTO company(employee, salary, department) VALUES
('Iva', 3900, 'HR'), ('Eli', 2850, 'Finance'), ('Toni', 4500, 'Dev'),
('Miro', 4200, 'Dev'), ('Hristo', 2500, 'HR'), ('Ivan', 5100, 'Dev'),
('Elena', 3550, 'Finance'), ('Georgi', 3890, 'Dev'), ('Evgeni', 5100, 'Dev');

SELECT * FROM company;
