USE `mariadb_climsoft_db_v4`;
ALTER TABLE `station`
	ADD COLUMN IF NOT EXISTS `icaoid` VARCHAR(20) NULL DEFAULT NULL AFTER `stationName`,
	ADD COLUMN IF NOT EXISTS `wmoid` VARCHAR(20) NULL DEFAULT NULL AFTER `stationName`,
	ADD COLUMN IF NOT EXISTS `qualifier` VARCHAR(20) NULL DEFAULT NULL AFTER `latitude`,
	CHANGE COLUMN IF EXISTS `openingDatetime` `openingDatetime` VARCHAR(50) NULL DEFAULT NULL AFTER `geoLocationAccuracy`,
	CHANGE COLUMN IF EXISTS `closingDatetime` `closingDatetime` VARCHAR(50) NULL DEFAULT NULL AFTER `openingDatetime`;
ALTER TABLE `instrument`
	CHANGE COLUMN IF EXISTS `installationDatetime` `installationDatetime` VARCHAR(50) NULL DEFAULT NULL AFTER `instrumentUncertainty`,
	CHANGE COLUMN IF EXISTS `deinstallationDatetime` `deinstallationDatetime` VARCHAR(50) NULL DEFAULT NULL AFTER `installationDatetime`,
	CHANGE COLUMN IF EXISTS `instrumentPicture` `instrumentPicture` CHAR(255) NULL AFTER `height`,
	ADD COLUMN IF NOT EXISTS `installedAt` VARCHAR(50) NULL DEFAULT NULL AFTER `instrumentPicture`;
ALTER TABLE `stationelement`
	ADD COLUMN IF NOT EXISTS `instrumentcode` VARCHAR(6) NULL DEFAULT NULL AFTER `recordedWith`,
	CHANGE COLUMN IF EXISTS `beginDate` `beginDate` VARCHAR(50) NULL DEFAULT NULL AFTER `height`,
	CHANGE COLUMN IF EXISTS `endDate` `endDate` VARCHAR(50) NULL DEFAULT NULL AFTER `beginDate`;
ALTER TABLE `obselement`
	ADD COLUMN IF NOT EXISTS `selected` TINYINT(4) NULL DEFAULT '0' AFTER `qcTotalRequired`,
        CHANGE COLUMN IF EXISTS `qcTotalRequired` `qcTotalRequired` INT(11) NULL DEFAULT '0' AFTER `elementtype`;
ALTER TABLE `physicalfeature`
	CHANGE COLUMN IF EXISTS `beginDate` `beginDate` VARCHAR(50) NULL DEFAULT NULL AFTER `associatedWith`,
	CHANGE COLUMN IF EXISTS `endDate` `endDate` VARCHAR(50) NULL DEFAULT NULL AFTER `beginDate`;
ALTER TABLE `observationschedule`
	CHANGE COLUMN IF EXISTS `startTime` `startTime` VARCHAR(50) NULL DEFAULT NULL AFTER `classifiedInto`,
	CHANGE COLUMN IF EXISTS `endTime` `endTime` VARCHAR(50) NULL DEFAULT NULL AFTER `startTime`;
ALTER TABLE `instrumentinspection`
	CHANGE COLUMN IF EXISTS `inspectionDatetime` `inspectionDatetime` VARCHAR(50) NULL DEFAULT NULL AFTER `performedOn`;
ALTER TABLE `instrumentfaultreport`
	CHANGE COLUMN IF EXISTS `reportDatetime` `reportDatetime` VARCHAR(50) NULL DEFAULT NULL AFTER `reportId`,
	CHANGE COLUMN IF EXISTS `receivedDatetime` `receivedDatetime` VARCHAR(50) NULL DEFAULT NULL AFTER `reportedBy`;
ALTER TABLE `featuregeographicalposition`
	CHANGE COLUMN IF EXISTS `observedOn` `observedOn` VARCHAR(50) NULL DEFAULT NULL AFTER `belongsTo`;
