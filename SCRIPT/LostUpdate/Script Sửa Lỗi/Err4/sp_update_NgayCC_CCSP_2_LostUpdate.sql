go
create  proc sp_update_NgayCC_CCSP_2
			@MaSP int,
			@MaCN int,
			@NgayCC date
as
begin tran
	SET TRAN ISOLATION LEVEL repeatable read
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

	
	update CUNGCAPSANPHAM
	set NgayCC = @NgayCC
	where MaSanPham = @MaSP and MaChiNhanh = @MaCN

	print N'hoàn tất giao tác'

commit tran

select* from CUNGCAPSANPHAM
exec sp_update_NgayCC_CCSP_2 0,0,'2021-12-24'