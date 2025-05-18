--1. Non-Correlated Subquery: Properties with average rating > 4.0
SELECT 
    p.property_id,
    p.property_name,
    p.address
FROM 
    properties p
WHERE 
    p.property_id IN (
        -- Non-correlated subquery: finds property IDs with avg rating > 4
        SELECT 
            r.property_id
        FROM 
            reviews r
        GROUP BY 
            r.property_id
        HAVING 
            AVG(r.rating) > 4.0
    );


--2. Correlated Subquery: Users with more than 3 bookings
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM 
    users u
WHERE 
    -- Correlated subquery: references outer query's u.user_id
    (
        SELECT 
            COUNT(*)
        FROM 
            bookings b
        WHERE 
            b.user_id = u.user_id  -- Correlation to outer query
    ) > 3;