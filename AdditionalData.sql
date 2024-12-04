-- added so there would be data shown in query task 3.
INSERT INTO Staff (StaffID, Role, Age, DrivingLicence, RestaurantID)
VALUES (1501, 'Dostavljač', 32, TRUE, 1);

DO $$ 
DECLARE 
    i INT := 1001;
    current_date DATE := CURRENT_DATE;
BEGIN
    WHILE i <= 1103 LOOP
        INSERT INTO Orders (OrderID, OrderType, TotalAmount, DeliveryTime, RestaurantID, GuestID, StaffID)
        VALUES (i, 'Dostava', 20.00, current_date, 1, 1, 1501);

        INSERT INTO OrdersDishes (OrderItemID, OrderID, DishID, Quantity)
        VALUES (i + 1000, i, 1, 1);

        i := i + 1;
    END LOOP;
END $$;

-- added so there would be data shown in query task 6.
INSERT INTO Dishes (DishID, Name, Category, Price, Calories, IsAvailable)
VALUES (502, 'Chocolate Cake', 'Desserts', 5.00, 350, TRUE);

INSERT INTO Orders (OrderID, OrderType, TotalAmount, DeliveryTime, RestaurantID, GuestID)
VALUES (1001, 'Dostava', 15.00, '2023-12-05 14:00:00', 1, 1);

INSERT INTO OrdersDishes (OrderItemID, OrderID, DishID, Quantity)
VALUES (1001, 1001, 502, 1),
       (1002, 1001, 502, 1),
       (1003, 1001, 502, 1),
       (1004, 1001, 502, 1),
       (1005, 1001, 502, 1),
       (1006, 1001, 502, 1),
       (1007, 1001, 502, 1),
       (1008, 1001, 502, 1),
       (1009, 1001, 502, 1),
       (1010, 1001, 502, 1),
	   (1011, 1001, 502, 1);