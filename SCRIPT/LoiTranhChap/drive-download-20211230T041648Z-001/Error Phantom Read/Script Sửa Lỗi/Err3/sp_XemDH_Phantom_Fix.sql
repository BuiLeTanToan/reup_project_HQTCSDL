USE BanHangOnline
GO

---------------Xóa dữ liệu vừa tạo để tiếp tục sử dụng T2 test-------------
DELETE FROM DonDatHang
WHERE MaDonHang = 500
go

---xử lý 
-- Proc xem don hang PHANTOM:
CREATE OR ALTER PROCEDURE sp_XemDH_fix
AS
BEGIN TRAN
	SET TRAN ISOLATION LEVEL SERIALIZABLE
	SELECT d.* 
	FROM DonDatHang d
	WAITFOR DELAY '00:00:10'
	SELECT d.* 
	FROM DonDatHang d
COMMIT TRAN
GO
EXEC sp_XemDH_fix 
