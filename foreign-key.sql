-- MySQL
CREATE TABLE product(
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30),
    supplier VARCHAR(30),
    description TEXT,
    type_id BIGINT,
    FOREIGN KEY(type_id) REFERENCES product_type(id) -- ON DELETE CASCADE|SET NULL
);

-- PostgreSQL
-- Exactly same no difference but "ON DELETE" command is not available for PostgreSQL on foreign key 
create table product(
    id SERIAL primary key,
    name VARCHAR(30),
    supplier VARCHAR(30),
    description text,
    type_id BIGINT,
    foreign key(type_id) references product_type(id) -- on delete is not available
);