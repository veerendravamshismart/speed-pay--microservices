-- name: GetCountries :many
-- Get all countries from the v1/countries endpoint
-- Retrieves all countries
SELECT * FROM tbl_countries;

-- name: GetOperators :many
-- Get all operators from the v1/operators endpoint
-- Retrieves all operators
SELECT * FROM tbl_operator;

-- name: GetOperatorProducts :many
-- Get products by operator ID
-- Retrieves products based on operator_id
-- Arguments: operator_id
SELECT * FROM tbl_products WHERE operator_id = $1;
-- name: GetProductImage :many
-- Get the image for a product based on product_image field
-- Retrieves the image for a specific product
-- Arguments: product_image
SELECT product_image FROM tbl_products WHERE product_image = $1;


