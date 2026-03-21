-- Rename address columns and drop unused address_zip
alter table shops rename column address_street to address;
alter table shops rename column address_city to city;
alter table shops drop column address_zip;
