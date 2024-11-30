-- Database: là nơi lưu trữ dữ liệu của toàn bộ dự án

-- Quy tắc viết script: Những lệnh liên quan tới script đều phải viết in hoa
-- Quy tắc đặt tên database, tên bảng: Viết thường hết, không có dấu cách, cho phép sử dụng _
-- Ctrl + Enter: Chạy 1 dòng, gặp dấu ; sẽ dừng

-- Cú pháp tạo database:
CREATE DATABASE vnexpress;
USE vnexpress; -- Chỉ định database sẽ sử dụng khi chạy script

-- Cú pháp tạo bảng:
-- kiểu dữ liệu: Chuỗi, Số nguyên, Số thực, Boolean, Ngày tháng,...
-- Khóa chính: Nội dung của cột đó sẽ là duy nhất, đánh sẵn Index
-- Cột đó bắt buộc phải có dữ liệu lúc thêm
-- Cú pháp: PRIMARY KEY(ten_cot_la_khoa_chinh)
CREATE TABLE baiviet (
	id int,
	tieude varchar(255),
	hinhanh varchar(255),
	noidung text,
	
	PRIMARY KEY(id)
);

-- Xóa bảng:
DROP TABLE baiviet;

-- Thêm dữ liệu cho bảng:
-- '' chuỗi 
INSERT INTO baiviet(id,tieude,noidung) VALUES(1,'baiviet1','noidung1');
INSERT INTO baiviet(id,tieude,noidung) VALUES(2,'baiviet1','noidung2');
INSERT INTO baiviet(id,tieude,noidung) VALUES(3,'baiviet2','noidung2');

-- Xóa dữ liệu
DELETE FROM baiviet WHERE tieude = 'baiviet1' AND noidung = 'noidung2';

-- Deffered, đánh Index
-- Xem dữ liệu -> Truy vấn dữ liệu -> Query
-- Cú pháp: 
-- SELECT tencot,... , *
-- FROM tenbang
-- WHERE dieukientruyvan
SELECT tieude, noidung 
FROM baiviet
WHERE tieude = 'baiviet1';

-- Update dữ liệu
UPDATE baiviet SET baiviet = 'tieudemoi'
WHERE tieude = 'baiviet2';