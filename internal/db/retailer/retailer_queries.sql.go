// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.27.0
// source: retailer_queries.sql

package db

import (
	"context"
	"database/sql"
)

const getAllRetailers = `-- name: GetAllRetailers :many
SELECT channel_id, address, area_id, ch_reference_id, channel_code, channel_type, city_id, country_id, date_of_birth, display_name, email, first_name, gender_id, inserted_date, inserted_user, longitude, last_modified_date, last_modified_user, last_name, latitude, level, mobile_number, pincode, region_id, remarks, status, profile_id, ch_level, password, currency_id, currency_name, country_name, area_name, city_name, region_name, profile_name, ch_reference_code, ch_reference_name, commission, commission_type, commission_value, dob, user_id, sales_manager_id, imei, serial_number, sim_number, calc_type, cat_id, client_name, contact_person, markup_value, mobile, currency_code, status_desc FROM tbl_channel
`

// Get all retailers from tbl_channel
// Retrieves all retailers
func (q *Queries) GetAllRetailers(ctx context.Context) ([]TblChannel, error) {
	rows, err := q.db.QueryContext(ctx, getAllRetailers)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []TblChannel
	for rows.Next() {
		var i TblChannel
		if err := rows.Scan(
			&i.ChannelID,
			&i.Address,
			&i.AreaID,
			&i.ChReferenceID,
			&i.ChannelCode,
			&i.ChannelType,
			&i.CityID,
			&i.CountryID,
			&i.DateOfBirth,
			&i.DisplayName,
			&i.Email,
			&i.FirstName,
			&i.GenderID,
			&i.InsertedDate,
			&i.InsertedUser,
			&i.Longitude,
			&i.LastModifiedDate,
			&i.LastModifiedUser,
			&i.LastName,
			&i.Latitude,
			&i.Level,
			&i.MobileNumber,
			&i.Pincode,
			&i.RegionID,
			&i.Remarks,
			&i.Status,
			&i.ProfileID,
			&i.ChLevel,
			&i.Password,
			&i.CurrencyID,
			&i.CurrencyName,
			&i.CountryName,
			&i.AreaName,
			&i.CityName,
			&i.RegionName,
			&i.ProfileName,
			&i.ChReferenceCode,
			&i.ChReferenceName,
			&i.Commission,
			&i.CommissionType,
			&i.CommissionValue,
			&i.Dob,
			&i.UserID,
			&i.SalesManagerID,
			&i.Imei,
			&i.SerialNumber,
			&i.SimNumber,
			&i.CalcType,
			&i.CatID,
			&i.ClientName,
			&i.ContactPerson,
			&i.MarkupValue,
			&i.Mobile,
			&i.CurrencyCode,
			&i.StatusDesc,
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

const getRetailerByID = `-- name: GetRetailerByID :one
SELECT channel_id, address, area_id, ch_reference_id, channel_code, channel_type, city_id, country_id, date_of_birth, display_name, email, first_name, gender_id, inserted_date, inserted_user, longitude, last_modified_date, last_modified_user, last_name, latitude, level, mobile_number, pincode, region_id, remarks, status, profile_id, ch_level, password, currency_id, currency_name, country_name, area_name, city_name, region_name, profile_name, ch_reference_code, ch_reference_name, commission, commission_type, commission_value, dob, user_id, sales_manager_id, imei, serial_number, sim_number, calc_type, cat_id, client_name, contact_person, markup_value, mobile, currency_code, status_desc FROM tbl_channel WHERE channel_id = $1
`

// Get a specific retailer by its ID
// Retrieves a single retailer based on channel_id
// Arguments: channel_id
func (q *Queries) GetRetailerByID(ctx context.Context, channelID int32) (TblChannel, error) {
	row := q.db.QueryRowContext(ctx, getRetailerByID, channelID)
	var i TblChannel
	err := row.Scan(
		&i.ChannelID,
		&i.Address,
		&i.AreaID,
		&i.ChReferenceID,
		&i.ChannelCode,
		&i.ChannelType,
		&i.CityID,
		&i.CountryID,
		&i.DateOfBirth,
		&i.DisplayName,
		&i.Email,
		&i.FirstName,
		&i.GenderID,
		&i.InsertedDate,
		&i.InsertedUser,
		&i.Longitude,
		&i.LastModifiedDate,
		&i.LastModifiedUser,
		&i.LastName,
		&i.Latitude,
		&i.Level,
		&i.MobileNumber,
		&i.Pincode,
		&i.RegionID,
		&i.Remarks,
		&i.Status,
		&i.ProfileID,
		&i.ChLevel,
		&i.Password,
		&i.CurrencyID,
		&i.CurrencyName,
		&i.CountryName,
		&i.AreaName,
		&i.CityName,
		&i.RegionName,
		&i.ProfileName,
		&i.ChReferenceCode,
		&i.ChReferenceName,
		&i.Commission,
		&i.CommissionType,
		&i.CommissionValue,
		&i.Dob,
		&i.UserID,
		&i.SalesManagerID,
		&i.Imei,
		&i.SerialNumber,
		&i.SimNumber,
		&i.CalcType,
		&i.CatID,
		&i.ClientName,
		&i.ContactPerson,
		&i.MarkupValue,
		&i.Mobile,
		&i.CurrencyCode,
		&i.StatusDesc,
	)
	return i, err
}

const getSalesManagersByChannelID = `-- name: GetSalesManagersByChannelID :many
SELECT channel_id, address, area_id, ch_reference_id, channel_code, channel_type, city_id, country_id, date_of_birth, display_name, email, first_name, gender_id, inserted_date, inserted_user, longitude, last_modified_date, last_modified_user, last_name, latitude, level, mobile_number, pincode, region_id, remarks, status, profile_id, ch_level, password, currency_id, currency_name, country_name, area_name, city_name, region_name, profile_name, ch_reference_code, ch_reference_name, commission, commission_type, commission_value, dob, user_id, sales_manager_id, imei, serial_number, sim_number, calc_type, cat_id, client_name, contact_person, markup_value, mobile, currency_code, status_desc FROM tbl_channel WHERE sales_manager_id = $1
`

// Get sales managers by channel ID
// Retrieves sales managers based on channel_id
// Arguments: channel_id
func (q *Queries) GetSalesManagersByChannelID(ctx context.Context, salesManagerID sql.NullInt32) ([]TblChannel, error) {
	rows, err := q.db.QueryContext(ctx, getSalesManagersByChannelID, salesManagerID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []TblChannel
	for rows.Next() {
		var i TblChannel
		if err := rows.Scan(
			&i.ChannelID,
			&i.Address,
			&i.AreaID,
			&i.ChReferenceID,
			&i.ChannelCode,
			&i.ChannelType,
			&i.CityID,
			&i.CountryID,
			&i.DateOfBirth,
			&i.DisplayName,
			&i.Email,
			&i.FirstName,
			&i.GenderID,
			&i.InsertedDate,
			&i.InsertedUser,
			&i.Longitude,
			&i.LastModifiedDate,
			&i.LastModifiedUser,
			&i.LastName,
			&i.Latitude,
			&i.Level,
			&i.MobileNumber,
			&i.Pincode,
			&i.RegionID,
			&i.Remarks,
			&i.Status,
			&i.ProfileID,
			&i.ChLevel,
			&i.Password,
			&i.CurrencyID,
			&i.CurrencyName,
			&i.CountryName,
			&i.AreaName,
			&i.CityName,
			&i.RegionName,
			&i.ProfileName,
			&i.ChReferenceCode,
			&i.ChReferenceName,
			&i.Commission,
			&i.CommissionType,
			&i.CommissionValue,
			&i.Dob,
			&i.UserID,
			&i.SalesManagerID,
			&i.Imei,
			&i.SerialNumber,
			&i.SimNumber,
			&i.CalcType,
			&i.CatID,
			&i.ClientName,
			&i.ContactPerson,
			&i.MarkupValue,
			&i.Mobile,
			&i.CurrencyCode,
			&i.StatusDesc,
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
