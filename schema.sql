USE frs;
--
-- HOST : cs336.cskndyzybdnx.us-east-2.rds.amazonaws.com	Database: FlightReservationDatabase
--

DROP TABLE IF EXISTS `Account`;
CREATE TABLE `Account`(
	`username` VARCHAR(50) NOT NULL DEFAULT '',
	`password` VARCHAR(50) NOT NULL DEFAULT '',
	`class` int(1) DEFAULT '3', /*1 for admin, 2 for employee, 3 for customer */
	`information` VARCHAR(200) DEFAULT NULL,
    `email` VARCHAR(200) DEFAULT NULL,
	PRIMARY KEY (`username`, `password`) 
);

LOCK TABLES `Account` WRITE;
/*!40000 ALTER TABLE `Account` DISABLE KEYS */;
INSERT INTO `Account` VALUES ('Manav','password', 1, 'blah', 'manva@gmail.com');
/*!40000 ALTER TABLE `Account` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `Flight`;
CREATE TABLE `Flight`(
	`flightID` INTEGER(11) NOT NULL AUTO_INCREMENT,
    `departureTime` TIME DEFAULT '00:00:00',
    `arrivalTime` TIME DEFAULT '00:00:00',
    `dayOfWeek` varchar(9) DEFAULT NULL,
    `routeID` int(11) DEFAULT NULL,
    PRIMARY KEY(`flightID`),
    KEY `routeID` (`routeID`)
);

LOCK TABLES `Flight` WRITE;
/*!40000 ALTER TABLE `Flight` DISABLE KEYS */;
INSERT INTO `Flight` VALUES (100,'09:30:00','12:30:00','Thursday',84),(102,'13:00:00','17:30:00','Friday',86),(103,'23:30:00','04:00:00','Friday',87),(110,'09:30:00','18:30:00','Saturday',30),(120,'04:30:00','15:30:00','Tuesday',42),(126,'21:30:00','01:30:00','Tuesday',45),(128,'10:30:00','20:30:00','Tuesday',12),(134,'23:30:00','07:30:00','Wednesday',54);
/*!40000 ALTER TABLE `Flight` ENABLE KEYS */;
UNLOCK TABLES;

CREATE TABLE `Trip` (
	`tripID` INTEGER(11) NOT NULL,
	`flightID` INTEGER(11) NOT NULL,
    `departureDate` DATE DEFAULT '0000-00-00',
    `arrivalDate` DATE DEFAULT '0000-00-00',
	`stops` int(11) DEFAULT NULL,
    `price` int(11) DEFAULT NULL,
    `flightType` VARCHAR(15) DEFAULT NULL,
    `seatNumber` INTEGER(11) DEFAULT NULL,
    PRIMARY KEY(`flightID`, `tripID`),
    FOREIGN KEY(`flightID`) REFERENCES `Flight`(`flightID`)
);

