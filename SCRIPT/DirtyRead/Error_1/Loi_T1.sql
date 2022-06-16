drop Proc KH_Update_DCGH
GO
CREATE PROCEDURE KH_Update_DCGH
		@MaDH int,
		@DCGH nvarchar(150)
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
	
	IF (LEN(@DCGH) > 50)
		BEGIN
			PRINT (N'Địa chỉ giao hàng quá dài');
			WAITFOR DELAY '00:00:08';
			ROLLBACK TRAN;
		END
		

COMMIT TRAN

exec KH_Update_DCGH '1', N'Đài thiên văn phía Nam của Châu Âu (tiếng Anh: European Southern Observatory (ESO), tiếng Pháp: Observatoire européen austral), tên chính thức là Tổ chức Nghiên cứu thiên văn châu Âu tại Nam Bán cầu (tiếng Anh: European Organization for Astronomical Research in the Southern Hemisphere, tiếng Pháp: Organisation Européenne pour des Recherches Astronomiques dans lHémisphere Austral)[1] là một tổ chức nghiên cứu liên chính phủ về thiên văn học, kết hợp từ mười bốn nước thuộc châu Âu và Brasil (2010). Được thành lập năm 1962 với mục đích cung cấp những cơ sở tiên tiến nhất và khả năng quan sát bầu trời ở Nam Bán cầu cho các nhà thiên văn châu Âu. Tổ chức này nổi tiếng với những đài thiên văn và điều hành những kính thiên văn lớn nhất, công nghệ hiện đại nhất trên thế giới; như Kính thiên văn công nghệ mới (NTT), đây là kính tiên phong áp dụng công nghệ quang học chủ động, và kính thiên văn rất lớn - VLT (Very Large Telescope), gồm bốn kính đường kính 8 m và bốn kính phụ đường kính 1,8 m.Nhiều cơ sở quan sát của tổ chức đã đóng góp những khám phá thiên văn quan trọng, cũng như thực hiện một vài danh lục thiên văn học. Một trong những khám phá gần đây đó là sự khám phá ra vụ bùng phát tia gamma xa nhất và chứng cứ cho một lỗ đen tại trung tâm của thiên hà chúng ta, dải Ngân Hà. Năm 2004, kính VLT đã cho phép các nhà thiên văn học chụp được bức ảnh trực tiếp đầu tiên về một hành tinh ngoại hệ 2M1207b, nó quay xung quanh lùn nâu cách Mặt Trời 173 năm ánh sáng. Nhờ phổ kế HARPS mà tổ chức đã phát hiện ra nhiều hành tinh ngoài Hệ Mặt Trời, bao gồm một hành tinh với khối lượng khoảng 5 lần khối lượng Trái Đất, Gliese 581c. Kính VLT cũng đã quan sát thấy một trong những thiên hà xa nhất Abell 1835 IR1916 đồng thời cung cấp thêm bằng chứng về thiên hà xa nhất cho tới tháng 11/2010, thiên hà UDFy-38135539.'