USE vnexpress;

CREATE TABLE students (
	id INT AUTO_INCREMENT,
	fullname VARCHAR(255) NOT NULL,
	gender VARCHAR(50),
	age INT,
	city VARCHAR(255),
	weight DOUBLE,
	PRIMARY KEY(id)
);

DROP TABLE students;

INSERT INTO students (id, fullname, gender, age, city, weight) VALUES(1,'Nguyen Thanh Nhan','Nam',19,'Can Tho',56.6574);
INSERT INTO students (id, fullname, gender, age, city, weight) VALUES(2,'Pham Thu Huong','Nu',20,'Vinh Long',72.456);
INSERT INTO students (id, fullname, gender, age, city, weight) VALUES(3,'Nguyen Nhu Ngoc','Nu',20,'Soc Trang',85.387);
INSERT INTO students (id, fullname, gender, age, city, weight) VALUES(4,'Bui Thanh Bao','Nam',19,'Soc Trang',49.3);
INSERT INTO students (id, fullname, gender, age, city, weight) VALUES(5,'Le My Nhan','Nu',22,'Can Tho',62.963);
INSERT INTO students (id, fullname, gender, age, city, weight) VALUES(6,'Tan Thuc Bao','Nam',35,'An Giang',55.5678);
INSERT INTO students (id, fullname, gender, age, city, weight) VALUES(7,'Trinn Giao Kim','Nam',44,'Bac Lieu',67.34);

-- Truy vấn 
SELECT id, fullname, gender, age, city, weight
FROM students;