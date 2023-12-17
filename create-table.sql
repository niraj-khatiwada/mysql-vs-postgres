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
    -- IMPORTANT: TIMESTAMP in MySQL does not store milliseconds by default. i.e. it stores as YYYY-MM-DD HH:MM:SS unlike YYYY-MM-DD HH:MM:SS.mmm in PostgreSQL. You have to use TIMESTAMP(3) for milliseconds precision.
    date_entered TIMESTAMP(3),
    created_at TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP(3),
    -- The "ON UPDATE" command on MySQL uses trigger under the hood to update the timestamp whenever there is mutation ion the row. PostgreSQL doesn't have this feature. We need to create a trigger manually for this case.
    updated_at TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
    -- We'll create a trigger manually for this one
    updated_at_manual TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP(3)
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
    -- TIMESTAMP is supported in both MySQL and PostgreSQL but,
    -- IMPORTANT: TIMESTAMP in PostgreSQL also stores milliseconds by default. i.e. YYYY-MM-DD HH:MM:SS.mmm. So, to make it consistent with MySQl, always use TIMESTAMP(3) in both.
    date_entered TIMESTAMP(3),
    -- 
    -- If you want to store timezone offset as well, use "timestamp with timezone" flag. Eg: "date_entered TIMESTAMP with time zone". Output will be: "2023-12-17 22:10:36.651 +0545". 
    -- "TIMESTAMPTZ" & "TIMESTAMP WITH TIME ZONE" are exactly same.
    -- "TIMESTAMP" & "TIMESTAMP WITHOUT TIME ZONE" are exactly same.
    -- date_entered TIMESTAMP with time zone,
    -- 
    -- PostgreSQL does not have "DATETIME" date data types. Use TIMESTAMP instead
    created_at TIMESTAMP(3) default CURRENT_TIMESTAMP(3),
    -- See procedure and trigger below to auto update updated_at timestamp
    updated_at TIMESTAMP(3) default CURRENT_TIMESTAMP(3)
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