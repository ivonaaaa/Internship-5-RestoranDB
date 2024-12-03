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

CREATE TABLE MenusDishes (
	MenuDishes SERIAL PRIMARY KEY,
	MenuID INT REFERENCES Menus(MenuID),
	DishID INT REFERENCES Dishes(DishID),
	UNIQUE (MenuID, DishID)
)

CREATE TABLE Guests (
	GuestID SERIAL PRIMARY KEY
)

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

CREATE TABLE OrdersDishes (
	OrderItemID SERIAL PRIMARY KEY,
	OrderID INT REFERENCES Orders(OrderID),
	DishID INT REFERENCES Dishes(DishID),
	Quantity INT NOT NULL CHECK (Quantity > 0)
)

CREATE TABLE Staff (
	StuffID SERIAL PRIMARY KEY,
	Role VARCHAR(50) NOT NULL CHECK (Role IN('Kuhar', 'Konobar', 'Dostavljač')),
	Age INT NOT NULL CHECK (NOT (Role = 'Kuhar' AND Age < 18)),
	DrivingLicence BOOLEAN DEFAULT FALSE CHECK (NOT (Role = 'Dostavljač' AND DrivingLicence = FALSE)),
	RestaurantID INT REFERENCES Restaurants(RestaurantID)
)

CREATE TABLE Reviews (
	ReviewID SERIAL PRIMARY KEY,
	DeliveryRating INT CHECK (DeliveryRating BETWEEN 1 AND 5),
	DishRating INT CHECK (DishRating BETWEEN 1 AND 5),
	Comment TEXT,
	GuestID INT REFERENCES Guests(GuestID),
	DishID INT REFERENCES Dishes(DishID),
	OrderID INT REFERENCES Orders(OrderID)
)



