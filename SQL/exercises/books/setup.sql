CREATE DATABASE library;

USE library;

CREATE TABLE books
(
	book_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(100),
  author_fname VARCHAR(100),
	author_lname VARCHAR(100)
);

INSERT INTO books (title, author_fname, author_lname)
VALUES
('White Noise', 'Don', 'DeLillo'),
('Oblivion: Stories', 'David', 'Foster Wallace'),
('Just Kids', 'Patti', 'Smith'),
('Consider the Lobster', 'David', 'Foster Wallace'),
('Norse Mythology', 'Don', 'Gaiman');

SELECT * FROM books;
