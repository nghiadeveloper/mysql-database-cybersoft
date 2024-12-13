CREATE DATABASE baitaptruyvan2;
USE baitaptruyvan2;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    manager_id INT,
    salary DECIMAL(10, 2)
);

INSERT INTO employees (employee_id, name, department_id, manager_id, salary) VALUES
(1, 'Alice', 1, NULL, 60000),
(2, 'Bob', 1, 1, 55000),
(3, 'Charlie', 2, 1, 70000),
(4, 'David', 2, 3, 65000),
(5, 'Eve', 3, 1, 62000),
(6, 'Frank', 3, 5, 58000),
(7, 'Grace', 4, 1, 72000),
(8, 'Heidi', 4, 7, 71000),
(9, 'Ivan', 5, 1, 75000),
(10, 'Judy', 5, 9, 68000);

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

INSERT INTO departments (department_id, department_name) VALUES
(1, 'HR'),
(2, 'Engineering'),
(3, 'Marketing'),
(4, 'Sales'),
(5, 'Finance');

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100),
    department_id INT
);

INSERT INTO projects (project_id, project_name, department_id) VALUES
(1, 'Project A', 1),
(2, 'Project B', 2),
(3, 'Project C', 2),
(4, 'Project D', 3),
(5, 'Project E', 4),
(6, 'Project F', 5),
(7, 'Project G', 1),
(8, 'Project H', 3),
(9, 'Project I', 4),
(10, 'Project J', 5);

CREATE TABLE employee_projects (
    employee_id INT,
    project_id INT,
    PRIMARY KEY (employee_id, project_id)
);

INSERT INTO employee_projects (employee_id, project_id) VALUES
(1, 1),
(1, 7),
(2, 1),
(3, 2),
(3, 3),
(4, 2),
(4, 3),
(5, 4),
(5, 8),
(6, 4),
(6, 8),
(7, 5),
(7, 9),
(8, 5),
(8, 9),
(9, 6),
(9, 10),
(10, 6),
(10, 10);


-- Truy vấn

-- 1) Liệt kê tên nhân viên và tên phòng ban của họ
SELECT e.name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

-- 2) Liệt kê tên nhân viên và tên dự án mà họ tham gia
SELECT e.name, p.project_name
FROM employees e
JOIN employee_projects ep ON e.employee_id = ep.employee_id
JOIN projects p ON ep.project_id = p.project_id;

-- 3) Liệt kê tên phòng ban, tên dự án và tên nhân viên tham gia dự án đó
SELECT d.department_name, p.project_name, e.name
FROM departments d 
JOIN projects p ON d.department_id = p.department_id
JOIN employee_projects ep ON ep.project_id = p.project_id
JOIN employees e ON ep.employee_id = e.employee_id;

SELECT d.department_name, p.project_name, e.name
FROM projects p 
JOIN employee_projects ep ON ep.project_id = p.project_id
JOIN employees e ON ep.employee_id = e.employee_id
JOIN departments d ON d.department_id = e.department_id;

-- 4) Tính tổng lương của nhân viên tham gia từng dự án
SELECT p.project_name, SUM(e.salary) AS tongluong
FROM projects p
JOIN employee_projects ep ON p.project_id = ep.project_id
JOIN employees e ON ep.employee_id = e.employee_id
GROUP BY p.project_name;

-- 5) Liệt kê tên nhân viên, tên quản lý của họ và tên dự án họ tham gia
SELECT e.name, m.name, p.project_name
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id
JOIN employee_projects ep ON e.employee_id = ep.employee_id
JOIN projects p ON ep.project_id = p.project_id;

-- 6) Liệt kê tên phòng ban và số lượng nhân viên tham gia dự án của từng phòng ban
-- lấy ra những dự án có số lượng nhân viên tham gia > hoặc = 2 
SELECT d.department_name, p.project_name, count(*) as soluong
FROM departments d 
JOIN projects p ON d.department_id = p.department_id
JOIN employee_projects ep ON ep.project_id = p.project_id
GROUP BY d.department_name, p.project_name;

-- 7) Tìm tên nhân viên có lương cao nhất tham gia trong mỗi dự án
SELECT p.project_name, e.name, e.salary
FROM projects p
JOIN employee_projects ep ON p.project_id = ep.project_id
JOIN employees e ON ep.employee_id = e.employee_id
WHERE (ep.project_id, e.salary) IN (
    SELECT eps.project_id, MAX(es.salary) AS maxluong
    FROM employee_projects eps
    JOIN employees es ON eps.employee_id = es.employee_id
    GROUP BY eps.project_id);
   
-- 8) Liệt kê tên dự án và tổng số nhân viên tham gia, sắp xếp theo tổng số nhân viên giảm dần
SELECT p.project_name, COUNT(ep.employee_id) AS tongso
FROM projects p
LEFT JOIN employee_projects ep ON p.project_id = ep.project_id
GROUP BY p.project_name
ORDER BY total_employees DESC;

