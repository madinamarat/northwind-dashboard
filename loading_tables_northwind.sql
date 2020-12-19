DROP TABLE IF EXISTS categories;

CREATE TABLE categories (
    categoryID SERIAL PRIMARY KEY,
    categoryName varchar(255),
    description varchar(255),
    picture bytea);

COPY categories FROM '/Users/madinamukhambekova/desktop/northwind/categories.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE customers (
    id varchar(255) UNIQUE NOT NULL,
    companyName VARCHAR(255),
    contactName VARCHAR(255),
    contactTitle VARCHAR(255),
    address VARCHAR(255),
    city VARCHAR(255),
    region VARCHAR(255),
    postalCode VARCHAR(255),
    country VARCHAR(255),
    phone VARCHAR(255),
    fax VARCHAR(255));

COPY customers (customerID,companyName,contactName,contactTitle, address, city,region, postalCode, country,phone,fax) FROM '/Users/madinamukhambekova/desktop/northwind/customers.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE employee_territories (
    employeeID INTEGER,
    territoryID varchar(255) UNIQUE NOT NULL
);

COPY employee_territories (employeeID, territoryID) FROM '/Users/madinamukhambekova/desktop/northwind/employee_territories.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE employees (
    employeeID SERIAL PRIMARY KEY,
    lastName VARCHAR(255),
    firstName VARCHAR(255),
    title VARCHAR(255),
    titleOfCourtesy VARCHAR(10),
    birthDate TIMESTAMP,
    hireDate TIMESTAMP,
    address VARCHAR(255),
    city VARCHAR(255),
    region VARCHAR(255),
    postalCode VARCHAR(255),
    country VARCHAR(255),
    homePhone VARCHAR(255),
    extension VARCHAR(255),
    photo bytea,
    notes TEXT,
    reportsTO VARCHAR(255),
    photoPath TEXT
);

COPY employees FROM '/Users/madinamukhambekova/desktop/northwind/employees.csv' DELIMITER ',' CSV HEADER;

DROP TABLE IF EXISTS products;

CREATE TABLE products (
    productID SERIAL PRIMARY KEY,
    productName VARCHAR(255),
    supplierID SMALLINT,
    categoryID SMALLINT,
    quantityPerUnit VARCHAR(255),
    unitPrice REAL,
    unitsInStock SMALLINT,
    unitsOnOrder SMALLINT,
    reorderLevel SMALLINT,
    discontinued SMALLINT);

COPY products FROM '/Users/madinamukhambekova/desktop/northwind/products.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE order_details (
    id SERIAL PRIMARY KEY,
    orderID SMALLINT,
    productID SMALLINT,
    unitPrice REAL,
    quantity SMALLINT,
    discount REAL
);

COPY order_details (orderID,productID,unitPrice,quantity,discount) FROM '/Users/madinamukhambekova/desktop/northwind/order_details.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE orders (
    orderID VARCHAR(255) UNIQUE NOT NULL,
    customerID varchar(255),
    employeeID SMALLINT,
    orderDate TIMESTAMP,
    requiredDate TIMESTAMP,
    shippedDate TIMESTAMP,
    shipVia SMALLINT,
    freight REAL,
    shipName VARCHAR(255),
    shipAddress VARCHAR(255),
    shipCity VARCHAR(255),
    shipRegion VARCHAR(255),
    shipPostalCode VARCHAR(255),
    shipCountry VARCHAR(255)
);

COPY orders FROM '/Users/madinamukhambekova/desktop/northwind/orders.csv' DELIMITER ',' NULL AS 'NULL' CSV HEADER;

CREATE TABLE regions (
    regionID SERIAL PRIMARY KEY,
    regionDescription VARCHAR(255)
);

COPY regions FROM '/Users/madinamukhambekova/desktop/northwind/regions.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE shippers (
    shipperID SERIAL PRIMARY KEY,
    companyName VARCHAR(255),
    phone VARCHAR(255)
);

COPY shippers FROM '/Users/madinamukhambekova/desktop/northwind/shippers.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE suppliers (
    supplierID SERIAL PRIMARY KEY,
    companyName VARCHAR(255),
    contactName varchar(255),
    contactTitle VARCHAR(255),
    address VARCHAR(255),
    city VARCHAR(255),
    region VARCHAR(255),
    postalCode VARCHAR(255),
    country VARCHAR(255),
    phone VARCHAR(255),
    fax VARCHAR(255),
    homePage VARCHAR(255));

COPY suppliers FROM '/Users/madinamukhambekova/desktop/northwind/suppliers.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE territories (
    territoryID varchar(255) UNIQUE NOT NULL,
    territoryDescription VARCHAR(255),
    regionID SMALLINT);

COPY territories FROM '/Users/madinamukhambekova/desktop/northwind/territories.csv' DELIMITER ',' CSV HEADER;


CREATE TABLE customers2 (
    id varchar(255) UNIQUE NOT NULL,
    companyName VARCHAR(255),
    contactName VARCHAR(255),
    contactTitle VARCHAR(255),
    address VARCHAR(255),
    city VARCHAR(255),
    region VARCHAR(255),
    postalCode VARCHAR(255),
    country VARCHAR(255),
    phone VARCHAR(255),
    fax VARCHAR(255),
    countrycode VARCHAR(2));

\COPY customers2 (id,companyName,contactName,contactTitle, address, city,region, postalCode, country,phone,fax,countrycode) FROM '/Users/madinamukhambekova/desktop/northwind/customers.csv' DELIMITER ',' CSV HEADER;
