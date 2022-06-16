USE BanHangOnline
GO

--T2 - them san pham moi
--drop proc sp_SPMoi
GO
CREATE OR ALTER PROCEDURE sp_SPMoi @MaCC int, @MaSP INT, @MaDT int, @TenSP varchar(40), @Giaban int, @PLHang nvarchar (10), @GhiChu nvarchar(30), @NgayCC date
AS
	BEGIN TRANSACTION 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
		INSERT dbo.SanPham
		(
		   MaSanPham,
		   TenSanPham,
		   GiaBan,
		   PhanLoaiHang,
		   MaDoiTac
		)
		VALUES
		(       
			@MaSP,
		    @TenSP,      
		    @Giaban,       
		    @PLHang,
			@MaDT
		    )
		INSERT CungCapSanPham
		(
			MaChiNhanh,
			MaSanPham,
			GhiChu,
			NgayCC
			)
		Values 
		(
			@MaCC,
			@MaSP,
			@GhiChu,
			@NgayCC
			)
	COMMIT TRANSACTION
	
GO
exec sp_SPMoi 1,130,1,N'rom tom',7000,'423sdf2ư4se','cugns','2021-11-11'
go