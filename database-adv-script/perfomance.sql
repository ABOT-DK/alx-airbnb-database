--Query Performance Optimization
--Performance Analysis
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.property_name,
    p.address,
    p.price_per_night,
    py.payment_id,
    py.amount,
    py.payment_date,
    py.payment_method
FROM 
    bookings b
JOIN 
    users u ON b.user_id = u.user_id
JOIN 
    properties p ON b.property_id = p.property_id
LEFT JOIN 
    payments py ON b.booking_id = py.booking_id
ORDER BY 
    b.booking_id DESC;


--Optimized Query
-- Optimized Query
SELECT 
    b.booking_id,
    u.user_id,
    u.first_name,
    u.last_name,
    p.property_id,
    p.property_name,
    p.price_per_night,
    py.amount,
    py.payment_method
FROM 
    bookings b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments py ON b.booking_id = py.booking_id
WHERE 
    b.created_at > CURRENT_DATE - INTERVAL '6 months'
    AND b.status = 'confirmed'
ORDER BY 
    b.booking_id DESC
LIMIT 1000;

-- EXPLAIN ANALYZE
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    u.user_id,
    u.first_name,
    u.last_name,
    p.property_id,
    p.property_name,
    p.price_per_night,
    py.amount,
    py.payment_method
FROM 
    bookings b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments py ON b.booking_id = py.booking_id
WHERE 
    b.created_at > CURRENT_DATE - INTERVAL '6 months'
    AND b.status = 'confirmed'
ORDER BY 
    b.booking_id DESC
LIMIT 1000;

--Supporting Indexes
-- Add these to your database_index.sql
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_created_at ON bookings(created_at);
CREATE INDEX idx_payments_booking_id ON payments(booking_id);





--Initial Query
-- Initial inefficient query
SELECT 
    b.booking_id,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.property_name,
    p.address,
    p.price_per_night,
    py.payment_id,
    py.amount,
    py.payment_date,
    py.payment_method
FROM 
    bookings b
JOIN 
    users u ON b.user_id = u.user_id
JOIN 
    properties p ON b.property_id = p.property_id
LEFT JOIN 
    payments py ON b.booking_id = py.booking_id
ORDER BY 
    b.booking_id DESC;
