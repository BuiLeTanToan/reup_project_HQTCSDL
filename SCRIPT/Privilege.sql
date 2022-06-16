CREATE ROLE DoiTac
CREATE ROLE NhanVien
CREATE ROLE TaiXe
CREATE ROLE KhachHang

--cap quyen role Doi Tac
GRANT select ON DonDatHang TO DoiTac
GRANT update ON DonDatHang(TinhTrangDonHang) TO DoiTac
GRANT select ON ChiTietDonDatHang TO DoiTac  
GRANT select ON ChiNhanh TO DoiTac 
GRANT select ON HopDong TO DoiTac 
GRANT select ON DoiTac TO DoiTac 
GRANT select ON GiaHanHopDong TO DoiTac 
GRANT select ON HoaHong TO DoiTac 
GRANT select ON PhieuGiaoHang TO DoiTac 
GRANT select, insert, update, Delete ON SanPham TO DoiTac
GRANT select, insert, update, Delete ON CungCapSanPham TO DoiTac 
GRANT update ON ChiNhanh(DiaChiChiNhanh) TO DoiTac
GRANT select, update ON GiaHanHopDong(TinhTrangGiaHan) TO DoiTac

--Cap quyen role khach hang
GRANT select ON KhachHang TO KhachHang
GRANT select, insert ON DonDatHang TO KhachHang
GRANT select ON ChiTietDonDatHang TO KhachHang
GRANT update ON DonDatHang(DiaChiGiaoHang) TO KhachHang

--Cap quyen role Tai xe 

GRANT select ON TaiXe TO TaiXe
GRANT select ON DonDatHang TO TaiXe
GRANT select ON ChiTietDonDatHang TO TaiXe
GRANT select ON PhieuGiaoHang TO TaiXe
GRANT select ON CungCapSanPham TO TaiXe
GRANT update ON PhieuGiaoHang(TinhTrangGiaoHang, MaTaiXe) TO TaiXe

--Cap quyen Role NhanVien 
GRANT select ON NhanVien TO NhanVien
GRANT select ON HopDong TO NhanVien
GRANT select ON DoiTac TO NhanVien
GRANT select,update ON GiaHanHopDong TO NhanVien
GRANT update ON HopDong(TGHetHan, GiaHan) TO NhanVien

--Them cac user mau vao role
--them user NhanVien 1 vào login moi NhanVien1
CREATE LOGIN NhanVien1
WITH PASSWORD = '12345';

Create user NhanVien1 for login NhanVien1
exec Sp_addRoleMember 'NhanVien', 'NhanVien1'

--them user TaiXe 1 vào login moi TaiXe1
CREATE LOGIN TaiXe1
WITH PASSWORD = '12345';

Create user TaiXe1 for login TaiXe1
exec Sp_addRoleMember 'TaiXe', 'TaiXe1'

--them user DoiTac1 vào login moi Doitac1
CREATE LOGIN DoiTac1
WITH PASSWORD = '12345';

Create user DoiTac1 for login DoiTac1
exec Sp_addRoleMember 'DoiTac', 'DoiTac1'

--them user KhachHang1 vào login moi KhachHang1
CREATE LOGIN KhachHang1
WITH PASSWORD = '12345';

Create user KhachHang1 for login KhachHang1
exec Sp_addRoleMember 'KhachHang', 'KhachHang1'

--them user DoiTac2 vào login moi Doitac2
create login DoiTac2
WITH PASSWORD = '12345'
Create user DoiTac2 for login DoiTac2
exec Sp_addRoleMember 'DoiTac', 'DoiTac2'

	          
go
create proc Tao_TK_KH @TenDN char(25) , @MK char(25), @TenKH nvarchar(30),@SDTKhachHang nvarchar(10)
	, @DiaChiKh nvarchar(150), @EmailKhachHang nvarchar(254)
as 
begin
	declare @STT int;
	select @STT = Max(ID) from TaiKhoan_KH;
	declare @MaKH int;
	select @MaKH = Max(MaKhachHang) from KhachHang

	set @STT = @STT +1;
	set @MaKH = @MaKH +1
	insert into KhachHang values(@MaKH,@TenKH,@SDTKhachHang,@DiaChiKH,@EmailKhachHang)
	insert into TaiKhoan_KH values(@STT,@TenDN, @MK,@MaKH)
end
