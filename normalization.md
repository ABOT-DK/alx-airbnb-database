# Database Schema Normalization Analysis

This document provides an analysis of the database schema and checks its conformance to the normalization principles: **1NF**, **2NF**, and **3NF**.

## 1. First Normal Form (1NF)

A table is in **1NF** if:
- All columns contain atomic values (no repeating groups or arrays).
- All entries in a column are of the same type.
- Each column has a unique name.

### Analysis:
- All attributes in the tables are **atomic**, with no repeating groups or arrays.
- Columns such as `first_name`, `last_name`, and `email` in the **User** table each contain a single piece of information.
- There are **no composite attributes** in the schema, ensuring compliance with **1NF**.

### Conclusion:
- The schema **complies with 1NF**.

---

## 2. Second Normal Form (2NF)

A table is in **2NF** if:
- It is in **1NF**.
- Every non-key attribute is **fully functionally dependent** on the **primary key** (no partial dependencies).

### Analysis:
- The **User** table has a primary key `user_id`, and all attributes (e.g., `first_name`, `last_name`, `email`) depend fully on `user_id`. No partial dependency exists.
- The **Property** table has a primary key `property_id`, and all attributes (e.g., `name`, `description`, `pricepernight`) depend fully on `property_id`.
- The **Booking** table has `booking_id` as the primary key, with all other attributes (e.g., `start_date`, `end_date`, `total_price`) dependent on it.
- The **Payment**, **Review**, and **Message** tables are similarly structured, where non-key attributes depend on the primary key.

### Conclusion:
- All tables comply with **2NF** as there are no partial dependencies.

---

## 3. Third Normal Form (3NF)

A table is in **3NF** if:
- It is in **2NF**.
- No non-key attribute is transitively dependent on the primary key (i.e., all non-key attributes are directly dependent on the primary key).

### Analysis:
- The **User** table does not have any non-key attributes dependent on other non-key attributes. For example, `role` depends directly on `user_id`.
- In the **Property** table, `host_id` is a foreign key that references `user_id` in the **User** table, but this does not introduce any transitive dependencies.
- The **Booking** table has no non-key attributes that depend on other non-key attributes. The `total_price` field, while calculated from `pricepernight` and duration, is stored here for convenience, but this does not violate 3NF.
- The **Payment**, **Review**, and **Message** tables have no transitive dependencies, as each non-key attribute depends directly on its respective primary key.

### Conclusion:
- All tables comply with **3NF** as there are no transitive dependencies.

---

## Redundancy and Violations of Normalization

- **Redundancy**: There is **no redundancy** in the schema. All attributes are atomic, and there are no repeating groups.
- **Violation of Normalization**: The schema adheres to **1NF**, **2NF**, and **3NF**, with no violations of any normalization principles.

---

## Possible Improvement

- **Total Price Calculation**: In the **Booking** table, the `total_price` attribute is stored, even though it could be derived from the `pricepernight` in the **Property** table and the duration of stay. While storing this value can improve query performance, it may be considered redundant if it can be calculated at query time.

---

## Conclusion

- The database schema is properly normalized to **3NF**.
- There is no redundancy or violation of normalization principles in the schema.

