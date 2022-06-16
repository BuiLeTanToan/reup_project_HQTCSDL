USE BanHangOnline
GO

--T2 - tạo thông tin DonHangCT moi
GO
CREATE OR ALTER PROCEDURE sp_DHCTMoi @MaDH int, @MaSP int, @SL int
AS
	BEGIN TRANSACTION 
	SET TRAN ISOLATION LEVEL READ COMMITTED;
		INSERT dbo.ChiTietDonDatHang
		(
		   MaDonHang,
		   MaSanPham,
		   Soluong
		)
		VALUES
		(       
			@MaDH,
			@MaSP,
			@SL
		)
		
	COMMIT TRANSACTION
	
GO

exec sp_DHCTMoi 124, 2, 5
go