LOCK TABLES `Trip` WRITE;
/*!40000 ALTER TABLE `Trip` DISABLE KEYS */;
INSERT INTO `Trip` VALUES (1,100,'2018-12-13','2018-12-13',0,200,'one-way',23),(2,102,'2019-01-18','2019-01-18',1,500,'round-trip',62),(2,103,'2019-02-01','2019-02-02',1,500,'round-trip',14),(3,110,'2019-04-20','2019-04-20',0,700,'one-way',83),(20,100,'2019-08-22','2019-08-22',0,300,'one-way',35),(67,100,'2020-03-12','2020-03-12',0,200,'one-way',40),(67,102,'2019-09-20','2019-09-20',1,1500,'round-trip',21),(67,103,'2019-09-27','2019-09-27',1,1500,'round-trip',63);
/*!40000 ALTER TABLE `Trip` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `Ticket`;
CREATE TABLE `Ticket`(
	`ticketID` int(11) NOT NULL AUTO_INCREMENT,
	`tripID` int(11) NOT NULL,
    `username` VARCHAR(50) DEFAULT NULL,
    `meal` varchar(20) DEFAULT 'regular',
    `class` varchar(11) DEFAULT 'economy',
    `buyTime` datetime DEFAULT NULL,
    `bookingFee` int(11) DEFAULT '10',
    PRIMARY KEY(`ticketID`),
	KEY `tripID` (`tripID`),
    KEY `username` (`username`)
);

LOCK TABLES `Ticket` WRITE;
/*!40000 ALTER TABLE `Ticket` DISABLE KEYS */;
INSERT INTO `Ticket` VALUES (1,1,'Manav','regular','economy',NULL,10),(2,2,'Manav','regular','economy',NULL,10),(3,3,'Manav','regular','business',NULL,10),(5,1,'Tanuj','vegetarian','economy',NULL,10),(6,20,'Manav','regular','business',NULL,10),(7,67,'Tanuj','vegetarian','business',NULL,10),(8,67,'Manav','regular','first class',NULL,10),(9,67,'Manav','regular','economy',NULL,10);
/*!40000 ALTER TABLE `Ticket` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `WaitingList`;
CREATE TABLE `WaitingList`(
	`queue#` int(11) NOT NULL AUTO_INCREMENT,
    `tripID` int(11) NOT NULL,
    `username` VARCHAR(50),
    PRIMARY KEY(`queue#`),
    KEY `tripID` (`tripID`),
    KEY `username` (`username`)
);

DROP TABLE IF EXISTS `Aircraft`;
CREATE TABLE `Aircraft`(
	`aircraftID` INTEGER(11) NOT NULL AUTO_INCREMENT,
    `airlineID` CHAR(2) DEFAULT NULL,
    `maxCapacity` INTEGER(11) DEFAULT '300',
    PRIMARY KEY(`aircraftID`),
    KEY `airlineID` (`airlineID`)
    -- CONSTRAINT `Aircraft_ibfk_1` FOREIGN KEY (`airlineID`) REFERENCES `Airline` (`airlineID`) ON DELETE CASCADE ON UPDATE CASCADE
);

LOCK TABLES `Aircraft` WRITE;
/*!40000 ALTER TABLE `Aircraft` DISABLE KEYS */;
INSERT INTO `Aircraft` VALUES (1203,'LH',300),(1343,'UA',300),(1934,'UA',300),(2445,'AE',300),(2450,'AE',300),(3201,'AA',300),(3552,'AE',300),(9430,'AE',300);
/*!40000 ALTER TABLE `Aircraft` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `Route`;
CREATE TABLE `Route`(
	`routeID` int(11) NOT NULL AUTO_INCREMENT,
	`airlineID` char(2) NOT NULL,
	`aircraftID` int(11) DEFAULT NULL,
	`departureAirportID` char(3) DEFAULT NULL,
	`arrivalAirportID` char(3) DEFAULT NULL,
    `domOrInt` varchar(13) DEFAULT NULL, /* 0 for domestic, 1 for international */
    PRIMARY KEY(`routeId`),
    KEY `airlineID` (`airlineID`),
	KEY `aircraftID` (`aircraftID`),
	KEY `departureAirportID` (`departureAirportID`),
	KEY `arrivalAirportID` (`arrivalAirportID`)
);

