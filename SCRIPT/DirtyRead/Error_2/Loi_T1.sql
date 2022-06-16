GO
CREATE PROCEDURE DT_Update_GiaSP
	@MaSP int,
	@GiaSP float
AS

BEGIN TRAN
	IF NOT EXISTS (SELECT * FROM SanPham WHERE MaSanPham = @MaSP)
	BEGIN
		PRINT (N'Mã sản phẩm không tồn tại');
		ROLLBACK TRAN;
	END

	UPDATE SanPham
		SET GiaBan = @GiaSP
		WHERE MaSanPham = @MaSP

	IF @GiaSP <= 0 OR ISNUMERIC(@GiaSP) != 1
	BEGIN
		PRINT N'Giá bán nhập vào không hợp lệ';
		WAITFOR DELAY '00:00:08';
		ROLLBACK TRAN;
	END
COMMIT TRAN



