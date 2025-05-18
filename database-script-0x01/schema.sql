-- Create the User table
CREATE TABLE User (
    user_id UUID PRIMARY KEY, -- Primary Key
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    email VARCHAR UNIQUE NOT NULL, -- Unique constraint on email
    password_hash VARCHAR NOT NULL,
    phone_number VARCHAR,
    role ENUM('guest', 'host', 'admin') NOT NULL, -- ENUM for user roles
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the Property table
CREATE TABLE Property (
    property_id UUID PRIMARY KEY, -- Primary Key
    host_id UUID NOT NULL, -- Foreign Key references User(user_id)
    name VARCHAR NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR NOT NULL,
    pricepernight DECIMAL NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (host_id) REFERENCES User(user_id) -- Foreign Key constraint
);

-- Create an index on the host_id for faster queries
CREATE INDEX idx_host_id ON Property (host_id);

-- Create the Booking table
CREATE TABLE Booking (
    booking_id UUID PRIMARY KEY, -- Primary Key
    property_id UUID NOT NULL, -- Foreign Key references Property(property_id)
    user_id UUID NOT NULL, -- Foreign Key references User(user_id)
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL, -- Enum for booking status
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES Property(property_id), -- Foreign Key constraint
    FOREIGN KEY (user_id) REFERENCES User(user_id) -- Foreign Key constraint
);

-- Create indexes for property_id and user_id for optimized query performance
CREATE INDEX idx_property_id ON Booking (property_id);
CREATE INDEX idx_user_id ON Booking (user_id);

-- Create the Payment table
CREATE TABLE Payment (
    payment_id UUID PRIMARY KEY, -- Primary Key
    booking_id UUID NOT NULL, -- Foreign Key references Booking(booking_id)
    amount DECIMAL NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method ENUM('credit_card', 'paypal', 'stripe') NOT NULL, -- Enum for payment methods
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id) -- Foreign Key constraint
);

-- Create an index on booking_id for optimized query performance
CREATE INDEX idx_booking_id ON Payment (booking_id);

-- Create the Review table
CREATE TABLE Review (
    review_id UUID PRIMARY KEY, -- Primary Key
    property_id UUID NOT NULL, -- Foreign Key references Property(property_id)
    user_id UUID NOT NULL, -- Foreign Key references User(user_id)
    rating INTEGER CHECK (rating >= 1 AND rating <= 5) NOT NULL, -- Check constraint on rating values
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES Property(property_id), -- Foreign Key constraint
    FOREIGN KEY (user_id) REFERENCES User(user_id) -- Foreign Key constraint
);

-- Create indexes for property_id and user_id for optimized query performance
CREATE INDEX idx_property_id_review ON Review (property_id);
CREATE INDEX idx_user_id_review ON Review (user_id);

-- Create the Message table
CREATE TABLE Message (
    message_id UUID PRIMARY KEY, -- Primary Key
    sender_id UUID NOT NULL, -- Foreign Key references User(user_id)
    recipient_id UUID NOT NULL, -- Foreign Key references User(user_id)
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES User(user_id), -- Foreign Key constraint
    FOREIGN KEY (recipient_id) REFERENCES User(user_id) -- Foreign Key constraint
);

-- Create indexes for sender_id and recipient_id for optimized query performance
CREATE INDEX idx_sender_id ON Message (sender_id);
CREATE INDEX idx_recipient_id ON Message (recipient_id);

