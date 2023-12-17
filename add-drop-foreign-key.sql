-- MySQL
-- To add fk, we need to first create the column
ALTER TABLE
    product
ADD
    COLUMN type_id BIGINT;

-- and then add constraint
ALTER TABLE
    product
ADD
    CONSTRAINT product_type_fk FOREIGN KEY(type_id) REFERENCES product_type(id);

-- PostgreSQL
-- Add column first
alter table
    product
add
    column type_id BIGINT;

-- the add fk constraint
alter table
    product
add
    constraint product_type_fk foreign key(type_id) references product_type(id);

-- To drop a foreign key, we must first delete the fk constraint. Get constraint name from:
SHOW CREATE TABLE product;

-- Delete constraint
ALTER TABLE
    product DROP CONSTRAINT `product_ibfk_1`;

-- Then Delete column
ALTER TABLE
    product DROP COLUMN type_id;

-- PostgreSQL
-- Delete constraint
alter table
    product drop constraint product_type_id_fkey;

-- Then Delete column
alter table
    product drop column type_id;