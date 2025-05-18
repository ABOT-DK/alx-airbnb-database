## Explanation of Sample SQL Data

### User Table
- Added 3 users with different roles: guest (Alice), host (Bob), and admin (Carol).
- Ensured emails are unique, and some users have optional phone numbers.

### Property Table
- Two properties added, both owned by Bob (host).
- Each property has a descriptive name, location, and price per night.

### Booking Table
- Alice made two bookings (one confirmed, one pending) on different properties.
- Total price is calculated based on duration and nightly rate.

### Payment Table
- A payment was made for a confirmed booking using a credit card.

### Review Table
- Alice left a 5-star review for one of the properties she booked.

### Message Table
- Demonstrates interaction between Alice (guest) and Bob (host) about the booking.
- Ensures both sender and recipient are valid users.

### Best Practices Followed
- UUIDs used for all primary keys.
- ENUM values used correctly (e.g., role, status, payment method).
- Timestamps for accurate logging of created/updated data.
- Foreign keys respected for relational integrity.
