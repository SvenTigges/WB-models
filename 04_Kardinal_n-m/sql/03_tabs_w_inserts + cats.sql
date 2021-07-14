-- 02. Tabellen verbunden + INSERT

-- Vorbereitung 
DROP DATABASE IF EXISTS mydb; 
CREATE DATABASE IF NOT EXISTS mydb;
USE mydb;

/* Cats: CREATE */
CREATE TABLE IF NOT EXISTS `mydb`.`cats` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cat_name` VARCHAR(45) NOT NULL,
  `fur_color` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

-- Cats: Struktur
DESCRIBE cats; 

-- cats: Inserts 
INSERT INTO `mydb`.`cats` (`id`, `cat_name`, `fur_color`) VALUES (DEFAULT, "Grizabella", "white");
INSERT INTO `mydb`.`cats` (`id`, `cat_name`, `fur_color`) VALUES (DEFAULT, "Mausi", "striped");

-- Servants: Inhalte 
SELECT * FROM cats; 

/* Servants: CREATE */
CREATE TABLE IF NOT EXISTS `mydb`.`servants` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `servant_name` VARCHAR(45) NOT NULL,
  `yrs_served` VARCHAR(45) NOT NULL,
  `cats_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_servants_cats_idx` (`cats_id` ASC) VISIBLE,
  CONSTRAINT `fk_servants_cats`
    FOREIGN KEY (`cats_id`)
    REFERENCES `mydb`.`cats` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Servants: Struktur
DESCRIBE servants; 

-- Servants: Inserts 
INSERT INTO `mydb`.`servants` (`id`, `servant_name`, `yrs_served`, `cats_id`) VALUES (DEFAULT, "Sven", 4, 1);
INSERT INTO `mydb`.`servants` (`id`, `servant_name`, `yrs_served`, `cats_id`) VALUES (DEFAULT, "Jan", 2, 2);

-- Servants: Inhalte 
SELECT * FROM servants; 

/* Products: CREATE */
 CREATE TABLE IF NOT EXISTS `mydb`.`products` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `product_name` VARCHAR(45) NOT NULL,
  `product_price` DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

-- Products: Struktur
DESCRIBE products;

-- Products: Inserts 
INSERT INTO `mydb`.`products` (`id`, `product_name`, `product_price`) VALUES (Default,"Whaiskas|Lachs",2.75);
INSERT INTO `mydb`.`products` (`id`, `product_name`, `product_price`) VALUES (Default,"Whaiskas|Huhn",2.80);
INSERT INTO `mydb`.`products` (`id`, `product_name`, `product_price`) VALUES (Default,"Felix|Yelly", 3.75);
INSERT INTO `mydb`.`products` (`id`, `product_name`, `product_price`) VALUES (Default,"Felix|Sauce", 3.80);

-- Products: Inhalte 
SELECT * FROM products; 

/* Purchases: CREATE*/
CREATE TABLE IF NOT EXISTS `mydb`.`purchases` (
  `servants_id` INT NOT NULL,
  `products_id` INT NOT NULL,
  PRIMARY KEY (`servants_id`, `products_id`),
  INDEX `fk_servants_has_products_products1_idx` (`products_id` ASC) VISIBLE,
  INDEX `fk_servants_has_products_servants1_idx` (`servants_id` ASC) VISIBLE,
  CONSTRAINT `fk_servants_has_products_servants1`
    FOREIGN KEY (`servants_id`)
    REFERENCES `mydb`.`servants` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_servants_has_products_products1`
    FOREIGN KEY (`products_id`)
    REFERENCES `mydb`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Purchases: Struktur 
DESCRIBE purchases;

-- Purchases: Inserts 
INSERT INTO `mydb`.`purchases` (`servants_id`, `products_id`) VALUES (1,2);
INSERT INTO `mydb`.`purchases` (`servants_id`, `products_id`) VALUES (1,3);
INSERT INTO `mydb`.`purchases` (`servants_id`, `products_id`) VALUES (2,1);
INSERT INTO `mydb`.`purchases` (`servants_id`, `products_id`) VALUES (2,2);
INSERT INTO `mydb`.`purchases` (`servants_id`, `products_id`) VALUES (2,3);
INSERT INTO `mydb`.`purchases` (`servants_id`, `products_id`) VALUES (2,4);

-- Purchases: Inhalte 
SELECT * FROM purchases;

