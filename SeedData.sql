COPY Restaurants(RestaurantID, Name, City, Capacity, WorkingHours)
FROM 'C:\Users\Public\Documents\Seeds\Restaurants.csv'
DELIMITER ','
CSV HEADER

COPY Menus(MenuID, RestaurantID)
FROM 'C:\Users\Public\Documents\Seeds\Menus.csv'
DELIMITER ','
CSV HEADER

COPY Dishes(DishID, Name, Category, Price, Calories, IsAvailable)
FROM 'C:\Users\Public\Documents\Seeds\Dishes.csv'
DELIMITER ','
CSV HEADER

COPY MenusDishes(MenuDishesID, MenuID, DishID)
FROM 'C:\Users\Public\Documents\Seeds\MenusDishes.csv'
DELIMITER ','
CSV HEADER

COPY Guests(GuestID, Name, Surname)
FROM 'C:\Users\Public\Documents\Seeds\Guests.csv'
DELIMITER ','
CSV HEADER

COPY LoyaltyCards(LoyaltyCardID, GuestID)
FROM 'C:\Users\Public\Documents\Seeds\LoyaltyCards.csv'
DELIMITER ','
CSV HEADER

COPY Orders(OrderID, OrderType, Adress, TotalAmount, DeliveryTime, GuestNote, RestaurantID, GuestID, StaffID)
FROM 'C:\Users\Public\Documents\Seeds\Orders.csv'
DELIMITER ','
CSV HEADER

COPY OrdersDishes(OrderItemID, OrderID, DishID, Quantity)
FROM 'C:\Users\Public\Documents\Seeds\OrdersDishes.csv'
DELIMITER ','
CSV HEADER

COPY Staff(StaffID, Role, Age, DrivingLicence, RestaurantID)
FROM 'C:\Users\Public\Documents\Seeds\Staff.csv'
DELIMITER ','
CSV HEADER

COPY Reviews(ReviewID, DeliveryRating, DishRating, Comment, GuestID, DishID, OrderID)
FROM 'C:\Users\Public\Documents\Seeds\Reviews.csv'
DELIMITER ','
CSV HEADER