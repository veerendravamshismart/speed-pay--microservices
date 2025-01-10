-- Create the tbl_channel table
CREATE TABLE tbl_channel (
    channel_id SERIAL PRIMARY KEY, -- Unique identifier for each channel
    address VARCHAR(255), -- Address of the channel
    area_id INT, -- Identifier for geographical area
    ch_reference_id INT, -- Reference ID related to the channel
    channel_code VARCHAR(255), -- Unique code identifying the channel
    channel_type INT, -- Type of channel (retail, wholesale, etc.)
    city_id INT, -- City identifier where the channel is located
    country_id INT, -- Country identifier where the channel is located
    date_of_birth TIMESTAMP, -- Date of birth (if applicable)
    display_name VARCHAR(255), -- Display name for the channel
    email VARCHAR(255), -- Email address associated with the channel
    first_name VARCHAR(255), -- First name of the contact person (if applicable)
    gender_id INT, -- Gender ID associated with the contact person
    inserted_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Default to current timestamp
    inserted_user INT, -- User ID of the person who inserted the record
    longitude DOUBLE PRECISION, -- Geographical longitude (corrected typo: `langitude`)
    last_modified_date TIMESTAMP, -- Timestamp of the last modification
    last_modified_user INT, -- User ID of the person who last modified the record
    last_name VARCHAR(255), -- Last name of the contact person (if applicable)
    latitude DOUBLE PRECISION, -- Geographical latitude
    level INT, -- Level or tier of the channel
    mobile_number VARCHAR(255), -- Mobile number of the channel or contact person
    pincode VARCHAR(255), -- Postal code for the channel's location
    region_id INT, -- Region identifier where the channel is located
    remarks VARCHAR(255), -- Additional remarks or comments
    status INT, -- Status of the channel (active, inactive, etc.)
    profile_id INT, -- Identifier for the channel's profile or business type
    ch_level INT, -- Level of the channel within the hierarchy
    password VARCHAR(200), -- Password for accessing the channel's system (if applicable)
    currency_id INT, -- Currency identifier associated with transactions or sales
    currency_name VARCHAR(255), -- Name of the currency
    country_name VARCHAR(255), -- Name of the country where the channel is located
    area_name VARCHAR(255), -- Name of the geographical area
    city_name VARCHAR(255), -- Name of the city
    region_name VARCHAR(255), -- Name of the region
    profile_name VARCHAR(255), -- Name of the profile or business type
    ch_reference_code VARCHAR(255), -- Reference code related to the channel
    ch_reference_name VARCHAR(255), -- Reference name related to the channel
    commission DOUBLE PRECISION, -- Commission rate or amount related to the channel
    commission_type INT, -- Type of commission (fixed, percentage, etc.)
    commission_value DOUBLE PRECISION, -- Commission value
    dob VARCHAR(255), -- Date of birth of the channel representative or related person
    user_id INT, -- Identifier for the user linked to the channel
    sales_manager_id INT, -- Identifier for the sales manager responsible for the channel
    imei VARCHAR(255), -- International Mobile Equipment Identity (IMEI) for devices used
    serial_number VARCHAR(255), -- Serial number of devices used by the channel
    sim_number VARCHAR(255), -- SIM card number associated with devices
    calc_type INT, -- Calculation type for commissions or other financials
    cat_id INT, -- Category identifier
    client_name VARCHAR(255), -- Name of the client or business partner
    contact_person VARCHAR(255), -- Name of the contact person associated with the channel
    markup_value DOUBLE PRECISION, -- Markup value for pricing
    mobile VARCHAR(255), -- Additional mobile number or contact information
    currency_code VARCHAR(255), -- Currency code for financial transactions
    status_desc VARCHAR(255) -- Description of the current status (active, inactive, etc.)
);

-- Define indexes for commonly queried columns
CREATE INDEX idx_currency_id ON tbl_channel(currency_id);
CREATE INDEX idx_country_id ON tbl_channel(country_id);

-- Define foreign key constraints
ALTER TABLE tbl_channel
    ADD CONSTRAINT fk_currency_id FOREIGN KEY (currency_id) REFERENCES tbl_currencies(currency_id) ON DELETE SET NULL,
    ADD CONSTRAINT fk_country_id FOREIGN KEY (country_id) REFERENCES tbl_countries(country_id) ON DELETE SET NULL;
