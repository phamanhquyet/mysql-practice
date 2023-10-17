use qlsv;

-- 36. Bổ sung một dòng dữ liệu cho bảng DMKHOA bộ giá trị sau: (‘KT’, ‘Kế toán’).
INSERT INTO dmkhoa (MaKhoa, TenKhoa) VALUES ('KT', 'Kế toán');

-- 37. Bổ sung một sinh viên cho bảng SINHVIEN (dữ liệu nào bất kỳ). và Bổ sung điểm học phần cho bảng DIEMHP (dữ liệu bất kỳ).
INSERT INTO sinhvien (MaSV, HoTen, MaLop, GioiTinh, NgaySinh, DiaChi) VALUES (10, 'Phạm Anh Quyết', 'CT11', 1, '1994-12-12', 'Liên Chiểu');
INSERT INTO diemhp (MaSV, MaHP, DiemHP) VALUES (10, 1, 9.9);

-- 38. Xóa những sinh viên có DTBC < 3 (sinh viên buộc thôi học).
DELETE FROM sinhvien
WHERE (SELECT AVG(DiemHP) FROM diemhp WHERE MaSV = sinhvien.MaSV) < 3;

-- 39. Xóa những sinh viên không học học phần nào.
DELETE FROM sinhvien
WHERE MaSV NOT IN (SELECT DISTINCT MaSV FROM diemhp);

-- 40. Xóa khỏi bảng dmlop những lớp không có sinh viên nào
delete from dmlop
where MaLop not in (select DISTINCT MaLop from sinhvien);

-- 41. Thêm cột XepLoai, Cập nhật dữ liệu cột XepLoai theo yêu cầu sau:
-- + Nếu DiemTBC >=8 thì xếp loại Giỏi, ngược lại 
-- + Nếu DiemTBC >=7 thì xếp loại Khá, ngược lại
-- + Nếu DiemTBC >=5 thì xếp loại Trung bình, Ngược lại là yếu

alter table sinhvien
add XepLoai NVARCHAR(10);
WITH DiemTBCTemp AS (
    SELECT MaSV, AVG(DiemHP) AS DiemTBC
    FROM diemhp
    GROUP BY MaSV
)
UPDATE sinhvien AS sv
JOIN DiemTBCTemp AS dt ON sv.MaSV = dt.MaSV
SET sv.XepLoai = CASE
    WHEN dt.DiemTBC >= 8 THEN 'Giỏi'
    WHEN dt.DiemTBC >= 7 THEN 'Khá'
    WHEN dt.DiemTBC >= 5 THEN 'Trung bình'
    ELSE 'Yếu'
END;

-- 42. Thêm cột XetLenLop, Cập nhập dữ liệu cho cột với yêu cầu sau: 
-- + Nếu DiemTBC >=5 thì được lên lớp, ngược lại 
-- + Nếu DiemTBC>=3 thì tạm ngừng tiến độ học tập 
-- + Ngược lại Buộc thôi học.
alter table sinhvien
add XetLenLop nvarchar(30);
WITH DiemTBCTemp AS (
    SELECT MaSV, AVG(DiemHP) AS DiemTBC
    FROM diemhp
    GROUP BY MaSV
)
update sinhvien as sv
LEFT join DiemTBCTemp AS dt ON sv.MaSV = dt.MaSV
set sv.XetLenLop = case
	when dt.DiemTBC >= 5 then 'Lên lớp'
    when dt.DiemTBC >= 3 then "Tạm ngưng tiến độ học tập"
    else 'Buộc thôi học'
end;


