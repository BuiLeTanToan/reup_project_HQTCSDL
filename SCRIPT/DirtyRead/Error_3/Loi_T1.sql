GO
CREATE PROCEDURE KH_Update_DCGH
		@MaDH int,
		@DCGH nvarchar
AS

BEGIN TRAN
	IF NOT EXISTS (SELECT * FROM DonDatHang WHERE MaDonHang = @MaDH)
	BEGIN
		PRINT (N'Mã Đơn hàng không tồn tại');
		ROLLBACK TRAN;
	END

	UPDATE DonDatHang
		SET DiaChiGiaoHang = @DCGH
		WHERE MaDonHang = @MaDH

	IF (LEN(@DCGH) < 30)
	BEGIN
		PRINT (N'Địa chỉ giao hàng quá ngắn');
		WAITFOR DELAY '00:00:08';
		ROLLBACK TRAN;
	END
COMMIT TRAN