ALTER TABLE `faultresolution`
	CHANGE COLUMN IF EXISTS `resolvedDatetime` `resolvedDatetime` VARCHAR(50) NULL DEFAULT NULL FIRST;
ALTER TABLE `stationidalias`
	CHANGE COLUMN IF EXISTS `idAliasBeginDate` `idAliasBeginDate` VARCHAR(50) NULL DEFAULT NULL AFTER `belongsTo`,
	CHANGE COLUMN IF EXISTS `idAliasEndDate` `idAliasEndDate` VARCHAR(50) NULL DEFAULT NULL AFTER `idAliasBeginDate`;
ALTER TABLE `stationlocationhistory`
	CHANGE COLUMN IF EXISTS `openingDatetime` `openingDatetime` VARCHAR(50) NULL DEFAULT NULL AFTER `geoLocationAccuracy`,
	CHANGE COLUMN IF EXISTS `closingDatetime` `closingDatetime` VARCHAR(50) NULL DEFAULT NULL AFTER `openingDatetime`;
ALTER TABLE `stationqualifier`
	CHANGE COLUMN IF EXISTS `qualifierBeginDate` `qualifierBeginDate` VARCHAR(50) NULL DEFAULT NULL AFTER `qualifier`,
	CHANGE COLUMN IF EXISTS `qualifierEndDate` `qualifierEndDate` VARCHAR(50) NULL DEFAULT NULL AFTER `qualifierBeginDate`;
ALTER TABLE `aws_sites` 
        ADD COLUMN IF NOT EXISTS `GTSEncode` TINYINT(1) NULL AFTER `OperationalStatus`,     
        ADD COLUMN IF NOT EXISTS `GTSHeader` VARCHAR(20) NULL AFTER `GTSEncode`,
	ADD COLUMN IF NOT EXISTS `FilePrefix` VARCHAR(50) NULL DEFAULT NULL AFTER `InputFile`,
	ADD COLUMN IF NOT EXISTS `chkPrefix` TINYINT(1) NULL DEFAULT '0' AFTER `FilePrefix`,
	CHANGE COLUMN `InputFile` `InputFile` VARCHAR(255) NULL DEFAULT NULL AFTER `SiteName`,
	CHANGE COLUMN `DataStructure` `DataStructure` VARCHAR(50) NULL DEFAULT NULL AFTER `chkPrefix`,
        CHANGE COLUMN `GTSEncode` `GTSEncode` TINYINT(1) NULL DEFAULT '0' AFTER `OperationalStatus`;
ALTER TABLE `aws_process_parameters`
        ADD COLUMN IF NOT EXISTS `UTCDiff` TINYINT(2) ZEROFILL NOT NULL DEFAULT '0' AFTER `DelinputFile`;
