/**********************/
go
create proc sp_update_NgayCC_CCSP
			@MaSP int,
			@MaCN int,
			@NgayCC date
as
begin tran
	SET TRAN ISOLATION LEVEL read uncommitted
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