
go
create or alter proc duyetHD (@requestMaHopDong int)
as
declare @thoiGianGiaHan date
BEGIN
begin tran
SET TRANSACTION ISOLATION
LEVEL READ COMMITTED
	if exists	(select *
				from GiaHanHopDong as GHHD
				where GHHD.MaHD = @requestMaHopDong)
		begin
			Update GiaHanHopDong
			set TinhTrangGiaHan = 'daduyet'
			where GiaHanHopDong.MAHD = @requestMaHopDong


			set @thoiGianGiaHan = (	select GHHD.ThoiGianGiaHan
									from GiaHanHopDong as GHHD
									where GHHD.MAHD = @requestMaHopDong)


			Update HopDong
			set TGHetHan = @thoiGianGiaHan
			where MaHD = @requestMaHopDong
			print('Duyet Hop dong thanh cong')
		end
	else
		begin
			print('Duyet hop dong khong thanh cong')
		end
commit tran
END

--TEST


