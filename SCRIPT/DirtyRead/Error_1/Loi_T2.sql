GO
CREATE or alter PROCEDURE TX_View_DCGH
		@MaDH int
AS

BEGIN TRAN
	IF NOT EXISTS (SELECT * FROM DonDatHang WHERE MaDonHang = @MaDH)
	BEGIN
		PRINT (N'Mã Đơn hàng không tồn tại');
		ROLLBACK TRAN;
	END
	SELECT * FROM DonDatHang
	WHERE MaDonHang = @MaDH
COMMIT TRAN

exec TX_View_DCGH '1'