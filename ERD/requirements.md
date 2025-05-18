# Entity-Relationship Diagram (ERD) and Normalization Analysis

## erDiagram

```mermaid
erDiagram
    USER ||--o{ PROPERTY : owns
    USER ||--o{ BOOKING : makes
    PROPERTY ||--o{ BOOKING : has
    BOOKING ||--|| PAYMENT : includes
    USER ||--o{ REVIEW : writes
    PROPERTY ||--o{ REVIEW : receives
    USER ||--o{ MESSAGE : sends
    USER ||--o{ MESSAGE : receives

    USER {
        UUID user_id PK
        VARCHAR first_name
        VARCHAR last_name
        VARCHAR email
        VARCHAR password_hash
        VARCHAR phone_number
        ENUM role
        TIMESTAMP created_at
    }

    PROPERTY {
        UUID property_id PK
        UUID host_id FK
        VARCHAR name
        TEXT description
        VARCHAR location
        DECIMAL pricepernight
        TIMESTAMP created_at
        TIMESTAMP updated_at
    }

    BOOKING {
        UUID booking_id PK
        UUID property_id FK
        UUID user_id FK
        DATE start_date
        DATE end_date
        DECIMAL total_price
        ENUM status
        TIMESTAMP created_at
    }

    PAYMENT {
        UUID payment_id PK
        UUID booking_id FK
        DECIMAL amount
        TIMESTAMP payment_date
        ENUM payment_method
    }

    REVIEW {
        UUID review_id PK
        UUID property_id FK
        UUID user_id FK
        INTEGER rating
        TEXT comment
        TIMESTAMP created_at
    }

    MESSAGE {
        UUID message_id PK
        UUID sender_id FK
        UUID recipient_id FK
        TEXT message_body
        TIMESTAMP sent_at
    }

```

---

## Details

### User

| Attribute      | Type      | Constraints                          |
|----------------|-----------|--------------------------------------|
| user_id        | UUID      | Primary Key, Indexed                 |
| first_name     | VARCHAR   | NOT NULL                             |
| last_name      | VARCHAR   | NOT NULL                             |
| email          | VARCHAR   | UNIQUE, NOT NULL                     |
| password_hash  | VARCHAR   | NOT NULL                             |
| phone_number   | VARCHAR   | NULL                                 |
| role           | ENUM      | (guest, host, admin), NOT NULL       |
| created_at     | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP            |

### Property

| Attribute       | Type      | Constraints                          |
|------------------|-----------|--------------------------------------|
| property_id      | UUID      | Primary Key, Indexed                 |
| host_id          | UUID      | Foreign Key → User(user_id)         |
| name             | VARCHAR   | NOT NULL                             |
| description      | TEXT      | NOT NULL                             |
| location         | VARCHAR   | NOT NULL                             |
| pricepernight    | DECIMAL   | NOT NULL                             |
| created_at       | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP            |
| updated_at       | TIMESTAMP | ON UPDATE CURRENT_TIMESTAMP          |

### Booking

| Attribute     | Type      | Constraints                          |
|---------------|-----------|--------------------------------------|
| booking_id    | UUID      | Primary Key, Indexed                 |
| property_id   | UUID      | Foreign Key → Property(property_id)  |
| user_id       | UUID      | Foreign Key → User(user_id)         |
| start_date    | DATE      | NOT NULL                             |
| end_date      | DATE      | NOT NULL                             |
| total_price   | DECIMAL   | NOT NULL                             |
| status        | ENUM      | (pending, confirmed, canceled)       |
| created_at    | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP            |

### Payment

| Attribute      | Type      | Constraints                          |
|----------------|-----------|--------------------------------------|
| payment_id     | UUID      | Primary Key, Indexed                 |
| booking_id     | UUID      | Foreign Key → Booking(booking_id)   |
| amount         | DECIMAL   | NOT NULL                             |
| payment_date   | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP            |
| payment_method | ENUM      | (credit_card, paypal, stripe)        |

### Review

| Attribute     | Type      | Constraints                          |
|---------------|-----------|--------------------------------------|
| review_id     | UUID      | Primary Key, Indexed                 |
| property_id   | UUID      | Foreign Key → Property(property_id)  |
| user_id       | UUID      | Foreign Key → User(user_id)         |
| rating        | INTEGER   | CHECK 1–5, NOT NULL                  |
| comment       | TEXT      | NOT NULL                             |
| created_at    | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP            |

### Message

| Attribute      | Type      | Constraints                          |
|----------------|-----------|--------------------------------------|
| message_id     | UUID      | Primary Key, Indexed                 |
| sender_id      | UUID      | Foreign Key → User(user_id)         |
| recipient_id   | UUID      | Foreign Key → User(user_id)         |
| message_body   | TEXT      | NOT NULL                             |
| sent_at        | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP            |

---

## Relationships Overview

- User (1) → (M) Property via `host_id`
- User (1) → (M) Booking via `user_id`
- Property (1) → (M) Booking via `property_id`
- Booking (1) → (1) Payment via `booking_id`
- User (1) → (M) Review via `user_id`
- Property (1) → (M) Review via `property_id`
- User (1) → (M) Message (via `sender_id` and `recipient_id`)

---

