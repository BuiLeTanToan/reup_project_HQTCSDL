go 
create proc sp_update_TGHieuLuc_HOPDONG_2
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

	
	update HOPDONG
	set TGHIEULUC = @NgayHieuLuc
	where MaHD = @MAHD

	print N'Hoàn tất giao tác';
commit tran
go


exec sp_update_TGHieuLuc_HOPDONG_2 0, '1900-12-13'
select * from HOPDONG