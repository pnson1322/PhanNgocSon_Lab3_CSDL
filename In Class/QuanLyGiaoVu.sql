-- Tạo database quản lí giáo vụ
CREATE DATABASE QUANLIGIAOVU

USE QUANLIGIAOVU

-- Tạo các quan hệ trong database
CREATE TABLE HOCVIEN(
	 MAHV char(5) PRIMARY KEY,
	 HO varchar(40),
	 TEN varchar(10),
	 NGSINH smalldatetime,
	 GIOITINH varchar(3),
	 NOISINH varchar(40),
	 MALOP char(4),
);

ALTER TABLE HOCVIEN
ALTER COLUMN MALOP CHAR (3)

ALTER TABLE HOCVIEN ADD
CONSTRAINT FK_MALOP FOREIGN KEY (MALOP) REFERENCES LOP(MALOP)

CREATE TABLE KHOA(
	MAKHOA varchar(4) PRIMARY KEY,
	TENKHOA varchar(40),
	NGTLAP smalldatetime,
	TRGKHOA char(4),
);

CREATE TABLE MONHOC(
	MAMH VARCHAR(10) PRIMARY KEY,
	TENMH VARCHAR(40),
	TCLT TINYINT,
	TCTH TINYINT,
	MAKHOA VARCHAR(4) REFERENCES KHOA(MAKHOA),
);

CREATE TABLE DIEUKIEN(
	MAMH VARCHAR(10) REFERENCES MONHOC(MAMH),
	MAMH_TRUOC VARCHAR(10) REFERENCES MONHOC(MAMH),
	PRIMARY KEY (MAMH, MAMH_TRUOC),
);

CREATE TABLE GIAOVIEN(
	MAGV CHAR(4) PRIMARY KEY,
	HOTEN VARCHAR(40),
	HOCVI VARCHAR(10),
	HOCHAM VARCHAR(10),
	GIOITINH VARCHAR(3),
	NGSINH SMALLDATETIME,
	NGVL SMALLDATETIME,
	HESO NUMERIC(4,2),
	MUCLUONG MONEY,
	MAKHOA VARCHAR(4) REFERENCES KHOA(MAKHOA),
);

CREATE TABLE LOP(
	MALOP CHAR(3) PRIMARY KEY,
	TENLOP VARCHAR(40),
	TRGLOP CHAR(5) REFERENCES HOCVIEN(MAHV),
	SISO TINYINT,
	MAGVCN CHAR(4) REFERENCES GIAOVIEN(MAGV),
);

CREATE TABLE GIANGDAY(
	MALOP CHAR(3) REFERENCES LOP(MALOP),
	MAMH VARCHAR(10) REFERENCES MONHOC(MAMH),
	MAGV CHAR(4) REFERENCES GIAOVIEN(MAGV),
	HOCKY TINYINT,
	NAM SMALLINT,
	TUNGAY SMALLDATETIME,
	DENNGAY SMALLDATETIME,
	PRIMARY KEY (MALOP, MAMH),
);

CREATE TABLE KETQUATHI(
	MAMH VARCHAR(10) REFERENCES MONHOC(MAMH),
	MAHV CHAR(5) REFERENCES HOCVIEN(MAHV),
	LANTHI TINYINT,
	NGTHI SMALLDATETIME,
	DIEM NUMERIC(4,2),
	KQUA VARCHAR(10),
	PRIMARY KEY(MAHV, MAMH, LANTHI),
);

ALTER TABLE KHOA ADD
CONSTRAINT FK_TGK_GV FOREIGN KEY (TRGKHOA) REFERENCES GIAOVIEN(MAGV)

-- Nhập dữ liệu cho cơ sở dữ liệu
INSERT KHOA (MAKHOA, TENKHOA, NGTLAP, TRGKHOA) VALUES 
(N'KHMT', N'Khoa hoc may tinh', CAST(N'2005-06-07T00:00:00.000' AS DateTime), NULL),
(N'HTTT', N'He thong thong tin', CAST(N'2005-06-07T00:00:00.000' AS DateTime), NULL),
(N'CNPM', N'Cong nghe phan mem', CAST(N'2005-06-07T00:00:00.000' AS DateTime), NULL),
(N'MTT', N'Mang va truyen thong', CAST(N'2005-10-20T00:00:00.000' AS DateTime), NULL),
(N'KTMT', N'Ky thuat may tinh', CAST(N'2005-12-20T00:00:00.000' AS DateTime), NULL);

