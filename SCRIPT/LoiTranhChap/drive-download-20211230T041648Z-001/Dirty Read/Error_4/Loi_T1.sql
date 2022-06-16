GO
CREATE PROCEDURE NV_Update_TGGH
		@MaHD int,
		@TGGH date
AS

BEGIN TRAN
	IF NOT EXISTS (SELECT * FROM GiaHanHopDong WHERE MAHD = @MaHD)
	BEGIN
		PRINT (N'Mã hợp đồng không tồn tại');
		ROLLBACK TRAN;
	END

	UPDATE GiaHanHopDong
		SET ThoiGianGiaHan = @TGGH
		WHERE MAHD = @MaHD

	IF ISDATE(@TGGH) != 1
	BEGIN
		PRINT N'Thời gian gia hạn không hợp lệ';
		ROLLBACK TRAN;
	END
COMMIT TRAN