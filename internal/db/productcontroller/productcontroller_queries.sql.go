// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.27.0
// source: productcontroller_queries.sql

package db

import (
	"context"
	"database/sql"
)

const getCountries = `-- name: GetCountries :many
SELECT country_id, country_name, country_code, calling_code, country_alpha_code3, region, flag_url, num_maxlength, num_minlength, status FROM tbl_countries
`

// Get all countries from the v1/countries endpoint
// Retrieves all countries
func (q *Queries) GetCountries(ctx context.Context) ([]TblCountry, error) {
	rows, err := q.db.QueryContext(ctx, getCountries)
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

const getOperatorProducts = `-- name: GetOperatorProducts :many
SELECT product_id, operator_id, price, product_name, service_type_id, validity, sync_provider_id, provider_product_code, short_description, description, product_code, service_type_temp, receive_currency_name, send_currency_name, send_price, service_type_name, inserted_date, inserted_user, last_modified_date, last_modified_user, status, remarks, validity_type_id, product_image, voucher_template, validity_desc, benefits, currency_name, language_code, language_id, max_price, max_send_price, more_description, op_param_1, op_param_2, op_param_3, op_param_4, op_param_5, validity_period_iso, benefit_codes, currency_id, sp_currency_id, sp_max_price, sp_price FROM tbl_products WHERE operator_id = $1
`

// Get products by operator ID
// Retrieves products based on operator_id
// Arguments: operator_id
func (q *Queries) GetOperatorProducts(ctx context.Context, operatorID sql.NullInt32) ([]TblProduct, error) {
	rows, err := q.db.QueryContext(ctx, getOperatorProducts, operatorID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []TblProduct
	for rows.Next() {
		var i TblProduct
		if err := rows.Scan(
			&i.ProductID,
			&i.OperatorID,
			&i.Price,
			&i.ProductName,
			&i.ServiceTypeID,
			&i.Validity,
			&i.SyncProviderID,
			&i.ProviderProductCode,
			&i.ShortDescription,
			&i.Description,
			&i.ProductCode,
			&i.ServiceTypeTemp,
			&i.ReceiveCurrencyName,
			&i.SendCurrencyName,
			&i.SendPrice,
			&i.ServiceTypeName,
			&i.InsertedDate,
			&i.InsertedUser,
			&i.LastModifiedDate,
			&i.LastModifiedUser,
			&i.Status,
			&i.Remarks,
			&i.ValidityTypeID,
			&i.ProductImage,
			&i.VoucherTemplate,
			&i.ValidityDesc,
			&i.Benefits,
			&i.CurrencyName,
			&i.LanguageCode,
			&i.LanguageID,
			&i.MaxPrice,
			&i.MaxSendPrice,
			&i.MoreDescription,
			&i.OpParam1,
			&i.OpParam2,
			&i.OpParam3,
			&i.OpParam4,
			&i.OpParam5,
			&i.ValidityPeriodIso,
			&i.BenefitCodes,
			&i.CurrencyID,
			&i.SpCurrencyID,
			&i.SpMaxPrice,
			&i.SpPrice,
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

const getOperators = `-- name: GetOperators :many
SELECT operator_id, operator_name, operator_code, status FROM tbl_operator
`

// Get all operators from the v1/operators endpoint
// Retrieves all operators
func (q *Queries) GetOperators(ctx context.Context) ([]TblOperator, error) {
	rows, err := q.db.QueryContext(ctx, getOperators)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []TblOperator
	for rows.Next() {
		var i TblOperator
		if err := rows.Scan(
			&i.OperatorID,
			&i.OperatorName,
			&i.OperatorCode,
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

const getProductImage = `-- name: GetProductImage :many
SELECT product_image FROM tbl_products WHERE product_image = $1
`

// Get the image for a product based on product_image field
// Retrieves the image for a specific product
// Arguments: product_image
func (q *Queries) GetProductImage(ctx context.Context, productImage sql.NullString) ([]sql.NullString, error) {
	rows, err := q.db.QueryContext(ctx, getProductImage, productImage)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []sql.NullString
	for rows.Next() {
		var product_image sql.NullString
		if err := rows.Scan(&product_image); err != nil {
			return nil, err
		}
		items = append(items, product_image)
	}
	if err := rows.Close(); err != nil {
		return nil, err
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}