INSERT MONHOC (MAMH, TENMH, TCLT, TCTH, MAKHOA) VALUES
(N'THDC', N'Tin hoc dai cuong', 4, 1, N'KHMT'),
(N'CTRR', N'Cau truc roi rac', 5, 0, N'KHMT'),
(N'CSDL', N'Co so du lieu', 3, 1, N'HTTT'),
(N'CTDLGT', N'Cau truc du lieu va giai thuat', 3, 1, N'KHMT'),
(N'PTTKTT', N'Phan tich thiet ke thuat toan', 3, 0, N'KHMT'),
(N'DHMT', N'Do hoa may tinh', 3, 1, N'KHMT'),
(N'KTMT', N'Kien truc may tinh', 3, 0, N'KTMT'),
(N'TKCSDL', N'Thiet ke co so du lieu', 3, 1, N'HTTT'),
(N'PTTKHTTT', N'Phan tich thiet ke he thong thong tin', 4, 1, N'HTTT'),
(N'HDH', N'He dieu hanh', 4, 0, N'KTMT'),
(N'NMCNPM', N'Nhap mon cong nghe phan mem', 3, 0, N'CNPM'),
(N'LTCFW', N'Lap trinh C for win', 3, 1, N'CNPM'),
(N'LTHDT', N'Lap trinh huong doi tuong', 3, 1, N'CNPM');

INSERT DIEUKIEN (MAMH, MAMH_TRUOC) VALUES
(N'CSDL', N'CTRR'),
(N'CSDL', N'CTDLGT'),
(N'CTDLGT', N'THDC'),
(N'PTTKTT', N'THDC'),
(N'PTTKTT', N'CTDLGT'),
(N'DHMT', N'THDC'),
(N'LTHDT', N'THDC'),
(N'PTTKHTTT', N'CSDL');

INSERT GIAOVIEN (MAGV, HOTEN, HOCVI, HOCHAM, GIOITINH, NGSINH, NGVL, HESO, MUCLUONG, MAKHOA) VALUES
(N'GV01', N'Ho Thanh Son', N'PTS', N'GS', N'Nam', '1950-05-02', '2004-01-11', 5, 2250000, N'KHMT'),
(N'GV02', N'Tran Tam Thanh', N'TS', N'PGS', N'Nam', '1965-12-17', '2004-04-20', 4.5, 2025000, N'HTTT'),
(N'GV03', N'Do Nghiem Phung', N'TS', N'GS', N'Nu', '1950-08-01', '2004-09-23', 4, 1800000, N'CNPM'),
(N'GV04', N'Tran Nam Son', N'TS', N'PGS', N'Nam', '1961-02-22', '2005-01-12', 4.5, 2025000, N'KTMT'),
(N'GV05', N'Mai Thanh Danh', N'ThS', N'GV', N'Nam', '1958-03-12', '2005-01-12', 3, 1350000, N'HTTT'),
(N'GV06', N'Tran Doan Hung', N'TS', N'GV', N'Nam', '1953-03-11', '2005-01-12', 4.5, 2025000, N'KHMT'),
(N'GV07', N'Nguyen Minh Tien', N'ThS', N'GV', N'Nam', '1971-11-23', '2005-03-01', 4, 1800000, N'KHMT'),
(N'GV08', N'Le Thi Tran', N'KS', N'Null', N'Nu', '1974-03-26', '2005-03-01', 1.69, 760500, N'KHMT'),
(N'GV09', N'Nguyen To Lan', N'ThS', N'GV', N'Nu', '1966-12-31', '2005-03-01', 4, 1800000, N'HTTT'),
(N'GV10', N'Le Tran Anh Loan', N'KS', N'Null', N'Nu', '1972-07-17', '2005-03-01', 1.86, 837000, N'CNPM'),
(N'GV11', N'Ho Thanh Tung', N'CN', N'GV', N'Nam', '1980-01-12', '2005-05-15', 2.67, 1201500, N'MTT'),
(N'GV12', N'Tran Van Anh', N'CN', N'Null', N'Nu', '1981-03-29', '2005-05-15', 1.69, 760500, N'CNPM'),
(N'GV13', N'Nguyen Linh Dan', N'CN', N'Null', N'Nu', '1980-05-23', '2005-05-15', 1.69, 760500, N'KTMT'),
(N'GV14', N'Truong Minh Chau', N'ThS', N'GV', N'Nu', '1976-11-30', '2005-05-15', 3, 1350000, N'MTT'),
(N'GV15', N'Le Ha Thanh', N'ThS', N'GV', N'Nam', '1978-05-04', '2005-05-15', 3, 1350000, N'KHMT');

