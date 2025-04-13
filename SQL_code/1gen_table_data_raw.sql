-- Tạo cơ sở dữ liệu
CREATE DATABASE FoodOrderDB;
GO
USE FoodOrderDB;
GO

-- Bảng Users (Người dùng)
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Username NVARCHAR(50) NOT NULL,
    Password NVARCHAR(100) NOT NULL,
    FullName NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(20) NOT NULL,
    Email NVARCHAR(100),
    Address NVARCHAR(255),
    UserRole NVARCHAR(20) DEFAULT 'Customer' -- Customer, Admin
);

-- Bảng Categories (Danh mục món ăn)
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(50) NOT NULL,
    Description NVARCHAR(255)
);

-- Bảng Foods (Món ăn)
CREATE TABLE Foods (
    FoodID INT PRIMARY KEY IDENTITY(1,1),
    FoodName NVARCHAR(100) NOT NULL,
    CategoryID INT,
    Description NVARCHAR(255),
    Price DECIMAL(10,2) NOT NULL,
    ImageName NVARCHAR(100),
    IsAvailable BIT DEFAULT 1,
    Quantity INT DEFAULT 100, -- Thêm trường số lượng món ăn còn lại
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Bảng Orders (Đơn hàng)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(10,2) NOT NULL,
    Status NVARCHAR(50) DEFAULT 'Pending', -- Pending, Confirmed, Delivering, Delivered, Cancelled
    DeliveryAddress NVARCHAR(255) NOT NULL,
    PhoneNumber NVARCHAR(20) NOT NULL,
    PaymentMethod NVARCHAR(50) DEFAULT 'Cash',
    Notes NVARCHAR(255),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Bảng OrderDetails (Chi tiết đơn hàng)
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    FoodID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (FoodID) REFERENCES Foods(FoodID)
);

