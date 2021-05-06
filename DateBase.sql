DROP SCHEMA IF EXISTS `Horb_db` ;

CREATE SCHEMA IF NOT EXISTS `Horb_db` DEFAULT CHARACTER SET utf8 ;
USE `Horb_db` ;

DROP TABLE IF EXISTS `Horb_db`.`driver` ;

CREATE TABLE IF NOT EXISTS `Horb_db`.`driver` (
                                                  `id` INT NOT NULL AUTO_INCREMENT,
                                                  `tel_num` VARCHAR(45) NOT NULL,
                                                  `name` VARCHAR(45) NOT NULL,
                                                  `surname` VARCHAR(45) NULL,
                                                  `count_of_orders` INT NULL,
                                                  `drive_license` VARCHAR(45) NOT NULL,
                                                  `rate` DECIMAL(2,1) NULL,
                                                  PRIMARY KEY (`id`),
                                                  UNIQUE INDEX `tel_num_UNIQUE` (`tel_num` ASC) VISIBLE,
                                                  UNIQUE INDEX `drive_license_UNIQUE` (`drive_license` ASC) VISIBLE)
    ENGINE = InnoDB;

DROP TABLE IF EXISTS `Horb_db`.`vehicle` ;

CREATE TABLE IF NOT EXISTS `Horb_db`.`vehicle` (
                                                   `id` INT NOT NULL AUTO_INCREMENT,
                                                   `driver_id` INT NOT NULL,
                                                   `number` VARCHAR(45) NOT NULL,
                                                   `model` VARCHAR(45) NOT NULL,
                                                   `places` INT NOT NULL,
                                                   `trunk_size_in_liter` INT NULL,
                                                   `color` VARCHAR(45) NULL,
                                                   `insurance_policy` VARCHAR(45) NOT NULL,
                                                   PRIMARY KEY (`id`),
                                                   INDEX `fk_vehicle_driver_idx` (`driver_id` ASC) VISIBLE,
                                                   CONSTRAINT `fk_vehicle_driver`
                                                       FOREIGN KEY (`driver_id`)
                                                           REFERENCES `Horb_db`.`driver` (`id`)
                                                           ON DELETE NO ACTION
                                                           ON UPDATE NO ACTION)
    ENGINE = InnoDB;

DROP TABLE IF EXISTS `Horb_db`.`credit_card` ;

CREATE TABLE IF NOT EXISTS `Horb_db`.`credit_card` (
                                                       `id` INT NOT NULL AUTO_INCREMENT,
                                                       `numer` VARCHAR(45) NOT NULL,
                                                       `date` DATE NULL,
                                                       `CV2` INT NULL,
                                                       PRIMARY KEY (`id`),
                                                       UNIQUE INDEX `num_UNIQUE` (`numer` ASC) VISIBLE)
    ENGINE = InnoDB;

DROP TABLE IF EXISTS `Horb_db`.`passenger` ;

CREATE TABLE IF NOT EXISTS `Horb_db`.`passenger` (
                                                     `id` INT NOT NULL AUTO_INCREMENT,
                                                     `name` VARCHAR(45) NOT NULL,
                                                     `surname` VARCHAR(45) NULL,
                                                     `tel_num` VARCHAR(45) NOT NULL,
                                                     `credit_card_id` INT NOT NULL,
                                                     `rate` DECIMAL(2,1) NULL,
                                                     PRIMARY KEY (`id`),
                                                     UNIQUE INDEX `tel_num_UNIQUE` (`tel_num` ASC) VISIBLE,
                                                     INDEX `fk_passenger_credit_cart1_idx` (`credit_card_id` ASC) VISIBLE,
                                                     UNIQUE INDEX `credit_cart_id_UNIQUE` (`credit_card_id` ASC) VISIBLE,
                                                     CONSTRAINT `fk_passenger_credit_cart1`
                                                         FOREIGN KEY (`credit_card_id`)
                                                             REFERENCES `Horb_db`.`credit_card` (`id`)
                                                             ON DELETE NO ACTION
                                                             ON UPDATE NO ACTION)
    ENGINE = InnoDB;

