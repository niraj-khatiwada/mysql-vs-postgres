-- MySQL
ALTER TABLE
    customer
ADD
    -- In MySQL, the values should be written within double quotes(")
    COLUMN sex_enum ENUM("M", "F")
AFTER
    sex;

ALTER TABLE
    customer DROP COLUMN sex_enum;

-- PostgreSQL
-- In PostgreSQL, the values should be written within single quotes(')
create type sex_enum as enum('M', 'F');

alter table
    customer
add
    column sex_enum sex_enum;

alter table
    customer drop column sex_enum;