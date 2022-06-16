drop proc UpdatePriceProduct
create or alter Proc UpdatePriceProduct (@inputGiaBan int, @inputMaSanPham int)
as
BEGIN
begin transaction;
SET TRANSACTION ISOLATION
LEVEL READ COMMITTED;
	if exists	(select *
				from SanPham as SP
				where SP.MaSanPham = @inputMaSanPham)
	begin
		Update SanPham
		Set GiaBan = @inputGiaBan
		where MaSanPham = @inputMaSanPham
	end
else 
	begin
		print('San Pham khong ton tai');
	end
commit transaction;
END


exec UpdatePriceProduct '5000',  '2';