CREATE TABLE IF NOT EXISTS `flags` (
  `characterSymbol` varchar(255) NOT NULL DEFAULT '',
  `numSymbol` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`characterSymbol`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
DELETE FROM `flags`;
INSERT INTO `flags` (`characterSymbol`, `numSymbol`, `description`) VALUES
	('D', 3, 'Dubious or Suspect Data'),
	('E', 2, 'Estimated Value'),
	('G', 4, 'Generated or Calculated Data'),
	('M', 0, 'Missing Data'),
	('T', 1, 'Trace Rainfall');
ALTER TABLE `data_forms`
       ADD COLUMN IF NOT EXISTS `entry_mode` TINYINT(2) ZEROFILL NOT NULL DEFAULT '0' AFTER `sequencer`;
DELETE FROM `tblproducts`;
INSERT INTO `tblproducts` (`productId`, `productName`, `prDetails`, `prCategory`) VALUES
	('0', 'Minutes', 'Minutes observations', 'Data'),
	('01', 'Inventory', 'Details of Data Records', 'Inventory'),
	('02', 'Hourly', 'Summaries of Hourly Observations', 'Data'),
	('03', 'Daily', 'Summaries of Daily Observation', 'Data'),
	('04', 'Pentad', '5 Days Summeries', 'Data'),
	('05', 'Dekadal', '10 Days Summaries', 'Data'),
	('06', 'Monthly', 'Monthly Summaries', 'Data'),
	('07', 'Annual', 'Annual Summaries', 'Data'),
	('08', 'Means', 'Long Term Means', 'Data'),
	('09', 'Extremes', 'Long Term', 'Data'),
	('10', 'WindRose', 'Wind Rose Picture', 'Graphics'),
	('11', 'TimeSeries', 'Time Series Chart', 'Graphics'),
	('12', 'Histograms', 'Histogram Chart', 'Graphics'),
	('13', 'Instat', 'Daily Data for Instat', 'Output for other Applications'),
	('14', 'Rclimdex', 'Daily Data for Rclimdex', 'Output for other Applications'),
	('15', 'CPT', 'Data for CPT', 'Output for other Applications'),
	('16', 'GeoCLIM Monthly', 'Monthly Data for GeoCLIM', 'Output for other Applications'),
	('17', 'GeoCLIM Dekadal', 'Dekadal Data for Geoclim', 'Output for other Applications'),
	('18', 'GeoCLIM Daily', 'Daily Data for Geoclim', 'Output for other Applications'),
	('19', 'ACMADBulletin', 'ACMAD Dekadal Bulletin', 'Summaries'),
	('20', 'CLIMAT', 'CLIMAT Messages', 'Messages'),
	('21', 'Missing Data', 'Inventory of Missing Data', 'Inventory');
Drop TABLE IF EXISTS `userrecords`;
CREATE TABLE `UserRecords` (
  `username` varchar(255) NOT NULL DEFAULT '',
  `recsexpt` int(11) DEFAULT NULL,
  `recsdone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`username`)
);
DROP TABLE IF EXISTS `seq_monthly_element`;
CREATE TABLE IF NOT EXISTS `seq_monthly_element` (
  `seq` bigint(20) NOT NULL AUTO_INCREMENT,
  `elementId` bigint(20) NOT NULL,
  PRIMARY KEY (`seq`)
);

DROP TABLE IF EXISTS `form_synoptic_2_ra1`;
CREATE TABLE IF NOT EXISTS `form_synoptic_2_ra1` (
  `stationId` varchar(50) NOT NULL DEFAULT '',
  `yyyy` int(11) NOT NULL,
  `mm` int(11) NOT NULL,
  `dd` int(11) NOT NULL,
  `hh` int(11) NOT NULL,
  `Val_Elem106` varchar(6) DEFAULT NULL,
  `Val_Elem107` varchar(6) DEFAULT NULL,
  `Val_Elem400` varchar(6) DEFAULT NULL,
  `Val_Elem814` varchar(6) DEFAULT NULL,
  `Val_Elem399` varchar(6) DEFAULT NULL,
  `Val_Elem301` varchar(6) DEFAULT NULL,
  `Val_Elem185` varchar(6) DEFAULT NULL,
  `Val_Elem101` varchar(6) DEFAULT NULL,
  `Val_Elem102` varchar(6) DEFAULT NULL,
  `Val_Elem103` varchar(6) DEFAULT NULL,
  `Val_Elem105` varchar(6) DEFAULT NULL,
  `Val_Elem192` varchar(6) DEFAULT NULL,
  `Val_Elem110` varchar(6) DEFAULT NULL,
  `Val_Elem114` varchar(6) DEFAULT NULL,
  `Val_Elem112` varchar(6) DEFAULT NULL,
  `Val_Elem111` varchar(6) DEFAULT NULL,
  `Val_Elem167` varchar(6) DEFAULT NULL,
  `Val_Elem197` varchar(6) DEFAULT NULL,
  `Val_Elem193` varchar(6) DEFAULT NULL,
  `Val_Elem115` varchar(6) DEFAULT NULL,
  `Val_Elem168` varchar(6) DEFAULT NULL,
  `Val_Elem169` varchar(6) DEFAULT NULL,
  `Val_Elem170` varchar(6) DEFAULT NULL,
  `Val_Elem171` varchar(6) DEFAULT NULL,
  `Val_Elem119` varchar(6) DEFAULT NULL,
  `Val_Elem116` varchar(6) DEFAULT NULL,
  `Val_Elem117` varchar(6) DEFAULT NULL,
  `Val_Elem118` varchar(6) DEFAULT NULL,
  `Val_Elem123` varchar(6) DEFAULT NULL,
  `Val_Elem120` varchar(6) DEFAULT NULL,
  `Val_Elem121` varchar(6) DEFAULT NULL,
  `Val_Elem122` varchar(6) DEFAULT NULL,
  `Val_Elem127` varchar(6) DEFAULT NULL,
  `Val_Elem124` varchar(6) DEFAULT NULL,
  `Val_Elem125` varchar(6) DEFAULT NULL,
  `Val_Elem126` varchar(6) DEFAULT NULL,
  `Val_Elem131` varchar(6) DEFAULT NULL,
  `Val_Elem128` varchar(6) DEFAULT NULL,
  `Val_Elem129` varchar(6) DEFAULT NULL,
  `Val_Elem130` varchar(6) DEFAULT NULL,
  `Val_Elem002` varchar(6) DEFAULT NULL,
  `Val_Elem003` varchar(6) DEFAULT NULL,
  `Val_Elem099` varchar(6) DEFAULT NULL,
  `Val_Elem018` varchar(6) DEFAULT NULL,
  `Val_Elem084` varchar(6) DEFAULT NULL,
  `Val_Elem132` varchar(6) DEFAULT NULL,
  `Val_Elem005` varchar(6) DEFAULT NULL,
  `Val_Elem174` varchar(6) DEFAULT NULL,
  `Val_Elem046` varchar(6) DEFAULT NULL,
  `Flag106` varchar(1) DEFAULT NULL,
  `Flag107` varchar(1) DEFAULT NULL,
  `Flag400` varchar(1) DEFAULT NULL,
  `Flag814` varchar(1) DEFAULT NULL,
  `Flag399` varchar(1) DEFAULT NULL,
  `Flag301` varchar(1) DEFAULT NULL,
  `Flag185` varchar(1) DEFAULT NULL,
  `Flag101` varchar(1) DEFAULT NULL,
  `Flag102` varchar(1) DEFAULT NULL,
  `Flag103` varchar(1) DEFAULT NULL,
  `Flag105` varchar(1) DEFAULT NULL,
  `Flag192` varchar(1) DEFAULT NULL,
  `Flag110` varchar(1) DEFAULT NULL,
  `Flag114` varchar(1) DEFAULT NULL,
  `Flag112` varchar(1) DEFAULT NULL,
  `Flag111` varchar(1) DEFAULT NULL,
  `Flag167` varchar(1) DEFAULT NULL,
  `Flag197` varchar(1) DEFAULT NULL,
  `Flag193` varchar(1) DEFAULT NULL,
  `Flag115` varchar(1) DEFAULT NULL,
  `Flag168` varchar(1) DEFAULT NULL,
  `Flag169` varchar(1) DEFAULT NULL,
  `Flag170` varchar(1) DEFAULT NULL,
  `Flag171` varchar(1) DEFAULT NULL,
  `Flag119` varchar(1) DEFAULT NULL,
  `Flag116` varchar(1) DEFAULT NULL,
  `Flag117` varchar(1) DEFAULT NULL,
  `Flag118` varchar(1) DEFAULT NULL,
  `Flag123` varchar(1) DEFAULT NULL,
  `Flag120` varchar(1) DEFAULT NULL,
  `Flag121` varchar(1) DEFAULT NULL,
  `Flag122` varchar(1) DEFAULT NULL,
  `Flag127` varchar(1) DEFAULT NULL,
  `Flag124` varchar(1) DEFAULT NULL,
  `Flag125` varchar(1) DEFAULT NULL,
  `Flag126` varchar(1) DEFAULT NULL,
  `Flag131` varchar(1) DEFAULT NULL,
  `Flag128` varchar(1) DEFAULT NULL,
  `Flag129` varchar(1) DEFAULT NULL,
  `Flag130` varchar(1) DEFAULT NULL,
  `Flag002` varchar(1) DEFAULT NULL,
  `Flag003` varchar(1) DEFAULT NULL,
  `Flag099` varchar(1) DEFAULT NULL,
  `Flag018` varchar(1) DEFAULT NULL,
  `Flag084` varchar(1) DEFAULT NULL,
  `Flag132` varchar(1) DEFAULT NULL,
  `Flag005` varchar(1) DEFAULT NULL,
  `Flag174` varchar(1) DEFAULT NULL,
  `Flag046` varchar(1) DEFAULT NULL,
  `signature` varchar(45) DEFAULT NULL,
  `entryDatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`stationId`,`yyyy`,`mm`,`dd`,`hh`)
);

