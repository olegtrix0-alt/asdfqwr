-- SQL script generated from the MySQL Workbench model: shop3cats
-- This script creates the database structure (tables and foreign keys).
CREATE DATABASE IF NOT EXISTS `shop3cats`
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `shop3cats`;

CREATE TABLE IF NOT EXISTS `categories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `manufacturers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `suppliers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `roles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `orderstatus` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `full_name` VARCHAR(60) NOT NULL,
  `login` VARCHAR(50) NOT NULL,
  `password` VARCHAR(30) NOT NULL,
  `role_id` INT NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `pvz` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `postcode` CHAR(6) NOT NULL,
  `city` VARCHAR(30) NOT NULL,
  `street` VARCHAR(30) NOT NULL,
  `house` VARCHAR(5),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `products` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `article` VARCHAR(10) NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `unit` VARCHAR(10) NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `discount` INT NOT NULL,
  `stock_qty` INT NOT NULL,
  `description` VARCHAR(255),
  `photo` VARCHAR(50),
  `category_id` INT NOT NULL,
  `manufacturer_id` INT NOT NULL,
  `supplier_id` INT NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `orders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `order_date` DATETIME NOT NULL,
  `delivery_date` DATETIME,
  `pvz_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `receive_code` VARCHAR(10) NOT NULL,
  `status_id` INT NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `prodorders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `qty` INT NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `users`
  ADD CONSTRAINT `fk_users_role` FOREIGN KEY (`role_id`)
  REFERENCES `roles` (`id`)
  ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `products`
  ADD CONSTRAINT `fk_products_category` FOREIGN KEY (`category_id`)
  REFERENCES `categories` (`id`)
  ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `products`
  ADD CONSTRAINT `fk_products_manufacturer` FOREIGN KEY (`manufacturer_id`)
  REFERENCES `manufacturers` (`id`)
  ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `products`
  ADD CONSTRAINT `fk_products_supplier` FOREIGN KEY (`supplier_id`)
  REFERENCES `suppliers` (`id`)
  ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `orders`
  ADD CONSTRAINT `fk_orders_pvz` FOREIGN KEY (`pvz_id`)
  REFERENCES `pvz` (`id`)
  ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `orders`
  ADD CONSTRAINT `fk_orders_user` FOREIGN KEY (`user_id`)
  REFERENCES `users` (`id`)
  ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `orders`
  ADD CONSTRAINT `fk_orders_status` FOREIGN KEY (`status_id`)
  REFERENCES `orderstatus` (`id`)
  ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `prodorders`
  ADD CONSTRAINT `fk_prodorders_order` FOREIGN KEY (`order_id`)
  REFERENCES `orders` (`id`)
  ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE `prodorders`
  ADD CONSTRAINT `fk_prodorders_product` FOREIGN KEY (`product_id`)
  REFERENCES `products` (`id`)
  ON DELETE NO ACTION ON UPDATE NO ACTION;
