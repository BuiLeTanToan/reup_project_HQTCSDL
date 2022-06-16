USE BanHangOnline
GO

----T1 */ xem thong tin danh sach donhang
--drop proc sp_SPMoi
CREATE OR ALTER PROCEDURE sp_XemDH
AS
BEGIN TRAN
	set tran ISOLATION LEVEL READ COMMITTED
	SELECT d.* 
	FROM DonDatHang d
	WAITFOR DELAY '00:00:10'
	SELECT d.* 
	FROM DonDatHang d
COMMIT TRAN
GO

EXEC sp_XemDH