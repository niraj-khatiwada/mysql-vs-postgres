-- You can change the whole data type and add constraint using MODIFY for MySQL or ALTER for PostgreSQL. This one only add/drops unique constraint.
-- MySQL
-- Find the name of the unique constraint
SHOW INDEX
FROM
    customer;

-- add constraint
ALTER TABLE
    customer
ADD
    CONSTRAINT `email` UNIQUE(email);

-- drop constraint
ALTER TABLE
    customer DROP CONSTRAINT `email`;

-- PostgreSQL
-- Find the name of the unique constraint
select
    *
from
    pg_indexes
where
    tablename = 'customer';

-- add constraint
alter table
    customer drop constraint customer_email_key;

-- drop constraint
alter table
    customer
add
    constraint customer_email_key unique(email);