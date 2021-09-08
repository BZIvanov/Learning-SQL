CREATE TABLE dates (
	username VARCHAR(50) NOT NULL,
	today TIMESTAMP NOT NULL DEFAULT NOW()
);

INSERT INTO dates(username) VALUES ('Iva');

SELECT * FROM dates;
