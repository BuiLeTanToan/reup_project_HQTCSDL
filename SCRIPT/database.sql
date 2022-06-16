--Create database BanHangOnline
--drop database BanHangOnline
USE BanHangOnline

create table DoiTac
(
	MaDoiTac int,
	TenDoiTac nvarchar(50),
	NguoiDaiDien nvarchar(50),
	SoChiNhanh int,
	SoDHMoiNgay int,
	Quan nvarchar(30),
	ThanhPho nVarchar(30),
	SDTDoiTac nvarchar(10),
	EmailDoiTac nvarchar(254),

	CONSTRAINT PK_DT PRIMARY KEY (MADOITAC)
)

create table HopDong
(
	MaHD int,
	MaSoThue nvarchar(20),
	MaDoiTac int,
	SoChiNhanh int,
	PhiKichHoat float default 1000000,
	TGHieuLuc date,
	TGHetHan date,
	GiaHan bit,

	CONSTRAINT PK_HD PRIMARY KEY (MAHD)

)


create table ChiNhanh(
	MaChiNhanh int,
	TenChiNhanh nvarchar(50),
	MaDoiTac int,
	DiaChiChiNhanh nvarchar(100),

	CONSTRAINT PK_CN PRIMARY KEY (MACHINHANH)

)

create table HoaHong(
	MaHD int,
	Thang date,
	DoanhSo float,
	PhiHoaHong float,
	MaDoiTac int,

	CONSTRAINT PK_HH PRIMARY KEY (MAHD,THANG)
)

create table GiaHanHopDong(
	MAHD int,
	MaNVQuanLi int, 
	ThoiGianGiaHan date,
	TinhTrangGiaHan nvarchar(15) default 'pending',

	CONSTRAINT PK_GHHD PRIMARY KEY (MAHD,MANVQUANLI)

)

create table SanPham(
	MaSanPham int,
	TenSanPham nvarchar(40),
	GiaBan float,
	PhanLoaiHang nvarchar(10),
	MaDoiTac int,

	CONSTRAINT PK_SP PRIMARY KEY (MASANPHAM)

)

create table CungCapSanPham(
	MaSanPham int,
	MaChiNhanh int,
	GhiChu nvarchar(30),
	NgayCC date,

	Constraint PK_CCSP PRIMARY KEY(MASANPHAM,MACHINHANH,NgayCC)
)

create table DonDatHang(
	MaDonHang int,
	MaKhachHang int,
	NgayThanhToan date,
	PhiVanChuyen float,
	TongTien float,
	HinhThucThanhToan nvarchar(20),
	TinhTrangDonHang nvarchar(15),
	PhiSanPham float,
	DiaChiGiaoHang nvarchar(150),

	CONSTRAINT PK_DDH PRIMARY KEY (MADONHANG)
)



create table PhieuGiaoHang (
	MaPhieuGiao int,
	MaTaiXe int,
	MaDonHang int,
	MaKH int,
	NgayGiao date,
	TinhTrangGiaoHang nvarchar(20),
	DiaChiGiaoHangTrenPhieu nvarchar(150),

	CONSTRAINT PK_PGH PRIMARY KEY (MaPhieuGiao)
)




create table ChiTietDonDatHang(
	MaDonHang int,
	MaSanPham int,
	Soluong int,
	DonGia float,
	ThanhTien float,

	CONSTRAINT PK_CTTDDH PRIMARY KEY (MaDonHang,MaSanPham)
)

create table KhachHang(
	MaKhachHang int,
	HoTenKhachHang nvarchar(30),
	SDTKhachHang nvarchar(10),
	DiaChiKhachHang nvarchar(150),
	EmailKhachHang nvarchar(254),


	CONSTRAINT PK_KH PRIMARY KEY (MaKhachHang)
)

create table TaiKhoan_KH
(
	ID int,
	TenDangNhap char(25) not null unique,
	MatKhau char(25),
	MaKH int,

	constraint FK_TKKH
	primary key (ID)

)


create table TaiXe(
	MaTaiXe int,
	TenTaiXe nvarchar(40),
	CMNDTaiXe nvarchar(9),
	SDTTaiXe nvarchar(10),
	DiaChiTaiXe nvarchar(150),
	SoXe nvarchar(15),
	EmailTaiXe nvarchar(254),
	ThuNhap float,
	PhiTheChan float,
	KhuVucHoatDong nvarchar(20),

	CONSTRAINT PK_TX PRIMARY KEY (MaTaiXe)
)

