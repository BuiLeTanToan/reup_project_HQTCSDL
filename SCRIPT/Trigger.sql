GO
create or alter trigger ct_thanhtien on ChiTietDonDatHang after insert, update 
--trigger này dùng để cập nhật ThanhTien trong bang CTđơn hàng và tham chiếu DonGia tu GiaBan trong bảng Sản phẩm
as 
begin
	declare @MaHD as int;
	declare @MaSP as int;
	declare @SL as int;
	declare @Gia as float;
	declare @ThanhTien as float;	
	SELECT 
		@MaHD = a.MaDonHang,
		@MaSP = a.MaSanPham,
		@SL = a.Soluong,
		@Gia = (SELECT sp.GiaBan FROM SanPham sp WHERE sp.MaSanPham = a.MaSanPham),
		@ThanhTien = a.Soluong * @Gia --Tính thành tiền = số lượng * đơn giá

	FROM inserted a;
	if exists (select MaDonHang, MaSanPham from ChiTietDonDatHang where MaDonHang = @MaHD and MaSanPham = @MaSP)
	begin
		UPDATE ChiTietDonDatHang 
		SET ThanhTien = @ThanhTien, DonGia = @Gia --Gán ThanhTien va DonGia vào bảng
		WHERE MaDonHang = @MaHD and MaSanPham = @MaSP
	end
	else 
	begin
		insert into ChiTietDonDatHang values (@MaHD, @MaSP, @SL, @Gia, @ThanhTien)
	end

	UPDATE DonDatHang --Ta update PhiSanPham = cách sum(ThanhTien) trong bảng ctdondathang
		SET PhiSanPham = (SELECT SUM(ct.ThanhTien) from ChiTietDonDatHang ct where ct.MaDonHang = @MaHD) --PhiSanPham = sum(ThanhTien) trong bang CTDONDATHANG
		WHERE MaDonHang = @MaHD

		update DonDatHang
		set TongTien  = PhiSanPham + PhiVanChuyen, NgayThanhToan = getdate() --TongTien = phí sản phẩm + phí vận chuyển
		where MaDonHang = @MaHD

end



go
create trigger TinhPhiHoaHong on HoaHong after insert, update
--Trigger này dùng để tính doanh số và phí hoa hồng trong bảng HOAHONG
as
begin
	declare @MaHD int;
	declare @Thang date;
	declare @DoanhSo float;
	declare @MaDoiTac int;
	declare @TGHieuLuc date;


	select @MaHD = I.MaHD, @Thang = I.Thang from inserted I 
	select @MaDoiTac = MaDoiTac from HopDong where @MaHD = MaHD
	select @TGHieuLuc = TGHIEULUC from HOPDONG where @MaHD = MaHD

	select @DoanhSo = sum(ct.ThanhTien) 
	from ChiTietDonHang ct, DonDatHang ddh, SanPham sp, HoaHong hh
	where ct.MaDonHang = ddh.MaDonHang and ct.MaSanPham = sp.MaSanPham and sp.MaDoiTac = @MaDoiTac and @Thang = month(ddh.NgayThanhToan) and year(@TGHieuLuc) = year(ddh.NgayThanhToan)

	update HoaHong
	set DoanhSo = @DoanhSo
	where @MaHD = MAHD

	update HoaHong
	set PhiHoaHong = DoanhSo * 0.1
	where @MaHD = MAHD

end

go
create trigger TinhThuNhapTaiXe
--Trigger này dùng để tính thu nhập của 1 tài xế dựa vào phí vận chuyển
on TaiXe
after insert, update
as
begin
	declare @MaTaiXe  int;
	declare @TongTien float;

	select @MaTaiXe = MaTaiXe from inserted

	select @TongTien = sum(ddh.PhiVanChuyen)
	from TaiXe tx, PhieuGiaoHang p,DonDatHang ddh
	where tx.MaTaiXe=@MaTaiXe and tx.MaTAIxE = p.MaTaiXe and p.MaDonHang = ddh.MaDonHang

	update TaiXe
	set ThuNhap = ThuNhap + @TongTien
	where @Mataixe = MaTaiXe

end

go

create trigger TgHieuLuc_TGKetThuc
--Trigger này dùng để kiểm tra TGHieuLuc và TGKetThuc có cách nhau ít nhất 1 tháng hay ko
on HopDong
after insert, update
as
begin
	
	declare @TgHieuLuc date;
	declare @TGKetThuc date;
	select @TgHieuLuc= TGHieuLuc from inserted
	select @TgKetThuc = TGHetHan from inserted
	if (datediff(day,@TGHieuLuc,@TGKetThuc)<30)
	begin
		print('Thoi gian hieu luc va thoi gian het han phai cach nhau 1 thang')
		rollback;
	end

end



go
create trigger Check_NgayGiao
--Trigger này dùng để kiểm tra ngày giao trong bảng PhieuGiaoHang có được tồn tại hay không nếu tình trạng đơn hàng là đã giao
on PhieuGiaoHang
after insert, update
as
begin
	
	declare @MaDonHang int;
	declare @NgayGiao date;

	select @MaDonHang = MaDonHang from inserted
	select @NgayGiao = NgayGiao from inserted

	declare @TinhTrang nvarchar(20);
	select @TinhTrang = ddh.TinhTrangDonHang from PhieuGiaoHang p, DonDatHang ddh where @MaDonhang = ddh.MaDonHang

	if @NgayGiao is null and @TinhTrang != N'Đã giao'
	begin
		print('Tinh trang da giao nhung ngay giao is null')
		rollback;
	end

end
go

