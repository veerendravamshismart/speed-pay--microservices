-- Table for countries
CREATE TABLE IF NOT EXISTS tbl_countries (
    country_id SERIAL PRIMARY KEY,
    country_name VARCHAR(255),
    country_code VARCHAR(45),
    calling_code VARCHAR(45),
    country_alpha_code3 VARCHAR(45),
    region VARCHAR(45),
    flag_url VARCHAR(255),
    num_maxlength INT,
    num_minlength INT,
    status INT
);

-- Table for operators
CREATE TABLE IF NOT EXISTS tbl_operator (
    operator_id SERIAL PRIMARY KEY,
    operator_name VARCHAR(255),
    operator_code VARCHAR(45),
    status INT
);

-- Table for products
CREATE TABLE IF NOT EXISTS tbl_products (
    product_id SERIAL PRIMARY KEY,
    operator_id INT REFERENCES tbl_operator(operator_id),
    price DOUBLE PRECISION,
    product_name VARCHAR(255),
    service_type_id INT,
    validity INT,
    sync_provider_id INT,
    provider_product_code VARCHAR(45),
    short_description VARCHAR(255),
    description VARCHAR(1000),
    product_code VARCHAR(45),
    service_type_temp VARCHAR(100),
    receive_currency_name VARCHAR(255),
    send_currency_name VARCHAR(255),
    send_price DOUBLE PRECISION,
    service_type_name VARCHAR(255),
    inserted_date TIMESTAMP,
    inserted_user INT,
    last_modified_date TIMESTAMP,
    last_modified_user INT,
    status INT,
    remarks VARCHAR(255),
    validity_type_id INT,
    product_image VARCHAR(255),
    voucher_template VARCHAR(255),
    validity_desc VARCHAR(255),
    benefits VARCHAR(255),
    currency_name VARCHAR(255),
    language_code VARCHAR(255),
    language_id INT,
    max_price DOUBLE PRECISION,
    max_send_price DOUBLE PRECISION,
    more_description VARCHAR(1000),
    op_param_1 VARCHAR(255),
    op_param_2 VARCHAR(255),
    op_param_3 VARCHAR(255),
    op_param_4 VARCHAR(255),
    op_param_5 VARCHAR(255),
    validity_period_iso VARCHAR(255),
    benefit_codes VARCHAR(100),
    currency_id INT,
    sp_currency_id INT,
    sp_max_price DOUBLE PRECISION,
    sp_price DOUBLE PRECISION
);

-- Additional table as per available details
CREATE TABLE IF NOT EXISTS tbl_voucher_pin (
    id SERIAL PRIMARY KEY,
    pin_code VARCHAR(255),
    status INT
);
