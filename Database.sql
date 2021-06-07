DROP DATABASE IF EXISTS `blood donation`;
CREATE DATABASE `blood donation`;
USE `blood donation`;

SET NAMES utf8 ;
SET character_set_client = utf8mb4 ;

CREATE TABLE `Blood bank` (
`BBNAME` varchar(20) NOT NULL,
`BBCONTACT` INTEGER(14) NOT NULL,
`BBADDRESS` varchar(20) NOT NULL,
PRIMARY KEY (`BBNAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Blood bank` VALUES ('Dar Es Salaam','0998888888', '12 Nyerere Road');
INSERT INTO `Blood bank` VALUES ('Zhenjiang', '0998888888', '10 Gongshu');
INSERT INTO `Blood bank` VALUES ('Forodhani', '0998888888', 'forodhani Street');
INSERT INTO `Blood bank` VALUES ('Dodoma', '0998888888', '654 Kikuyu');
INSERT INTO `Blood bank` VALUES ('Wuxi', '0998888888', 'Liyuan');

CREATE TABLE `recepient` (
`BBNAME` varchar(20) NOT NULL,
`recepient_id` int(5) AUTO_INCREMENT NOT NULL,
`recepient_name` varchar(20) NOT NULL,
`recepient_gender` text(6) NOT NULL,
`recepient_contact` varchar(20) NOT NULL,
`recepient_address` varchar(30) NOT NULL,
PRIMARY KEY (`recepient_id`),
KEY `FK_BBNAME` (`BBNAME`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `recepient`  VALUES ('Zhenjiang','1','Sibeal Langmead',	'Female','87-352-888-50','85 Express Court');
INSERT INTO `recepient`  VALUES ('Zhenjiang','2','Olenka Hubbert','Female','61-620-514-8727','5 Reinke Terrace');
INSERT INTO `recepient`  VALUES ('Zhenjiang','3','Noby	Whapple','Female',	'509-502-789-5278','5371 Springview Circle');


CREATE TABLE `donor` (
`BBNAME` varchar(20) NOT NULL,
`donor_id` int(5) AUTO_INCREMENT NOT NULL,
`donor_name` varchar(20) NOT NULL,
`donor_gender` text(6) NOT NULL,
`donor_contact` varchar(20) NOT NULL,
`donor_address` varchar(30) NOT NULL,
PRIMARY KEY (`donor_id`),
KEY `FK_BBNAME` (`Blood bank`),
FOREIGN KEY (`BBNAME`) REFERENCES `Blood bank` (`BBNAME`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `donor` VALUES ('Zanzibar','11','Jozef Dysart','Male','937-179-268-064','5639 Badeau Point');
INSERT INTO `donor` VALUES ('Zanzibar','12', 'Andie Dumper','Female', '+593-758-158-4419',	'2 Northfield Circle');
INSERT INTO `donor` VALUES ('Zanzibar','Cammi McKelvey','Male','+27-676-723-7233','97 Bonner Center');
INSERT INTO `donor` VALUES ('Wuxi','14','Willy	Bouldstridge','Female','+420-188-424-6592','0 Morrow Trail');
INSERT INTO `donor` VALUES ('Zhhenjiang','15','Fairfax	Lanegran','Male','+62-508-378-2116','97458 Carpenter Lane');
INSERT INTO `donor` VALUES ('Zhenjiang','16','Korie	Deniset','Male','+420 683-606-3795','209 Northport Point');
INSERT INTO `donor` VALUES ('Zhenjiang','17','Verine Kneel','Male','+62-226-967-3173','814 Loeprich Junction');
INSERT INTO `donor` VALUES ('Zanzibar','18','Leia Gerner','Male','+34-837-487-1294','3 Transport Lane');
INSERT INTO `donor` VALUES ('Zanzibar','19', 'Vlad Friend','Male','+7-166-838-9580','1 Summerview Alley');
INSERT INTO `donor` VALUES ('Wuxi','20','Pauletta Kasman','Female','+86-930-842-8982','233 La Follette Street');

CREATE TABLE `storage` (
`BBNAME` int(5) NOT NULL,
`blood_id` int(5) AUTO_INCREMENT NOT NULL,
`donor_name` varchar(20) NOT NULL,
`blood_type` varchar(2) NOT NULL,
`date_taken` date NOT NULL,
`expiry_date` date NOT NULL,
PRIMARY KEY(`blood_id`),
KEY `FK_BBNAME_idx` (`Blood_bank`),
KEY `FK_donor_name_idx` (`donor_name`),
CONSTRAINT `FK_BBNAME` FOREIGN KEY (`BBNAME`) REFERENCES `Blood bank` (`BBNAME`),
CONSTRAINT `FK_donor_name` FOREIGN KEY (`donor_name`) REFERENCES `donor` (`donor_name`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci; 

INSERT INTO `storage` VALUES (1, 'Jozef Dysart', 'O+', '11-03-2021', '11-09-2021');
INSERT INTO `storage` VALUES ();
INSERT INTO `storage` VALUES ();
INSERT INTO `storage` VALUES ();
INSERT INTO `storage` VALUES ();
INSERT INTO `storage` VALUES ();
INSERT INTO `storage` VALUES ();
INSERT INTO `storage` VALUES ();
INSERT INTO `storage` VALUES ();
INSERT INTO `storage` VALUES ();

CREATE TABLE `recepient_medical_report` (
`BBNAME` varchar (10) NOT NULL,
`recepient_id` int(5) AUTO_INCREMENT NOT NULL,
`recepient_blood_group` varchar(2) NOT NULL,
`recepient_health_status` varchar(10) NOT NULL,
`recepient_birthdate` date NOT NULL,
`recepient_weight` varchar(6) NOT NULL,
`recepient_height` varchar(5) NOT NULL,
PRIMARY KEY(`recepient_id`),
KEY `FK_BBNAME_idx` (`Blood bank`),
KEY `FK_recepient_idx` (`recepient_id`),
CONSTRAINT `FK_BBNAME` FOREIGN KEY (`BBNAME`) REFERENCES `Blood bank` (`BBNAME`),
CONSTRAINT `FK_recepient_id` FOREIGN KEY (`client_id`) REFERENCES `recepient` (`recepient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `recepient_medical_report` VALUES ('Dodoma',1, 'O+', 'NEED BLOOD', '12-12-2010', '120KG', '167CM');
INSERT INTO `recepient_medical_report` VALUES ();
INSERT INTO `recepient_medical_report` VALUES ();
INSERT INTO `recepient_medical_report` VALUES ();
INSERT INTO `recepient_medical_report` VALUES ();
INSERT INTO `recepient_medical_report` VALUES ();
INSERT INTO `recepient_medical_report` VALUES ();


CREATE TABLE `donor_medical_report` (
`BBNAME` int(5) NOT NULL,
`donor_id` int(5) AUTO_INCREMENT NOT NULL,
`donor_blood_group` varchar(2) NOT NULL,
`donor_status` varchar(10) NOT NULL,
`donor_birthdate` date NOT NULL,
`donor_weight` varchar(6) NOT NULL,
`donor_height` varchar(5) NOT NULL,
PRIMARY KEY(`donor_id`),
KEY `FK_BBNAME` (`Blood bank`),
KEY `FK_donor_id` (`donor`),
FOREIGN KEY (`BBNAME`) REFERENCES `Blood bank` (`BBNAME`),
CONSTRAINT `FK_donor_id_idx` FOREIGN KEY (`donor_id`) REFERENCES `donor_id` (`donor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `donor_medical_report` VALUES ('Wuxi', 1, 'O+', 'HEALTHY', '10-05-1999','67KG','175CM');
INSERT INTO `donor_medical_report` VALUES ();
INSERT INTO `donor_medical_report` VALUES ();
INSERT INTO `donor_medical_report` VALUES ();
INSERT INTO `donor_medical_report` VALUES ();
INSERT INTO `donor_medical_report` VALUES ();
INSERT INTO `donor_medical_report` VALUES ();
INSERT INTO `donor_medical_report` VALUES ();
INSERT INTO `donor_medical_report` VALUES ();