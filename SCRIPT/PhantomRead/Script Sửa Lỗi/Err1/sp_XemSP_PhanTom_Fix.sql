USE BanHangOnline
GO

---------------Xóa dữ liệu vừa tạo để tiếp tục sử dụng T2 test-------------
DELETE FROM CungCapSanPham
WHERE MaSanPham = 500
go
DELETE FROM SanPham
WHERE MaSanPham = 500
go
---xử lý 
-- Proc xem san pham sau khi sua loi PHANTOM:
CREATE OR ALTER PROCEDURE sp_XemSP_fix
	@MaDT int
AS
BEGIN TRAN
	SET TRAN ISOLATION LEVEL SERIALIZABLE
	IF not exists (select * from DoiTac where MaDoiTac = @MaDT)
	begin
		Print @MaDT + N'Không tồn tại';
		rollback tran;
	end
	SELECT s.* 
	FROM DoiTac d, SanPham s
	WHERE d.MaDoiTac=@MaDT and d.MaDoiTac=s.MaDoiTac
	WAITFOR DELAY '00:00:10'
	SELECT s.* 
	FROM DoiTac d, SanPham s
	WHERE d.MaDoiTac=@MaDT and d.MaDoiTac=s.MaDoiTac
COMMIT TRAN

GO
EXEC sp_XemSP_fix 1
