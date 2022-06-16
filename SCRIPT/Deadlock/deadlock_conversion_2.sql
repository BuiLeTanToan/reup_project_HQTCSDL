go
alter Proc UpdatePriceProduct_Conversion_2 (@inputGiaBan float, @inputMaSanPham int)
as
BEGIN tran
	set tran isolation level serializable
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
commit tran

exec UpdatePriceProduct_Conversion_2 5200,0