create table NganHang(
	MaNganHang int,
	STK nvarchar(15),
	TenNH nvarchar(20),
	MaTaiXe int,

	CONSTRAINT PK_NganHang PRIMARY KEY (MaNganHang)
)



create table NhanVien(
	MaNhanVien int,
	TenNhanVien nvarchar(30),
	SDTNhanVien nvarchar(10),

	CONSTRAINT PK_NV PRIMARY KEY (MaNHANVIEN)
)

create table TaiKhoan_NhanVien
(
	ID int,
	TenDangNhapNV char(25) not null unique,
	MatKhauNV char(25),
	MaNV int,

	constraint FK_TKNV
	primary key (ID)

)

create table TaiKhoan_TaiXe
(
	ID int,
	TenDangNhapNV char(25) not null unique,
	MatKhauNV char(25),
	MaTX int,

	constraint FK_TKTX
	primary key (ID)

)

create table TaiKhoan_DoiTac
(
	ID int,
	TenDangNhapNV char(25) not null unique,
	MatKhauNV char(25),
	MaDoiTac int,

	constraint FK_TKDT
	primary key (ID)

)

alter table TaiKhoan_DoiTac
add
constraint FK_TKDT_DT
foreign key(MaDoiTac)
references DoiTac

alter table TaiKhoan_TaiXe
add
constraint FK_TKTX_TX
foreign key(MaTX)
references TaiXe

alter table TaiKhoan_NhanVien
add
constraint FK_TKNV_NV
foreign key(MaNV)
references NhanVien


alter table SanPham
add
constraint FK_SP_DT
foreign key (MaDoiTac)
references DoiTac


alter table NganHang
add
constraint FK_NganHang_TaiXe
foreign key(MaTaiXe)
references TaiXe

ALTER TABLE HOPDONG
ADD CONSTRAINT FK_DT_HD
FOREIGN KEY (MADOITAC)
REFERENCES DOITAC(MADOITAC);

ALTER TABLE CHINHANH
ADD CONSTRAINT FK_CN_DT
FOREIGN KEY (MADOITAC)
REFERENCES DOITAC(MADOITAC);

ALTER TABLE HOAHONG
ADD CONSTRAINT FK_HH_HD
FOREIGN KEY (MAHD)
REFERENCES HOPDONG(MAHD);


ALTER TABLE GIAHANHOPDONG
ADD CONSTRAINT FK_GHHD_HD_MAHD
FOREIGN KEY (MAHD)
REFERENCES HOPDONG(MAHD);

ALTER TABLE GIAHANHOPDONG
ADD CONSTRAINT FK_GHHD_HD_NVQUANLI
FOREIGN KEY (MANVQUANLI)
REFERENCES NHANVIEN(MANHANVIEN);

ALTER TABLE CUNGCAPSANPHAM
ADD CONSTRAINT FK_CCSP_SP
FOREIGN KEY (MASANPHAM)
REFERENCES SANPHAM;

ALTER TABLE CUNGCAPSANPHAM
ADD CONSTRAINT FK_CCSP_CN
FOREIGN KEY (MACHINHANH)
REFERENCES CHINHANH;

ALTER TABLE DONDATHANG
ADD CONSTRAINT FK_DDH_KH
FOREIGN KEY (MAKHACHHANG)
REFERENCES KHACHHANG;

ALTER TABLE PHIEUGIAOHANG
ADD CONSTRAINT FK_PGH_TX
FOREIGN KEY (MATAIXE)
REFERENCES TAIXE;

ALTER TABLE PHIEUGIAOHANG
ADD CONSTRAINT FK_PGH_DDH
FOREIGN KEY (MaDonHang)
REFERENCES DonDatHang(MaDonHang);

ALTER TABLE PHIEUGIAOHANG
ADD CONSTRAINT FK_PGH_KH
FOREIGN KEY (MaKH)
REFERENCES KhachHang(MaKhachHang);

ALTER TABLE ChiTietDonDatHang
ADD CONSTRAINT FK_CTDDH_SP
FOREIGN KEY (MASANPHAM)
REFERENCES SANPHAM(MASANPHAM);


ALTER TABLE ChiTietDonDatHang
ADD CONSTRAINT FK_CTDDH_DDH_MADH
FOREIGN KEY (MADONHANG)
REFERENCES DONDATHANG(MADONHANG);

alter table TaiKhoan_KH
add
constraint FK_TKKH_KH
foreign key(MaKH)
references KhachHang


alter table HoaHong
add
constraint FK_HH_DT
foreign key(MaDoiTac)
references DoiTac