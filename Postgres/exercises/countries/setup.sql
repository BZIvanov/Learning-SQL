CREATE TABLE user_country (
	username VARCHAR(50) NOT NULL,
	country VARCHAR(50) NOT NULL
);

INSERT INTO user_country(username, country) VALUES
('Iva', 'Bulgaria'), ('Jake', 'France'), ('Tina', 'France'),
('Spas', 'Bulgaria'), ('Julie', 'Italy'), ('Tim', 'Italy'),
('Moni', 'Bulgaria'), ('Peter', 'Germany'), ('Bistra', 'Bulgaria'),
('Moni', 'Bulgaria'), ('Mike', 'Poland'), ('Eva', 'Spain');

SELECT * FROM user_country;
