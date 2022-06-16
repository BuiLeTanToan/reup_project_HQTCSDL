create or alter proc deleteDH (@requestMaDonHang int, @requestMaKH int)
as
BEGIN
begin tran
SET TRANSACTION ISOLATION
LEVEL READ COMMITTED
	if exists	(select *
				from DonDatHang as DDH
				where DDH.MaDonHang = @requestMaDonHang and DDH.MaKhachHang = @requestMaKH)
		begin
			Delete from ChiTietDonDatHang
			where MaDonHang = @requestMaDonHang

			Delete from DonDatHang
			where MaDonHang = @requestMaDonHang
			and MaKhachHang = @requestMaKH
			print('Huy don hang thanh cong')
		end
	else
		begin
			print('Ma don hang khong hop le')
		end 

commit tran
END



exec deleteDH '18', '1'