INSERT LOP (MALOP, TENLOP, TRGLOP, SISO, MAGVCN) VALUES
(N'K11', N'Lop 1 khoa 1', N'K1108', 11, N'GV07'),
(N'K12', N'Lop 2 khoa 1', N'K1205', 12, N'GV09'),
(N'K13', N'Lop 3 khoa 1', N'K1305', 12, N'GV14');

INSERT HOCVIEN (MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) VALUES
(N'K1101', N'Nguyen Van', N'A', '1986-01-27', N'Nam', N'TpHCM', N'K11'),
(N'K1102', N'Tran Ngoc', N'Han', '1986-03-14', N'Nu', N'Kien Giang', N'K11'),
(N'K1103', N'Ha Duy', N'Lap', '1986-04-18', N'Nam', N'Nghe An', N'K11'),
(N'K1104', N'Tran Ngoc', N'Linh', '1986-03-30', N'Nu', N'Tay Ninh', N'K11'),
(N'K1105', N'Tran Minh', N'Long', '1986-02-27', N'Nam', N'TpHCM', N'K11'),
(N'K1106', N'Le Nhat', N'Minh', '1986-01-24', N'Nam', N'TpHCM', N'K11'),
(N'K1107', N'Nguyen Nhu', N'Nhut', '1986-01-27', N'Nam', N'Ha Noi', N'K11'),
(N'K1108', N'Nguyen Manh', N'Tam', '1986-02-27', N'Nam', N'Kien Giang', N'K11'),
(N'K1109', N'Phan Thi Thanh', N'Tam', '1986-01-27', N'Nu', N'Vinh Long', N'K11'),
(N'K1110', N'Le Hoai', N'Thuong', '1986-02-05', N'Nu', N'Can Tho', N'K11'),
(N'K1111', N'Le Ha', N'Vinh', '1986-12-25', N'Nam', N'Vinh Long', N'K11'),
(N'K1201', N'Nguyen Van', N'B', '1986-02-11', N'Nam', N'TpHCM', N'K12'),
(N'K1202', N'Nguyen Thi Kim', N'Duyen', '1986-01-18', N'Nu', N'TpHCM', N'K12'),
(N'K1203', N'Tran Thi Kim', N'Duyen', '1986-09-17', N'Nu', N'TpHCM', N'K12'),
(N'K1204', N'Truong My', N'Hanh', '1986-05-19', N'Nu', N'Dong Nai', N'K12'),
(N'K1205', N'Nguyen Thanh', N'Nam', '1986-04-17', N'Nam', N'TpHCM', N'K12'),
(N'K1206', N'Nguyen Thi Truc', N'Thanh', '1986-03-04', N'Nu', N'Kien Giang', N'K12'),
(N'K1207', N'Tran Thi Bich', N'Thuy', '1986-02-08', N'Nu', N'Nghe An', N'K12'),
(N'K1208', N'Huynh Thi Kim', N'Trieu', '1986-04-08', N'Nu', N'Tay Ninh', N'K12'),
(N'K1209', N'Pham Thanh', N'Trieu', '1986-02-23', N'Nam', N'TpHCM', N'K12'),
(N'K1210', N'Ngo Thanh', N'Tuan', '1986-02-14', N'Nam', N'TpHCM', N'K12'),
(N'K1211', N'Do Thi', N'Xuan', '1986-03-09', N'Nu', N'Ha Noi', N'K12'),
(N'K1212', N'Le Thi Phi', N'Yen', '1986-03-12', N'Nu', N'TpHCM', N'K12'),
(N'K1301', N'Nguyen Thi Kim', N'Cuc', '1986-06-09', N'Nu', N'Kien Giang', N'K13'),
(N'K1302', N'Truong Thi My', N'Hien', '1986-03-18', N'Nu', N'Nghe An', N'K13'),
(N'K1303', N'Le Duc', N'Hien', '1986-03-21', N'Nam', N'Tay Ninh', N'K13'),
(N'K1304', N'Le Quang', N'Hien', '1986-04-18', N'Nam', N'TpHCM', N'K13'),
(N'K1305', N'Le Thi', N'Huong', '1986-03-27', N'Nu', N'TpHCM', N'K13'),
(N'K1306', N'Nguyen Thai', N'Huu', '1986-03-30', N'Nam', N'Ha Noi', N'K13'),
(N'K1307', N'Tran Minh', N'Man', '1986-05-28', N'Nam', N'TpHCM', N'K13'),
(N'K1308', N'Nguyen Hieu', N'Nghia', '1986-04-08', N'Nam', N'Kien Giang', N'K13'),
(N'K1309', N'Nguyen Trung', N'Nghia', '1987-01-18', N'Nam', N'Nghe An', N'K13'),
(N'K1310', N'Tran Thi Hong', N'Tham', '1986-04-22', N'Nu', N'Tay Ninh', N'K13'),
(N'K1311', N'Tran Minh', N'Thuc', '1986-04-04', N'Nam', N'TpHCM', N'K13'),
(N'K1312', N'Nguyen Thi Kim', N'Yen', '1986-09-07', N'Nu', N'TpHCM', N'K13');

