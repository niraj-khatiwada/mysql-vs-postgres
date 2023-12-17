-- MySQL
ALTER TABLE
    customer
MODIFY
    COLUMN first_name VARCHAR(254);

-- PostgreSQL
alter table
    customer
alter column
    -- "alter" instead of "MODIFY"
    -- add "type" flag before new data type
    first_name type VARCHAR(254);