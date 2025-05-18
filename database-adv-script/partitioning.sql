-- 1. Create partitioned table structure
CREATE TABLE bookings_partitioned (
    booking_id SERIAL,
    user_id INT NOT NULL,
    property_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (booking_id, start_date)
) PARTITION BY RANGE (start_date);

-- 2. Create monthly partitions for current and next year
CREATE TABLE bookings_y2023m01 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2023-01-01') TO ('2023-02-01');

CREATE TABLE bookings_y2023m02 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2023-02-01') TO ('2023-03-01');
    
-- ... create partitions for all required months ...

CREATE TABLE bookings_y2024m01 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2024-01-01') TO ('2024-02-01');

-- 3. Create default partition for future dates
CREATE TABLE bookings_future PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2024-02-01') TO (MAXVALUE);

-- 4. Migrate data from original table
INSERT INTO bookings_partitioned 
SELECT * FROM bookings;

-- 5. Create indexes on partitioned table
CREATE INDEX idx_part_booking_user ON bookings_partitioned(user_id);
CREATE INDEX idx_part_booking_property ON bookings_partitioned(property_id);
CREATE INDEX idx_part_booking_dates ON bookings_partitioned(start_date, end_date);

-- 6. Test query performance
EXPLAIN ANALYZE
SELECT * FROM bookings_partitioned
WHERE start_date BETWEEN '2023-06-01' AND '2023-06-30';