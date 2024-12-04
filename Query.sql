--1
SELECT * FROM Dishes
WHERE Price < 15

--2
SELECT * FROM Orders
WHERE EXTRACT(YEAR FROM DeliveryTime) = 2023
AND TotalAmount > 50

--3
SELECT 
    s.StaffID, 
    s.Role, 
    r.Name AS RestaurantName, 
    r.City, 
    COUNT(o.OrderID) AS Deliveries
FROM Orders o
JOIN Staff s ON o.StaffID = s.StaffID
JOIN Restaurants r ON o.RestaurantID = r.RestaurantID
WHERE o.OrderType = 'Dostava' AND s.Role = 'Dostavljač'
GROUP BY s.StaffID, s.Role, r.Name, r.City
HAVING COUNT(o.OrderID) > 100;

--4
SELECT 
    s.StaffID, 
    r.Name AS RestaurantName, 
    r.City
FROM Staff s
JOIN Restaurants r ON s.RestaurantID = r.RestaurantID
WHERE s.Role = 'Kuhar' AND r.City = 'Zagreb';

--5
SELECT
	r.RestaurantID,
	r.Name,
	r.City,
	COUNT(o.OrderID) AS OrderCount
FROM Orders o
JOIN Restaurants r ON o.RestaurantID = r.RestaurantID
WHERE r.City = 'Split' AND EXTRACT(YEAR FROM o.DeliveryTime) = 2023
GROUP BY r.RestaurantID;

--6
SELECT Dishes.Name, SUM(OrdersDishes.Quantity) AS TotalOrders
FROM Dishes
JOIN OrdersDishes ON Dishes.DishID = OrdersDishes.DishID
JOIN Orders ON OrdersDishes.OrderID = Orders.OrderID
WHERE Dishes.Category = 'Desserts' 
  AND EXTRACT(MONTH FROM Orders.DeliveryTime) = 12 
  AND EXTRACT(YEAR FROM Orders.DeliveryTime) = 2023
GROUP BY Dishes.DishID
HAVING SUM(OrdersDishes.Quantity) > 10;

--7
SELECT g.GuestID, g.Name, g.Surname, COUNT(o.OrderID) AS OrderCount
FROM Orders o
JOIN Guests g ON o.GuestID = g.GuestID
WHERE g.Surname LIKE 'M%'
GROUP BY g.GuestID, g.Name, g.Surname;

--8
SELECT 
    r.RestaurantID, 
    r.Name AS RestaurantName,
	COUNT(rv.DeliveryRating) AS DeliveryRatingCount,
    AVG(rv.DeliveryRating) AS AvgDeliveryRating,
	COUNT(rv.DishRating) AS DishRatingCount,
    AVG(rv.DishRating) AS AvgDishRating
FROM Reviews rv
JOIN Orders o ON rv.OrderID = o.OrderID
JOIN Restaurants r ON o.RestaurantID = r.RestaurantID
WHERE r.City = 'Rijeka'
GROUP BY r.RestaurantID, r.Name;

--9
SELECT * 
FROM Restaurants
WHERE Capacity > 30 AND RestaurantID IN (
    SELECT DISTINCT RestaurantID
    FROM Orders
    WHERE OrderType = 'Dostava'
);

--10
DELETE FROM MenusDishes
WHERE DishID IN (
    SELECT DishID
    FROM Dishes
    WHERE DishID NOT IN (
        SELECT DISTINCT DishID
        FROM OrdersDishes
        JOIN Orders ON OrdersDishes.OrderID = Orders.OrderID
        WHERE EXTRACT(YEAR FROM Orders.DeliveryTime) >= EXTRACT(YEAR FROM CURRENT_DATE) - 2
    )
);

--11
DELETE FROM LoyaltyCards
WHERE GuestID IN (
    SELECT GuestID
    FROM Guests
    WHERE GuestID NOT IN (
        SELECT DISTINCT GuestID
        FROM Orders
        JOIN OrdersDishes ON Orders.OrderID = OrdersDishes.OrderID
        WHERE EXTRACT(YEAR FROM Orders.DeliveryTime) >= EXTRACT(YEAR FROM CURRENT_DATE) - 1
    )
);












