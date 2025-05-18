--Database Index Creation Script
-- Users Table Indexes
CREATE INDEX idx_users_user_id ON users(user_id); -- Primary key (likely already indexed)
CREATE INDEX idx_users_email ON users(email); -- For login queries
CREATE INDEX idx_users_last_name ON users(last_name); -- For name searches

-- Bookings Table Indexes
CREATE INDEX idx_bookings_booking_id ON bookings(booking_id); -- Primary key
CREATE INDEX idx_bookings_user_id ON bookings(user_id); -- Foreign key to users
CREATE INDEX idx_bookings_property_id ON bookings(property_id); -- Foreign key to properties
CREATE INDEX idx_bookings_check_in_date ON bookings(check_in_date); -- For date range queries
CREATE INDEX idx_bookings_status ON bookings(status); -- For status filtering
CREATE INDEX idx_bookings_user_property ON bookings(user_id, property_id); -- Composite index

-- Properties Table Indexes
CREATE INDEX idx_properties_property_id ON properties(property_id); -- Primary key
CREATE INDEX idx_properties_location ON properties(location); -- For location searches
CREATE INDEX idx_properties_price ON properties(price); -- For price filtering/sorting
CREATE INDEX idx_properties_rating ON properties(average_rating); -- For rating filtering/sorting
CREATE INDEX idx_properties_location_price ON properties(location, price); -- Composite index

--Performance Measurement
--Before Adding Indexes
-- Example query to test
EXPLAIN ANALYZE
SELECT u.user_id, u.first_name, u.last_name, COUNT(b.booking_id) AS total_bookings
FROM users u
LEFT JOIN bookings b ON u.user_id = b.user_id
WHERE u.last_name LIKE 'Smith%'
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY total_bookings DESC;

--After Adding Indexes
-- Run the same query after creating indexes
EXPLAIN ANALYZE
SELECT u.user_id, u.first_name, u.last_name, COUNT(b.booking_id) AS total_bookings
FROM users u
LEFT JOIN bookings b ON u.user_id = b.user_id
WHERE u.last_name LIKE 'Smith%'
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY total_bookings DESC;