from sqlalchemy import Column, Integer, String, Boolean, Enum, Float, ForeignKey, DateTime
from sqlalchemy.orm import relationship
from nha_sach import db
from flask_login import UserMixin
from enum import Enum as UserEnum
from datetime import datetime




class UserRole(UserEnum):
    KH = 1
    ADMIN = 2

class KhachHang(db.Model, UserMixin):
    __tablename__ = 'KhachHang'

    id = Column(Integer, primary_key=True, autoincrement=True)
    Ho = Column(String(50), nullable=True)
    Ten = Column(String(50), nullable=True)
    Email = Column(String(50))
    TenDangNhap = Column(String(100), nullable=False, unique=True)
    MatKhau = Column(String(100), nullable=False)
    GioiTinh = Column(String(100), nullable=False)
    HinhAnh = Column(String(100))
    SoDT = Column(String(100), nullable=False)
    HoatDonng = Column(Boolean, default=True)
    VaiTro = Column(Enum(UserRole), default=UserRole.KH)
    don_hang = relationship('DonHang', backref='TenKH', lazy=True)

    def __str__(self):
        return self.Ten


class LoaiSach(db.Model):
    __tablename__ = 'LoaiSach'

    MaLoaiSach = Column(Integer, primary_key=True)
    MieuTaLoaiSach = Column(String(100), nullable=True)
    sach = relationship('Sach', backref='LoaiSach', lazy=True)


class Sach(db.Model):
    __tablename__ = 'Sach'

    MaSach = Column(Integer, primary_key=True, autoincrement=True)
    TuaSach = Column(String(50), nullable=False)
    MoTaSach = Column(String(255))
    GiaBia = Column(Float, default=0)
    HinhAnh = Column(String(100))
    NamXuatBan = Column(Integer, nullable=False)
    ma_loaiSach = Column(Integer, ForeignKey(LoaiSach.MaLoaiSach), nullable=False)
    chiTiet_DH = relationship('ChiTietDonHang', backref='Sach', lazy=True)
    tg_vietsach = relationship('TacGiaVietSach', backref='Sach', lazy=True)


class DonHang(db.Model):
    __tablename__ = 'DonHang'
    MaDH = Column(Integer, primary_key=True, autoincrement=True)
    NgayMua = Column(DateTime, default=datetime.today())
    ma_kh = Column(Integer, ForeignKey(KhachHang.id), nullable=False)
    chiTiet_DH = relationship('ChiTietDonHang', backref='DonHang', lazy=True)


class ChiTietDonHang(db.Model):
    __tablename__ = 'ChiTietDonHang'
    ma_dh = Column(Integer, ForeignKey(DonHang.MaDH), primary_key=True)
    ma_sach = Column(Integer, ForeignKey(Sach.MaSach), primary_key=True)
    SoLuong = Column(Integer, default=0)
    GiaBan = Column(Float, default=0)
    TyLeGiamGia = Column(Float, default=0)

class TacGia(db.Model):
    __tablename__ = 'TacGia'
    MaTG = Column(Integer, primary_key=True)
    Ho = Column(String(50), nullable=True)
    Ten = Column(String(50), nullable=True)
    HinhAnh = Column(String(50))
    TieuSu = Column(String(50))
    tg_vietsach = relationship('TacGiaVietSach', backref='TacGia', lazy=True)

class TacGiaVietSach(db.Model):
    __tablename__ = 'TacGiaVietSach'
    ma_tg = Column(Integer, ForeignKey(TacGia.MaTG), primary_key=True)
    ma_sach = Column(Integer, ForeignKey(Sach.MaSach), primary_key=True)



if __name__ == '__main__':
    db.create_all()