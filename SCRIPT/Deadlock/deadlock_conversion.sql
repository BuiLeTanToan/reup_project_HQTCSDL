go
alter Proc UpdatePriceProduct_Conversion (@inputGiaBan float, @inputMaSanPham int)
as
BEGIN tran
	set tran isolation level serializable
	if exists	(select *
				from SanPham as SP
				where SP.MaSanPham = @inputMaSanPham)
	begin
		waitfor delay '00:00:08'
		Update SanPham 
		Set GiaBan = @inputGiaBan
		where MaSanPham = @inputMaSanPham
		
	end
	else 
	begin
		print('San Pham khong ton tai');
	end
commit tran

exec UpdatePriceProduct_Conversion 5000,0
select * from sanpham