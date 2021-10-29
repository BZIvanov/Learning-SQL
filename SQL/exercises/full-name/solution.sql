DELIMITER //
CREATE PROCEDURE GetFullName(FirstName VARCHAR(20), LastName VARCHAR(20))
BEGIN 
	DECLARE FullName VARCHAR(40);
  SET FullName = CONCAT(FirstName, ' ', LastName);
  SELECT FullName;
END//
DELIMITER ;

CALL GetFullName('Iva', 'Ivanova');
