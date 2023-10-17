# 2023-dn-phamanhquyet-sql-practice

## Description
This database enables efficient management of students, classes, majors, courses, and departments within a university, allowing for the tracking of student performance in various courses while maintaining relationships between these entities.

## Diagram
<img src = "https://f11-zpcloud.zdn.vn/6994477220157532059/d568b260ffd02b8e72c1.jpg" alt = "Database Diagram">

## Analyze the structure of the database.

### DMKHOA
- This table stores information about university departments.
= It includes columns for department code (MaKhoa) and department name (TenKhoa).
- The MaKhoa column is the primary key, ensuring the uniqueness of each department.

### DMHOCPHAN
- This table holds data about university courses or subjects.
- It includes columns for course code (MaHP), course name (TenHP), credit hours (Sodvht), department code (MaNganh), and semester (HocKy).
- The MaHP column serves as the primary key for identifying each course.

### DMNGANH
- This table contains information regarding academic majors or fields of study.
- It includes columns for major code (MaNganh), major name (TenNganh), and department code (MaKhoa) for the department to which the major belongs.
- MaNganh is the primary key, and MaKhoa is a foreign key linked to DMKHOA.

### DMLOP
- This table stores data on university classes or study groups.
- It includes columns for class code (MaLop), class name (TenLop), major code (MaNganh), academic year (KhoaHoc), education level (HeDT), and enrollment year (NamNhapHoc).
- MaLop is the primary key, and MaNganh is a foreign key linked to DMNGANH.

### SINHVIEN
- This table holds information about university students.
- It includes columns for student ID (MaSV), full name (HoTen), class code (MaLop), gender (GioiTinh), date of birth (NgaySinh), and address (DiaChi).
- MaSV is the primary key, and MaLop is a foreign key linked to DMLOP.

### DIEMHP
- This table is designed to record course grades for students.
- It includes columns for student ID (MaSV), course code (MaHP), and the course grade (DiemHP).
- The DiemHP column has a CHECK constraint to ensure that grades fall within the 0-10 range.
- MaSV is a foreign key linked to SINHVIEN, and MaHP is a foreign key linked to DMHOCPHAN.
