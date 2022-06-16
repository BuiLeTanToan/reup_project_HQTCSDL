drop proc Tao_TK_KH
create proc Tao_TK_KH @TenDN char(25) , @MK char(25), @TenKH nvarchar(30),@SDTKhachHang nvarchar(10)
	, @DiaChiKh nvarchar(150), @EmailKhachHang nvarchar(254)
as 
begin
	declare @STT int;
	declare @MaKH int;

	if exists (	Select * 
				from TaiKhoan_KH)
		begin
		select @STT = Max(ID) from TaiKhoan_KH;
	
		select @MaKH = Max(MaKhachHang) from KhachHang
		end
	else
		begin
		set @STT = 0;
		set @MaKH = 0;
		end
	set @STT = @STT +1;
	set @MaKH = @MaKH +1
	insert into KhachHang values(@MaKH,@TenKH,@SDTKhachHang,@DiaChiKH,@EmailKhachHang)
	insert into TaiKhoan_KH values(@STT,@TenDN, @MK,@MaKH)
end

exec Tao_TK_KH 'ABCDEF','A','THAI NE','123456789','BEN TRE','HOANGTHAI@GAML.COM'
