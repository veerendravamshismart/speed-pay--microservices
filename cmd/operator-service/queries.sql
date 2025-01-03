-- name: CreateOperator :exec
INSERT INTO operators (name, country, status)
VALUES ($1, $2, $3)
RETURNING id, name, country, status;

-- name: GetAllOperators :many
SELECT id, name, country, status FROM operators;

-- name: GetOperatorByID :one
SELECT id, name, country, status FROM operators WHERE id = $1;

-- name: UpdateOperator :exec
UPDATE operators
SET name = $1, country = $2, status = $3
WHERE id = $4
RETURNING id, name, country, status;

-- name: DeleteOperator :exec
DELETE FROM operators WHERE id = $1;
