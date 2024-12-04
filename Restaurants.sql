CREATE TABLE Restaurants (
	RestaurantID SERIAL PRIMARY KEY,
	Name VARCHAR(50) NOT NULL,
	City VARCHAR(30) NOT NULL,
	Capacity INT NOT NULL CHECK (Capacity > 0),
	WorkingHours VARCHAR(50) NOT NULL
)

CREATE TABLE Menus (
	MenuID SERIAL PRIMARY KEY,
	RestaurantID INT REFERENCES Restaurants(RestaurantID)
)

CREATE TABLE Dishes ( 
	DishID SERIAL PRIMARY KEY,
	Name VARCHAR(50) NOT NULL,
	Category VARCHAR(30) NOT NULL CHECK (Category IN ('Predjelo', 'Glavno jelo', 'Desert')),
	Price DECIMAL(5, 2) NOT NULL CHECK (Price > 0),
	Calories INT NOT NULL CHECK (Calories > 0),
	IsAvailable BOOLEAN NOT NULL DEFAULT TRUE
)

ALTER TABLE Dishes DROP CONSTRAINT dishes_category_check

ALTER TABLE Dishes
ADD CONSTRAINT dishes_category_check
CHECK (Category IN ('Appetizers', 'Main Dish', 'Desserts'))

CREATE TABLE MenusDishes (
	MenuDishes SERIAL PRIMARY KEY,
	MenuID INT REFERENCES Menus(MenuID),
	DishID INT REFERENCES Dishes(DishID),
	UNIQUE (MenuID, DishID)
)

ALTER TABLE MenusDishes
RENAME COLUMN MenuDishes TO MenuDishesID

CREATE TABLE Guests (
	GuestID SERIAL PRIMARY KEY
)

ALTER TABLE Guests
ADD COLUMN Name VARCHAR(30),
ADD COLUMN Surname VARCHAR(30)

CREATE TABLE LoyaltyCards (
	LoyaltyCardID SERIAL PRIMARY KEY,
	GuestID INT REFERENCES Guests(GuestID)
)

CREATE TABLE Orders (
	OrderID SERIAL PRIMARY KEY,
	OrderType VARCHAR(20) NOT NULL CHECK (OrderType IN('Dostava', 'Nije dostava')),
	Adress VARCHAR(50),
	TotalAmount DECIMAL(5, 2) NOT NULL CHECK (TotalAmount > 0),
	DeliveryTime TIMESTAMP,
	GuestNote TEXT,
	RestaurantID INT REFERENCES Restaurants(RestaurantID),
	GuestID INT REFERENCES Guests(GuestID)
)

ALTER TABLE Orders
ADD COLUMN StaffID INT REFERENCES Staff(StaffID);

DO $$ 
DECLARE
    i INT := 1;
    staff_id INT := 1001;
BEGIN
    WHILE i <= 1000 LOOP
        UPDATE Orders
        SET StaffID = staff_id
        WHERE OrderID = i;

        i := i + 1;
    END LOOP;
END $$;
CREATE TABLE OrdersDishes (
	OrderItemID SERIAL PRIMARY KEY,
	OrderID INT REFERENCES Orders(OrderID),
	DishID INT REFERENCES Dishes(DishID),
	Quantity INT NOT NULL CHECK (Quantity > 0)
)

CREATE TABLE Staff (
	StuffID SERIAL PRIMARY KEY,
	Role VARCHAR(50) NOT NULL,
	Age INT NOT NULL CHECK (NOT (Role = 'Kuhar' AND Age < 18)),
	DrivingLicence BOOLEAN DEFAULT FALSE CHECK (NOT (Role = 'Dostavljač' AND DrivingLicence = FALSE)),
	RestaurantID INT REFERENCES Restaurants(RestaurantID)
)

ALTER TABLE Staff
RENAME COLUMN StuffID TO StaffID

ALTER TABLE Staff
DROP CONSTRAINT staff_check;

ALTER TABLE Staff
DROP CONSTRAINT staff_check1;

UPDATE Staff
SET Role = 'Kuhar'
WHERE Role = 'kuhar';

UPDATE Staff
SET Role = 'Konobar'
WHERE Role = 'konobar';

UPDATE Staff
SET Role = 'Dostavljač'
WHERE Role = 'dostavljač';

CREATE TABLE Reviews (
	ReviewID SERIAL PRIMARY KEY,
	DeliveryRating INT CHECK (DeliveryRating BETWEEN 1 AND 5),
	DishRating INT CHECK (DishRating BETWEEN 1 AND 5),
	Comment TEXT,
	GuestID INT REFERENCES Guests(GuestID),
	DishID INT REFERENCES Dishes(DishID),
	OrderID INT REFERENCES Orders(OrderID)
)