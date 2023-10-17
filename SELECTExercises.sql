use qlsv;

-- 1. Hiển thị danh sách gồm: MaSV, HoTen, MaLop, NgaySinh (dd/mm/yyyy),  GioiTinh (Nam, Nữ) , Namsinh của những sinh viên nam học lớp CT11.
SELECT 
    MaSV,
    HoTen,
    MaLop,
    DATE_FORMAT(NgaySinh, '%d/%m/%Y') AS Ngay_Sinh,
    CASE
        WHEN GioiTinh = FALSE THEN 'nam'
        WHEN GioiTinh = TRUE THEN 'nữ'
    END AS Gioi_tinh
FROM
    sinhvien
WHERE
    MaLop = 'CT11';

-- 2. Hiển thị danh sách gồm: MaSV, HoTen, MaLop, NgaySinh (dd/mm/yyyy), GioiTinh (Nam, Nữ) của những sinh viên học lớp CT11,CT12,CT13.
SELECT 
    MaSV,
    HoTen,
    MaLop,
    DATE_FORMAT(NgaySinh, '%d/%m/%Y') AS Ngay_Sinh,
    CASE
        WHEN GioiTinh = FALSE THEN 'nam'
        WHEN GioiTinh = TRUE THEN 'nữ'
    END AS Gioi_tinh
FROM
    sinhvien
WHERE
    MaLop = 'CT11' OR MaLop = 'CT12'
        OR MaLop = 'CT13';

-- 3. Hiển thị danh sách gồm: MaSV, HoTen, MaLop, NgaySinh (dd/mm/yyyy), GioiTinh (Nam, Nữ), Tuổi của những sinh viên có tuổi từ 19-21.
-- Note: Do đây là database cũ nên tôi sẽ lấy cột mốc 2014-04-05
SELECT 
    MaSV,
    HoTen,
    MaLop,
    DATE_FORMAT(NgaySinh, '%d/%m/%Y') AS Ngay_Sinh,
    CASE
        WHEN GioiTinh = FALSE THEN 'nam'
        WHEN GioiTinh = TRUE THEN 'nữ'
    END AS Gioi_tinh,
    FLOOR(DATEDIFF('2014-04-05', NgaySinh) / 365) AS Tuoi
FROM
    sinhvien
WHERE
    FLOOR(DATEDIFF('2014-04-05', NgaySinh) / 365) BETWEEN 19 AND 21;

-- 4. Hiển thị danh sách gồm: MaSV, HoTen, MaLop, NgaySinh (dd/mm/yyyy), GioiTinh (Nam, Nữ) , Namsinh của những sinh viên có họ không bắt đầu bằng chữ N,L,T.
SELECT 
    MaSV,
    HoTen,
    DATE_FORMAT(NgaySinh, '%d/%m/%Y') AS Ngay_Sinh,
    CASE
        WHEN GioiTinh = FALSE THEN 'nam'
        WHEN GioiTinh = TRUE THEN 'nữ'
    END AS Gioi_tinh,
    DATE_FORMAT(NgaySinh, '%Y') AS Namsinh
FROM
    sinhvien
WHERE
    HoTen NOT LIKE 'N%'
        AND HoTen NOT LIKE 'L%'
        AND HoTen NOT LIKE 'T%';

-- 5. Hiển thị danh sách gồm MaSV, HoTên, MaLop, DiemHP, MaHP của những sinh viên có điểm HP >= 5.
select sv.MaSV, sv.HoTen, sv.MaLop, dhp.DiemHP, dhp.MaHP 
from sinhvien sv
inner join diemhp dhp on sv.MaSV = dhp.MaSV
where dhp.DiemHP >= 5;

-- 6. Hiển thị danh sách MaSV, HoTen , MaLop, MaHP, DiemHP được sắp xếp theo ưu tiên Mã lớp, Họ tên tăng dần. 3. Hiển thị danh sách gồm MaSV, HoTen, MaLop, DiemHP, MaHP của những sinh viên có điểm HP từ 5 đến 7 ở học kỳ I.
select sv.MaSV, sv.HoTen, sv.MaLop, dhp.MaHP, dhp.DiemHP
from sinhvien sv
inner join diemhp dhp on sv.MaSV = dhp.MaSV
inner join dmhocphan dmhp on dhp.MaHP = dmhp.MaHP
where dhp.DiemHP between 5 and 7 and dmhp.HocKy = 1
order by sv.MaLop, sv.HoTen ASC;

-- 7. Hiển thị danh sách sinh viên gồm MaSV, HoTen, MaLop, TenLop, MaKhoa của Khoa có mã CNTT
select sv.MaSV, sv.HoTen, sv.MaLop, dl.TenLop, dn.MaKhoa
from sinhvien sv
inner join dmlop dl on sv.MaLop = dl.MaLop
inner join dmnganh dn on dl.MaNganh = dn.MaNganh
where dn.MaKhoa = 'CNTT';

-- 8. Cho biết MaLop, TenLop, tổng số sinh viên của mỗi lớp.
select sv.MaLop, dl.TenLop, count(sv.MaSV)
from sinhvien sv
inner join dmlop dl on sv.MaLop = dl.MaLop
group by sv.MaLop;

