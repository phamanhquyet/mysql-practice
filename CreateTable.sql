USE qlsv;
CREATE TABLE DMKHOA (
    MaKhoa NVARCHAR(10),
    TenKhoa NVARCHAR(50),
    PRIMARY KEY (MaKhoa)
);

CREATE TABLE DMHOCPHAN (
    MaHP INT,
    TenHP NVARCHAR(100),
    Sodvht INT(1),
    MaNganh VARCHAR(10),
    HocKy INT(1),
    PRIMARY KEY (MaHP)
);

CREATE TABLE DMNGANH (
    MaNganh NVARCHAR(10),
    TenNganh NVARCHAR(100),
    MaKhoa NVARCHAR(10),
    PRIMARY KEY (MaNganh),
    CONSTRAINT FK_MaKhoa FOREIGN KEY(MaKhoa) REFERENCES DMKHOA(MaKhoa)
);

CREATE TABLE DMLOP (
    MaLop NVARCHAR(10),
    TenLop NVARCHAR(100),
    MaNganh NVARCHAR(10),
    KhoaHoc INT,
    HeDT VARCHAR(5),
    NamNhapHoc INT,
    PRIMARY KEY (MaLop),
    CONSTRAINT FK_MaNganh FOREIGN KEY(MaNganh) REFERENCES DMNGANH(MaNganh)
);

CREATE TABLE SINHVIEN (
    MaSV INT,
    HoTen NVARCHAR(75),
    MaLop NVARCHAR(10),
    GioiTinh BOOLEAN,
    NgaySinh DATETIME,
    DiaChi NVARCHAR(255),
    PRIMARY KEY (MaSV),
    CONSTRAINT FK_MaLop FOREIGN KEY(MaLop) REFERENCES DMLOP(MaLop)
);

CREATE TABLE DIEMHP (
    MaSV INT,
    MaHP INT,
    DiemHP DECIMAL(4,2),
    CONSTRAINT CheckDiem CHECK (DiemHP >= 0 AND DiemHP <= 10),
    CONSTRAINT FK_MaSV FOREIGN KEY(MaSV) REFERENCES SINHVIEN(MaSV),
    CONSTRAINT FK_MaHP FOREIGN KEY(MaHP) REFERENCES DMHOCPHAN(MaHP)
);