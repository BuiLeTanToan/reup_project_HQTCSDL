USE BanHangOnline
GO

----T1 */ xem thong tin danh sach donhangchitiet va thongkeSP
--drop proc sp_ThongKeSP
CREATE OR ALTER PROCEDURE sp_ThongKeSP
	@MaDT int
AS
BEGIN TRAN
	set tran ISOLATION LEVEL READ COMMITTED
	IF not exists (select * from DoiTac where MaDoiTac = @MaDT)
	begin
		Print @MaDT + N'Không tồn tại';
		rollback tran;
	end
	SELECT ct.* 
	FROM DoiTac d, SanPham s, ChiTietDonDatHang ct
	WHERE d.MaDoiTac=@MaDT and  d.MaDoiTac= s.MaDoiTac and ct.MaSanPham= s.MaSanPham
	WAITFOR DELAY '00:00:10'
	SELECT SUM(ct.Soluong) as TongSP_Daban
	FROM DoiTac d, SanPham s, ChiTietDonDatHang ct
	WHERE d.MaDoiTac=@MaDT and  d.MaDoiTac= s.MaDoiTac and ct.MaSanPham= s.MaSanPham
COMMIT TRAN
GO

EXEC sp_ThongKeSP 1
