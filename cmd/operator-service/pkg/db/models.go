// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.27.0

package db

import (
	"database/sql"
)

type TblOperator struct {
	OperatorID        int32
	CountryID         sql.NullInt32
	OperatorCode      sql.NullString
	OperatorLogo      sql.NullString
	OperatorName      sql.NullString
	InsertedDate      sql.NullTime
	InsertedUser      sql.NullInt32
	LastModifiedDate  sql.NullTime
	LastModifiedUser  sql.NullInt32
	Remarks           sql.NullString
	Status            sql.NullInt32
	CurrencyID        sql.NullInt32
	ServiceTypeCodes  sql.NullString
	ValidationRegex   sql.NullString
	OperatorSyncCode  sql.NullString
	OperatorSyncCode2 sql.NullString
	PrintTemplateID   sql.NullInt32
	ServiceTypeID     sql.NullInt32
	CountryName       sql.NullString
	CurrencyCode      sql.NullString
}
