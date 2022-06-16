go
alter  procedure sp_update_gia_Sp_2
		@MaSP int,
		@GiaBan float
as

begin tran
	set tran isolation level Repeatable Read
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
	
	
	--declare @GiaBan float;
	--select @GiaBan = GiaBan from SanPham where MaSanPham = @MaSP
	waitfor delay '00:00:01';

	update SanPham
	set GiaBan = @GiaBan
	where MaSanPham = @MaSP

	
	
commit tran
go

select * from sanpham
exec sp_update_gia_Sp_2 0, 3500