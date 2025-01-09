-- name: GetAllCountries :many
-- Get all countries from tbl_countries
-- Retrieves all countries
-- Arguments: None
SELECT * FROM tbl_countries;

-- name: GetAllRegions :many
-- Get all regions
-- Retrieves all regions
SELECT * FROM tbl_regions;

-- name: GetAllCities :many
-- Get all cities
-- Retrieves all cities
SELECT * FROM tbl_cities;

-- name: GetAllAreas :many
-- Get all areas
-- Retrieves all areas
SELECT * FROM tbl_areas;

-- name: GetAllCurrencies :many
-- Get all currencies
-- Retrieves all currencies

SELECT * FROM tbl_currencies;

-- name: GetCountryByID :one
-- Get a specific country by its ID
-- Retrieves a single country based on country_id
-- Arguments: country_id
SELECT * FROM tbl_countries WHERE country_id = $1;

-- name: GetCurrencyByID :one
-- Get a specific currency by its ID
-- Retrieves a specific currency based on currency_id
-- Arguments: currency_id
SELECT * FROM tbl_currencies WHERE currency_id = $1;

-- name: GetRegionsByCountryID :many
-- Get regions by country ID
-- Retrieves regions based on country_id
-- Arguments: country_id
SELECT * FROM tbl_regions WHERE country_id = $1;

-- name: GetCitiesByRegionID :many
-- Get cities by region ID
-- Retrieves cities based on region_id
-- Arguments: region_id
SELECT * FROM tbl_cities WHERE region_id = $1;

-- name: GetAreasByCityID :many
-- Get areas by city ID
-- Retrieves areas based on city_id
-- Arguments: city_id
SELECT * FROM tbl_areas WHERE city_id = $1;

