create proc TX_CapNhatTinhTrangGiaoHang (@reqMaPhieuGiao int,@MaDH int, @status nvarchar(50))
as
BEGIN tran
	if exists (select PGH.MaPhieuGiao
				from PhieuGiaoHang as PGH
				where PGH.MaPhieuGiao = @reqMaPhieuGiao and PGH.MaDonHang = @MaDH)
		begin
		Update PhieuGiaoHang
		set TinhTrangGiaoHang = @status
		where MaPhieuGiao = @reqMaPhieuGiao
		Update DonDatHang
		set TinhTrangDonHang = @status
		where MaDonHang = @MaDH
		end
	else
		begin
		print('Don hang khong ton tai')
		end
commit tran


exec TX_CapNhatTinhTrangGiaoHang 4,13, N'chưa giao'