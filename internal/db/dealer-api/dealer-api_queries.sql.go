// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.27.0
// source: dealer-api_queries.sql

package db

import (
	"context"
	"database/sql"
)

const getAllAreas = `-- name: GetAllAreas :many
SELECT area_id, area_name, city_id FROM tbl_areas
`

// Get all areas
// Retrieves all areas
func (q *Queries) GetAllAreas(ctx context.Context) ([]TblArea, error) {
	rows, err := q.db.QueryContext(ctx, getAllAreas)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []TblArea
	for rows.Next() {
		var i TblArea
		if err := rows.Scan(&i.AreaID, &i.AreaName, &i.CityID); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Close(); err != nil {
		return nil, err
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const getAllCities = `-- name: GetAllCities :many
SELECT city_id, city_name, region_id FROM tbl_cities
`

// Get all cities
// Retrieves all cities
func (q *Queries) GetAllCities(ctx context.Context) ([]TblCity, error) {
	rows, err := q.db.QueryContext(ctx, getAllCities)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []TblCity
	for rows.Next() {
		var i TblCity
		if err := rows.Scan(&i.CityID, &i.CityName, &i.RegionID); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Close(); err != nil {
		return nil, err
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const getAllCountries = `-- name: GetAllCountries :many
SELECT country_id, country_name, country_code, calling_code, country_alpha_code3, region, flag_url, num_maxlength, num_minlength, status, currency_id_temp FROM tbl_countries
`

// Get all countries from tbl_countries
// Retrieves all countries
// Arguments: None
func (q *Queries) GetAllCountries(ctx context.Context) ([]TblCountry, error) {
	rows, err := q.db.QueryContext(ctx, getAllCountries)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []TblCountry
	for rows.Next() {
		var i TblCountry
		if err := rows.Scan(
			&i.CountryID,
			&i.CountryName,
			&i.CountryCode,
			&i.CallingCode,
			&i.CountryAlphaCode3,
			&i.Region,
			&i.FlagUrl,
			&i.NumMaxlength,
			&i.NumMinlength,
			&i.Status,
			&i.CurrencyIDTemp,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Close(); err != nil {
		return nil, err
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const getAllCurrencies = `-- name: GetAllCurrencies :many

SELECT currency_id, currency_name, currency_code, country_id FROM tbl_currencies
`

// Get all currencies
// Retrieves all currencies
func (q *Queries) GetAllCurrencies(ctx context.Context) ([]TblCurrency, error) {
	rows, err := q.db.QueryContext(ctx, getAllCurrencies)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []TblCurrency
	for rows.Next() {
		var i TblCurrency
		if err := rows.Scan(
			&i.CurrencyID,
			&i.CurrencyName,
			&i.CurrencyCode,
			&i.CountryID,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Close(); err != nil {
		return nil, err
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const getAllNumberSeries = `-- name: GetAllNumberSeries :many
SELECT number_series_id, operator_id, number_series, status FROM tbl_number_series
`

// Get all number series
// Retrieves all records from tbl_number_series
func (q *Queries) GetAllNumberSeries(ctx context.Context) ([]TblNumberSeries, error) {
	rows, err := q.db.QueryContext(ctx, getAllNumberSeries)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []TblNumberSeries
	for rows.Next() {
		var i TblNumberSeries
		if err := rows.Scan(
			&i.NumberSeriesID,
			&i.OperatorID,
			&i.NumberSeries,
			&i.Status,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Close(); err != nil {
		return nil, err
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const getAllRegions = `-- name: GetAllRegions :many
SELECT region_id, country_id, region_name FROM tbl_regions
`

// Get all regions
// Retrieves all regions
func (q *Queries) GetAllRegions(ctx context.Context) ([]TblRegion, error) {
	rows, err := q.db.QueryContext(ctx, getAllRegions)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []TblRegion
	for rows.Next() {
		var i TblRegion
		if err := rows.Scan(&i.RegionID, &i.CountryID, &i.RegionName); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Close(); err != nil {
		return nil, err
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const getAllServiceTypes = `-- name: GetAllServiceTypes :many
SELECT service_type_id, service_type_name, service_type_code, inserted_date, inserted_user, last_modified_date, last_modified_user, remarks, status, sync_code1, sync_codes FROM tbl_service_types
`

// Get all service types
// Retrieves all records from tbl_service_types
func (q *Queries) GetAllServiceTypes(ctx context.Context) ([]TblServiceType, error) {
	rows, err := q.db.QueryContext(ctx, getAllServiceTypes)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []TblServiceType
	for rows.Next() {
		var i TblServiceType
		if err := rows.Scan(
			&i.ServiceTypeID,
			&i.ServiceTypeName,
			&i.ServiceTypeCode,
			&i.InsertedDate,
			&i.InsertedUser,
			&i.LastModifiedDate,
			&i.LastModifiedUser,
			&i.Remarks,
			&i.Status,
			&i.SyncCode1,
			&i.SyncCodes,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Close(); err != nil {
		return nil, err
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const getAreasByCityID = `-- name: GetAreasByCityID :many
SELECT area_id, area_name, city_id FROM tbl_areas WHERE city_id = $1
`

// Get areas by city ID
// Retrieves areas based on city_id
// Arguments: city_id
func (q *Queries) GetAreasByCityID(ctx context.Context, cityID sql.NullInt32) ([]TblArea, error) {
	rows, err := q.db.QueryContext(ctx, getAreasByCityID, cityID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []TblArea
	for rows.Next() {
		var i TblArea
		if err := rows.Scan(&i.AreaID, &i.AreaName, &i.CityID); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Close(); err != nil {
		return nil, err
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const getCitiesByRegionID = `-- name: GetCitiesByRegionID :many
SELECT city_id, city_name, region_id FROM tbl_cities WHERE region_id = $1
`

// Get cities by region ID
// Retrieves cities based on region_id
// Arguments: region_id
func (q *Queries) GetCitiesByRegionID(ctx context.Context, regionID sql.NullInt32) ([]TblCity, error) {
	rows, err := q.db.QueryContext(ctx, getCitiesByRegionID, regionID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []TblCity
	for rows.Next() {
		var i TblCity
		if err := rows.Scan(&i.CityID, &i.CityName, &i.RegionID); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Close(); err != nil {
		return nil, err
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const getCountryByID = `-- name: GetCountryByID :one
SELECT country_id, country_name, country_code, calling_code, country_alpha_code3, region, flag_url, num_maxlength, num_minlength, status, currency_id_temp FROM tbl_countries WHERE country_id = $1
`

// Get a specific country by its ID
// Retrieves a single country based on country_id
// Arguments: country_id
func (q *Queries) GetCountryByID(ctx context.Context, countryID int32) (TblCountry, error) {
	row := q.db.QueryRowContext(ctx, getCountryByID, countryID)
	var i TblCountry
	err := row.Scan(
		&i.CountryID,
		&i.CountryName,
		&i.CountryCode,
		&i.CallingCode,
		&i.CountryAlphaCode3,
		&i.Region,
		&i.FlagUrl,
		&i.NumMaxlength,
		&i.NumMinlength,
		&i.Status,
		&i.CurrencyIDTemp,
	)
	return i, err
}

const getCurrencyByID = `-- name: GetCurrencyByID :one
SELECT currency_id, currency_name, currency_code, country_id FROM tbl_currencies WHERE currency_id = $1
`

// Get a specific currency by its ID
// Retrieves a specific currency based on currency_id
// Arguments: currency_id
func (q *Queries) GetCurrencyByID(ctx context.Context, currencyID int32) (TblCurrency, error) {
	row := q.db.QueryRowContext(ctx, getCurrencyByID, currencyID)
	var i TblCurrency
	err := row.Scan(
		&i.CurrencyID,
		&i.CurrencyName,
		&i.CurrencyCode,
		&i.CountryID,
	)
	return i, err
}

const getRegionsByCountryID = `-- name: GetRegionsByCountryID :many
SELECT region_id, country_id, region_name FROM tbl_regions WHERE country_id = $1
`

// Get regions by country ID
// Retrieves regions based on country_id
// Arguments: country_id
func (q *Queries) GetRegionsByCountryID(ctx context.Context, countryID sql.NullInt32) ([]TblRegion, error) {
	rows, err := q.db.QueryContext(ctx, getRegionsByCountryID, countryID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []TblRegion
	for rows.Next() {
		var i TblRegion
		if err := rows.Scan(&i.RegionID, &i.CountryID, &i.RegionName); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Close(); err != nil {
		return nil, err
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}