INSERT GIANGDAY (MALOP, MAMH, MAGV, HOCKY, NAM, TUNGAY, DENNGAY) VALUES
(N'K11', N'THDC', N'GV07', 1, 2006, '2006-01-02', '2006-05-12'),
(N'K12', N'THDC', N'GV06', 1, 2006, '2006-01-02', '2006-05-12'),
(N'K13', N'THDC', N'GV15', 1, 2006, '2006-01-02', '2006-05-12'),
(N'K11', 'CTRR', N'GV02', 1, 2006, '2006-01-09', '2006-05-17'),
(N'K12', N'CTRR', N'GV02', 1, 2006, '2006-01-09', '2006-05-17'),
(N'K13', N'CTRR', N'GV08', 1, 2006, '2006-01-09', '2006-05-17'),
(N'K11', N'CSDL', N'GV05', 2, 2006, '2006-06-01', '2006-07-15'),
(N'K12', N'CSDL', N'GV09', 2, 2006, '2006-06-01', '2006-07-15'),
(N'K13', N'CTDLGT', N'GV15', 2, 2006, '2006-06-01', '2006-07-15'),
(N'K13', N'CSDL', N'GV05', 3, 2006, '2006-08-01', '2006-12-15'),
(N'K13', N'DHMT', N'GV07', 3, 2006, '2006-08-01', '2006-12-15'),
(N'K11', N'CTDLGT', N'GV15', 3, 2006, '2006-08-01', '2006-12-15'),
(N'K12', N'CTDLGT', N'GV15', 3, 2006, '2006-08-01', '2006-12-15'),
(N'K11', N'HDH', N'GV04', 1, 2007, '2007-01-02', '2007-02-18'),
(N'K12', N'HDH', N'GV04', 1, 2007, '2007-01-02', '2007-03-20'),
(N'K11', N'DHMT', N'GV07', 1, 2007, '2007-02-18', '2007-03-20');

