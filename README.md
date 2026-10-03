# HỆ THỐNG QUẢN LÝ CHO THUÊ CĂN HỘ (APARTMENT MANAGEMENT)

## 1. Giới thiệu

Hệ thống Quản lý Cho thuê Căn hộ được xây dựng nhằm hỗ trợ công ty bất động sản quản lý thông tin căn hộ, khách hàng và hợp đồng thuê nhà.

Hệ thống cho phép:

* Quản lý thông tin khách hàng.
* Quản lý thông tin căn hộ.
* Quản lý hợp đồng thuê.
* Tìm kiếm hợp đồng thông qua thông tin khách hàng hoặc căn hộ.
* Thống kê tình trạng thuê căn hộ.

---

## 2. Công nghệ sử dụng

* Java 17+
* Spring MVC (Không sử dụng Spring Boot)
* Hibernate ORM
* MySQL
* JSP/JSTL
* Apache Tomcat 10
* Bootstrap 5
* Font Awesome
* Maven

---

## 3. Thiết kế cơ sở dữ liệu

### Bảng KHACH_HANG

| Tên cột     | Kiểu dữ liệu             | Mô tả         |
| ----------- | ------------------------ | ------------- |
| maKhachHang | INT (PK, AUTO_INCREMENT) | Mã khách hàng |
| hoTen       | VARCHAR(100)             | Họ tên        |
| soCCCD      | VARCHAR(12)              | CCCD          |
| soDT        | VARCHAR(10)              | Số điện thoại |
| email       | VARCHAR(100)             | Email         |

---

### Bảng CAN_HO

| Tên cột      | Kiểu dữ liệu             | Mô tả            |
| ------------ | ------------------------ | ---------------- |
| maCanHo      | INT (PK, AUTO_INCREMENT) | Mã căn hộ        |
| tenCanHo     | VARCHAR(100)             | Tên căn hộ       |
| loaiPhong    | VARCHAR(20)              | Studio, 1PN, 2PN |
| giaThuePhong | BIGINT                   | Giá thuê         |
| diaChi       | VARCHAR(255)             | Địa chỉ          |

---

### Bảng HOP_DONG

| Tên cột     | Kiểu dữ liệu             | Mô tả                  |
| ----------- | ------------------------ | ---------------------- |
| maHopDong   | INT (PK, AUTO_INCREMENT) | Mã hợp đồng            |
| maKhachHang | INT (FK)                 | Khách hàng             |
| maCanHo     | INT (FK)                 | Căn hộ                 |
| ngayBatDau  | DATE                     | Ngày bắt đầu           |
| ngayKetThuc | DATE                     | Ngày kết thúc          |
| tienDatCoc  | BIGINT                   | Tiền đặt cọc           |
| trangThai   | VARCHAR(50)              | Còn hiệu lực / Hết hạn |

---

## 4. Quan hệ dữ liệu

### KHACH_HANG → HOP_DONG

Một khách hàng có thể ký nhiều hợp đồng.

```java
@OneToMany(mappedBy = "khachHang")
private List<HopDong> hopDongList;
```

---

### CAN_HO → HOP_DONG

Một căn hộ có thể được thuê nhiều lần theo thời gian.

```java
@OneToMany(mappedBy = "canHo")
private List<HopDong> hopDongList;
```

---

### HOP_DONG → KHACH_HANG

```java
@ManyToOne
@JoinColumn(name = "maKhachHang")
private KhachHang khachHang;
```

---

### HOP_DONG → CAN_HO

```java
@ManyToOne
@JoinColumn(name = "maCanHo")
private CanHo canHo;
```

---

## 5. Dữ liệu mẫu

Yêu cầu:

* Ít nhất 5 khách hàng.
* Ít nhất 5 căn hộ.

Ví dụ:

### KHACH_HANG

| Họ tên       | CCCD         |
| ------------ | ------------ |
| Nguyễn Văn A | 012345678901 |
| Trần Văn B   | 012345678902 |
| Lê Văn C     | 012345678903 |
| Phạm Văn D   | 012345678904 |
| Hoàng Văn E  | 012345678905 |

---

### CAN_HO

| Tên căn hộ    | Loại   |
| ------------- | ------ |
| Sunrise A1    | Studio |
| Sunrise A2    | 1PN    |
| Sunrise A3    | 2PN    |
| Green Home B1 | Studio |
| Green Home B2 | 2PN    |

---

## 6. Chức năng hệ thống

### 6.1 Khai báo Hợp đồng thuê

Cho phép thêm mới hợp đồng thuê nhà.

Thông tin:

* Khách hàng
* Căn hộ
* Ngày bắt đầu
* Ngày kết thúc
* Tiền đặt cọc
* Trạng thái

---

### ComboBox Khách hàng

Load từ bảng:

```text
KHACH_HANG
```

