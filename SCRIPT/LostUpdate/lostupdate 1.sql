go
create  procedure sp_update_gia_Sp
		@MaSP int,
		@GiaBan float
as

begin tran
	---set tran isolation level Repeatable Read
	IF not exists (select * from sanpham where masanpham = @MaSp)
	begin
		Print @MaSP + N'Không tồn tại';
		rollback tran;
	end
	If @GiaBan <=0 or ISNUMERIC(@GiaBan) !=1
	begin
		Print N'Giá bán nhập vào không hợp lệ';
		rollback tran
	end

	waitfor delay '00:00:05';
	update SanPham
	set GiaBan = @GiaBan
	where MaSanPham = @MaSP

	
	
commit tran
go

select * from sanpham
exec sp_update_gia_Sp 0, 3800




go 
create proc sp_update_TGHieuLuc_HOPDONG
	@MaHD int,
	@NgayHieuLuc date
as 
begin tran
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	if not exists (select * from HOPDONG where MaHD =@MAHD)
	begin
		print N'Mã hợp đồng không tồn tại';
		rollback tran;
	end

	if ISDATE(cast(@NgayHieuLuc as nvarchar)) != 1
	begin
		print N'Ngày nhập vào không hợp lệ';
		rollback tran ;
	end
	
	declare @NgayHetHan date;
	select @NgayHetHan = TGHetHan from HOPDONG where @MAHD = MaHD
	if @NgayHieuLuc > @NgayHetHan
	begin
		print N'Ngày hiệu lực phải nhỏ hơn ngày hết hạn';
		rollback tran;
	end

	waitfor delay '00:00:06'
	update HOPDONG
	set TGHIEULUC = @NgayHieuLuc
	where MaHD = @MAHD

	print N'Hoàn tất giao tác';
commit tran
go

exec sp_update_TGHieuLuc_HOPDONG 0, '1900-12-12'
select * from HOPDONG

--/************************************/--


go
alter proc sp_update_TinhTrangDatHang
		@MaPG int,
		@TinhTrang nvarchar(20)
as
begin tran
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	if not exists(select * from PHIEUGIAOHANG where @MaPG = MaPhieuGiao)
	begin
		print N'Mã phiếu giao không hợp lệ';
		rollback tran;
	end
	if ISNUMERIC(@TinhTrang) = 1
	begin 
		print N'Tình trạng nhập không phải là chuỗi';
		rollback tran;
	end

	waitfor delay '00:00:08'
	update PHIEUGIAOHANG
	set TinhTrangGiaoHang= @TinhTrang
	where MaPhieuGiao = @MaPG

	print N'hoàn tất giao tác'

commit tran

select * from PHIEUGIAOHANG

exec sp_update_TinhTrangDatHang 1, N'đã giao'


/**********************/
go
create proc sp_update_NgayCC_CCSP
			@MaSP int,
			@MaCN int,
			@NgayCC date
as
begin tran
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	if not exists (select * from CUNGCAPSANPHAM where @MaSP = MaSanPham and @MACN = MaChiNhanh)
	begin
		print N'Không tồn tại mã sản phẩm'
		rollback tran
	end

	if ISNUMERIC(@MACN) !=1
	begin
		print N'Không đúng kiểu dữ liệu cho mã chi nhánh'
		rollback tran;
	end

	waitfor delay '00:00:08'
	update CUNGCAPSANPHAM
	set NgayCC = @NgayCC
	where MaSanPham = @MaSP and MaChiNhanh = @MaCN

	print N'hoàn tất giao tác'

commit tran

select* from CUNGCAPSANPHAM
exec sp_update_NgayCC_CCSP 0,0,'2021-12-25'






