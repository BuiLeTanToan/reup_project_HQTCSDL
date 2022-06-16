USE BanHangOnline
GO

----T1 */
--drop proc sp_XemSP
CREATE OR ALTER PROCEDURE sp_XemSP
	@MaDT int
AS
BEGIN TRAN
	set tran ISOLATION LEVEL READ COMMITTED
	IF not exists (select * from DoiTac where MaDoiTac = @MaDT)
	begin
		Print @MaDT + N'Không t?n t?i';
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

EXEC sp_XemSP 1