INSERT KETQUATHI (MAHV, MAMH, LANTHI, NGTHI, DIEM, KQUA) VALUES
(N'K1101', N'CSDL', 1, '2006-07-20', 10, N'Dat'),
(N'K1101', N'CTDLGT', 1, '2006-12-28', 9, N'Dat'),
(N'K1101', N'THDC', 1, '2006-05-20', 9, N'Dat'),
(N'K1101', N'CTRR', 1, '2006-05-13', 9.5, N'Dat'),
(N'K1102', N'CSDL', 1, '2006-07-20', 4, N'Khong Dat'),
(N'K1102', N'CSDL', 2, '2006-07-27', 4.25, N'Khong Dat'),
(N'K1102', N'CSDL', 3, '2006-08-10', 4.5, N'Khong Dat'),
(N'K1102', N'CTDLGT', 1, '2006-12-28', 4.5, N'Khong Dat'),
(N'K1102', N'CTDLGT', 2, '2007-01-05', 4, N'Khong Dat'),
(N'K1102', N'CTDLGT', 3, '2007-01-15', 6, N'Dat'),
(N'K1102', N'THDC', 1, '2006-05-20', 5, N'Dat'),
(N'K1102', N'CTRR', 1, '2006-05-13', 7, N'Dat'),
(N'K1103', N'CSDL', 1, '2006-07-20', 3.5, N'Khong Dat'),
(N'K1103', N'CSDL', 2, '2006-07-27', 8.25, N'Dat'),
(N'K1103', N'CTDLGT', 1, '2006-12-28', 7, N'Dat'),
(N'K1103', N'THDC', 1, '2006-05-20', 8, N'Dat'),
(N'K1103', N'CTRR', 1, '2006-05-13', 6.5, N'Dat'),
(N'K1104', N'CSDL', 1, '2006-07-20', 3.75, N'Khong Dat'),
(N'K1104', N'CTDLGT', 1, '2006-12-28', 4, N'Khong Dat'),
(N'K1104', N'THDC', 1, '2006-05-20', 4, N'Khong Dat'),
(N'K1104', N'CTRR', 1, '2006-05-13', 4, N'Khong Dat'),
(N'K1104', N'CTRR', 2, '2006-05-20', 3.5, N'Khong Dat'),
(N'K1104', N'CTRR', 3, '2006-06-30', 4, N'Khong Dat'),
(N'K1201', N'CSDL', 1, '2006-07-20', 6, N'Dat'),
(N'K1201', N'CTDLGT', 1, '2006-12-28', 5, N'Dat'),
(N'K1201', N'THDC', 1, '2006-05-20', 8.5, N'Dat'),
(N'K1201', N'CTRR', 1, '2006-05-13', 9, N'Dat'),
(N'K1202', N'CSDL', 1, '2006-07-20', 8, N'Dat'),
(N'K1202', N'CTDLGT', 1, '2006-12-28', 4, N'Khong Dat'),
(N'K1202', N'CTDLGT', 2, '2007-01-05', 5, N'Dat'),
(N'K1202', N'THDC', 1, '2006-05-20', 4, N'Khong Dat'),
(N'K1202', N'THDC', 2, '2006-05-27', 4, N'Khong Dat'),
(N'K1202', N'CTRR', 1, '2006-05-13', 3, N'Khong Dat'),
(N'K1202', N'CTRR', 2, '2006-05-20', 4, N'Khong Dat'),
(N'K1202', N'CTRR', 3, '2006-06-30', 6.25, N'Dat'),
(N'K1203', N'CSDL', 1, '2006-07-20', 9.25, N'Dat'),
(N'K1203', N'CTDLGT', 1, '2006-12-28', 9.5, N'Dat'),
(N'K1203', N'THDC', 1, '2006-05-20', 10, N'Dat'),
(N'K1203', N'CTRR', 1, '2006-05-13', 10, N'Dat'),
(N'K1204', N'CSDL', 1, '2006-07-20', 8.5, N'Dat'),
(N'K1204', N'CTDLGT', 1, '2006-12-28', 6.75, N'Dat'),
(N'K1204', N'THDC', 1, '2006-05-20', 4, N'Khong Dat'),
(N'K1204', N'CTRR', 1, '2006-05-13', 6, N'Dat'),
(N'K1301', N'CSDL', 1, '2006-12-20', 4.25, N'Khong Dat'),
(N'K1301', N'CTDLGT', 1, '2006-07-25', 8, N'Dat'),
(N'K1301', N'THDC', 1, '2006-05-20', 7.75, N'Dat'),
(N'K1301', N'CTRR', 1, '2006-05-13', 8, N'Dat'),
(N'K1302', N'CSDL', 1, '2006-12-20', 6.75, N'Dat'),
(N'K1302', N'CTDLGT', 1, '2006-07-25', 5, N'Dat'),
(N'K1302', N'THDC', 1, '2006-05-20', 8, N'Dat'),
(N'K1302', N'CTRR', 1, '2006-05-13', 8.5, N'Dat'),
(N'K1303', N'CSDL', 1, '2006-12-20', 4, N'Khong Dat'),
(N'K1303', N'CTDLGT', 1, '2006-07-25', 4.5, N'Khong Dat'),
(N'K1303', N'CTDLGT', 2, '2006-08-07', 4, N'Khong Dat'),
(N'K1303', N'CTDLGT', 3, '2006-08-15', 4.25, N'Khong Dat'),
(N'K1303', N'THDC', 1, '2006-05-20', 4.5, N'Khong Dat'),
(N'K1303', N'CTRR', 1, '2006-05-13', 3.25, N'Khong Dat'),
(N'K1303', N'CTRR', 2, '2006-05-20', 5, N'Dat'),
(N'K1304', N'CSDL', 1, '2006-12-20', 7.75, N'Dat'),
(N'K1304', N'CTDLGT', 1, '2006-07-25', 9.75, N'Dat'),
(N'K1304', N'THDC', 1, '2006-05-20', 5.5, N'Dat'),
(N'K1304', N'CTRR', 1, '2006-05-13', 5, N'Dat'),
(N'K1305', N'CSDL', 1, '2006-12-20', 9.25, N'Dat'),
(N'K1305', N'CTDLGT', 1, '2006-07-25', 10, N'Dat'),
(N'K1305', N'THDC', 1, '2006-05-20', 8, N'Dat'),
(N'K1305', N'CTRR', 1, '2006-05-13', 10, N'Dat');