CREATE TABLE IF NOT EXISTS `observationschedule` (
  `classifiedInto` varchar(255) DEFAULT NULL,
  `startTime` time DEFAULT NULL,
  `endTime` time DEFAULT NULL,
  `interval` varchar(255) DEFAULT NULL,
  `additionalObsTime` varchar(255) DEFAULT NULL,
  UNIQUE KEY `scheduleIdentification` (`classifiedInto`,`startTime`,`endTime`),
  CONSTRAINT `FK_mysql_climsoft_db_v4_obsSchedule` FOREIGN KEY (`classifiedInto`) REFERENCES `obsscheduleclass` (`scheduleClass`)
);

CREATE TABLE IF NOT EXISTS `form_Agro1` (
  `stationId` varchar(50) NOT NULL DEFAULT '',
  `yyyy` int(11) NOT NULL,
  `mm` int(11) NOT NULL,
  `dd` int(11) NOT NULL,
  `Val_Elem101` varchar(6) DEFAULT NULL,
  `Val_Elem102` varchar(6) DEFAULT NULL,
  `Val_Elem103` varchar(6) DEFAULT NULL,
  `Val_Elem105` varchar(6) DEFAULT NULL,
  `Val_Elem002` varchar(6) DEFAULT NULL,
  `Val_Elem003` varchar(6) DEFAULT NULL,
  `Val_Elem099` varchar(6) DEFAULT NULL,
  `Val_Elem072` varchar(6) DEFAULT NULL,
  `Val_Elem073` varchar(6) DEFAULT NULL,
  `Val_Elem074` varchar(6) DEFAULT NULL,
  `Val_Elem554` varchar(6) DEFAULT NULL,
  `Val_Elem075` varchar(6) DEFAULT NULL,
  `Val_Elem076` varchar(6) DEFAULT NULL,
  `Val_Elem561` varchar(6) DEFAULT NULL,
  `Val_Elem562` varchar(6) DEFAULT NULL,
  `Val_Elem563` varchar(6) DEFAULT NULL,
  `Val_Elem513` varchar(6) DEFAULT NULL,
  `Val_Elem005` varchar(6) DEFAULT NULL,
  `Val_Elem504` varchar(6) DEFAULT NULL,
  `Val_Elem532` varchar(6) DEFAULT NULL,
  `Val_Elem137` varchar(6) DEFAULT NULL,
  `Val_Elem018` varchar(6) DEFAULT NULL,
  `Val_Elem518` varchar(6) DEFAULT NULL,
  `Val_Elem511` varchar(6) DEFAULT NULL,
  `Val_Elem512` varchar(6) DEFAULT NULL,
  `Val_Elem503` varchar(6) DEFAULT NULL,
  `Val_Elem515` varchar(6) DEFAULT NULL,
  `Val_Elem564` varchar(6) DEFAULT NULL,
  `Val_Elem565` varchar(6) DEFAULT NULL,
  `Val_Elem566` varchar(6) DEFAULT NULL,
  `Val_Elem531` varchar(6) DEFAULT NULL,
  `Val_Elem530` varchar(6) DEFAULT NULL,
  `Val_Elem541` varchar(6) DEFAULT NULL,
  `Val_Elem542` varchar(6) DEFAULT NULL,
  `Flag101` varchar(1) DEFAULT NULL,
  `Flag102` varchar(1) DEFAULT NULL,
  `Flag103` varchar(1) DEFAULT NULL,
  `Flag105` varchar(1) DEFAULT NULL,
  `Flag002` varchar(1) DEFAULT NULL,
  `Flag003` varchar(1) DEFAULT NULL,
  `Flag099` varchar(1) DEFAULT NULL,
  `Flag072` varchar(1) DEFAULT NULL,
  `Flag073` varchar(1) DEFAULT NULL,
  `Flag074` varchar(1) DEFAULT NULL,
  `Flag554` varchar(1) DEFAULT NULL,
  `Flag075` varchar(1) DEFAULT NULL,
  `Flag076` varchar(1) DEFAULT NULL,
  `Flag561` varchar(1) DEFAULT NULL,
  `Flag562` varchar(1) DEFAULT NULL,
  `Flag563` varchar(1) DEFAULT NULL,
  `Flag513` varchar(1) DEFAULT NULL,
  `Flag005` varchar(1) DEFAULT NULL,
  `Flag504` varchar(1) DEFAULT NULL,
  `Flag532` varchar(1) DEFAULT NULL,
  `Flag137` varchar(1) DEFAULT NULL,
  `Flag018` varchar(1) DEFAULT NULL,
  `Flag518` varchar(1) DEFAULT NULL,
  `Flag511` varchar(1) DEFAULT NULL,
  `Flag512` varchar(1) DEFAULT NULL,
  `Flag503` varchar(1) DEFAULT NULL,
  `Flag515` varchar(1) DEFAULT NULL,
  `Flag564` varchar(1) DEFAULT NULL,
  `Flag565` varchar(1) DEFAULT NULL,
  `Flag566` varchar(1) DEFAULT NULL,
  `Flag531` varchar(1) DEFAULT NULL,
  `Flag530` varchar(1) DEFAULT NULL,
  `Flag541` varchar(1) DEFAULT NULL,
  `Flag542` varchar(1) DEFAULT NULL,
  `signature` varchar(45) DEFAULT NULL,
  `entryDatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`stationId`,`yyyy`,`mm`,`dd`)
);
ALTER TABLE `form_daily2` ADD COLUMN IF NOT EXISTS `entryDatetime` DATETIME NULL DEFAULT NULL AFTER `signature`;
ALTER TABLE `form_hourly` ADD COLUMN IF NOT EXISTS `entryDatetime` DATETIME NULL DEFAULT NULL AFTER `signature`;
ALTER TABLE `form_hourlywind` ADD COLUMN IF NOT EXISTS `entryDatetime` DATETIME NULL DEFAULT NULL AFTER `signature`;
ALTER TABLE `form_monthly` ADD COLUMN IF NOT EXISTS `entryDatetime` DATETIME NULL DEFAULT NULL AFTER `signature`;
ALTER TABLE `form_synoptic2_tdcf` ADD COLUMN IF NOT EXISTS `entryDatetime` DATETIME NULL DEFAULT NULL AFTER `signature`;
ALTER TABLE `form_synoptic_2_ra1` ADD COLUMN IF NOT EXISTS `entryDatetime` DATETIME NULL DEFAULT NULL AFTER `signature`;
ALTER TABLE `form_agro1` ADD COLUMN IF NOT EXISTS `entryDatetime` DATETIME NULL DEFAULT NULL AFTER `signature`;
ALTER TABLE `aws_sites` ADD COLUMN IF NOT EXISTS `GTSEncode` TINYINT(1) NULL AFTER `OperationalStatus`,

-- Create procedures for drawing data inventory charts
-- Dumping structure for procedure find_gaps
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE IF NOT EXISTS `find_gaps`(IN Stn VARCHAR(255),IN Elm INT(11),IN Opening_Date DATE,IN Closing_Date DATE)
BEGIN
DECLARE Next_Date DATE;
IF Opening_Date <= Closing_Date THEN
 SET Next_Date  = Opening_Date;
 WHILE Next_Date < Closing_Date DO
    SELECT COUNT(*) INTO @FOUND
  FROM observationfinal
  WHERE recordedfrom=Stn
  AND describedby=Elm
  AND DATE(obsDatetime)=Next_Date;

  IF @FOUND <1 THEN
   INSERT INTO gaps VALUES (Stn,Elm,Next_Date);
   Commit;
  END IF;
 SET Next_Date = DATE_ADD(Next_Date, INTERVAL 1 DAY);
 END WHILE;
END IF;
END//
DELIMITER ;

-- Dumping structure for procedure gather_stats
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE IF NOT EXISTS `gather_stats`(
	IN `Stn` VARCHAR(255),
	IN `Elm` INT(11),
	IN `Opening_Date` DATETIME,
	IN `Closing_Date` DATETIME
)
BEGIN
IF Opening_Date < Closing_Date THEN
INSERT INTO missing_stats
SELECT recordedfrom,describedby,datediff(Closing_Date,Opening_Date)-COUNT(*) AS missing,Closing_Date,Opening_Date 
FROM observationfinal
WHERE recordedfrom = Stn
AND obsdatetime >= Opening_Date
AND obsdatetime <= Closing_Date
AND describedby = Elm
GROUP by recordedfrom,describedby;
END IF;
END//
DELIMITER ;

-- Dumping structure for procedure missing_data
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE IF NOT EXISTS `missing_data`(
	IN `STN` VARCHAR(255),
	IN `ELEM` BIGINT(20),
	IN `STARTDATE` DATETIME,
	IN `ENDDATE` DATETIME
)
BEGIN
    
DECLARE NEX_DATE DATE;
    
DECLARE MISSING_VALUE VARCHAR(255);
    

SET NEX_DATE = STARTDATE;

	
    IF NEX_DATE <= ENDDATE THEN
        
WHILE NEX_DATE <= ENDDATE DO
            
SET MISSING_VALUE = NULL;
            
	    SELECT recordedFrom INTO MISSING_VALUE
	    FROM observationfinal
            WHERE recordedFrom=STN
	    AND date(obsdatetime) = NEX_DATE

	    AND describedBy=ELEM;


IF MISSING_VALUE IS NULL THEN
                   
INSERT INTO MISSING_DATA VALUES (STN,NEX_DATE,ELEM);
		   
COMMIT;
            
END IF;
            
	    SET NEX_DATE = ADDDATE(NEX_DATE, INTERVAL 1 DAY);
        
END WHILE;
    
END IF;

END//
DELIMITER ;

-- Dumping structure for procedure refresh_data
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE IF NOT EXISTS `refresh_data`()
BEGIN
DROP TABLE IF EXISTS MISSING_STATS;
CREATE TABLE MISSING_STATS(STN_ID VARCHAR(255) NOT NULL, ELEM BIGINT NOT NULL, MISSING BIGINT, Closing_Date Date,Opening_Date Date, PRIMARY KEY(STN_ID,ELEM,Closing_Date,Opening_Date));
END//
DELIMITER ;

-- Dumping structure for procedure refresh_gaps
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE IF NOT EXISTS `refresh_gaps`()
BEGIN
DROP TABLE IF EXISTS gaps;
CREATE TABLE gaps (Missing_STNID VARCHAR(255) NOT NULL, Missing_ELEM BIGINT NOT NULL, Missing_Date Date,PRIMARY KEY(Missing_STNID,Missing_ELEM,Missing_Date));
END//
DELIMITER ;
