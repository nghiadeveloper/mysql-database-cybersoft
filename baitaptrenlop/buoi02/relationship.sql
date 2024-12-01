USE vnexpress;

-- Relationship
-- Để liên kết dữ liệu của 2 bảng lại với nhau chỉ cần có 1 cột chứa dữ liệu trùng với 1 cột nào đó 
-- của bảng cần liên kết dữ liệu là được

-- Tạo bảng
CREATE TABLE danhmuc (
	id INT AUTO_INCREMENT,
	tendanhmuc VARCHAR(255),
	PRIMARY KEY(id)
);

CREATE TABLE baiviet (
	id int AUTO_INCREMENT,
	tieude varchar(255),
	noidung text,
	id_danhmuc int,
	PRIMARY KEY(id)
	-- FOREIGN KEY(id_danhmuc) REFERENCES danhmuc(id)
);

-- Xóa bảng
DROP TABLE danhmuc;
DROP TABLE baiviet;

-- Thêm cột (chỉnh sửa bảng)
-- Từ khóa: insert batch, duplicate data
ALTER TABLE baiviet ADD COLUMN id_danhmuc INT;

-- Thêm dữ liệu
INSERT INTO danhmuc(tendanhmuc) VALUES('Danh muc 1');
INSERT INTO danhmuc(tendanhmuc) VALUES('Danh muc 2');
INSERT INTO danhmuc(tendanhmuc) VALUES('Danh muc 3');
INSERT INTO danhmuc(tendanhmuc) VALUES('Danh muc 4');

INSERT INTO baiviet(tieude,noidung,id_danhmuc) VALUES('Tieu de 1','Noi dung 1',1);
INSERT INTO baiviet(tieude,noidung,id_danhmuc) VALUES('Tieu de 2','Noi dung 2',2);
INSERT INTO baiviet(tieude,noidung,id_danhmuc) VALUES('Tieu de 3','Noi dung 3',3);
INSERT INTO baiviet(tieude,noidung,id_danhmuc) VALUES('Tieu de 4','Noi dung 4',4);


-- Truy vấn
SELECT * FROM danhmuc d;

-- Cách liên kết dữ liệu của 2 hoặc nhiều bảng lại với nhau: phép tích và phép join

-- Tại sao không nên sử dụng phép tich mà sử dụng phép join?
-- 1. Phép tích: Trong quá trình liên kết 2 bảng với nhau nó sẽ trả về rất nhiều dữ liệu, rồi mới dùng where để lọc lại dữ liệu
-- 2. Phép Join: Trong quá trình liên kết 2 bảng với nhau nó sẽ lọc dữ liệu luôn

-- Cách 1: Phép tích
SELECT * 
FROM baiviet b, danhmuc d
WHERE b.id_danhmuc = d.id;

-- Cách 2: Phép Join
-- Phép join nhớ ghi JOIN và ON, mysql ko có full join (bản chất full join chính là phép tích) là lấy toàn bộ dữ liệu của bài viết 
-- liên kết với bảng danh mục với điều kiện giá trị của id_danhmuc trong bảng bài viết với giá trị id của bảng danh mục 
SELECT * 
FROM baiviet b 
JOIN danhmuc d ON b.id_danhmuc = d.id;

-- Khóa ngoại: nhằm để đảm bảo tính toàn vẹn về mặt dữ liệu

-- Cột đóng vai trò là khóa ngoại thì kiểu dữ liệu phải trùng với kiểu dữ liệu của cột mà nó tham chiếu tới
ALTER TABLE baiviet ADD CONSTRAINT FK_id_danhmuc_baiviet FOREIGN KEY(id_danhmuc) REFERENCES danhmuc(id);

-- Mối quan hệ giữa 2 bảng (định nghĩa bằng miệng): giúp xác định khóa ngoại nằm bên bảng nào là hợp lý (ít bị trùng dữ liệu)
-- one to one (1 - 1): 1 dòng dữ liệu của bảng này chỉ lấy được 1 dòng dữ liệu của bảng kia
-- Khóa ngoại nằm bảng nào cũng được, vùa là khóa ngoại kiêm luôn là khóa chính

-- one to many (1 - n): 1 dòng dữ liệu của bảng này sẽ lấy được nhiều dòng dữ liệu của bảng kia
-- Khóa ngoại nằm bảng nhiều

-- many to one (n - 1): nhiều dòng dữ liệu của bảng này sẽ lấy được 1 dòng dữ liệu của bảng kia
-- Khóa ngoại nằm bảng nhiều

-- many to many (n - n): 1 dòng dữ liệu của bảng này sẽ lấy được nhièu dòng dữ liệu của bảng kia 
-- và 1 dòng dữ liệu của bảng kia sẽ lấy được nhiều dòng dữ liệu của bảng này
-- Sẽ phát sinh ra 1 bảng trung gian (bảng thứ 3) và bảng này sẽ có 2 cột cùng đóng vai trò là khóa chính và khoá ngoại