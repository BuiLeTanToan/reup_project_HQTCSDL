USE BanHangOnline
GO

---------------Xóa dữ liệu vừa tạo để tiếp tục sử dụng T2 test-------------
DELETE FROM ChiTietDonDatHang
WHERE MaDonHang = 124
go

---xử lý 
-- Proc Thống kê sau khi cập nhật xử lí lỗi PHANTOM:

CREATE OR ALTER PROCEDURE sp_ThongKeSP_fix
	@MaDT int
AS
BEGIN TRAN
	SET TRAN ISOLATION LEVEL SERIALIZABLE
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

EXEC sp_ThongKeSP_fix 1