DROP TABLE IF EXISTS `Horb_db`.`order_type` ;

CREATE TABLE IF NOT EXISTS `Horb_db`.`order_type` (
                                                      `id` INT NOT NULL AUTO_INCREMENT,
                                                      `name` VARCHAR(45) NOT NULL,
                                                      PRIMARY KEY (`id`),
                                                      UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
    ENGINE = InnoDB;

DROP TABLE IF EXISTS `Horb_db`.`streets` ;

CREATE TABLE IF NOT EXISTS `Horb_db`.`streets` (
                                                   `id` INT NOT NULL AUTO_INCREMENT,
                                                   `Name` VARCHAR(45) NULL,
                                                   PRIMARY KEY (`id`))
    ENGINE = InnoDB;

DROP TABLE IF EXISTS `Horb_db`.`city` ;

CREATE TABLE IF NOT EXISTS `Horb_db`.`city` (
                                                `id` INT NOT NULL AUTO_INCREMENT,
                                                `name` VARCHAR(45) NULL,
                                                PRIMARY KEY (`id`),
                                                UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
    ENGINE = InnoDB;

DROP TABLE IF EXISTS `Horb_db`.`adress` ;

CREATE TABLE IF NOT EXISTS `Horb_db`.`adress` (
                                                  `id` INT NOT NULL AUTO_INCREMENT,
                                                  `streets_id` INT NOT NULL,
                                                  `house_number` INT NOT NULL,
                                                  `house_letter` VARCHAR(1) NULL,
                                                  `city_id` INT NOT NULL,
                                                  PRIMARY KEY (`id`),
                                                  INDEX `fk_adress_streets1_idx` (`streets_id` ASC) VISIBLE,
                                                  INDEX `fk_adress_city1_idx` (`city_id` ASC) VISIBLE,
                                                  CONSTRAINT `fk_adress_streets1`
                                                      FOREIGN KEY (`streets_id`)
                                                          REFERENCES `Horb_db`.`streets` (`id`)
                                                          ON DELETE NO ACTION
                                                          ON UPDATE NO ACTION,
                                                  CONSTRAINT `fk_adress_city1`
                                                      FOREIGN KEY (`city_id`)
                                                          REFERENCES `Horb_db`.`city` (`id`)
                                                          ON DELETE NO ACTION
                                                          ON UPDATE NO ACTION)
    ENGINE = InnoDB;

DROP TABLE IF EXISTS `Horb_db`.`order_state` ;

CREATE TABLE IF NOT EXISTS `Horb_db`.`order_state` (
                                                       `id` INT NOT NULL AUTO_INCREMENT,
                                                       `state` VARCHAR(45) NULL,
                                                       PRIMARY KEY (`id`))
    ENGINE = InnoDB;

DROP TABLE IF EXISTS `Horb_db`.`order` ;

CREATE TABLE IF NOT EXISTS `Horb_db`.`order` (
                                                 `id` INT NOT NULL AUTO_INCREMENT,
                                                 `passenger_id` INT NOT NULL,
                                                 `cost` DECIMAL(10,2) NOT NULL,
                                                 `estimated_departure_time` VARCHAR(45) NULL,
                                                 `estimated_arrival_time` VARCHAR(45) NULL,
                                                 `count_passangers` INT NULL,
                                                 `paymant_type` VARCHAR(45) NOT NULL,
                                                 `order_type_id` INT NOT NULL,
                                                 `adress_start_id` INT NOT NULL,
                                                 `adress_end_id` INT NOT NULL,
                                                 `vehicle_id` INT NOT NULL,
                                                 `order_state_id` INT NOT NULL,
                                                 PRIMARY KEY (`id`),
                                                 INDEX `fk_passenger_has_vehicle_passenger1_idx` (`passenger_id` ASC) VISIBLE,
                                                 INDEX `fk_order_order_type1_idx` (`order_type_id` ASC) VISIBLE,
                                                 INDEX `fk_order_adress1_idx` (`adress_start_id` ASC) VISIBLE,
                                                 INDEX `fk_order_adress2_idx` (`adress_end_id` ASC) VISIBLE,
                                                 INDEX `fk_order_vehicle1_idx` (`vehicle_id` ASC) VISIBLE,
                                                 INDEX `fk_order_order state1_idx` (`order_state_id` ASC) VISIBLE,
                                                 CONSTRAINT `fk_passenger_has_vehicle_passenger1`
                                                     FOREIGN KEY (`passenger_id`)
                                                         REFERENCES `Horb_db`.`passenger` (`id`)
                                                         ON DELETE NO ACTION
                                                         ON UPDATE NO ACTION,
                                                 CONSTRAINT `fk_order_order_type1`
                                                     FOREIGN KEY (`order_type_id`)
                                                         REFERENCES `Horb_db`.`order_type` (`id`)
                                                         ON DELETE NO ACTION
                                                         ON UPDATE NO ACTION,
                                                 CONSTRAINT `fk_order_adress1`
                                                     FOREIGN KEY (`adress_start_id`)
                                                         REFERENCES `Horb_db`.`adress` (`id`)
                                                         ON DELETE NO ACTION
                                                         ON UPDATE NO ACTION,
                                                 CONSTRAINT `fk_order_adress2`
                                                     FOREIGN KEY (`adress_end_id`)
                                                         REFERENCES `Horb_db`.`adress` (`id`)
                                                         ON DELETE NO ACTION
                                                         ON UPDATE NO ACTION,
                                                 CONSTRAINT `fk_order_vehicle1`
                                                     FOREIGN KEY (`vehicle_id`)
                                                         REFERENCES `Horb_db`.`vehicle` (`id`)
                                                         ON DELETE NO ACTION
                                                         ON UPDATE NO ACTION,
                                                 CONSTRAINT `fk_order_order state1`
                                                     FOREIGN KEY (`order_state_id`)
                                                         REFERENCES `Horb_db`.`order_state` (`id`)
                                                         ON DELETE NO ACTION
                                                         ON UPDATE NO ACTION)
    ENGINE = InnoDB;

INSERT INTO city (name) VALUES
("Дніпро"),
("Київ"),
("Харків"),
("Одеса"),
("Донецьк"),
("Запоріжжя"),
("Львів"),
("Кривий Ріг"),
("Миколаїв"),
("Маріуполь"),
("Вінниця"),
("Херсон");

INSERT INTO streets (name) VALUES
("Архівна"),
("Франка I."),
("Личаківська"),
("Стрийська"),
("Городоцька"),
("Зелена"),
("Червоної Калини"),
("Тараса Шевченка"),
("Свободи"),
("В'ячеслава Чорновола");

INSERT INTO adress (streets_id, house_number, house_letter, city_id) VALUES
(1,88,"",7),
(3,12,"a",7),
(5,67,"",7),
(6,5,"",7),
(2,22,"",7),
(5,14,"b",7),
(7,9,"a",7),
(2,8,"",7),
(4,14,"c",7),
(5,45,"",7),
(1,20,"",7),
(2,17,"a",7);

INSERT INTO order_type (name) VALUES
("Driver"),
("Child"),
("Comfort"),
("Standart"),
("Buissnes");

INSERT INTO credit_card (numer,date,CV2) VALUES
("0000888899993333",'2021-09-01',123),
("5234572345793457",'2022-06-01',454),
("5234574365936534",'2024-06-01',342),
("2138472374385634",'2022-07-01',634),
("8967348679345687",'2022-11-01',456),
("1234743523452347",'2022-06-01',476),
("3748592346537845",'2021-12-01',354),
("3245874375878344",'2024-04-01',765),
("4589237589235723",'2022-05-01',009),
("2359847235723475",'2020-12-01',345);

INSERT INTO passenger (name,surname,tel_num,credit_card_id,rate) VALUES
("Анна","Петренко","+380986745637",1,5.0),
("Надія","Б-- роварчук","+380215354235",2,4.2),
("Віталій","Іванченко","+380215432454",3,3.3),
("Артем","Середа","+380645643564",4,4.5),
("Микола","Дмитренко ","+380342565345",5,5.0),
("B'ячеслав","Кравченко","+380563753254",6,5.0),
("Віталій","Таращук","+380934534544",7,2.8),
("Лариса","Броварчук","+380153502454",8,2.0),
("Bалерій","Іванченко","+380345236540",9,3.3),
("Олексій","Антоненко","+380324500034",10,4.9);

INSERT INTO driver (tel_num,name,surname,count_of_orders,drive_license,rate) VALUES
("+380967872639","Нікіта","Горб",99,	     "RBI248258",5.0),
("+380653464356","Bсеволод","Кравчук",45,    "RBI325345",4.6),
("+380345634564","Ірина","Лисенко",67,       "RBI345643",4.2),
("+380093405954","Марина","Лисенко",120,     "RBI275399",3.4),
("+380239450924","Антон","Захарчук",34,      "RBI523466",3.3),
("+380345234504","Любов","Павлюк",96,		 "RBI834754",1.9),
("+380458976504","Володимир","Кравчук",34,	 "RBI983044",4.9),
("+380234524350","Анастасія","Шинкаренко",45,"RBI678980",2.2),
("+380234532530","Валентин","Кравченко",33,  "RBI007654",4.6),
("+380353564509","Рома","Крамаренко",10,     "RBI242345",3.5);

INSERT INTO order_state (state) VALUES
("Search driver"),
("Waiting"),
("In progress"),
("Done");

INSERT INTO vehicle (driver_id, number, model, places, trunk_size_in_liter, color, insurance_policy) VALUES
(1, "AE1234EA", "Tesla model S", 4, 30, "black",  "ВВВ9876567834"),
(2, "AE4564EA", "Audi R8", 4, 30, "blue", 		  "ADV2345345345"),
(3, "AE5756EA", "VAZ 2101", 1, 30, "white", 	  "SDF1343242304"),
(4, "AE6667EA", "Tesla model Y", 4, 30, "orange", "JDC1234213495"),
(4, "AE2343EA", "Mazda", 2, 30, "black", 		  "ASD6785674567"),
(5, "AE0010EA", "Hondai", 2, 30, "blue", 		  "FEF5678567546"),
(6, "AE1101EA", "Fiat", 4, 30, "green", 		  "AUF0890893456"),
(1, "AE3453EA", "Tesla model 3", 4, 30, "orange", "AUF4634565466"),
(8, "AE5464EA", "Audi", 4, 30, "yellow", 		  "GEL8678567877"),
(9, "AE1235EA", "Mercedes", 4, 30, "blue", 		  "BDS4563656666"),
(10, "AE8765EA", "BMW", 2, 30, "yellow", 		  "LOL0010100101"),
(7, "AE2344EA", "Nissan", 4, 30, "blue", 		  "KEK2282282282");

INSERT INTO `order` (passenger_id, cost, estimated_departure_time,
                     estimated_arrival_time, count_passangers, paymant_type,
                     order_type_id,adress_start_id,adress_end_id,vehicle_id,order_state_id) VALUES
(1,30,"10:20","10:40",4,"cash",1,1,2,1,1),
(2,70,"9:40","10:00",1,"card",2,4,5,8,2),
(3,100,"16:00","16:40",1,"cash",3,8,9,9,4),
(4,80,"16:59","17:20",3,"cash",3,2,7,10,3),
(4,76,"18:30","18:50",4,"card",2,6,7,4,3),
(5,54,"16:10","16:40",4,"cash",4,4,6,4,4),
(1,94,"14:15","14:30",1,"cash",4,7,9,7,2),
(5,82,"12:22","12:33",1,"card",2,9,8,9,3),
(8,59,"13:43","13:55",1,"card",1,2,2,10,4),
(9,20,"22:27","22:57",2,"cash",3,7,3,2,4);


