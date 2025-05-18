--1. Aggregation with COUNT and GROUP BY: Bookings per User
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    COUNT(b.booking_id) AS total_bookings
FROM 
    users u
LEFT JOIN 
    bookings b ON u.user_id = b.user_id
GROUP BY 
    u.user_id, u.first_name, u.last_name, u.email
ORDER BY 
    total_bookings DESC;


--2. Window Function: Ranking Properties by Bookings
SELECT 
    p.property_id,
    p.property_name,
    p.address,
    COUNT(b.booking_id) AS total_bookings,
    ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
FROM 
    properties p
LEFT JOIN 
    bookings b ON p.property_id = b.property_id
GROUP BY 
    p.property_id, p.property_name, p.address
ORDER BY 
    booking_rank;


--Option 1: Using ROW_NUMBER()
SELECT 
    p.property_id,
    p.property_name,
    p.address,
    COUNT(b.booking_id) AS total_bookings,
    ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
FROM 
    properties p
LEFT JOIN 
    bookings b ON p.property_id = b.property_id
GROUP BY 
    p.property_id, p.property_name, p.address
ORDER BY 
    booking_rank;

--Option 2: Using RANK()
SELECT 
    p.property_id,
    p.property_name,
    p.address,
    COUNT(b.booking_id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
FROM 
    properties p
LEFT JOIN 
    bookings b ON p.property_id = b.property_id
GROUP BY 
    p.property_id, p.property_name, p.address
ORDER BY 
    booking_rank;

--Option 3: Using DENSE_RANK()
SELECT 
    p.property_id,
    p.property_name,
    p.address,
    COUNT(b.booking_id) AS total_bookings,
    DENSE_RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
FROM 
    properties p
LEFT JOIN 
    bookings b ON p.property_id = b.property_id
GROUP BY 
    p.property_id, p.property_name, p.address
ORDER BY 
    booking_rank;