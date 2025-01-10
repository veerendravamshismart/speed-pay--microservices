
-- name: GetUserByUsername :many
-- Query to get the user by username (login_id or email)
SELECT
       user_id,
    password,
    email,
    login_id
FROM
    tbl_user
WHERE
    login_id = $1 OR email = $1;
