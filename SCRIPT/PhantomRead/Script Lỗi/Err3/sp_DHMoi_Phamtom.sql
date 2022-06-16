USE BanHangOnline
GO

--T2 - tạo thông tin DonHang moi
GO
CREATE OR ALTER PROCEDURE sp_DHMoi @MaDH int, @MaKH int, @NgayTT date, @PhiVC int, @HTTT nvarchar(10), @Diachi nvarchar(50)
AS
	BEGIN TRANSACTION 
	SET TRAN ISOLATION LEVEL READ COMMITTED;
		INSERT dbo.DonDatHang
		(
		   MaDonHang,
		   MaKhachHang,
		   NgayThanhToan,
		   PhiVanChuyen,
		   HinhThucThanhToan,
		   DiaChiGiaoHang
		)
		VALUES
		(       
			@MaDH,
			@MaKH,
			@NgayTT,
			@PhiVC,
			@HTTT,
			@Diachi
		)
		
	COMMIT TRANSACTION
	
GO

exec sp_DHMoi 500,222,'2021-12-04',15000,'credit','9 Dien Bien Phu, quan 1, HCM'
go
