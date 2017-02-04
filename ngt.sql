CREATE TABLE `NG_CLIENT`
(
  `client_id`   SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `client_name` VARCHAR(50) NOT NULL,
  `client_address` VARCHAR(250),
  `client_city` VARCHAR(50),
  `client_state` VARCHAR(50),
  `client_postal_code` VARCHAR(50),
  `client_country` VARCHAR(50),
  `client_tax_id` VARCHAR(20),
  PRIMARY KEY(client_id)
);
CREATE TABLE `NG_COUNTRY`
(
  `country_id`   SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `country_name` VARCHAR(150),
  `country_abbr` VARCHAR(4),
  PRIMARY KEY (country_id)
);
CREATE TABLE `NG_CLIENT_ROLE`
(
  `client_id` SMALLINT UNSIGNED NOT NULL REFERENCES `NG_CLIENT`.`client_id` ON DELETE CASCADE,
  `role_name` VARCHAR(15) NOT NULL
);
CREATE TABLE `NGT_PACKING_LIST`
(
  `pkl_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `client_id` SMALLINT UNSIGNED NOT NULL REFERENCES `NG_CLIENT`.`client_id` ON DELETE CASCADE,
  `packing_list_no` VARCHAR(50) NOT NULL,
  `packing_list_date` DATE NOT NULL,
  `sales_order_number` VARCHAR(50) NOT NULL,
  `purchase_order_number` VARCHAR(50) NOT NULL,
  `purchase_order_date` DATE NOT NULL,
  `invoice_number` VARCHAR(50) NOT NULL,
  `invoice_date` DATE NOT NULL,
  `pre_carrier` VARCHAR(100),
  `port_of_loading` VARCHAR(100),
  `final_destination` VARCHAR(100),
  `exporter_id` SMALLINT UNSIGNED NOT NULL REFERENCES `NG_CLIENT`.`client_id` ON DELETE CASCADE,
  `buyer_id` SMALLINT UNSIGNED NOT NULL REFERENCES `NG_CLIENT`.`client_id` ON DELETE CASCADE,
  `consignee_id` SMALLINT UNSIGNED NOT NULL REFERENCES `NG_CLIENT`.`client_id` ON DELETE CASCADE,
  `country_of_origin` SMALLINT UNSIGNED NOT NULL REFERENCES `NG_COUNTRY`.`country_id` ON DELETE CASCADE,
  `terms_of_delivery` VARCHAR(1024),
  `box` VARCHAR(50),
  `seals` VARCHAR(250),
  `freight_cost` DECIMAL(18,9),
  `insurance_cost` DECIMAL(18,9),
  PRIMARY KEY (pkl_id),
  UNIQUE INDEX ux_pkl_header (client_id, packing_list_no, invoice_number)
);
CREATE TABLE `NGT_PACKING_LIST_ITEM`
(
  `pkl_item_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `pkl_id` INT UNSIGNED NOT NULL REFERENCES `NGT_PACKING_LIST`.`pkl_id` ON DELETE CASCADE,
  `item` VARCHAR(50),
  `rate` DECIMAL(18,9),
  `pallet_no` VARCHAR(50),
  `roll_no` VARCHAR(50),
  `pallet_width` DECIMAL(18,9),
  `pallet_length` DECIMAL(18,9),
  `pallet_height` DECIMAL(18,9),
  `rolls_in_pallet` SMALLINT UNSIGNED,
  `roll_remarks` VARCHAR(250),
  `pallet_remarks` VARCHAR(250),
  `roll_net_weight` DECIMAL(18,9),
  `roll_gross_weight` DECIMAL(18,9),
  `pallet_gross_weight` DECIMAL(18,9),
  PRIMARY KEY (pkl_item_id),
  UNIQUE INDEX ux_pkl_item (pkl_id, roll_no)
);
