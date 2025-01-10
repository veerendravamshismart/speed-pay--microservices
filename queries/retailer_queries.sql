-- name: GetAllRetailers :many
-- Get all retailers from tbl_channel
-- Retrieves all retailers
SELECT * FROM tbl_channel;

-- name: GetRetailerByID :one
-- Get a specific retailer by its ID
-- Retrieves a single retailer based on channel_id
-- Arguments: channel_id
SELECT * FROM tbl_channel WHERE channel_id = $1;



-- name: GetSalesManagersByChannelID :many
-- Get sales managers by channel ID
-- Retrieves sales managers based on channel_id
-- Arguments: channel_id
SELECT * FROM tbl_channel WHERE sales_manager_id = $1;



