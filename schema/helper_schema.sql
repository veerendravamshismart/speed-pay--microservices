CREATE TABLE tbl_user (
    user_id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    login_id VARCHAR(255) NOT NULL UNIQUE,
    mobile_number VARCHAR(20),
    password VARCHAR(255) NOT NULL,
    user_name VARCHAR(255),
    channel_id INT,
    otp VARCHAR(6),
    mpin VARCHAR(6),
    role_id INT,
    api_user BOOLEAN DEFAULT FALSE,
    status VARCHAR(10)
);