-- 9. Cho biết điểm trung bình chung của mỗi sinh viên, xuất ra bảng mới có tên DIEMTBC, biết rằng công thức tính DiemTBC như sau: 
-- DiemTBC = ∑(DiemHP * SoDvht) / ∑(SoDvht)
create table if not exists DIEMTBC as 
select sv.MaSV, sv.HoTen, sum(dhp.DiemHP * dmhp.Sodvht) / sum(dmhp.Sodvht) as diemtbc
from sinhvien sv
inner join diemhp dhp on sv.MaSV = dhp.MaSV
inner join dmhocphan dmhp on dhp.MaHP = dmhp.MaHP
group by sv.MaSV, sv.HoTen;

-- 10. Cho biết điểm trung bình chung của mỗi sinh viên ở mỗi học kỳ.
select sv.MaSV, sv.HoTen, sum(dhp.DiemHP * dmhp.Sodvht) / sum(dmhp.Sodvht) as diemtbc, dmhp.HocKy
from sinhvien sv
inner join diemhp dhp on sv.MaSV = dhp.MaSV
inner join dmhocphan dmhp on dhp.MaHP = dmhp.MaHP
group by sv.MaSV, sv.HoTen, dmhp.HocKy
order by sv.MaSV, dmhp.HocKy;

-- 11. Cho biết MaLop, TenLop, số lượng nam nữ theo từng lớp.
select 
	dl.MaLop,
    dl.TenLop,
    sum(case when sv.GioiTinh = 0 then 1 else 0 end) as so_luong_nam,
    sum(case when sv.GioiTinh = 1 then 1 else 0 end) as so_luong_nu
from dmlop dl
left join sinhvien sv on dl.MaLop = sv.MaLop -- sử dụng left join để bao gồm tất cả các lớp từ bảng DMLOP, bất kể có sinh viên nào thuộc lớp đó hay không.
-- Sử dụng LEFT JOIN sẽ giúp bảo đảm rằng tất cả các lớp từ bảng DMLOP sẽ xuất hiện trong kết quả, ngay cả khi không có sinh viên trong lớp đó. 
group by dl.MaLop, dl.TenLop;

-- 12. Cho biết điểm trung bình chung của mỗi sinh viên ở học kỳ 1.
-- DiemTBC = ∑(DiemHP * SoDvht) / ∑(SoDvht)
select sv.MaSV, sv.HoTen, sum(dhp.DiemHP * dmhp.Sodvht) / sum(dmhp.Sodvht) as diemtbc, dmhp.HocKy
from sinhvien sv
inner join diemhp dhp on sv.MaSV = dhp.MaSV
inner join dmhocphan dmhp on dhp.MaHP = dmhp.MaHP
where dmhp.HocKy = 1
group by sv.MaSV, sv.HoTen, dmhp.HocKy
order by sv.MaSV;

-- 13. Cho biết MaSV, HoTen, Số các học phần thiếu điểm (DiemHP<5) của mỗi sinh viên.
select sv.MaSV, sv.HoTen, sum(case when dhp.DiemHP < 5 then 1 else 0 end) as SoHocPhanThieuDiem
from sinhvien sv
inner join diemhp dhp on sv.MaSV = dhp.MaSV
group by dhp.MaSV;

-- 14. Đếm số sinh viên có điểm HP <5 của mỗi học phần. 
select 
	dhp.MaHP,
	sum(case when dhp.DiemHP < 5 then 1 else 0 end) as SoSinhvienThieuDiem
from diemhp dhp
group by dhp.MaHP;
-- 14.1. Tính tổng số đơn vị học trình có điểm HP <5 của mỗi sinh viên
select 
	sv.MaSV,
    sv.Hoten,
	sum(case when dhp.DiemHP < 5 then dmhp.Sodvht else 0 end) as TongDvhtDiemThap
from sinhvien sv
left join diemhp dhp on sv.MaSV = dhp.MaSV
left join dmhocphan dmhp on dhp.MaHP = dmhp.MaHP
group by sv.MaSV, sv.HoTen;

-- 15. Cho biết MaLop, TenLop có tổng số sinh viên > 10.
select dl.MaLop, dl.TenLop
from dmlop dl
inner join sinhvien sv on dl.MaLop = sv.MaLop
group by dl.MaLop, dl.TenLop 
having count(sv.MaSV)>10;

-- 16. Cho biết HoTen sinh viên có điểm Trung bình chung các học phần <3. 
select Hoten from diemtbc where diemtbc < 3;

-- 17. Cho biết HoTen sinh viên có ít nhất 2 học phần có điểm <5.
select sv.HoTen
from sinhvien sv
inner join diemhp dh on sv.MaSV = dh.MaSV
where dh.DiemHP < 5
group by sv.MaSV, sv.HoTen
having count(distinct dh.MaHP) >= 2;