LOCK TABLES `Route` WRITE;
/*!40000 ALTER TABLE `Route` DISABLE KEYS */;
INSERT INTO `Route` VALUES (12,'AE',9430,'HYD','ACC','International'),(30,'LH',1203,'LGA','LHR','International'),(42,'AE',3552,'ORD','DEL','International'),(45,'AE',2445,'DEL','HYD','International'),(54,'AE',2450,'ACC','FNJ','International'),(84,'AA',3201,'EWR','MCO','Domestic'),(86,'UA',1934,'JFK','LAX','Domestic'),(87,'UA',1343,'LAX','JFK','Domestic');
/*!40000 ALTER TABLE `Route` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `Airline`;
CREATE TABLE `Airline`(
	`airlineID` CHAR(2) NOT NULL,
    `airlineName` VARCHAR(50) DEFAULT NULL,
    `airportID` VARCHAR(3) NOT NULL,
    PRIMARY KEY(`airlineID`, `airportID`),
    KEY `airportID` (`airportID`)
);

LOCK TABLES `Airline` WRITE;
/*!40000 ALTER TABLE `Airline` DISABLE KEYS */;
INSERT INTO `Airline` VALUES ('AA','American Airlines','EWR'),('AA','American Airlines','MCO'),('AE','Emirates','ACC'),('AE','Emirates','DEL'),('AE','Emirates','FNJ'),('AE','Emirates','HYD'),('AE','Emirates','ORD'),('LH','Lufthansa','LGA'),('LH','Lufthansa','LHR'),('UA','United Airlines','JFK'),('UA','United Airlines','LAX');
/*!40000 ALTER TABLE `Airline` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `Airport`;
CREATE TABLE `Airport`(
	`airportID` CHAR(3) NOT NULL,
    `airportName` VARCHAR(50) DEFAULT NULL,
    `country` VARCHAR(50) DEFAULT NULL,
	`city` VARCHAR(50) DEFAULT NULL,
    PRIMARY KEY(`airportID`)
);

LOCK TABLES `Airport` WRITE;
/*!40000 ALTER TABLE `Airport` DISABLE KEYS */;
INSERT INTO `Airport` VALUES ('ACC','Kotoka International Airport','Accra','Ghana'),('DEL','Indira Gandhi International Airport','New Dehli','India'),('EWR','Newark International Airport','Newark','USA'),('FNJ','Pyongyang Sunan International Airport','Pyongyang','North Korea'),('HYD','Rajiv Gandhi International Airport','Hyderabad','India'),('JFK','John F. Kennedy International Airport','New York City','USA'),('LAX','Los Angeles International Airport','Los Angeles','USA'),('LGA','LaGuardia Airport','New York City','USA'),('LHR','Heathrow Airport','London','UK'),('MCO','Orlando International Airport','Orlando','USA'),('ORD','O\'Hare International Airport','Chicago','USA');
/*!40000 ALTER TABLE `Airport` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `Carries`;
CREATE TABLE `Carries`(
	`airportID` INTEGER,
    `airlineID` INTEGER,
    key `airportID` (`airportID`),
    key `airlineID` (`airlineID`)
);

DROP TABLE IF EXISTS `Flies`;
CREATE TABLE `Flies`(
	`airlineID` INTEGER,
    `routeID` INTEGER,
    KEY `airlineID` (`airlineID`),
    KEY `routeID` (`routeID`)
);

DROP TABLE IF EXISTS `Has`;
CREATE TABLE `Has`(
	`aircraftID` INTEGER,
    `routeID` INTEGER,
    KEY `aircraftID` (`aircraftID`),
    KEY `routeID` (`routeID`)
);

DROP TABLE IF EXISTS `Piloted`;
CREATE TABLE `Piloted`(
	`routeID` INTEGER,
    `flightID` INTEGER,
    KEY `routeID` (`routeID`),
    KEY `flightID` (`flightID`)
);

DROP TABLE IF EXISTS `PartOf`;
CREATE TABLE `PartOf`(
	`flightID` INTEGER,
    `tripID` INTEGER,
    KEY `flightID` (`flightID`),
	KEY `tripID` (`tripID`)
);

DROP TABLE IF EXISTS `Places`;
CREATE TABLE `Places`(
	`queue#` INTEGER,
    `flightID` INTEGER,
    `tripID` INTEGER,
    KEY `queue#` (`queue#`),
    KEY `flightID` (`flightID`),
    KEY `tripID` (`tripID`)
);

DROP TABLE IF EXISTS `Contains`;
CREATE TABLE `Contains`(
	`flightID` INTEGER,
    `tripID` INTEGER,
    `ticketID` INTEGER,
    KEY `flightID` (`flightId`),
    KEY `tripID` (`tripID`),
    KEY `ticketID` (`ticketID`)
);

DROP TABLE IF EXISTS `BoughtBy`;
CREATE TABLE `BoughtBy`(
	`username` VARCHAR(50),
    `password` VARCHAR(50),
    `ticketID` INTEGER,
    KEY `username` (`username`),
    KEY `password` (`password`),
    KEY `ticketID` (`ticketID`)
);
-- INSERT INTO `Account` VALUES('manav','pass',1,'oldspice@gmail.com','info');

SELECT * FROM `Account`;
SELECT * FROM `Aircraft`;
SELECT * FROM `Airline`;
SELECT * FROM `Airport`;
SELECT * FROM `Flight`;
SELECT * FROM `Places`;
SELECT * FROM `Route`;
SELECT * FROM `Ticket`;
SELECT * FROM `Trip`;