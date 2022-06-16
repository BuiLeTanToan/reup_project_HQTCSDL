USE BanHangOnline
GO

---------------Xóa dữ liệu vừa tạo để tiếp tục sử dụng T2 test-------------
DELETE FROM HopDong
WHERE MaHD = 500
go

---xử lý 
-- Proc Thống kê sau khi cập nhật xử lí lỗi PHANTOM:
CREATE OR ALTER PROCEDURE sp_XemHD_fix
AS
BEGIN TRAN
	SET TRAN ISOLATION LEVEL SERIALIZABLE
	SELECT h.* 
	FROM HopDong h
	WAITFOR DELAY '00:00:10'
	SELECT h.* 
	FROM HopDong h
COMMIT TRAN
GO

EXEC sp_XemHD_fix 