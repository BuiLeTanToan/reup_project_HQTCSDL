
insert into NhanVien values ('2', 'Nguyen Thi B', '0987654321')
insert into GiaHanHopDong values ('24', '2', '2022-10-20', 'chuaduyet')
Update GiaHanHopDong set TinhTrangGiaHan = 'chuaduyet' where MAHD = '24'
go
create or alter proc KiemTraTinhTrangHD (@inputMaHopDong int)
as
BEGIN
begin tran
SET TRANSACTION ISOLATION
LEVEL READ COMMITTED
	if exists	(select *
				from GiaHanHopDong as GHHD
				where GHHD.MAHD = @inputMaHopDong )
		begin
			print('Thong tin Hop dong')
			select GHHD.TinhTrangGiaHan
			from GiaHanHopDong as GHHD
			where GHHD.MAHD = @inputMaHopDong 
			
			waitfor delay '00:00:08';

			print('Thong tin Hop dong')
			select GHHD.TinhTrangGiaHan
			from GiaHanHopDong as GHHD
			where GHHD.MAHD = @inputMaHopDong 
		end
	else
		begin 
			print('Khong tim thay Hop Dong')
			rollback tran
		end

commit tran
END



--TEST

exec KiemTraTinhTrangHD '24'
