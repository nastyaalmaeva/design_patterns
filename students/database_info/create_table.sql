CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    surname VARCHAR NOT NULL,
    name VARCHAR NOT NULL,
    patronymic VARCHAR NOT NULL,
    phone_number VARCHAR,
    telegram VARCHAR,
    email_address VARCHAR,
    git VARCHAR,
    birthdate DATE
);