UPDATE KHOA SET TRGKHOA = N'GV01' 
WHERE MAKHOA = N'KHMT'

UPDATE KHOA SET TRGKHOA = N'GV02' 
WHERE MAKHOA = N'HTTT'

UPDATE KHOA SET TRGKHOA = N'GV03' 
WHERE MAKHOA = N'CNPM'

UPDATE KHOA SET TRGKHOA = N'GV04' 
WHERE MAKHOA = N'MTT'

UPDATE KHOA SET TRGKHOA = N'Null'
WHERE MAKHOA = N'KTMT'

-- II.
-- 1. Tăng hệ số lương thêm 0.2 cho những giáo viên là trưởng khoa.
UPDATE GIAOVIEN
SET HESO = HESO * 1.2
WHERE MAGV in (Select TRGKHOA From KHOA)

--Câu 2.Cập nhật giá trị điểm trung bình tất cả các môn học  (DIEMTB) của mỗi học viên (tất cả các môn học đều có hệ số 1 và nếu học viên thi một môn nhiều lần, chỉ lấy điểm của lần thi sau cùng).
UPDATE HOCVIEN SET DIEMTB = DTB_HOCVIEN.DTB
FROM HOCVIEN HV LEFT JOIN (SELECT MAHV, AVG(DIEM) AS DTB 
	FROM KETQUATHI A
	WHERE NOT EXISTS (
		SELECT 1 
		FROM KETQUATHI B 
		WHERE A.MAHV = B.MAHV AND A.MAMH = B.MAMH AND A.LANTHI < B.LANTHI
	) 
	GROUP BY MAHV
) DTB_HOCVIEN
ON HV.MAHV = DTB_HOCVIEN.MAHV

-- 3. Cập nhật giá trị cho cột GHICHU là “Cam thi” đối với trường hợp: học viên có một môn bất kỳ thi lần thứ 3 dưới 5 điểm.
UPDATE HOCVIEN 
SET GHICHU = 'Cam thi'
WHERE MAHV IN (
	SELECT MAHV 
	FROM KETQUATHI 
	WHERE LANTHI = 3 AND DIEM < 5
)

