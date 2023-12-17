-- MySQL
-- In MySQL, we can use enum type directly as a data type.
ALTER TABLE
    customer
ADD
    COLUMN sex_enum ENUM("M", "F")
AFTER
    sex;

-- PostgreSQL
-- In Postgres, we need to  create a custom enum type first to use it.
create type sex_enum_type enum('M', 'F');

alter table
    customer
add
    --  after <column> command is not supported in PostgreSQL
    column sex_enum sex_enum_type;