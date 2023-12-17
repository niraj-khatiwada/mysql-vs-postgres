-- MySQL
CREATE TRIGGER before_update_on_manual_customer_row BEFORE
UPDATE
    ON customer FOR EACH ROW
SET
    NEW.updated_at_manual = CURRENT_TIMESTAMP;

-- Show all triggers
SHOW TRIGGERS;

-- Drop trigger
DROP TRIGGER before_update_on_manual_customer_row;

-- PostgreSQL
--  For postgres we need to create a function(procedure) first.
`create or replace 
function update_updated_at() 
    returns trigger as $$ 
    begin 
        NEW.updated_at = now();
return new;
end;
$$ language 'plpgsql'
` -- 
-- Now create a trigger to call the above procedure
create trigger before_update_on_updated_at_customer_row before
update
    on customer for each row execute procedure update_updated_at();

-- Show all triggers
SHOW TRIGGERS;

-- Drop trigger
DROP TRIGGER before_update_on_updated_at_customer_row;