CREATE TABLE IF NOT EXISTS person (
    id_person INTEGER -- SERIAL
    PRIMARY KEY,
    name TEXT NOT NULL,
    surname TEXT NOT NULL,
    patronymic TEXT,
    phone VARCHAR(11) NOT NULL
);

CREATE TABLE IF NOT EXISTS work (
    id_work INTEGER PRIMARY KEY,
    name_work TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS malfunction (
    id_malfunction INTEGER PRIMARY KEY,
    name_malfunction TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS spare_part (
    code INTEGER PRIMARY KEY,
    name_spare_part TEXT NOT NULL,
    additional_features TEXT,
    quantity INTEGER,
    units_of_measurement TEXT,
    cost INTEGER,
    category TEXT
);

CREATE TABLE IF NOT EXISTS provider (
    id_provider INTEGER PRIMARY KEY,
    name_provider TEXT NOT NULL,
    adress TEXT NOT NULL,
    name_manager TEXT NOT NULL,
    surname_manager TEXT NOT NULL,
    patronymic_manager TEXT,
    phone_manager VARCHAR(11) NOT NULL
);

CREATE TABLE IF NOT EXISTS car (
    number VARCHAR(6) PRIMARY KEY,
    region VARCHAR(3) NOT NULL,
    year INTEGER NOT NULL,
    category TEXT NOT NULL,
    model TEXT NOT NULL,
    body_type TEXT NOT NULL,
    mark TEXT NOT NULL,
    id_person INTEGER REFERENCES person(id_person)
);

CREATE TABLE IF NOT EXISTS master (
    id_master INTEGER PRIMARY KEY,
    date_of_birth DATE,
    specialization TEXT,
    experience INTEGER NOT NULL,
    work_rate FLOAT,
    id_person INTEGER REFERENCES person(id_person)
);

CREATE TABLE IF NOT EXISTS order_ (
    id_order INTEGER PRIMARY KEY,
    date_of_receipt DATE,
    planned_completion DATE,
    actual_completion DATE,
    sum_of_cost INTEGER CHECK (sum_of_cost >= 0),
    comment TEXT,
    client BOOL,
    number VARCHAR(6) REFERENCES car(number),
    id_master INTEGER REFERENCES master(id_master),
    id_provider INTEGER REFERENCES provider(id_provider)
);

CREATE TABLE IF NOT EXISTS order_malfunction (
    id_order INTEGER REFERENCES order_(id_order),
    id_malfunction INTEGER REFERENCES malfunction(id_malfunction)
);

ALTER TABLE
    order_malfunction
ADD
    CONSTRAINT order_malfunction_PK PRIMARY KEY (id_order, id_malfunction);

CREATE TABLE IF NOT EXISTS order_of_spare_part (
    id_order INTEGER REFERENCES order_(id_order),
    code INTEGER REFERENCES spare_part(code),
    count INTEGER CHECK (count > 0)
);

ALTER TABLE
    order_of_spare_part
ADD
    CONSTRAINT order_of_spare_part_PK PRIMARY KEY (id_order, code);

CREATE TABLE IF NOT EXISTS order_work (
    id_order INTEGER REFERENCES order_(id_order),
    id_work INTEGER REFERENCES work(id_work)
);

ALTER TABLE
    order_work
ADD
    CONSTRAINT order_work_PK PRIMARY KEY (id_order, id_work);