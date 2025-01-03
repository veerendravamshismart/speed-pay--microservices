-- Create regions table
CREATE TABLE regions (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Create currencies table
CREATE TABLE currencies (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    code VARCHAR(10) NOT NULL
);

-- Create areas table
CREATE TABLE areas (
    id SERIAL PRIMARY KEY,
    region_id INT NOT NULL REFERENCES regions(id),
    country_name VARCHAR(255) NOT NULL,
    country_code VARCHAR(10) NOT NULL,
    currency_id INT NOT NULL REFERENCES currencies(id)
);

-- Create countries table
CREATE TABLE countries (
    id SERIAL PRIMARY KEY,
    area_id INT NOT NULL REFERENCES areas(id)
);
