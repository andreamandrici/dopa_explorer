-- CREATE TABLE utils.tracker

DROP TABLE IF EXISTS utils.tracker;
CREATE TABLE utils.tracker (id serial PRIMARY KEY, "schema" text, "table" text, "date" integer);