-- 4. Cập nhật giá trị cho cột XEPLOAI trong quan hệ HOCVIEN như sau:
-- o Nếu DIEMTB >= 9 thì XEPLOAI =”XS”
-- o Nếu 8 <= DIEMTB < 9 thì XEPLOAI = “G”
-- o Nếu 6.5 <= DIEMTB < 8 thì XEPLOAI = “K”
-- o Nếu 5 <= DIEMTB < 6.5 thì XEPLOAI = “TB”
-- o Nếu DIEMTB < 5 thì XEPLOAI = ”Y”
UPDATE HOCVIEN 
SET XEPLOAI = 
CASE 
	WHEN DIEMTB >= 9 THEN 'XS'
	WHEN DIEMTB >= 8 THEN 'G'
	WHEN DIEMTB >= 6.5 THEN 'K'
	WHEN DIEMTB >= 5 THEN 'TB'
	ELSE 'Y'
	END

-- III.
-- 6. Tìm tên những môn học mà giáo viên có tên “Tran Tam Thanh” dạy trong học kỳ 1 năm 2006.
SELECT TENMH FROM MONHOC, GIANGDAY, GIAOVIEN
WHERE MONHOC.MAMH = GIANGDAY.MAMH AND GIAOVIEN.MAGV = GIANGDAY.MAGV AND HOTEN = N'Tran Tam Thanh' AND HOCKY = 1 AND NAM = 2006

-- 7. Tìm những môn học (mã môn học, tên môn học) mà giáo viên chủ nhiệm lớp “K11” dạy trong học kỳ 1 năm 2006.
SELECT MONHOC.MAMH, TENMH FROM MONHOC, LOP, GIANGDAY
WHERE MONHOC.MAMH = GIANGDAY.MAMH AND GIANGDAY.MAGV = LOP.MAGVCN AND GIANGDAY.MALOP = N'K11' AND HOCKY = 1 AND NAM = 2006

-- 8. Tìm họ tên lớp trưởng của các lớp mà giáo viên có tên “Nguyen To Lan” dạy môn “Co So Du Lieu”.
SELECT HO, TEN FROM HOCVIEN, LOP, GIAOVIEN, GIANGDAY, MONHOC
WHERE HOCVIEN.MAHV = LOP.TRGLOP AND GIANGDAY.MALOP = LOP.MALOP AND GIANGDAY.MAGV = GIAOVIEN.MAGV AND GIANGDAY.MAMH = MONHOC.MAMH
	AND HOTEN = N'Nguyen To Lan' AND TENMH = N'Co so du lieu'
	
-- 9. In ra danh sách những môn học (mã môn học, tên môn học) phải học liền trước môn “Co So Du Lieu”.
SELECT MH2.MAMH, MH2.TENMH 
FROM DIEUKIEN JOIN MONHOC MH1 ON DIEUKIEN.MAMH = MH1.MAMH
			JOIN MONHOC MH2 ON DIEUKIEN.MAMH_TRUOC = MH2.MAMH
WHERE MH1.TENMH = N'Co so du lieu'

-- 10. Môn “Cau Truc Roi Rac” là môn bắt buộc phải học liền trước những môn học (mã môn học, tên môn học) nào.
SELECT MH1.MAMH, MH1.TENMH 
FROM DIEUKIEN JOIN MONHOC MH1 ON DIEUKIEN.MAMH = MH1.MAMH
			JOIN MONHOC MH2 ON DIEUKIEN.MAMH_TRUOC = MH2.MAMH
WHERE MH2.TENMH = N'Cau truc roi rac'

-- 11. Tìm họ tên giáo viên dạy môn CTRR cho cả hai lớp “K11” và “K12” trong cùng học kỳ 1 năm 2006.
(SELECT HOTEN FROM GIAOVIEN, GIANGDAY
WHERE GIAOVIEN.MAGV = GIANGDAY.MAGV AND MALOP = N'K11' AND HOCKY = 1 AND NAM = 2006)
UNION
(SELECT HOTEN FROM GIAOVIEN, GIANGDAY
WHERE GIAOVIEN.MAGV = GIANGDAY.MAGV AND MALOP = N'K12' AND HOCKY = 1 AND NAM = 2006)

