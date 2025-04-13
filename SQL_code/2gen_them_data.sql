-- Thêm dữ liệu đơn hàng theo năm (2022-2023)
USE FoodOrderDB;
GO

-- Thêm đơn hàng năm 2022
INSERT INTO Orders (UserID, OrderDate, TotalAmount, Status, DeliveryAddress, PhoneNumber, PaymentMethod, Notes)
VALUES 
-- Quý 1/2022
(3, '2022-01-15 12:30:00', 110000, 'Delivered', N'456 Đường Lê Lợi, Quận 1, TP.HCM', '0901234567', 'Cash', N''),
(4, '2022-03-10 14:10:00', 175000, 'Delivered', N'789 Đường Nguyễn Huệ, Quận 1, TP.HCM', '0909876543', 'Card', N''),

-- Quý 2/2022
(5, '2022-05-05 13:00:00', 165000, 'Delivered', N'123 Đường Trần Hưng Đạo, Quận 5, TP.HCM', '0907654321', 'Cash', N''),
(6, '2022-06-10 19:15:00', 185000, 'Delivered', N'456 Đường Võ Văn Tần, Quận 3, TP.HCM', '0903214567', 'Cash', N''),

-- Quý 3/2022
(7, '2022-07-12 18:20:00', 145000, 'Delivered', N'654 Đường Lý Thường Kiệt, Quận 11, TP.HCM', '0902468135', 'Cash', N''),
(8, '2022-09-05 17:15:00', 195000, 'Delivered', N'987 Đường Nguyễn Thị Minh Khai, Quận 3, TP.HCM', '0901357924', 'Card', N''),

-- Quý 4/2022
(3, '2022-11-08 19:30:00', 195000, 'Delivered', N'456 Đường Lê Lợi, Quận 1, TP.HCM', '0901234567', 'Cash', N''),
(4, '2022-12-25 15:40:00', 210000, 'Delivered', N'789 Đường Nguyễn Huệ, Quận 1, TP.HCM', '0909876543', 'Card', N'');

-- Thêm đơn hàng năm 2023
INSERT INTO Orders (UserID, OrderDate, TotalAmount, Status, DeliveryAddress, PhoneNumber, PaymentMethod, Notes)
VALUES 
-- Quý 1/2023
(5, '2023-02-05 14:20:00', 115000, 'Delivered', N'123 Đường Trần Hưng Đạo, Quận 5, TP.HCM', '0907654321', 'Cash', N''),
(6, '2023-03-08 13:10:00', 185000, 'Delivered', N'456 Đường Võ Văn Tần, Quận 3, TP.HCM', '0903214567', 'Card', N''),

-- Quý 2/2023
(7, '2023-04-07 12:45:00', 175000, 'Delivered', N'654 Đường Lý Thường Kiệt, Quận 11, TP.HCM', '0902468135', 'Cash', N''),
(8, '2023-06-11 19:15:00', 205000, 'Delivered', N'987 Đường Nguyễn Thị Minh Khai, Quận 3, TP.HCM', '0901357924', 'Card', N''),

-- Quý 3/2023
(3, '2023-08-12 13:30:00', 215000, 'Delivered', N'456 Đường Lê Lợi, Quận 1, TP.HCM', '0901234567', 'Cash', N''),
(4, '2023-09-08 17:15:00', 235000, 'Delivered', N'789 Đường Nguyễn Huệ, Quận 1, TP.HCM', '0909876543', 'Card', N''),

-- Quý 4/2023
(5, '2023-10-05 18:25:00', 195000, 'Delivered', N'123 Đường Trần Hưng Đạo, Quận 5, TP.HCM', '0907654321', 'Cash', N''),
(6, '2023-12-12 17:15:00', 255000, 'Delivered', N'456 Đường Võ Văn Tần, Quận 3, TP.HCM', '0903214567', 'Card', N'');

-- Thêm đơn hàng đầu năm 2024
INSERT INTO Orders (UserID, OrderDate, TotalAmount, Status, DeliveryAddress, PhoneNumber, PaymentMethod, Notes)
VALUES 
(3, '2024-01-10 12:30:00', 135000, 'Delivered', N'456 Đường Lê Lợi, Quận 1, TP.HCM', '0901234567', 'Cash', N''),
(4, '2024-02-07 18:45:00', 195000, 'Delivered', N'789 Đường Nguyễn Huệ, Quận 1, TP.HCM', '0909876543', 'Card', N'');

