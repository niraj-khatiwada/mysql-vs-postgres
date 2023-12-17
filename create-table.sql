-- MySQL
CREATE TABLE customer (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email VARCHAR(255) UNIQUE NOT NULL,
    company VARCHAR(60),
    street VARCHAR(50),
    city VARCHAR(40),
    state CHAR(2),
    zip SMALLINT,
    phone VARCHAR(20),
    birth_date DATE,
    sex CHAR(1),
    date_entered TIMESTAMP,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    -- The "ON UPDATE" command on MySQL uses trigger under the hood to update the timestamp whenever there is mutation ion the row. PostgreSQL doesn't have this feature. We need to create a trigger manually for this case.
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    -- We'll create a trigger manually for this one
    updated_at_manual DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- PostgreSQL
create table customer (
    -- AUTO_INCREMENT in MySQL for integer is SERIAL in PostgreSQL
    id SERIAL primary key,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email VARCHAR(255) unique not null,
    company VARCHAR(60),
    street VARCHAR(50),
    city VARCHAR(40),
    state CHAR(2),
    zip smallint,
    phone VARCHAR(20),
    birth_date DATE,
    sex CHAR(1),
    -- TIMESTAMP is supported in both MySQL and PostgreSQL
    date_entered TIMESTAMP,
    -- PostgreSQL does not have "DATETIME" date data types. Use TIMESTAMP instead
    created_at TIMESTAMP default CURRENT_TIMESTAMP,
    -- See procedure and trigger below to auto update updated_at timestamp
    updated_at TIMESTAMP default CURRENT_TIMESTAMP
);

-- create a procedure(function) first
-- Below command is inside (`) because this .sql file formats it weirdly for some reason.
`create or replace 
function update_updated_at() 
    returns trigger as $$ 
    begin 
        NEW.updated_at = now();
return new;
end;
$$ language 'plpgsql'
` -- 
-- Create the trigger to call the above procedure
create trigger before_update_on_updated_at_customer_row before
update
    on customer for each row execute procedure update_updated_at();