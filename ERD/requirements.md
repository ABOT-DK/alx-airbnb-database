<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  
</head>
<body>

<h1>Entity-Relationship Diagram (ERD) and Normalization Analysis</h1>

<div class="section">
  <h2>User</h2>
  <table>
    <tr><th>Attribute</th><th>Type</th><th>Constraints</th></tr>
    <tr><td>user_id</td><td>UUID</td><td>Primary Key, Indexed</td></tr>
    <tr><td>first_name</td><td>VARCHAR</td><td>NOT NULL</td></tr>
    <tr><td>last_name</td><td>VARCHAR</td><td>NOT NULL</td></tr>
    <tr><td>email</td><td>VARCHAR</td><td>UNIQUE, NOT NULL</td></tr>
    <tr><td>password_hash</td><td>VARCHAR</td><td>NOT NULL</td></tr>
    <tr><td>phone_number</td><td>VARCHAR</td><td>NULL</td></tr>
    <tr><td>role</td><td>ENUM</td><td>(guest, host, admin), NOT NULL</td></tr>
    <tr><td>created_at</td><td>TIMESTAMP</td><td>DEFAULT CURRENT_TIMESTAMP</td></tr>
  </table>
</div>

<div class="section">
  <h2>Property</h2>
  <table>
    <tr><th>Attribute</th><th>Type</th><th>Constraints</th></tr>
    <tr><td>property_id</td><td>UUID</td><td>Primary Key, Indexed</td></tr>
    <tr><td>host_id</td><td>UUID</td><td>Foreign Key → User(user_id)</td></tr>
    <tr><td>name</td><td>VARCHAR</td><td>NOT NULL</td></tr>
    <tr><td>description</td><td>TEXT</td><td>NOT NULL</td></tr>
    <tr><td>location</td><td>VARCHAR</td><td>NOT NULL</td></tr>
    <tr><td>pricepernight</td><td>DECIMAL</td><td>NOT NULL</td></tr>
    <tr><td>created_at</td><td>TIMESTAMP</td><td>DEFAULT CURRENT_TIMESTAMP</td></tr>
    <tr><td>updated_at</td><td>TIMESTAMP</td><td>ON UPDATE CURRENT_TIMESTAMP</td></tr>
  </table>
</div>

<div class="section">
  <h2>Booking</h2>
  <table>
    <tr><th>Attribute</th><th>Type</th><th>Constraints</th></tr>
    <tr><td>booking_id</td><td>UUID</td><td>Primary Key, Indexed</td></tr>
    <tr><td>property_id</td><td>UUID</td><td>Foreign Key → Property(property_id)</td></tr>
    <tr><td>user_id</td><td>UUID</td><td>Foreign Key → User(user_id)</td></tr>
    <tr><td>start_date</td><td>DATE</td><td>NOT NULL</td></tr>
    <tr><td>end_date</td><td>DATE</td><td>NOT NULL</td></tr>
    <tr><td>total_price</td><td>DECIMAL</td><td>NOT NULL</td></tr>
    <tr><td>status</td><td>ENUM</td><td>(pending, confirmed, canceled)</td></tr>
    <tr><td>created_at</td><td>TIMESTAMP</td><td>DEFAULT CURRENT_TIMESTAMP</td></tr>
  </table>
</div>

<div class="section">
  <h2>Payment</h2>
  <table>
    <tr><th>Attribute</th><th>Type</th><th>Constraints</th></tr>
    <tr><td>payment_id</td><td>UUID</td><td>Primary Key, Indexed</td></tr>
    <tr><td>booking_id</td><td>UUID</td><td>Foreign Key → Booking(booking_id)</td></tr>
    <tr><td>amount</td><td>DECIMAL</td><td>NOT NULL</td></tr>
    <tr><td>payment_date</td><td>TIMESTAMP</td><td>DEFAULT CURRENT_TIMESTAMP</td></tr>
    <tr><td>payment_method</td><td>ENUM</td><td>(credit_card, paypal, stripe)</td></tr>
  </table>
</div>

<div class="section">
  <h2>Review</h2>
  <table>
    <tr><th>Attribute</th><th>Type</th><th>Constraints</th></tr>
    <tr><td>review_id</td><td>UUID</td><td>Primary Key, Indexed</td></tr>
    <tr><td>property_id</td><td>UUID</td><td>Foreign Key → Property(property_id)</td></tr>
    <tr><td>user_id</td><td>UUID</td><td>Foreign Key → User(user_id)</td></tr>
    <tr><td>rating</td><td>INTEGER</td><td>CHECK 1–5, NOT NULL</td></tr>
    <tr><td>comment</td><td>TEXT</td><td>NOT NULL</td></tr>
    <tr><td>created_at</td><td>TIMESTAMP</td><td>DEFAULT CURRENT_TIMESTAMP</td></tr>
  </table>
</div>

<div class="section">
  <h2>Message</h2>
  <table>
    <tr><th>Attribute</th><th>Type</th><th>Constraints</th></tr>
    <tr><td>message_id</td><td>UUID</td><td>Primary Key, Indexed</td></tr>
    <tr><td>sender_id</td><td>UUID</td><td>Foreign Key → User(user_id)</td></tr>
    <tr><td>recipient_id</td><td>UUID</td><td>Foreign Key → User(user_id)</td></tr>
    <tr><td>message_body</td><td>TEXT</td><td>NOT NULL</td></tr>
    <tr><td>sent_at</td><td>TIMESTAMP</td><td>DEFAULT CURRENT_TIMESTAMP</td></tr>
  </table>
</div>

<div class="section">
  <h2>Relationships Overview</h2>
  <ul>
    <li>User (1) → (M) Property via host_id</li>
    <li>User (1) → (M) Booking via user_id</li>
    <li>Property (1) → (M) Booking via property_id</li>
    <li>Booking (1) → (1) Payment via booking_id</li>
    <li>User (1) → (M) Review via user_id</li>
    <li>Property (1) → (M) Review via property_id</li>
    <li>User (1) → (M) Message (sender_id/recipient_id)</li>
  </ul>
</div>

</body>
</html>