Ví dụ:

```jsp
<form:select path="maKhachHang">
    <form:options
        items="${khachHangList}"
        itemValue="maKhachHang"
        itemLabel="hoTen"/>
</form:select>
```

---

### ComboBox Căn hộ

Load từ bảng:

```text
CAN_HO
```

Ví dụ:

```jsp
<form:select path="maCanHo">
    <form:options
        items="${canHoList}"
        itemValue="maCanHo"
        itemLabel="tenCanHo"/>
</form:select>
```

---

## 7. Validation

### Bắt buộc nhập

Tất cả trường đều bắt buộc.

Ví dụ:

```java
@NotNull
private Integer maKhachHang;
```

---

### Ngày kết thúc

Điều kiện:

```text
Ngày kết thúc > Ngày bắt đầu
```

Ví dụ:

```java
if(ngayKetThuc.isBefore(ngayBatDau)
    || ngayKetThuc.isEqual(ngayBatDau)) {
    errors.rejectValue(
        "ngayKetThuc",
        "error.endDate"
    );
}
```

---

### Tiền đặt cọc

Điều kiện:

* Là số nguyên dương.
* Chia hết cho 500.000.

Ví dụ:

```java
tienDatCoc > 0
&& tienDatCoc % 500000 == 0
```

Hợp lệ:

```text
500000
1000000
1500000
2000000
```

Không hợp lệ:

```text
650000
1200000
```

---

## 8. Chức năng tìm kiếm

### Form 1: Tìm kiếm Hợp đồng

Cho phép tìm kiếm theo:

* CCCD khách hàng
* Tên căn hộ

---

### Kết quả tìm kiếm

Hiển thị:

| Trường dữ liệu |
| -------------- |
| Mã hợp đồng    |
| Tên khách hàng |
| Số điện thoại  |
| Tên căn hộ     |
| Ngày bắt đầu   |
| Giá thuê       |
| Tiền đặt cọc   |

---

## 9. Câu JOIN quan trọng

Ví dụ HQL:

```sql
SELECT hd
FROM HopDong hd
JOIN hd.khachHang kh
JOIN hd.canHo ch
WHERE kh.soCCCD LIKE :keyword
   OR ch.tenCanHo LIKE :keyword
```

Hoặc SQL:

```sql
SELECT hd.maHopDong,
       kh.hoTen,
       kh.soDT,
       ch.tenCanHo,
       hd.ngayBatDau,
       ch.giaThuePhong,
       hd.tienDatCoc
FROM HOP_DONG hd
INNER JOIN KHACH_HANG kh
    ON hd.maKhachHang = kh.maKhachHang
INNER JOIN CAN_HO ch
    ON hd.maCanHo = ch.maCanHo
WHERE kh.soCCCD LIKE '%?%'
   OR ch.tenCanHo LIKE '%?%';
```

---

## 10. Kiến trúc dự án

```text
src/main/java
│
├── controller
│   ├── HopDongController
│   └── TimKiemController
│
├── entity
│   ├── KhachHang
│   ├── CanHo
│   └── HopDong
│
├── dao
│   ├── KhachHangDAO
│   ├── CanHoDAO
│   └── HopDongDAO
│
├── service
│   ├── HopDongService
│
├── validator
│   └── HopDongValidator
│
└── config
    ├── WebConfig
    ├── HibernateConfig
    └── AppInitializer
```

---

## 11. Giao diện

Yêu cầu:

* Bootstrap 5
* Font Awesome
* Responsive Design

Trang chính:

### Dashboard

* Tổng số căn hộ
* Tổng số khách hàng
* Tổng số hợp đồng

### Quản lý hợp đồng

* Thêm hợp đồng
* Danh sách hợp đồng

### Tìm kiếm

* Theo CCCD
* Theo tên căn hộ

---

## 12. Yêu cầu kỹ thuật

### Framework

* Spring MVC thuần

### ORM

* Hibernate

### Database

* MySQL

### Server

* Tomcat 10

### Coding Convention

* PascalCase cho Class.
* camelCase cho biến.
* Tách tầng:

    * Controller
    * Service
    * DAO
    * Entity

---

## 13. Kết luận

Hệ thống đáp ứng đầy đủ các yêu cầu:

✔ Quản lý Khách hàng

✔ Quản lý Căn hộ

✔ Quản lý Hợp đồng thuê

✔ ComboBox load dữ liệu từ CSDL

✔ Validation dữ liệu đầu vào

✔ Kiểm tra ngày kết thúc

✔ Kiểm tra tiền đặt cọc

✔ Tìm kiếm bằng JOIN

✔ Spring MVC thuần

✔ Hibernate ORM

✔ MySQL

✔ Tomcat 10

✔ Bootstrap + Font Awesome

✔ Tuân thủ Java Coding Convention
