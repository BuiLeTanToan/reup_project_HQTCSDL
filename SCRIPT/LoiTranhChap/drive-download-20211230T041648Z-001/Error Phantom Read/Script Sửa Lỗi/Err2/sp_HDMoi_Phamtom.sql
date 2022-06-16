USE BanHangOnline
GO

--T2 - them hop dong moi
GO
CREATE OR ALTER PROCEDURE sp_HDMoi @Mahd int, @Mathue varchar(10), @MaDoiTac int, @SoCN int, @Phi int, @TGHL date, @TGHH date
AS
	BEGIN TRANSACTION 
	SET TRAN ISOLATION LEVEL READ COMMITTED;
		INSERT dbo.HopDong
		(
		   MaHD,
		   MaSoThue,
		   MaDoiTac,
		   SoChiNhanh,
		   PhiKichHoat,
		   TGHieuLuc,
		   TGHetHan
		)
		VALUES
		(       
			@Mahd,
		    @Mathue,      
		    @MaDoiTac,       
			@SoCN,
			@Phi,
			@TGHL,
			@TGHH
		)
		
	COMMIT TRANSACTION
	
GO
exec sp_HDMoi 22,'34fns',1,2,100000,'2020-10-30','2020-12-31'
go
