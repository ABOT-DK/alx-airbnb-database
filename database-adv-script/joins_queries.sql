
-- 1. INNER JOIN: Retrieve all bookings and their respective users
SELECT 
    b.booking_id,
    b.property_id,
    b.check_in_date,
    b.check_out_date,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM 
    bookings b
INNER JOIN 
    users u ON b.user_id = u.user_id;


--2. LEFT JOIN: Retrieve all properties and their reviews (including properties with no reviews)
SELECT 
    p.property_id,
    p.property_name,
    p.address,
    r.review_id,
    r.rating,
    r.comment,
    r.review_date
FROM 
    properties p
LEFT JOIN 
    reviews r ON p.property_id = r.property_id;
ORDER BY
    p.property_id



--3. FULL OUTER JOIN: Retrieve all users and all bookings (including unmatched records)
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    b.booking_id,
    b.property_id,
    b.check_in_date,
    b.check_out_date
FROM 
    users u
FULL OUTER JOIN 
    bookings b ON u.user_id = b.user_id;