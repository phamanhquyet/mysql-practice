use qlsv;
-- add data to dmkhoa table
INSERT INTO dmkhoa (MaKhoa, TenKhoa) VALUES ('CNTT', 'Công nghệ thông tin');
INSERT INTO dmkhoa (MaKhoa, TenKhoa) VALUES ('KT', 'Kế toán');
INSERT INTO dmkhoa (MaKhoa, TenKhoa) VALUES ('SP', 'Sư phạm');

-- add data to dmhocphan table
INSERT INTO dmhocphan (MaHP, TenHP, Sodvht, MaNganh, HocKy) VALUES (1, 'Toán cao cấp A1', 4, '480202', 1);
INSERT INTO dmhocphan (MaHP, TenHP, Sodvht, MaNganh, HocKy) VALUES (2, 'Tiếng Anh 1', 3, '480202', 1);
INSERT INTO dmhocphan (MaHP, TenHP, Sodvht, MaNganh, HocKy) VALUES (3, 'Vật lý đại cương', 4, '480202', 1);
INSERT INTO dmhocphan (MaHP, TenHP, Sodvht, MaNganh, HocKy) VALUES (4, 'Tiếng anh 2', 7, '480202', 1);
INSERT INTO dmhocphan (MaHP, TenHP, Sodvht, MaNganh, HocKy) VALUES (5, 'Tiếng anh 1', 3, '140909', 2);
INSERT INTO dmhocphan (MaHP, TenHP, Sodvht, MaNganh, HocKy) VALUES (6, 'Xác suất thống kê', 3, '140902', 2);

-- add data to dmnganh table
INSERT INTO dmnganh (MaNganh, TenNganh, MaKhoa) VALUES ('140909', 'Sư phạm toán tin 1', 'SP');
INSERT INTO dmnganh (MaNganh, TenNganh, MaKhoa) VALUES ('480202', 'Tin học ứng dụng', 'CNTT');

-- add data to dmlop table
INSERT INTO dmlop (MaLop, TenLop, MaNganh, KhoaHoc, HeDT, NamNhapHoc) VALUES ('CT11', 'Cao đẳng tin học', '480202', 11, 'TC', 2013);
INSERT INTO dmlop (MaLop, TenLop, MaNganh, KhoaHoc, HeDT, NamNhapHoc) VALUES ('CT12', 'Cao đẳng tin học', '480202', 12, 'CD', 2013);
INSERT INTO dmlop (MaLop, TenLop, MaNganh, KhoaHoc, HeDT, NamNhapHoc) VALUES ('CT13', 'Cao đẳng tin học', '480202', 13, 'CD', 2014);

-- add data to sinhvien table
-- 0 is false, 1 is true
INSERT INTO sinhvien (MaSV, HoTen, MaLop, GioiTinh, NgaySinh, DiaChi) VALUES (1, 'Phan Thanh', 'CT12', 0, '1990-12-09', 'Tuy Phước');
INSERT INTO sinhvien (MaSV, HoTen, MaLop, GioiTinh, NgaySinh, DiaChi) VALUES (2, 'Nguyễn Thị Cẩm', 'CT12', 1, '1994-12-01', 'Quy Nhơn');
INSERT INTO sinhvien (MaSV, HoTen, MaLop, GioiTinh, NgaySinh, DiaChi) VALUES (3, 'Võ Thị Hà', 'CT12', 1, '1995-07-02', 'An Nhơn');
INSERT INTO sinhvien (MaSV, HoTen, MaLop, GioiTinh, NgaySinh, DiaChi) VALUES (4, 'Trần Hoài Nam', 'CT12', 0, '1994-05-04', 'Tây Sơn');
INSERT INTO sinhvien (MaSV, HoTen, MaLop, GioiTinh, NgaySinh, DiaChi) VALUES (5, 'Trần Văn Hoàng', 'CT13', 0, '1995-04-08', 'Vĩnh Thạnh');
INSERT INTO sinhvien (MaSV, HoTen, MaLop, GioiTinh, NgaySinh, DiaChi) VALUES (6, 'Đặng Thị Thảo', 'CT13', 1, '1995-12-06', 'Quy Nhơn');
INSERT INTO sinhvien (MaSV, HoTen, MaLop, GioiTinh, NgaySinh, DiaChi) VALUES (7, 'Lê Thị Sen', 'CT13', 1, '1994-12-08', 'Phù Cát');
INSERT INTO sinhvien (MaSV, HoTen, MaLop, GioiTinh, NgaySinh, DiaChi) VALUES (8, 'Nguyễn Văn Huy', 'CT11', 0, '1995-04-06', 'Phù Mỹ');
INSERT INTO sinhvien (MaSV, HoTen, MaLop, GioiTinh, NgaySinh, DiaChi) VALUES (9, 'Trần Thị Hoa', 'CT11', 1, '1994-09-08', 'Hoài Nhơn');

-- add data to diemhp table
INSERT INTO diemhp (MaSV, MaHP, DiemHP) VALUES (2, 2, 5.9);
INSERT INTO diemhp (MaSV, MaHP, DiemHP) VALUES (2, 3, 4.5);
INSERT INTO diemhp (MaSV, MaHP, DiemHP) VALUES (3, 1, 4.3);
INSERT INTO diemhp (MaSV, MaHP, DiemHP) VALUES (3, 2, 6.7);
INSERT INTO diemhp (MaSV, MaHP, DiemHP) VALUES (3, 3, 7.3);
INSERT INTO diemhp (MaSV, MaHP, DiemHP) VALUES (4, 1, 4.0);
INSERT INTO diemhp (MaSV, MaHP, DiemHP) VALUES (4, 2, 5.2);
INSERT INTO diemhp (MaSV, MaHP, DiemHP) VALUES (4, 3, 3.5);
INSERT INTO diemhp (MaSV, MaHP, DiemHP) VALUES (5, 1, 9.8);
INSERT INTO diemhp (MaSV, MaHP, DiemHP) VALUES (5, 2, 7.9);
INSERT INTO diemhp (MaSV, MaHP, DiemHP) VALUES (5, 3, 7.5);
INSERT INTO diemhp (MaSV, MaHP, DiemHP) VALUES (6, 1, 6.1);
INSERT INTO diemhp (MaSV, MaHP, DiemHP) VALUES (6, 2, 5.6);
INSERT INTO diemhp (MaSV, MaHP, DiemHP) VALUES (6, 3, 4.0);
INSERT INTO diemhp (MaSV, MaHP, DiemHP) VALUES (7, 1, 6.2);