GO

-- Thêm chi tiết đơn hàng cho năm 2022
-- Lấy OrderID bắt đầu từ bảng Orders
DECLARE @OrderID2022 INT;
SELECT @OrderID2022 = (SELECT MIN(OrderID) FROM Orders WHERE YEAR(OrderDate) = 2022);

-- Thêm chi tiết cho đơn hàng 2022
INSERT INTO OrderDetails (OrderID, FoodID, Quantity, UnitPrice)
VALUES 
-- Đơn 1 (tháng 1/2022)
(@OrderID2022, 1, 1, 45000),
(@OrderID2022, 17, 1, 35000),
(@OrderID2022, 18, 1, 30000),

-- Đơn 2 (tháng 3/2022)
(@OrderID2022+1, 4, 1, 55000),
(@OrderID2022+1, 14, 1, 55000),
(@OrderID2022+1, 22, 1, 35000),
(@OrderID2022+1, 32, 1, 40000),

-- Đơn 3 (tháng 5/2022)
(@OrderID2022+2, 15, 1, 65000),
(@OrderID2022+2, 31, 1, 45000),
(@OrderID2022+2, 23, 1, 40000),
(@OrderID2022+2, 24, 1, 35000),

-- Đơn 4 (tháng 6/2022)
(@OrderID2022+3, 5, 1, 60000),
(@OrderID2022+3, 25, 1, 60000),
(@OrderID2022+3, 31, 1, 45000),
(@OrderID2022+3, 37, 1, 25000),

-- Đơn 5 (tháng 7/2022)
(@OrderID2022+4, 4, 1, 55000),
(@OrderID2022+4, 13, 1, 55000),
(@OrderID2022+4, 24, 1, 35000),

-- Đơn 6 (tháng 9/2022)
(@OrderID2022+5, 15, 1, 65000),
(@OrderID2022+5, 25, 1, 60000),
(@OrderID2022+5, 22, 2, 35000),

-- Đơn 7 (tháng 11/2022)
(@OrderID2022+6, 9, 1, 50000),
(@OrderID2022+6, 14, 1, 55000),
(@OrderID2022+6, 31, 1, 45000),
(@OrderID2022+6, 24, 1, 35000),
(@OrderID2022+6, 36, 1, 30000),

-- Đơn 8 (tháng 12/2022)
(@OrderID2022+7, 6, 1, 55000),
(@OrderID2022+7, 11, 1, 60000),
(@OrderID2022+7, 22, 1, 35000),
(@OrderID2022+7, 38, 1, 40000),
(@OrderID2022+7, 36, 1, 30000);

GO

-- Thêm chi tiết đơn hàng cho năm 2023
DECLARE @OrderID2023 INT;
SELECT @OrderID2023 = (SELECT MIN(OrderID) FROM Orders WHERE YEAR(OrderDate) = 2023);

INSERT INTO OrderDetails (OrderID, FoodID, Quantity, UnitPrice)
VALUES 
-- Đơn 1 (tháng 2/2023)
(@OrderID2023, 3, 1, 50000),
(@OrderID2023, 22, 1, 35000),
(@OrderID2023, 32, 1, 40000),
(@OrderID2023, 36, 1, 30000),

-- Đơn 2 (tháng 3/2023)
(@OrderID2023+1, 4, 1, 55000),
(@OrderID2023+1, 10, 1, 65000),
(@OrderID2023+1, 22, 1, 35000),
(@OrderID2023+1, 32, 1, 40000),

-- Đơn 3 (tháng 4/2023)
(@OrderID2023+2, 6, 1, 55000),
(@OrderID2023+2, 15, 1, 65000),
(@OrderID2023+2, 23, 1, 40000),
(@OrderID2023+2, 24, 1, 35000),

-- Đơn 4 (tháng 6/2023)
(@OrderID2023+3, 2, 1, 45000),
(@OrderID2023+3, 10, 1, 65000),
(@OrderID2023+3, 22, 1, 35000),
(@OrderID2023+3, 38, 1, 40000),
(@OrderID2023+3, 36, 1, 30000),

