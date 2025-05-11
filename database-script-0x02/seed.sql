-- Insert sample users
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)
VALUES 
  ('uuid-1', 'Alice', 'Smith', 'alice@example.com', 'hashed_pw1', '1234567890', 'guest', CURRENT_TIMESTAMP),
  ('uuid-2', 'Bob', 'Johnson', 'bob@example.com', 'hashed_pw2', '2345678901', 'host', CURRENT_TIMESTAMP),
  ('uuid-3', 'Carol', 'Lee', 'carol@example.com', 'hashed_pw3', NULL, 'admin', CURRENT_TIMESTAMP);

-- Insert sample properties
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight, created_at, updated_at)
VALUES 
  ('prop-1', 'uuid-2', 'Beach House', 'A house by the beach', 'California', 150.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('prop-2', 'uuid-2', 'Mountain Cabin', 'A cozy cabin in the mountains', 'Colorado', 200.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insert sample bookings
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
VALUES 
  ('book-1', 'prop-1', 'uuid-1', '2025-06-01', '2025-06-05', 600.00, 'confirmed', CURRENT_TIMESTAMP),
  ('book-2', 'prop-2', 'uuid-1', '2025-07-10', '2025-07-15', 1000.00, 'pending', CURRENT_TIMESTAMP);

-- Insert sample payments
INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method)
VALUES 
  ('pay-1', 'book-1', 600.00, CURRENT_TIMESTAMP, 'credit_card');

-- Insert sample reviews
INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at)
VALUES 
  ('rev-1', 'prop-1', 'uuid-1', 5, 'Amazing place! Very clean and great host.', CURRENT_TIMESTAMP);

-- Insert sample messages
INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at)
VALUES 
  ('msg-1', 'uuid-1', 'uuid-2', 'Hi, I’d like to know if early check-in is possible?', CURRENT_TIMESTAMP),
  ('msg-2', 'uuid-2', 'uuid-1', 'Sure, you can check in by noon.', CURRENT_TIMESTAMP);
