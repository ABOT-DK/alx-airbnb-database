## Explanation

### User Table

- `user_id` is the primary key with UUID data type.  
- `email` has a unique constraint to ensure no duplicate email addresses.  
- `role` is an ENUM type, restricting values to `'guest'`, `'host'`, or `'admin'`.  
- `created_at` is set to default to the current timestamp.  

### Property Table

- `property_id` is the primary key with UUID.  
- `host_id` is a foreign key referencing the `user_id` in the **User** table.  
- `created_at` and `updated_at` are timestamps, with the `updated_at` column automatically updated when a record is changed.  

### Booking Table

- `booking_id` is the primary key with UUID.  
- `property_id` and `user_id` are foreign keys, referencing the **Property** and **User** tables, respectively.  
- `status` is an ENUM field.  
- `total_price` is stored as a DECIMAL type.  

### Payment Table

- `payment_id` is the primary key with UUID.  
- `booking_id` is a foreign key referencing the **Booking** table.  
- `payment_method` is an ENUM with values `'credit_card'`, `'paypal'`, or `'stripe'`.  
- The `amount` and `payment_date` fields store the transaction details.  

### Review Table

- `review_id` is the primary key with UUID.  
- `property_id` and `user_id` are foreign keys referencing the **Property** and **User** tables, respectively.  
- `rating` is an integer with a constraint to ensure it is between 1 and 5.  

### Message Table

- `message_id` is the primary key with UUID.  
- `sender_id` and `recipient_id` are foreign keys referencing the **User** table for both sender and recipient.  
- `sent_at` is a timestamp for when the message was sent.  

### Indexes

- Indexes are created on foreign key columns (`host_id`, `property_id`, `user_id`, `booking_id`, `sender_id`, and `recipient_id`) to ensure fast lookups and improve query performance, especially for JOIN operations.
