---create data
delete from HoaHong
delete from HopDong
where HopDong.MaDoiTac = '1'
delete from ChiNhanh
where ChiNhanh.MaDoiTac = '1'
delete from DoiTac
where DoiTac.MaDoiTac = '1'

insert into DoiTac values ('1', 'Cong Ty TNHH An Viet', 'Nguyen Van A', '5', '400', 'Quan 1', 'TP.HCM', '0321654987', 'anvietcoltd@email.com')
insert into ChiNhanh values ('4', 'Chi Nhanh Mac Thi Buoi', '1', '18, Mac Thi Buoi, Quan 2, TP.HCM')
insert into HopDong values ('24', 'CB4051', '1', '5', '1000000', '2020-10-20', '2021-10-20', '1')
insert into HoaHong values ('24', '2020-05-01', null, null, '1')
go
create or alter proc viewAddress(@inputMaChiNhanh int)
as
BEGIN
begin tran
SET TRANSACTION ISOLATION
LEVEL READ COMMITTED
	if exists	(select *
				from ChiNhanh as CN
				where CN.MaChiNhanh = @inputMaChiNhanh)
		begin
			print('Dia chi')
			select CN.DiaChiChiNhanh
			from ChiNhanh as CN
			where CN.MaChiNhanh = @inputMaChiNhanh

			waitfor delay '00:00:08';

			print('Dia chi')
			select CN.DiaChiChiNhanh
			from ChiNhanh as CN
			where CN.MaChiNhanh = @inputMaChiNhanh
		end
	else
		begin 
			print('Khong tim thay dia chi hop le')
		end
commit tran
END

--TEST

exec viewAddress '4'
