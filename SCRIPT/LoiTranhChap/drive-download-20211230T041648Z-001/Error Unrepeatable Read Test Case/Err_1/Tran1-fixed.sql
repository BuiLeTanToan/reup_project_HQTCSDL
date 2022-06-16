drop proc ViewPriceProduct
Create or alter Proc ViewPriceProduct (@inputMaSanPham int)
as
BEGIN
begin transaction;
SET TRANSACTION ISOLATION
LEVEL REPEATABLE READ;
	if exists	(select SP.GiaBan
				from SanPham as SP
				where SP.MaSanPham = @inputMaSanPham)
	begin
		print('Gia cua san pham la')
		select SP.GiaBan
		from SanPham as SP
		where SP.MaSanPham = @inputMaSanPham

		waitfor delay '00:00:08';

		select SP.GiaBan
		from SanPham as SP
		where SP.MaSanPham = @inputMaSanPham
	end
	else
	begin
		print('San pham khong ton tai')
	end
commit transaction;
END


exec ViewPriceProduct '2'