-- 12. Tìm những học viên (mã học viên, họ tên) thi không đạt môn CSDL ở lần thi thứ 1 nhưng chưa thi lại môn này.
select distinct HV.MAHV, HV.HO, HV.TEN
from HOCVIEN HV, KETQUATHI KQ
where KQ.KQUA='Khong Dat' and KQ.LANTHI=1 and HV.MAHV=KQ.MAHV and HV.MAHV in
( Select HOCVIEN.MAHV
from HOCVIEN, KETQUATHI
where KETQUATHI.MAMH='CSDL' and HOCVIEN.MAHV=KETQUATHI.MAHV
group by HOCVIEN.MAHV
having count(KETQUATHI.LANTHI)=1)

-- 13. Tìm giáo viên (mã giáo viên, họ tên) không được phân công giảng dạy bất kỳ môn học nào.
SELECT MAGV, HOTEN FROM GIAOVIEN
EXCEPT
(SELECT GIAOVIEN.MAGV, HOTEN FROM GIAOVIEN, GIANGDAY
WHERE GIAOVIEN.MAGV = GIANGDAY.MAGV)

-- 14. Tìm giáo viên (mã giáo viên, họ tên) không được phân công giảng dạy bất kỳ môn học nào thuộc khoa giáo viên đó phụ trách.
SELECT MAGV, HOTEN
FROM GIAOVIEN 
WHERE  NOT EXISTS 
(
 SELECT MAGV
 FROM GIANGDAY,MONHOC  
 WHERE  GIAOVIEN.MAGV=GIANGDAY.MAGV AND GIANGDAY.MAMH=MONHOC.MAMH AND MONHOC.MAKHOA=GIAOVIEN.MAKHOA
)

-- 15. Tìm họ tên các học viên thuộc lớp “K11” thi một môn bất kỳ quá 3 lần vẫn “Khong dat” hoặc thi lần thứ 2 môn CTRR được 5 điểm.
SELECT HO + ' ' + TEN AS HOTEN FROM HOCVIEN
WHERE MAHV IN (
	SELECT MAHV FROM KETQUATHI A
	WHERE LEFT(MAHV, 3) = 'K11' AND ((
		NOT EXISTS (
			SELECT 1 FROM KETQUATHI B 
			WHERE A.MAHV = B.MAHV AND A.MAMH = B.MAMH AND A.LANTHI < B.LANTHI
		)  AND LANTHI = 3 AND KQUA = 'Khong Dat'
	) OR MAMH = 'CTRR' AND LANTHI = 2 AND DIEM = 5)
)

-- 16. Tìm họ tên giáo viên dạy môn CTRR cho ít nhất hai lớp trong cùng một học kỳ của một năm học.
SELECT HOTEN FROM GIAOVIEN 
WHERE MAGV IN (
	SELECT MAGV FROM GIANGDAY 
	WHERE MAMH = N'CTRR'
	GROUP BY MAGV, HOCKY, NAM 
	HAVING COUNT(MALOP) >= 2
)

-- 17. Danh sách học viên và điểm thi môn CSDL (chỉ lấy điểm của lần thi sau cùng).
SELECT HV.MAHV, HO + ' ' + TEN AS HOTEN, DIEM 
FROM HOCVIEN HV INNER JOIN (
	SELECT MAHV, DIEM 
	FROM KETQUATHI A
	WHERE NOT EXISTS (
		SELECT 1 
		FROM KETQUATHI B 
		WHERE A.MAHV = B.MAHV AND A.MAMH = B.MAMH AND A.LANTHI < B.LANTHI
	) AND MAMH = 'CSDL'
) DIEM_CSDL
ON HV.MAHV = DIEM_CSDL.MAHV

-- 18. Danh sách học viên và điểm thi môn “Co So Du Lieu” (chỉ lấy điểm cao nhất của các lần thi).
SELECT HV.MAHV, HO + ' ' + TEN AS HOTEN, DIEM 
FROM HOCVIEN HV INNER JOIN (
	SELECT MAHV, MAX(DIEM) AS DIEM FROM KETQUATHI 
	WHERE MAMH IN (
		SELECT MAMH FROM MONHOC 
		WHERE TENMH = 'Co So Du Lieu'
	) 
	GROUP BY MAHV, MAMH
) DIEM_CSDL_MAX
ON HV.MAHV = DIEM_CSDL_MAX.MAHV