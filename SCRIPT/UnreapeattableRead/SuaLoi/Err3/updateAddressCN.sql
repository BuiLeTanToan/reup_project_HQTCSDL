create or alter proc updateAddressCN (@requestMaChiNhanh int, @requestMaDoiTac int, @DiaChiMoi nvarchar(50))
as

BEGIN
begin tran
SET TRANSACTION ISOLATION
LEVEL READ COMMITTED
	if exists	(select *
				from ChiNhanh as CN
				where CN.MaChiNhanh = @requestMaChiNhanh
				and CN.MaDoiTac = @requestMaDoiTac)
	begin
		Update ChiNhanh
		set DiaChiChiNhanh = @DiaChiMoi
		where MaChiNhanh = @requestMaChiNhanh
		print('Thay doi dia chi thanh cong')
	end
	else
	begin
		print('Thay doi dia chi khong thanh cong')
	end
commit tran
END

 
exec updateAddressCN '4', '1', '28 Le Van Huu, Quan 5, TP.HCM'
