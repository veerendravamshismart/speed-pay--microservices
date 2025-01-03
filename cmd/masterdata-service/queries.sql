-- name: GetAllRegions :many
SELECT id, name
FROM regions;

-- name: GetAllCurrencies :many
SELECT id, name, code
FROM currencies;

-- name: GetAllAreas :many
SELECT areas.id AS area_id, areas.country_name, areas.country_code, 
       regions.name AS region_name, currencies.name AS currency_name
FROM areas
JOIN regions ON areas.region_id = regions.id
JOIN currencies ON areas.currency_id = currencies.id;

-- name: GetCountryByID :one
SELECT countries.id AS country_id, areas.country_name, areas.country_code, 
       regions.name AS region_name, currencies.name AS currency_name
FROM countries
JOIN areas ON countries.area_id = areas.id
JOIN regions ON areas.region_id = regions.id
JOIN currencies ON areas.currency_id = currencies.id
WHERE countries.id = $1;

-- name: CreateCountry :exec
INSERT INTO countries (area_id) VALUES ($1);
