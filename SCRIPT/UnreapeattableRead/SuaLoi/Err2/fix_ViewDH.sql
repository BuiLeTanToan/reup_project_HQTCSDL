delete from TaiKhoan_KH where MaKH ='1'
delete from KhachHang where MaKhachHang = '1'
delete from DonDatHang where MaKhachHang = '1'
delete from ChiTietDonDatHang where MaDonHang = '18'
insert into SanPham values ('2', 'Kem danh rang', '10000', 'K', null)
insert into KhachHang values ('1', 'Nguyen Van A', '0123456789', '12 Pham Ngu Lao, Quan 7, TP.HCM', 'nguyenvana@email.com')
insert into DonDatHang values ('18', '1', '2021-12-23', '15000', null, 'tienmat', 'dagiao', null, 'abdcefgh')
insert into ChiTietDonDatHang values ('18', '2', '2', null, null)


go
create or alter proc viewDH (@inputMaDonHang int)
as
BEGIN
begin tran
SET TRANSACTION ISOLATION
LEVEL REPEATABLE READ
if exists	(select *
			from DonDatHang as DDH
			where DDH.MaDonHang = @inputMaDonHang)

begin

	print('Chi Tiet Don Hang')
	select *
	from DonDatHang as DDH
	where DDH.MaDonHang = @inputMaDonHang

	waitfor delay '00:00:08';

	print('Chi Tiet Don Hang')
	select *
	from DonDatHang as DDH
	where DDH.MaDonHang = @inputMaDonHang

end
else 
begin
	 print('Don hang khong ton tai')
end
commit tran
END
--TESTING
exec viewDH '18'