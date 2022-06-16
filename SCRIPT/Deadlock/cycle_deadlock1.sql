create proc NV_CapNhatTTDonHang (@reqMaDonHang int, @status nvarchar(50))
as
BEGIN tran
	if exists (select *
				from DonDatHang as DDH
				where DDH.MaDonHang = @reqMaDonHang)
		begin
		Update DonDatHang
		set TinhTrangDonHang = @status
		where MaDonHang = @reqMaDonHang
		waitfor delay '00:00:07'
		Update PhieuGiaoHang
		set TinhTrangGiaoHang = @status
		where MaDonHang = @reqMaDonHang
		end
	else
		begin
		print('Don hang khong ton tai')
		end

commit tran

exec NV_CapNhatTTDonHang 13, N'đã giao'
select * from dondathang
select * from phieugiaohang