-- 9) Tính lương trung bình của nhân viên trong từng phòng ban tham gia dự án
SELECT d.department_name, AVG(e.salary) AS trungbinhluong
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN employee_projects ep ON e.employee_id = ep.employee_id
GROUP BY d.department_name;

-- 10) Tìm tên nhân viên và dự án mà họ tham gia ít nhất một lần trong mỗi phòng ban
SELECT e.name, p.project_name
FROM employees e
JOIN employee_projects ep ON e.employee_id = ep.employee_id
JOIN projects p ON ep.project_id = p.project_id
WHERE e.department_id;

-- 11) Tìm tên nhân viên và số lượng dự án mà họ tham gia nhiều nhất
SELECT e.name, COUNT(ep.project_id) AS soluongduan
FROM employees e
JOIN employee_projects ep ON e.employee_id = ep.employee_id
GROUP BY e.employee_id, e.name
ORDER BY soluongduan DESC
LIMIT 1;

-- 12) Tìm tên phòng ban và số lượng dự án mà phòng ban đó quản lý nhiều nhất
SELECT d.department_name, COUNT(p.project_id) AS soluongduan
FROM departments d
JOIN projects p ON d.department_id = p.department_id
GROUP BY d.department_id, d.department_name
ORDER BY soluongduan DESC
LIMIT 1;

-- 13) Tìm tên nhân viên có lương thấp nhất trong từng dự án
SELECT p.project_name, e.name, e.salary
FROM projects p
JOIN employee_projects ep ON p.project_id = ep.project_id
JOIN employees e ON ep.employee_id = e.employee_id
WHERE (ep.project_id, e.salary) IN (
    SELECT eps.project_id, MIN(es.salary) AS minluong
    FROM employee_projects eps
    JOIN employees es ON eps.employee_id = es.employee_id
    GROUP BY eps.project_id
);

-- 14) Liệt kê tên tất cả các dự án không có nhân viên tham gia
SELECT p.project_name
FROM projects p
LEFT JOIN employee_projects ep ON p.project_id = ep.project_id
WHERE ep.employee_id IS NULL;

-- 15) Tìm tên nhân viên có lương cao nhất và thấp nhất trong mỗi phòng ban
SELECT d.department_id, d.department_name, e_high.name AS nhanvienluongcao, e_high.salary AS luongcao, e_low.name AS nhanvienluongthap, e_low.salary AS luongthap
FROM departments d
JOIN employees e_high ON d.department_id = e_high.department_id
JOIN employees e_low ON d.department_id = e_low.department_id
WHERE e_high.salary = (SELECT MAX(salary) FROM employees WHERE department_id = d.department_id)
AND e_low.salary = (SELECT MIN(salary) FROM employees WHERE department_id = d.department_id);

-- 16) Tính tổng lương và số lượng nhân viên cho từng dự án trong mỗi phòng ban
SELECT d.department_name, p.project_name, SUM(e.salary) AS tongluong, COUNT(e.employee_id) AS soluongnhanvien
FROM departments d
JOIN projects p ON d.department_id = p.department_id
LEFT JOIN employee_projects ep ON p.project_id = ep.project_id
LEFT JOIN employees e ON ep.employee_id = e.employee_id
GROUP BY d.department_id, p.project_id;

-- 17) Tìm tên các nhân viên không tham gia bất kỳ dự án nào
SELECT e.name
FROM employees e
LEFT JOIN employee_projects ep ON e.employee_id = ep.employee_id
WHERE ep.project_id IS NULL;

-- 18) Tính tổng số dự án mà mỗi phòng ban đang quản lý
SELECT d.department_name, COUNT(p.project_id) AS tongsoduan
FROM departments d
LEFT JOIN projects p ON d.department_id = p.department_id
GROUP BY d.department_id;

-- 19) Tìm tên nhân viên và tên dự án mà nhân viên có lương cao nhất tham gia trong từng phòng ban
SELECT d.department_name, e.name, p.project_name
FROM departments d
JOIN projects p ON d.department_id = p.department_id
JOIN employee_projects ep ON p.project_id = ep.project_id
JOIN employees e ON ep.employee_id = e.employee_id
WHERE e.salary = (
    SELECT MAX(es.salary)
    FROM employees es
    WHERE es.department_id = d.department_id
);

-- 20) Tính tổng lương của nhân viên trong mỗi phòng ban theo từng dự án mà không có nhân viên tham gia dự án
SELECT d.department_name, p.project_name, SUM(e.salary) AS tongluong
FROM departments d
JOIN projects p ON d.department_id = p.department_id
LEFT JOIN employee_projects ep ON p.project_id = ep.project_id
LEFT JOIN employees e ON ep.employee_id = e.employee_id
WHERE ep.employee_id IS NULL
GROUP BY d.department_name, p.project_name;