-- Bảng Ratings (Đánh giá)
CREATE TABLE Ratings (
    RatingID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    UserID INT NOT NULL,
    Rating INT NOT NULL, -- 1 to 5
    Comment NVARCHAR(MAX),
    RatingDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Bảng SavedCarts (Giỏ hàng đã lưu)
CREATE TABLE SavedCarts (
    CartID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    FoodID INT NOT NULL,
    Quantity INT NOT NULL,
    SavedDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (FoodID) REFERENCES Foods(FoodID)
);

-- Tạo index để tăng tốc truy vấn
CREATE INDEX IDX_SavedCarts_UserID ON SavedCarts(UserID);

GO

-- Thêm dữ liệu mẫu vào bảng Users
-- Password mặc định '123456' = 8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92
INSERT INTO Users (Username, Password, FullName, Phone, Email, Address, UserRole)
VALUES 
('admin', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'Quản trị viên', '0900000000', 'admin@foodorder.com', N'123 Đường Admin, Quận 1, TP.HCM', 'Admin'),
('manager', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'Quản lý nhà hàng', '0900000001', 'manager@foodorder.com', N'456 Đường Manager, Quận 2, TP.HCM', 'Admin'),
('user1', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'Nguyễn Văn A', '0901234567', 'user1@example.com', N'456 Đường Lê Lợi, Quận 1, TP.HCM', 'Customer'),
('user2', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'Trần Thị B', '0909876543', 'user2@example.com', N'789 Đường Nguyễn Huệ, Quận 1, TP.HCM', 'Customer'),
('user3', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'Lê Văn C', '0907654321', 'user3@example.com', N'123 Đường Trần Hưng Đạo, Quận 5, TP.HCM', 'Customer'),
('user4', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'Phạm Thị D', '0903214567', 'user4@example.com', N'456 Đường Võ Văn Tần, Quận 3, TP.HCM', 'Customer'),
('user5', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'Hoàng Văn E', '0905678932', 'user5@example.com', N'789 Đường Điện Biên Phủ, Quận Bình Thạnh, TP.HCM', 'Customer'),
('user6', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'Ngô Thị F', '0908765123', 'user6@example.com', N'321 Đường Cách Mạng Tháng 8, Quận 10, TP.HCM', 'Customer'),
('user7', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'Vũ Văn G', '0902468135', 'user7@example.com', N'654 Đường Lý Thường Kiệt, Quận 11, TP.HCM', 'Customer'),
('user8', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'Đặng Thị H', '0901357924', 'user8@example.com', N'987 Đường Nguyễn Thị Minh Khai, Quận 3, TP.HCM', 'Customer');

-- Thêm dữ liệu mẫu vào bảng Categories
INSERT INTO Categories (CategoryName, Description)
VALUES 
(N'Cơm', N'Các món cơm Việt Nam và cơm chiên đa dạng'),
(N'Phở', N'Các loại phở truyền thống và phở đặc biệt'),
(N'Bún', N'Các món bún ngon từ mọi miền đất nước'),
(N'Đồ uống', N'Nước uống, giải khát, trà sữa, cà phê'),
(N'Mì', N'Các món mì, hủ tiếu và mì xào'),
(N'Bánh mì', N'Bánh mì kẹp thịt đa dạng'),
(N'Món khai vị', N'Các món ăn nhẹ, khai vị'),
(N'Tráng miệng', N'Các món tráng miệng, chè, bánh ngọt');

-- Thêm dữ liệu mẫu vào bảng Foods
INSERT INTO Foods (FoodName, CategoryID, Description, Price, ImageName, IsAvailable, Quantity)
VALUES 
-- Món Cơm (CategoryID = 1)
(N'Cơm Sườn', 1, N'Cơm trắng, sườn nướng, đồ chua và nước mắm', 45000, 'com_suon.jpg', 1, 50),
(N'Cơm Gà', 1, N'Cơm trắng, gà rán, sốt cay ngọt', 45000, 'com_ga.jpg', 1, 45),
(N'Cơm Chiên Dương Châu', 1, N'Cơm chiên với thịt, trứng, đậu Hà Lan và cà rốt', 50000, 'com_chien_duong_chau.jpg', 1, 60),
(N'Cơm Chiên Hải Sản', 1, N'Cơm chiên với hải sản tươi ngon', 55000, 'com_chien_hai_san.jpg', 1, 40),
(N'Cơm Tấm Sườn Bì Chả', 1, N'Cơm tấm với sườn nướng, bì và chả', 60000, 'com_tam.jpg', 1, 55),
(N'Cơm Rang Thịt Bò', 1, N'Cơm rang với thịt bò xào', 55000, 'com_rang_thit_bo.jpg', 1, 35),

-- Món Phở (CategoryID = 2)
(N'Phở Bò Tái', 2, N'Phở với thịt bò tái', 55000, 'pho_bo_tai.jpg', 1, 70),
(N'Phở Bò Chín', 2, N'Phở với thịt bò chín', 55000, 'pho_bo_chin.jpg', 1, 65),
(N'Phở Gà', 2, N'Phở với thịt gà', 50000, 'pho_ga.jpg', 1, 60),
(N'Phở Đặc Biệt', 2, N'Phở với nhiều loại thịt bò khác nhau', 65000, 'pho_dac_biet.jpg', 1, 50),
(N'Phở Nam Vang', 2, N'Phở kiểu Nam Vang với thịt bò, tôm, lòng', 60000, 'pho_nam_vang.jpg', 1, 40),

-- Món Bún (CategoryID = 3)
(N'Bún Chả', 3, N'Bún, chả nướng, đồ chua và nước mắm', 50000, 'bun_cha.jpg', 1, 55),
(N'Bún Bò Huế', 3, N'Bún với thịt bò, chả và nước dùng cay cay', 60000, 'bun_bo_hue.jpg', 1, 50),
(N'Bún Thịt Nướng', 3, N'Bún với thịt nướng, đồ chua và nước mắm', 55000, 'bun_thit_nuong.jpg', 1, 60),
(N'Bún Đậu Mắm Tôm', 3, N'Bún đậu, chả cốm, thịt luộc và mắm tôm', 65000, 'bun_dau_mam_tom.jpg', 1, 45),
(N'Bún Cá', 3, N'Bún với cá chiên giòn và nước dùng chua ngọt', 55000, 'bun_ca.jpg', 1, 40),

-- Đồ uống (CategoryID = 4)
(N'Trà Sữa Trân Châu', 4, N'Trà sữa với trân châu đen', 35000, 'tra_sua.jpg', 1, 80),
(N'Cà Phê Đen', 4, N'Cà phê đen nguyên chất', 25000, 'ca_phe_den.jpg', 1, 100),
(N'Cà Phê Sữa', 4, N'Cà phê với sữa đặc', 30000, 'ca_phe_sua.jpg', 1, 100),
(N'Sinh Tố Xoài', 4, N'Sinh tố xoài tươi ngon', 35000, 'sinh_to_xoai.jpg', 1, 70),
(N'Sinh Tố Bơ', 4, N'Sinh tố bơ béo ngậy', 40000, 'sinh_to_bo.jpg', 1, 65),
(N'Nước Ép Cam', 4, N'Nước ép cam tươi', 35000, 'nuoc_ep_cam.jpg', 1, 75),
(N'Nước Ép Dưa Hấu', 4, N'Nước ép dưa hấu mát lạnh', 30000, 'nuoc_ep_dua_hau.jpg', 1, 75),
(N'Trà Đào', 4, N'Trà đào với đào miếng', 35000, 'tra_dao.jpg', 1, 80),

-- Món Mì (CategoryID = 5)
(N'Mì Xào Hải Sản', 5, N'Mì xào với hải sản tươi ngon', 60000, 'mi_xao_hai_san.jpg', 1, 45),
(N'Mì Hoành Thánh', 5, N'Mì với hoành thánh nhân thịt', 55000, 'mi_hoanh_thanh.jpg', 1, 40),
(N'Hủ Tiếu Nam Vang', 5, N'Hủ tiếu kiểu Nam Vang', 55000, 'hu_tieu_nam_vang.jpg', 1, 50),
(N'Mì Quảng', 5, N'Mì Quảng truyền thống với thịt, tôm, đậu phộng', 60000, 'mi_quang.jpg', 1, 45),

-- Bánh mì (CategoryID = 6)
(N'Bánh Mì Thịt', 6, N'Bánh mì với thịt, pate và rau', 30000, 'banh_mi_thit.jpg', 1, 60),
(N'Bánh Mì Gà', 6, N'Bánh mì với thịt gà xé và sốt mayonnaise', 35000, 'banh_mi_ga.jpg', 1, 55),
(N'Bánh Mì Chả Cá', 6, N'Bánh mì với chả cá và đồ chua', 35000, 'banh_mi_cha_ca.jpg', 1, 50),
(N'Bánh Mì Xíu Mại', 6, N'Bánh mì với xíu mại và nước sốt', 40000, 'banh_mi_xiu_mai.jpg', 1, 45),

-- Món khai vị (CategoryID = 7)
(N'Chả Giò', 7, N'Chả giò rán giòn với nhân thịt và rau củ', 45000, 'cha_gio.jpg', 1, 70),
(N'Gỏi Cuốn', 7, N'Gỏi cuốn tôm thịt với nước chấm', 40000, 'goi_cuon.jpg', 1, 75),
(N'Gỏi Ngó Sen', 7, N'Gỏi ngó sen với tôm, thịt và gia vị', 50000, 'goi_ngo_sen.jpg', 1, 40),
(N'Đậu Hũ Chiên', 7, N'Đậu hũ chiên giòn với sốt chấm', 35000, 'dau_hu_chien.jpg', 1, 50),

-- Tráng miệng (CategoryID = 8)
(N'Chè Thái', 8, N'Chè Thái với nhiều loại thạch và đậu', 30000, 'che_thai.jpg', 1, 60),
(N'Bánh Flan', 8, N'Bánh flan caramel béo mịn', 25000, 'banh_flan.jpg', 1, 65),
(N'Trái Cây Dĩa', 8, N'Đĩa trái cây tươi theo mùa', 40000, 'trai_cay_dia.jpg', 1, 50),
(N'Sữa Chua Nếp Cẩm', 8, N'Sữa chua với nếp cẩm và đường phèn', 35000, 'sua_chua_nep_cam.jpg', 1, 55);

-- Thêm dữ liệu mẫu vào bảng Orders
INSERT INTO Orders (UserID, OrderDate, TotalAmount, Status, DeliveryAddress, PhoneNumber, PaymentMethod, Notes)
VALUES 
-- Đơn hàng cũ hơn
(3, '2025-02-15 12:30:00', 125000, 'Delivered', N'456 Đường Lê Lợi, Quận 1, TP.HCM', '0901234567', 'Cash', N'Không hành, ít ớt'),
(4, '2025-02-16 18:45:00', 135000, 'Delivered', N'789 Đường Nguyễn Huệ, Quận 1, TP.HCM', '0909876543', 'Card', N'Giao nhanh nếu có thể'),
(5, '2025-02-17 14:20:00', 95000, 'Delivered', N'123 Đường Trần Hưng Đạo, Quận 5, TP.HCM', '0907654321', 'Cash', N''),
(6, '2025-02-18 19:15:00', 155000, 'Delivered', N'456 Đường Võ Văn Tần, Quận 3, TP.HCM', '0903214567', 'Cash', N'Thêm tương ớt'),
-- Đơn hàng gần đây hơn
(3, '2025-03-01 13:10:00', 165000, 'Delivered', N'456 Đường Lê Lợi, Quận 1, TP.HCM', '0901234567', 'Card', N''),
(4, '2025-03-02 20:30:00', 210000, 'Delivered', N'789 Đường Nguyễn Huệ, Quận 1, TP.HCM', '0909876543', 'Cash', N''),
(7, '2025-03-05 12:45:00', 110000, 'Delivered', N'654 Đường Lý Thường Kiệt, Quận 11, TP.HCM', '0902468135', 'Cash', N''),
(8, '2025-03-08 18:20:00', 145000, 'Delivered', N'987 Đường Nguyễn Thị Minh Khai, Quận 3, TP.HCM', '0901357924', 'Card', N'Không đồ chua'),
-- Đơn hàng mới nhất
(3, '2025-03-16 12:00:00', 180000, 'Delivered', N'456 Đường Lê Lợi, Quận 1, TP.HCM', '0901234567', 'Cash', N''),
(5, '2025-03-17 13:30:00', 140000, 'Delivering', N'123 Đường Trần Hưng Đạo, Quận 5, TP.HCM', '0907654321', 'Card', N'Giao tận nơi'),
(6, '2025-03-18 14:15:00', 175000, 'Confirmed', N'456 Đường Võ Văn Tần, Quận 3, TP.HCM', '0903214567', 'Cash', N''),
(4, '2025-03-18 15:40:00', 195000, 'Pending', N'789 Đường Nguyễn Huệ, Quận 1, TP.HCM', '0909876543', 'Card', N'Gọi trước khi giao 15 phút'),
(7, '2025-03-18 18:20:00', 155000, 'Pending', N'654 Đường Lý Thường Kiệt, Quận 11, TP.HCM', '0902468135', 'Cash', N'');

-- Thêm dữ liệu mẫu vào bảng OrderDetails
INSERT INTO OrderDetails (OrderID, FoodID, Quantity, UnitPrice)
VALUES 
-- Đơn hàng 1
(1, 1, 1, 45000), -- Cơm Sườn
(1, 17, 2, 35000), -- Trà Sữa Trân Châu
(1, 31, 1, 45000), -- Chả Giò

-- Đơn hàng 2
(2, 7, 2, 55000), -- Phở Bò Tái
(2, 18, 1, 25000), -- Cà Phê Đen

-- Đơn hàng 3
(3, 27, 1, 30000), -- Bánh Mì Thịt
(3, 17, 1, 35000), -- Trà Sữa Trân Châu
(3, 36, 1, 30000), -- Chè Thái

-- Đơn hàng 4
(4, 5, 1, 60000), -- Cơm Tấm Sườn Bì Chả
(4, 10, 1, 65000), -- Phở Đặc Biệt
(4, 21, 1, 30000), -- Cà Phê Sữa

-- Đơn hàng 5
(5, 4, 1, 55000), -- Cơm Chiên Hải Sản
(5, 14, 1, 55000), -- Bún Thịt Nướng
(5, 22, 1, 35000), -- Sinh Tố Xoài
(5, 32, 1, 40000), -- Gỏi Cuốn

-- Đơn hàng 6
(6, 15, 1, 65000), -- Bún Đậu Mắm Tôm
(6, 25, 1, 60000), -- Mì Xào Hải Sản
(6, 29, 1, 40000), -- Bánh Mì Xíu Mại
(6, 23, 1, 40000), -- Sinh Tố Bơ
(6, 37, 1, 25000), -- Bánh Flan

-- Đơn hàng 7
(7, 13, 1, 55000), -- Bún Thịt Nướng
(7, 19, 1, 35000), -- Cà Phê Sữa
(7, 38, 1, 40000), -- Trái Cây Dĩa

-- Đơn hàng 8
(8, 6, 1, 55000), -- Cơm Rang Thịt Bò
(8, 33, 1, 50000), -- Gỏi Ngó Sen
(8, 24, 1, 35000), -- Nước Ép Cam
(8, 39, 1, 35000), -- Sữa Chua Nếp Cẩm

-- Đơn hàng 9
(9, 10, 1, 65000), -- Phở Đặc Biệt
(9, 31, 1, 45000), -- Chả Giò
(9, 32, 1, 40000), -- Gỏi Cuốn
(9, 21, 1, 30000), -- Cà Phê Sữa

-- Đơn hàng 10
(10, 3, 1, 50000), -- Cơm Chiên Dương Châu
(10, 16, 1, 55000), -- Bún Cá
(10, 24, 1, 35000), -- Nước Ép Cam

-- Đơn hàng 11
(11, 5, 1, 60000), -- Cơm Tấm Sườn Bì Chả
(11, 25, 1, 60000), -- Mì Xào Hải Sản
(11, 22, 1, 35000), -- Sinh Tố Xoài
(11, 36, 1, 30000), -- Chè Thái

-- Đơn hàng 12
(12, 4, 1, 55000), -- Cơm Chiên Hải Sản
(12, 9, 1, 50000), -- Phở Gà
(12, 26, 1, 55000), -- Mì Hoành Thánh
(12, 24, 1, 35000), -- Nước Ép Cam

-- Đơn hàng 13
(13, 11, 1, 60000), -- Phở Nam Vang
(13, 14, 1, 55000), -- Bún Thịt Nướng
(13, 26, 1, 40000), -- Bánh Mì Xíu Mại
(13, 25, 1, 30000); -- Nước Ép Dưa Hấu

-- Thêm dữ liệu mẫu vào bảng Ratings
INSERT INTO Ratings (OrderID, UserID, Rating, Comment, RatingDate)
VALUES 
-- Đánh giá cho đơn hàng đã giao
(1, 3, 5, N'Đồ ăn rất ngon, giao hàng nhanh chóng và đúng giờ!', '2025-02-15 14:30:00'),
(2, 4, 4, N'Thức ăn ngon, nhưng giao hơi muộn một chút.', '2025-02-16 20:15:00'),
(3, 5, 3, N'Đồ ăn bình thường, giao hàng đúng giờ.', '2025-02-17 16:00:00'),
(4, 6, 5, N'Rất hài lòng với đồ ăn và dịch vụ giao hàng.', '2025-02-18 21:00:00'),
(5, 3, 4, N'Đồ ăn ngon, giao hàng nhanh.', '2025-03-01 15:00:00'),
(6, 4, 5, N'Xuất sắc! Sẽ đặt lại.', '2025-03-02 22:00:00'),
(7, 7, 4, N'Đồ ăn ngon, giá cả hợp lý.', '2025-03-05 14:30:00'),
(8, 8, 5, N'Thức ăn rất ngon, giao hàng đúng giờ.', '2025-03-08 20:00:00'),
(9, 3, 4, N'Đồ ăn ngon, giao hàng nhanh chóng.', '2025-03-16 14:00:00');

-- Dữ liệu mẫu cho giỏ hàng đã lưu
INSERT INTO SavedCarts (UserID, FoodID, Quantity, SavedDate)
VALUES
-- Giỏ hàng của user3
(3, 1, 1, GETDATE()),  -- Cơm Sườn
(3, 17, 2, GETDATE()), -- Trà Sữa Trân Châu

-- Giỏ hàng của user3
(3, 1, 1, GETDATE()),  -- Cơm Sườn
(3, 17, 2, GETDATE()), -- Trà Sữa Trân Châu

-- Giỏ hàng của user4
(4, 7, 1, GETDATE()),   -- Phở Bò Tái
(4, 18, 1, GETDATE()),  -- Cà Phê Đen
(4, 32, 2, GETDATE()),  -- Gỏi Cuốn

-- Giỏ hàng của user5
(5, 13, 1, GETDATE()),  -- Bún Thịt Nướng
(5, 23, 1, GETDATE()),  -- Sinh Tố Bơ
(5, 37, 2, GETDATE()),  -- Bánh Flan

-- Giỏ hàng của user6
(6, 5, 1, GETDATE()),   -- Cơm Tấm Sườn Bì Chả
(6, 24, 2, GETDATE()),  -- Nước Ép Cam

-- Giỏ hàng của user7
(7, 29, 1, GETDATE()),  -- Bánh Mì Xíu Mại
(7, 33, 1, GETDATE()),  -- Gỏi Ngó Sen
(7, 21, 1, GETDATE());  -- Cà Phê Sữa

GO




