go
create proc sp_update_TinhTrangDatHang
		@MaPG int,
		@TinhTrang nvarchar(20)
as
begin tran
	SET TRAN ISOLATION LEVEL repeatable read
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
