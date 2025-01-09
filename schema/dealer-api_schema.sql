-- schema.sql

-- Table for countries
CREATE TABLE tbl_countries (
    country_id integer NOT NULL,
    country_name character varying(255),
    country_code character varying(45),
    calling_code character varying(45),
    country_alpha_code3 character varying(45),
    region character varying(45),
    flag_url character varying(255),
    num_maxlength integer,
    num_minlength integer,
    status integer,
    currency_id_temp integer,
    PRIMARY KEY (country_id)
);

-- Table for currencies
CREATE TABLE tbl_currencies (
    currency_id integer NOT NULL,
    currency_name character varying(255),
    currency_code character varying(45),
    country_id integer,
    PRIMARY KEY (currency_id),
    FOREIGN KEY (country_id) REFERENCES tbl_countries (country_id)
);

-- Table for regions
CREATE TABLE tbl_regions (
    region_id integer NOT NULL,
    country_id integer,
    region_name character varying(255),
    PRIMARY KEY (region_id),
    FOREIGN KEY (country_id) REFERENCES tbl_countries (country_id)
);

-- Table for cities
CREATE TABLE tbl_cities (
    city_id integer NOT NULL,
    city_name character varying(255),
    region_id integer,
    PRIMARY KEY (city_id),
    FOREIGN KEY (region_id) REFERENCES tbl_regions (region_id)
);

-- Table for areas
CREATE TABLE tbl_areas (
    area_id integer NOT NULL,
    area_name character varying(255),
    city_id integer,
    PRIMARY KEY (area_id),
    FOREIGN KEY (city_id) REFERENCES tbl_cities (city_id)
);
