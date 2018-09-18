DROP TABLE IF EXISTS property_search;

CREATE TABLE property_search(
  id SERIAL4 PRIMARY KEY,
  address VARCHAR(255),
  value INT4,
  number_of_bedrooms INT2,
  buy_let_status VARCHAR(255)
);