-- 18. Cho biết HoTen sinh viên học TẤT CẢ các học phần ở ngành 140902. 
select sv.HoTen
from sinhvien sv
inner join dmlop dl on sv.Malop = dl.MaLop
inner join dmnganh dn on dl.MaNganh = dn.MaNganh
left join dmhocphan dmh on dn.MaNganh = dmh.MaNganh
group by sv.MaSV, sv.HoTen
having count(distinct dmh.MaHP) = (select count(distinct MaHP) from dmhocphan where MaNganh = '140902');

-- 19. Cho biết HoTen sinh viên học ít nhất 3 học phần mã ‘1’, ‘2’, ‘3’
select sv.HoTen
from sinhvien sv
inner join diemhp dh on sv.MaSV = dh.MaSV
where dh.MaHP in ('1','2','3')
group by sv.MaSV, sv.HoTen
having count(distinct dh.MaHP) >= 3;

-- 20. Cho biết MaSV, HoTen sinh viên có điểm TBC cao nhất ở học kỳ 1.
select sv.MaSV, sv.HoTen, sum(dhp.DiemHP * dmhp.Sodvht) / sum(dmhp.Sodvht) as diemtbc, dmhp.HocKy 
from sinhvien sv 
inner join diemhp dhp on sv.MaSV = dhp.MaSV
inner join dmhocphan dmhp on dhp.MaHP = dmhp.MaHP
where dmhp.HocKy = 1
group by sv.MaSV, sv.HoTen, dmhp.HocKy
order by diemtbc desc
limit 1;

-- 21. Cho biết MaSV, HoTen sinh viên có số học phần điểm HP <5 nhiều nhất
select sv.MaSV, sv.HoTen, count(distinct dh.MaHP) as sohp
from sinhvien sv
inner join diemhp dh on sv.MaSV = dh.MaSV
where dh.DiemHP < 5
group by sv.MaSV, sv.HoTen
order by count(distinct dh.MaHP) desc
limit 1;

-- 22. Cho biết MaHP, TenHP có số sinh viên điểm HP <5 nhiều nhất.
select dhp.MaHP, dmhp.TenHP, count(dhp.MaSV) as SoSinhVienDiemThap
from diemhp dhp
inner join dmhocphan dmhp on dhp.MaHP = dmhp.MaHP
where dhp.DiemHP < 5
group by dmhp.MaHP, dmhp.TenHP
having count(dhp.MaSV) = (SELECT MAX(CountSinhVienDiemThap) FROM (SELECT COUNT(MaSV) AS CountSinhVienDiemThap FROM diemhp WHERE DiemHP < 5 GROUP BY MaHP) AS TempTable)
ORDER BY SoSinhVienDiemThap DESC
limit 1;

-- 23. Cho biết Tên lớp có sinh viên tên Hoa.
select DISTINCT dl.TenLop
from dmlop dl
inner join sinhvien sv on dl.MaLop = sv.MaLop
where sv.HoTen like '% Hoa';

-- 24. Cho biết HoTen sinh viên có điểm học phần ‘001’là < 5.
select sv.Hoten 
from sinhvien sv
inner join diemhp dhp on sv.MaSV = dhp.MaSV
where dhp.MaHP = 1 and dhp.DiemHP < 5;

-- 25. Cho biết danh sách các học phần có số đơn vị học trình lớn hơn hoặc bằng số đơn vị học trình của học phần mã 1.
select MaHP, TenHP, Sodvht
from dmhocphan
where Sodvht >= (select Sodvht from dmhocphan where MaHP = 1) and MaHP <> 1;

-- 26. Cho biết HoTen sinh viên có DiemHP cao nhất. 
select sv.HoTen
from sinhvien sv
inner join diemhp dhp on sv.MaSV = dhp.MaSV
where dhp.diemHP = (select max(DiemHP) from diemhp) 
order by dhp.DiemHP;

-- 27. Cho biết HoTen sinh viên có tuổi cao nhất. 
SELECT 
    HoTen
FROM
    sinhvien
WHERE
    FLOOR(DATEDIFF(CURDATE(), NgaySinh) / 365) = (SELECT 
            MAX(FLOOR(DATEDIFF(CURDATE(), NgaySinh) / 365))
        FROM
            sinhvien)
ORDER BY FLOOR(DATEDIFF(CURDATE(), NgaySinh) / 365);

-- 28. Cho biết MaSV, HoTen sinh viên có điểm học phần mã ‘1’ cao nhất.
select sv.MaSV, sv.Hoten
from sinhvien sv
inner join diemhp dhp on sv.MaSV = dhp.MaSV
where dhp.diemHP = (select max(DiemHP) from diemhp where MaHP = 1);

-- 29. Cho biết MaSV, MaHP có điểm HP lớn hơn bất kỳ các điểm HP của sinh viên mã ‘1’.
select MaSV, MaHP
from diemhp
where DiemHP > (select max(DiemHP) from diemhp where MaSV = 1);

-- 30. Cho biết sinh viên có điểm học phần nào đó lớn hơn gấp rưỡi điểm trung bình chung của sinh viên đó.
select sv.MaSV, sv.HoTen, dhp.MaHP, dhp.DiemHP
from sinhvien sv
inner join diemhp dhp on sv.MaSV = sv.MaSV
where dhp.DiemHP > (2 * (select avg(DiemHP) from diemhp where MaSV = sv.MaSV));