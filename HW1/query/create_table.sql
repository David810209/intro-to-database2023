--"colors" table
-- primary key “id”.
CREATE TABLE public.colors
(
	id VARCHAR(15),
    name VARCHAR(50),
    rgb CHAR(6),
    is_trans BOOLEAN,
    primary key (id)
);

--“themes” table
--primary key “id”
CREATE TABLE public.themes
(
	id VARCHAR(15),
    name VARCHAR(100),
    parent_id VARCHAR(15),
    primary key (id)
);

--“sets” table
--primary key “set_num”
--choose theme_id as foreign key reference from “themes”
CREATE TABLE public.sets
(
	set_num VARCHAR(20),
    name VARCHAR(100),
    year INT,
    theme_id VARCHAR(15),
    num_parts INT,
    primary key (set_num),
    foreign key (theme_id) references themes(id)
);

--“inventories” table
--primary key “id”.
--choose set_num as foreign key reference from “sets”
CREATE TABLE public.inventories
(
	id VARCHAR(15),
    version INT,
    set_num VARCHAR(20),
    primary key (id),
    foreign key (set_num) references sets(set_num)
);

--“inventory_sets” table
--primary key “inventory_id” and “set_num”
--choose inventory_id as foreign key reference from “inventories”
--choose set_num as foreign key reference from “sets”
CREATE TABLE public.inventory_sets
(
	inventory_id VARCHAR(15),
    set_num VARCHAR(20),
    quantity INT,
    primary key (inventory_id, set_num),
    foreign key (inventory_id) references inventories(id),
    foreign key (set_num) references sets(set_num)
);

--“part_categories” table
--primary key “id”
CREATE TABLE public.part_categories
(
    id VARCHAR(15),
    name VARCHAR(100),
    primary key (id)
);

--“parts” table
--primary key “part_num”
--choose part_cat_id as foreign key reference from “part_categories”
CREATE TABLE public.parts
(
    part_num VARCHAR(20),
    name VARCHAR(300),
    part_cat_id VARCHAR(15),
    primary key (part_num),
    foreign key (part_cat_id) references part_categories(id)
);

--“inventory_parts” table
--no primary key because there is no unique attribute in “inventory_parts.csv”
--choose inventory_id as foreign key reference from "inventories"
--choose color_id as foreign key reference from "colors"
CREATE TABLE public.inventory_parts
(
    inventory_id VARCHAR(15),
    part_num VARCHAR(20),
    color_id VARCHAR(15),
    quantity INT,
    is_spare BOOLEAN,
    foreign key (inventory_id) references inventories(id),
    foreign key (color_id) references colors(id)
);
COPY public.colors(id, name, rgb, is_trans)
FROM 'C:/Program Files/PostgreSQL/16/bin/colors.csv'
DELIMITER ',' 
CSV HEADER;

COPY public.themes(id,name,parent_id)
FROM 'C:/Program Files/PostgreSQL/16/bin/themes.csv'
DELIMITER ',' 
CSV HEADER;

COPY public.sets(set_num,name,year,theme_id,num_parts)
FROM 'C:/Program Files/PostgreSQL/16/bin/sets.csv'
DELIMITER ',' 
CSV HEADER;

COPY public.inventories(id,version,set_num)
FROM 'C:/Program Files/PostgreSQL/16/bin/inventories.csv'
DELIMITER ',' 
CSV HEADER;

COPY public.inventory_sets(inventory_id,set_num,quantity)
FROM 'C:/Program Files/PostgreSQL/16/bin/inventory_sets.csv'
DELIMITER ',' 
CSV HEADER;

COPY public.part_categories(id,name)
FROM 'C:/Program Files/PostgreSQL/16/bin/part_categories.csv'
DELIMITER ',' 
CSV HEADER;

COPY public.parts(part_num,name,part_cat_id)
FROM 'C:/Program Files/PostgreSQL/16/bin/parts.csv'
DELIMITER ',' 
CSV HEADER;

COPY public.inventory_parts(inventory_id,part_num,color_id,quantity,is_spare)
FROM 'C:/Program Files/PostgreSQL/16/bin/inventory_parts.csv'
DELIMITER ',' 
CSV HEADER;
