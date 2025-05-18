# SQL Index Optimization Plan

## 📌 High-Usage Columns Identified

### **Users Table**
| Column | Usage Pattern |
|--------|--------------|
| `user_id` | Primary key, JOIN operations |
| `email` | WHERE clauses (authentication) |
| `last_name` | Search filters, ORDER BY |

### **Bookings Table**  
| Column | Usage Pattern |
|--------|--------------|
| `booking_id` | Primary key |
| `user_id` | Foreign key JOINs |
| `property_id` | Foreign key JOINs |
| `check_in_date` | Date range filters, sorting |
| `status` | WHERE clause filtering |

### **Properties Table**
| Column | Usage Pattern |
|--------|--------------|
| `property_id` | Primary key |
| `location` | Search filters |
| `price` | Range queries, sorting |
| `average_rating` | Quality filtering, sorting |

## 🛠️ Index Creation Script (`database_index.sql`)

```sql
-- USERS TABLE INDEXES
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_last_name ON users(last_name);

-- BOOKINGS TABLE INDEXES 
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_check_in_date ON bookings(check_in_date);
CREATE INDEX idx_bookings_status ON bookings(status);
CREATE INDEX idx_bookings_user_property ON bookings(user_id, property_id);

-- PROPERTIES TABLE INDEXES
CREATE INDEX idx_properties_location ON properties(location);
CREATE INDEX idx_properties_price ON properties(price);
CREATE INDEX idx_properties_rating ON properties(average_rating);
CREATE INDEX idx_properties_location_price ON properties(location, price);
```

## ⏱️ Performance Measurement Protocol
*Before Index Implementation*
```sql
EXPLAIN ANALYZE
SELECT u.user_id, u.first_name, COUNT(b.booking_id) 
FROM users u
LEFT JOIN bookings b ON u.user_id = b.user_id
WHERE u.last_name LIKE 'A%'
GROUP BY u.user_id, u.first_name;
```
*After Index Implementation*
```sql
-- Re-run same query after index creation
EXPLAIN ANALYZE
SELECT u.user_id, u.first_name, COUNT(b.booking_id) 
FROM users u
LEFT JOIN bookings b ON u.user_id = b.user_id
WHERE u.last_name LIKE 'A%'
GROUP BY u.user_id, u.first_name;
```
## 📈 Expected Performance Improvements

### **JOIN Operations**
| Index Applied | Performance Gain |
|--------------|------------------|
| `idx_bookings_user_id` | 70-90% faster JOINs between users/bookings |
| `idx_bookings_property_id` | 60-85% faster property-related queries |

### **Filtering (WHERE Clauses)**
| Query Filter | Without Index | With Index | Improvement |
|-------------|--------------|------------|-------------|
| `last_name LIKE 'A%'` | Sequential Scan | Index Range Scan | 8-12x faster |
| `status = 'confirmed'` | Full Table Scan | Bitmap Index Scan | 10-15x faster |
| `price BETWEEN 100 AND 200` | O(n) Linear Search | O(log n) Binary Search | 20-50x faster |

### **Sorting (ORDER BY)**
| Sort Column | Unindexed Performance | Indexed Performance |
|------------|----------------------|---------------------|
| `check_in_date DESC` | 500ms (10k rows) | 50ms (10k rows) |
| `average_rating` | Requires filesort | Presorted results |

### **Composite Queries**
| Query Pattern | Optimization |
|--------------|-------------|
| `WHERE location='Paris' ORDER BY price` | `idx_properties_location_price` enables single-pass execution |
| `user_id=5 AND status='active'` | Composite index cuts search space exponentially |

### **Benchmark Metrics**
```sql
-- Sample benchmark query
EXPLAIN ANALYZE 
SELECT * FROM bookings 
WHERE user_id = 100 AND status = 'confirmed';
```