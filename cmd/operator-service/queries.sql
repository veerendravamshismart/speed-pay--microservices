-- name: GetAllOperators :many
-- Get all operators
-- Arguments: None
SELECT * FROM tbl_operator;

-- name: GetOperatorByID :one
-- Get a specific operator by its operator_id
-- Arguments: operator_id
SELECT * FROM tbl_operator WHERE operator_id = $1;

-- name: CreateOperator :one
-- Insert a new operator and return the operator_id
-- Arguments: country_id, operator_code, operator_logo, operator_name, inserted_date, inserted_user,
--           last_modified_date, last_modified_user, remarks, status, currency_id, service_type_codes,
--           validation_regex, operator_sync_code, operator_sync_code2, print_template_id, service_type_id,
--           country_name, currency_code
INSERT INTO tbl_operator (
    country_id, operator_code, operator_logo, operator_name, inserted_date, inserted_user,
    last_modified_date, last_modified_user, remarks, status, currency_id, service_type_codes,
    validation_regex, operator_sync_code, operator_sync_code2, print_template_id, service_type_id,
    country_name, currency_code
)
VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19)
RETURNING operator_id;

-- name: UpdateOperatorStatus :one
-- Update the status of a specific operator by its operator_id
-- Arguments: status, operator_id
UPDATE tbl_operator
SET status = $1
WHERE operator_id = $2
RETURNING operator_id;


-- name: UpdateOperator :one
-- Update the details of a specific operator
-- Arguments: operator_id, country_id, operator_code, operator_logo, operator_name, inserted_date, inserted_user,
--           last_modified_date, last_modified_user, remarks, status, currency_id, service_type_codes,
--           validation_regex, operator_sync_code, operator_sync_code2, print_template_id, service_type_id,
--           country_name, currency_code
UPDATE tbl_operator
SET
    country_id = $2,
    operator_code = $3,
    operator_logo = $4,
    operator_name = $5,
    inserted_date = $6,
    inserted_user = $7,
    last_modified_date = $8,
    last_modified_user = $9,
    remarks = $10,
    status = $11,
    currency_id = $12,
    service_type_codes = $13,
    validation_regex = $14,
    operator_sync_code = $15,
    operator_sync_code2 = $16,
    print_template_id = $17,
    service_type_id = $18,
    country_name = $19,
    currency_code = $20
WHERE operator_id = $1
RETURNING operator_id;