-- Đơn 5 (tháng 8/2023)
(@OrderID2023+4, 3, 1, 50000),
(@OrderID2023+4, 25, 1, 60000),
(@OrderID2023+4, 22, 1, 35000),
(@OrderID2023+4, 32, 1, 40000),
(@OrderID2023+4, 37, 1, 25000),
(@OrderID2023+4, 36, 1, 30000),

-- Đơn 6 (tháng 9/2023)
(@OrderID2023+5, 10, 1, 65000),
(@OrderID2023+5, 15, 1, 65000),
(@OrderID2023+5, 19, 1, 30000),
(@OrderID2023+5, 38, 1, 40000),
(@OrderID2023+5, 39, 1, 35000),

-- Đơn 7 (tháng 10/2023)
(@OrderID2023+6, 7, 1, 55000),
(@OrderID2023+6, 14, 1, 55000),
(@OrderID2023+6, 25, 1, 60000),
(@OrderID2023+6, 24, 1, 35000),
(@OrderID2023+6, 37, 1, 25000),

-- Đơn 8 (tháng 12/2023)
(@OrderID2023+7, 5, 1, 60000),
(@OrderID2023+7, 14, 1, 55000),
(@OrderID2023+7, 19, 1, 30000),
(@OrderID2023+7, 33, 1, 50000),
(@OrderID2023+7, 39, 1, 35000),
(@OrderID2023+7, 36, 1, 30000);

GO

-- Thêm chi tiết đơn hàng cho năm 2024
DECLARE @OrderID2024 INT;
SELECT @OrderID2024 = (SELECT MIN(OrderID) FROM Orders WHERE YEAR(OrderDate) = 2024);

INSERT INTO OrderDetails (OrderID, FoodID, Quantity, UnitPrice)
VALUES 
-- Đơn 1 (tháng 1/2024)
(@OrderID2024, 1, 1, 45000),
(@OrderID2024, 17, 1, 35000),
(@OrderID2024, 23, 1, 40000),
(@OrderID2024, 31, 1, 45000),

-- Đơn 2 (tháng 2/2024)
(@OrderID2024+1, 7, 1, 55000),
(@OrderID2024+1, 14, 1, 55000),
(@OrderID2024+1, 31, 1, 45000),
(@OrderID2024+1, 37, 1, 25000),
(@OrderID2024+1, 24, 1, 35000);

GO

-- Thêm vài đánh giá cho đơn hàng cũ
-- Lấy OrderID cho đơn hàng năm 2022
DECLARE @RatingOrderID2022 INT;
SELECT @RatingOrderID2022 = (SELECT MIN(OrderID) FROM Orders WHERE YEAR(OrderDate) = 2022);

-- Lấy OrderID cho đơn hàng năm 2023
DECLARE @RatingOrderID2023 INT;
SELECT @RatingOrderID2023 = (SELECT MIN(OrderID) FROM Orders WHERE YEAR(OrderDate) = 2023);

-- Thêm đánh giá
INSERT INTO Ratings (OrderID, UserID, Rating, Comment, RatingDate)
VALUES 
-- Đánh giá cho đơn hàng 2022
(@RatingOrderID2022, 3, 5, N'Đồ ăn rất ngon, giao hàng nhanh!', DATEADD(HOUR, 3, '2022-01-15 12:30:00')),
(@RatingOrderID2022+3, 6, 4, N'Món ăn ngon, giao hơi chậm một chút.', DATEADD(HOUR, 2, '2022-06-10 19:15:00')),
(@RatingOrderID2022+6, 3, 5, N'Rất hài lòng với chất lượng món ăn.', DATEADD(HOUR, 4, '2022-11-08 19:30:00')),

-- Đánh giá cho đơn hàng 2023
(@RatingOrderID2023+1, 6, 5, N'Tuyệt vời, sẽ đặt lại!', DATEADD(HOUR, 3, '2023-03-08 13:10:00')),
(@RatingOrderID2023+4, 3, 4, N'Thức ăn ngon, giao đúng giờ.', DATEADD(HOUR, 2, '2023-08-12 13:30:00')),
(@RatingOrderID2023+7, 6, 5, N'Xuất sắc! Đồ ăn ngon và phục vụ tốt.', DATEADD(HOUR, 4, '2023-12-12 17:15:00'));

GO