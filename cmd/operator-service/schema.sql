-- schema.sql

CREATE TABLE IF NOT EXISTS tbl_operator (
    operator_id         INTEGER PRIMARY KEY, -- Unique identifier for the operator
    country_id          INTEGER,             -- Foreign key to country
    operator_code       VARCHAR(255),        -- Unique code for the operator
    operator_logo       VARCHAR(255),        -- Logo of the operator
    operator_name       VARCHAR(255),        -- Name of the operator
    inserted_date       TIMESTAMPTZ,         -- Timestamp for creation
    inserted_user       INTEGER,             -- User ID for the creator
    last_modified_date  TIMESTAMPTZ,         -- Timestamp for last modification
    last_modified_user  INTEGER,             -- User ID for last modifier
    remarks             VARCHAR(255),        -- Remarks or comments about the operator
    status              INTEGER DEFAULT 0,   -- Status (active/inactive, default is 0)
    currency_id         INTEGER,             -- Foreign key to currency
    service_type_codes  VARCHAR(100),        -- Service type codes for the operator
    validation_regex    VARCHAR(100),        -- Validation regex for the operator's data
    operator_sync_code  VARCHAR(255),        -- Sync code for the operator
    operator_sync_code2 VARCHAR(255),        -- Alternate sync code for the operator
    print_template_id   INTEGER,             -- Print template ID for the operator
    service_type_id     INTEGER,             -- Service type ID for the operator
    country_name        VARCHAR(255),        -- Country name
    currency_code       VARCHAR(255),        -- Currency code
    CONSTRAINT fk_country FOREIGN KEY (country_id) REFERENCES tbl_countries(country_id),
    CONSTRAINT fk_currency FOREIGN KEY (currency_id) REFERENCES tbl_currencies(currency_id)
);
