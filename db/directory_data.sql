-- phpMyAdmin SQL Dump
-- version 2.9.0.2
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Generation Time: Jan 24, 2007 at 01:46 AM
-- Server version: 4.1.21
-- PHP Version: 4.4.2
-- 
-- Database: `diopa_modx`
-- 

-- --------------------------------------------------------

-- 
-- Table structure for table `directory_deaneries`
-- 

USE diopa_mental_test

CREATE TABLE `church_finder_deaneries` (
  `deanery_id` int(11) NOT NULL auto_increment,
  `deanery` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`deanery_id`),
  UNIQUE KEY `deanery` (`deanery`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

-- 
-- Dumping data for table `directory_deaneries`
-- 

INSERT INTO `church_finder_deaneries` (`deanery_id`, `deanery`) VALUES 
(1, 'Brandywine'),
(2, 'Bucks'),
(3, 'Conestoga'),
(4, 'Delaware'),
(5, 'Merion'),
(6, 'Montgomery'),
(7, 'Pennypack'),
(8, 'Schuylkill'),
(9, 'Southwark'),
(10, 'Wissahickon'),
(11, '');

-- --------------------------------------------------------

-- 
-- Table structure for table `directory_orgs`
-- 

CREATE TABLE `church_finder_orgs` (
  `org_id` int(11) NOT NULL auto_increment,
  `org_name` varchar(100) default NULL,
  `org_address_line1` varchar(100) default NULL,
  `org_address_line2` varchar(100) default NULL,
  `org_address_city` varchar(50) default NULL,
  `org_address_state` char(2) default NULL,
  `org_address_zip` varchar(10) default NULL,
  `org_phone` varchar(14) default NULL,
  `org_fax` varchar(14) default NULL,
  `org_website_url` varchar(200) default NULL,
  `org_deanery` varchar(50) default NULL,
  `lat` varchar(20) default NULL,
  `lng` varchar(20) default NULL,
  `ignore_address` tinyint(1) default '0',
  `org_created` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`org_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=158 ;

-- 
-- Dumping data for table `directory_orgs`
-- 

INSERT INTO `church_finder_orgs` (`org_id`, `org_name`, `org_address_line1`, `org_address_line2`, `org_address_city`, `org_address_state`, `org_address_zip`, `org_phone`, `org_fax`, `org_website_url`, `org_deanery`, `lat`, `lng`, `ignore_address`, `org_created`) VALUES 
(1, 'Church of the Good Samaritan, Paoli', '212 West Lancaster Avenue', '', 'Paoli', 'PA', '19301', '6106444040', '6106441904', 'www.good-samaritan.org', 'Brandywine', '40.041637', '-75.491902', 0, '2006-06-19 19:21:56'),
(2, 'St. Mark''s Church, Honey Brook', '1040 Chestnut Tree Road', '', 'Honey Brook', 'PA', '193440326', '6109422365', '', 'www.stmarkshb.org', 'Brandywine', '40.109335', '-75.849879', 0, '2006-06-19 19:21:56'),
(3, 'Church of the Advent, Kennett Square', '201 Crestline Drive', '', 'Kennett Square', 'PA', '193482422', '6104444624', '6104441842', 'www.church-of-the-advent.com', 'Brandywine', '39.851848', '-75.717617', 0, '2006-06-19 19:21:56'),
(4, 'St. Francis-in-the-Fields, Sugartown', '689 Sugartown Road', '', 'Malvern', 'PA', '19355', '6106470130', '', 'www.stfrancisfields.org', 'Brandywine', '39.992664', '-75.502475', 0, '2006-06-19 19:21:56'),
(5, 'St. Christopher''s Church, Oxford', '116 Lancaster Pike', '', 'Oxford', 'PA', '19363', '6109328134', '', 'www.brandywine.net/users/stchristophers', 'Brandywine', '39.788377', '-75.997938', 0, '2006-06-19 19:21:56'),
(6, 'Church of the Ascension, Parkesburg', 'P.O. Box 193', '', 'Parkesburg', 'PA', '19365', '6108579176', '6105935121', '', 'Brandywine', '39.965388', '-75.926041', 0, '2006-06-19 19:21:56'),
(7, 'Church of the Holy Trinity, West Chester', '212 South High Street', '', 'West Chester', 'PA', '193823499', '6106964640', '6106967625', 'www.HtrinityWC.com', 'Brandywine', '39.957956', '-75.602534', 0, '2006-06-19 19:21:56'),
(8, 'St. John''s Church, Concord', '576 Concord Road', '', 'Glen Mills', 'PA', '19342', '6104592994', '6104595522', 'www.saintjohnsconcord.com', 'Brandywine', '39.878953', '-75.506745', 0, '2006-06-19 19:21:56'),
(9, 'St. Paul''s Church, West Whiteland', '1105 East Lincoln Highway', '', 'Exton', 'PA', '19341', '6103632363', '6103637305', 'www.stpauls-westwhiteland.org', 'Brandywine', '40.032071', '-75.592526', 0, '2006-06-19 19:21:56'),
(10, 'St. James'' Church, Downingtown', '409 East Lancaster Avenue', '', 'Downingtown', 'PA', '19335', '6102691774', '', 'www.stjameschurch.ws', 'Brandywine', '40.009837', '-75.697114', 0, '2006-06-19 19:21:56'),
(11, 'St. Andrew''s, West Vincent', '7 St. Andrew''s Lane', '', 'Glenmoore', 'PA', '19343', '6104585277', '6104588803', '', 'Brandywine', '40.115826', '-75.697289', 0, '2006-06-19 19:21:56'),
(12, 'St. Peter''s Church in the Great Valley', 'P.O. Box 334', '', 'Paoli', 'PA', '193010334', '6106442261', '6106447967', 'www.stpetersgv.org', 'Brandywine', '40.04259', '-75.482702', 0, '2006-06-19 19:21:56'),
(13, 'Calvary Church, Rockdale', '667 Mount Road', '', 'Aston', 'PA', '19014', '6104592013', '6104592032', 'www.calvaryepiscopalrockdale.org', 'Brandywine', '39.891075', '-75.438506', 0, '2006-06-19 19:21:56'),
(14, 'St. Mary''s Church, Warwick', '61 Morningside Drive', '', 'Elverson', 'PA', '19520', '6102865734', '', 'www.forministry.com/19520SMEC', 'Brandywine', '40.16132', '-75.776083', 0, '2006-06-19 19:21:56'),
(15, 'St. John''s Church, Compass', '1520 W. Kings Highway', '', 'Gap', 'PA', '175279007', '7174424302', '', 'www.stjohnscompass.org', 'Brandywine', '40.022921', '-75.942465', 0, '2006-06-19 19:21:56'),
(16, 'Trinity Church, Coatesville', '323 East Lincoln Highway', '', 'Coatesville', 'PA', '19320', '6103844771', '6103841538', 'www.trinitycoatesville.org', 'Brandywine', '39.983746', '-75.819566', 0, '2006-06-19 19:21:56'),
(17, 'Christ Church, Eddington', 'P.O. Box 374', '', 'Bensalem', 'PA', '19020', '2156382650', '2156395441', '', 'Bucks', '40.110881', '-74.937753', 0, '2006-06-19 19:21:56'),
(18, 'Church of St. James the Greater, Bristol', '225 Walnut Street', '', 'Bristol', 'PA', '19007', '2157882228', '2157887784', '', 'Bucks', '40.097242', '-74.854051', 0, '2006-06-19 19:21:56'),
(19, 'Church of the Redeemer, Andalusia', '1065 Bristol Pike', '', 'Andalusia', 'PA', '190206414', '2156394387', '', '', 'Bucks', '40.068789', '-74.96919', 0, '2006-06-19 19:21:56'),
(20, 'St. James'' Church, Langhorne', '330 South Bellevue Avenue', '', 'Langhorne', 'PA', '19047', '2157573766', '2157570932', 'stjameslanghorne.org', 'Bucks', '40.173953', '-74.919316', 0, '2006-06-19 19:21:56'),
(21, 'Grace Church, Hulmeville', '313 Main Street', '', 'Hulmeville', 'PA', '190475801', '2157576025', '2157575404', 'www.geocities.com/grace_e_church/home.html', 'Bucks', '40.141595', '-74.908338', 0, '2006-06-19 19:21:56'),
(22, 'All Saints'', Fallsington', '9 Old Locust Street', '', 'Fallsington', 'PA', '19054', '2152955196', '', '', 'Bucks', '40.187541', '-74.816479', 0, '2006-06-19 19:21:56'),
(23, 'Church of the Incarnation, Morrisville', '1505 Makefield Road', '', 'Morrisville', 'PA', '190673149', '2152952259', '2152959540', '', 'Bucks', '40.208904', '-74.82256', 0, '2006-06-19 19:21:56'),
(24, 'St. Andrew''s Church, Yardley', '47 West Afton Avenue', '', 'Yardley', 'PA', '190671444', '2154932636', '2154933092', 'www.st.andrew-yardley.org', 'Bucks', '40.242252', '-74.841147', 0, '2006-06-19 19:21:56'),
(25, 'St. Paul''s Church, Levittown', '89 Pinewood Drive', '', 'Levittown', 'PA', '190543609', '2159468559', '', 'www.saint-pauls-levittown.org', 'Bucks', '40.155307', '-74.826877', 0, '2006-06-19 19:21:56'),
(26, 'Redemption, Southampton', '1101 Second Street Pike', '', 'Southampton', 'PA', '18966', '2153570303', '2153570336', 'www.churchoftheredemption.org', 'Bucks', '40.181239', '-75.037519', 0, '2006-06-19 19:21:56'),
(27, 'Emmanuel Church, Quakertown', '560 S. Main Street', '', 'Quakertown', 'PA', '189511571', '2155363040', '2155363492', 'www.emmanuelquakertown.org', 'Bucks', '40.433463', '-75.347609', 0, '2006-06-19 19:21:56'),
(28, 'St. Luke''s Church, Newtown', '100 E. Washington Avenue', '', 'Newtown', 'PA', '189401980', '2159682781', '2159689064', 'www.stlukesnewtown.org', 'Bucks', '40.229217', '-74.935272', 0, '2006-06-19 19:21:56'),
(29, 'St. Paul''s Church, Doylestown', 'Pine and East Oakland Streets', '', 'Doylestown', 'PA', '189014647', '2153485511', '2153484966', 'www.stpaulsdoylestown.org', 'Bucks', '40.31001', '-75.12796', 0, '2006-06-19 19:21:56'),
(30, 'Trinity Church, Buckingham', 'P.O. Box 387', '', 'Buckingham', 'PA', '189120387', '2157947921', '2157945223', 'www.trinityepiscopalbuckingham.org', 'Bucks', '40.323611', '-75.060278', 0, '2006-06-19 19:21:56'),
(31, 'Good Shepherd Church, Hilltown', 'P.O. Box 132', '', 'Hilltown', 'PA', '189270132', '2158223930', '', 'goodshepherdhilltown.org', 'Bucks', '40.34762', '-75.27118', 0, '2006-06-19 19:21:56'),
(32, 'Church of the Holy Nativity, Wrightstown', '749 Durham Road', '', 'Wrightstown', 'PA', '18940', '2155983405', '2155980199', 'holynativitychurch.org', 'Bucks', '40.278565', '-74.992462', 0, '2006-06-19 19:21:56'),
(33, 'Trinity Church, Solebury', 'P.O. Box 377', '', 'Solebury', 'PA', '18963', '2152975135', '2152970987', 'www.trinitysolebury.org', 'Bucks', '40.380556', '-75.008611', 0, '2006-06-19 19:21:56'),
(34, 'St. Philip''s Church, New Hope', '10 Chapel Road', '', 'New Hope', 'PA', '189381006', '2158625782', '', 'www.stphilipsnewhope.org', 'Bucks', '40.377389', '-74.96619', 0, '2006-06-19 19:21:56'),
(35, 'Holy Comforter, Drexel Hill', '1000 Burmont Road', '', 'Drexel Hill', 'PA', '19026', '6107896754', '6107890124', 'www.churchoftheholycomforter.org', 'Conestoga', '39.953164', '-75.313683', 0, '2006-06-19 19:21:56'),
(36, 'Incarnation Holy Sacrament Church, Drexel Hill', '3000 Garrett Road', '', 'Drexel Hill', 'PA', '190262217', '6102595148', '4844616699', 'users.rcn.com/ihschurch', 'Conestoga', '39.946983', '-75.291247', 0, '2006-06-19 19:21:56'),
(37, 'St. Faith Church, Havertown', '1208 Allston Road', '', 'Havertown', 'PA', '190833895', '6104469450', '6104469450', '', 'Conestoga', '39.97963', '-75.299795', 0, '2006-06-19 19:21:56'),
(38, 'St. Michael''s Church, Yeadon', '813 Longacre Blvd.', '', 'Yeadon', 'PA', '19050', '6102597871', '6102599047', '', 'Conestoga', '39.936104', '-75.250496', 0, '2006-06-19 19:21:56'),
(39, 'St. Alban''s, Newtown Square', '3625 Chapel Road', '', 'Newtown Square', 'PA', '19073', '6103560459', '6103562873', 'www.stalbans-ns.org', 'Conestoga', '39.987761', '-75.399926', 0, '2006-06-19 19:21:56'),
(40, 'Church of the Holy Apostles, Penn Wynne', '1020 Remington Road', '', 'Wynnewood', 'PA', '19096', '6106426617', '6106424867', 'www.cha-pa.org', 'Conestoga', '39.9857', '-75.2835', 1, '2006-06-19 19:21:56'),
(41, 'St. John the Evangelist, Lansdowne', '19 W. Baltimore Avenue', '', 'Lansdowne', 'PA', '19050', '6106233731', '6106231506', 'saintjohnschurch.tripod.com', 'Conestoga', '39.937936', '-75.273308', 0, '2006-06-19 19:21:56'),
(42, 'Trinity Church, Swarthmore', 'N. Chester Road &amp; College Avenue', '', 'Swarthmore', 'PA', '19081', '6105442297', '6105447128', 'www.trinityswarthmore.org', 'Delaware', '', '', 0, '2006-06-19 19:21:56'),
(43, 'Church of St. John the Evangelist, Essington', '16 W. Third Street', '', 'Essington', 'PA', '19029', '6105213612', '6105243612', 'stjohns_essington.worthyofpraise.org', 'Delaware', '39.864227', '-75.301115', 0, '2006-06-19 19:21:56'),
(44, 'Nevil Memorial Church of St. George', '1 West Ardmore Avenue, Box C', '', 'Ardmore', 'PA', '190031017', '6106423500', '6106424676', 'www.stgeorgeschurch.org', 'Delaware', '40.00878', '-75.293147', 0, '2006-06-19 19:21:56'),
(45, 'St. Stephen''s Church, Clifton Heights', 'P.O. Box 254', '', 'Clifton Heights', 'PA', '19018', '6106223636', '6102598342', 'www.ststephenscliftonheights.org', 'Delaware', '39.923579', '-75.299592', 0, '2006-06-19 19:21:56'),
(46, 'Trinity Church, Collingdale', '801 MacDade Blvd.', '', 'Collingdale', 'PA', '190233733', '6104612054', '', '', 'Delaware', '39.911508', '-75.277592', 0, '2006-06-19 19:21:56'),
(47, 'All Saints'', Darby', 'Main &amp; Summit Sts., P.O. Box 4', '', 'Darby', 'PA', '19023', '6105835055', '', '', 'Delaware', '', '', 0, '2006-06-19 19:21:56'),
(48, 'St. Martin''s Church, Boothwyn', '700 Meetinghouse Road', '', 'Boothwyn', 'PA', '190613503', '6104851866', '6104851344', '', 'Delaware', '39.834957', '-75.432737', 0, '2006-06-19 19:21:56'),
(49, 'St. Paul''s Church, Chester', '301 East 9th Street', '', 'Chester', 'PA', '19013', '6108725711', '6108720394', '', 'Delaware', '39.853456', '-75.358524', 0, '2006-06-19 19:21:56'),
(50, 'Christ Church, Media', '311 South Orange Street', '', 'Media', 'PA', '19063', '6105667525', '6105667950', 'www.christchurchmedia.org', 'Delaware', '39.916667', '-75.393367', 0, '2006-06-19 19:21:56'),
(51, 'Church of the Redeemer, Springfield', '145 West Springfield Road', '', 'Springfield', 'PA', '19064', '6105448113', '6105448114', 'www.redeemerspringfield.net', 'Delaware', '39.934508', '-75.332193', 0, '2006-06-19 19:21:56'),
(52, 'Church of the Atonement, Morton', '935 Amosland Road', '', 'Morton', 'PA', '190701968', '6105432103', '', '', 'Delaware', '39.906958', '-75.322614', 0, '2006-06-19 19:21:56'),
(53, 'St. Stephen''s Church, Norwood', '128 Chester Pike', '', 'Norwood', 'PA', '190741702', '6104610490', '', 'www.ststephens-norwood.org', 'Delaware', '39.892888', '-75.295912', 0, '2006-06-19 19:21:56'),
(54, 'Mision San Pablo', 'c/o St. Paul''s Church, 301 E. Ninth Street', '', 'Chester', 'PA', '190136020', '6108725711', '6108720300', '', 'Delaware', '', '', 0, '2006-06-19 19:21:56'),
(55, 'Church of St. James, Green Ridge', '3210 Concord Road', '', 'Aston', 'PA', '190141903', '6104942752', '6104943325', '', 'Delaware', '39.848126', '-75.400267', 0, '2006-06-19 19:21:56'),
(56, 'St. James'' Church, Prospect Park', 'P.O. Box 64', '', 'Prospect Park', 'PA', '190762521', '6104616698', '6104618406', 'www.stjamesprospectpark.org', 'Delaware', '39.885737', '-75.308165', 0, '2006-06-19 19:21:56'),
(57, 'Christ Church, Ridley Park', '104 Nevin Street', '', 'Ridley Park', 'PA', '190782195', '6105211626', '6105214899', 'www.christchurchridleypark.org', 'Delaware', '39.876626', '-75.324191', 0, '2006-06-19 19:21:56'),
(58, 'St. Mary''s Church, Chester', 'P.O. Box 595', '', 'Chester', 'PA', '19016', '6108748565', '6108740300', '', 'Delaware', '39.849444', '-75.356111', 0, '2006-06-19 19:21:56'),
(59, 'Church of the Good Shepherd, Rosemont', '1116 Lancaster Avenue', '', 'Rosemont', 'PA', '19010', 'Phone:', '6105257514', '', 'Merion', '40.025', '-75.325351', 0, '2006-06-19 19:21:56'),
(60, 'St. Mary''s Church, Ardmore', 'P.O. Box 86', '', 'Ardmore', 'PA', '19003', '6106491486', '6106494562', 'stmarysardmore.org', 'Merion', '40.001971', '-75.29665', 0, '2006-06-19 19:21:56'),
(61, 'St. David''s Church, Radnor', '763 Valley Forge Road', '', 'Wayne', 'PA', '19087', '6106887947', '6106871718', 'www.stdavidschurch.org', 'Merion', '40.027784', '-75.404712', 0, '2006-06-19 19:21:56'),
(62, 'All Saints'', Wynnewood', '1325 Montgomery Avenue', '', 'Wynnewood', 'PA', '19096', '6106424098', '6106644523', '', 'Merion', '40.01325', '-75.271631', 0, '2006-06-19 19:21:56'),
(63, 'St. John''s Church, Lower Merion', '404 Levering Mill Road', '', 'Bala Cynwyd', 'PA', '19004', '6106644517', '6106647881', 'www.stjohnlm.org', 'Merion', '40.007467', '-75.242791', 0, '2006-06-19 19:21:56'),
(64, 'Church of the Redeemer, Bryn Mawr', 'P.O. Box 1030', '', 'Bryn Mawr', 'PA', '19010', '6105252486', '6105258547', 'theredeemer.org', 'Merion', '40.023618', '-75.329487', 0, '2006-06-19 19:21:56'),
(65, 'Christ Church, Ithan', '536 Conestoga Road', '', 'Villanova', 'PA', '19085', '6106881110', '6106881198', 'www.christchurchithan.org', 'Merion', '40.031928', '-75.371739', 0, '2006-06-19 19:21:56'),
(66, 'St. Martin''s Church, Radnor', '400 King of Prussia Road', '', 'Radnor', 'PA', '19087', '6106884830', '6106872990', 'www.saintmartins-church.org', 'Merion', '40.047266', '-75.362274', 0, '2006-06-19 19:21:56'),
(67, 'St. Christopher''s Church, Gladwyne', '226 Righters Mill Road', '', 'Gladwyne', 'PA', '190351597', '6106428920', '6106421241', '', 'Merion', '40.033887', '-75.276183', 0, '2006-06-19 19:21:56'),
(68, 'St. Mary''s Church, Wayne', '104 Louella Avenue', '', 'Wayne', 'PA', '19087', '6106881313', '6106880889', 'www.stmaryswaynepa.org', 'Merion', '40.043788', '-75.385464', 0, '2006-06-19 19:21:56'),
(69, 'Church of St. Asaph, Bala Cynwyd', 'P.O. Box 118', '', 'Bala Cynwyd', 'PA', '19004', '6106640966', '6106643760', 'www.saintasaphs.org', 'Merion', '40.01179', '-75.23421', 0, '2006-06-19 19:21:56'),
(70, 'Church of Our Saviour, Jenkintown', 'Old York and Homestead Roads', '', 'Jenkintown', 'PA', '19046', '2158870500', '2158871596', 'www.thechurchofoursaviour.com', 'Montgomery', '40.09674', '-75.12581', 0, '2006-06-19 19:21:56'),
(71, 'Church of the Holy Trinity, Lansdale', '407 North Broad Street', '', 'Lansdale', 'PA', '19446', '2158554431', '2158551330', 'lansdaletrinity.org', 'Montgomery', '40.243725', '-75.281423', 0, '2006-06-19 19:21:56'),
(72, 'All Hallows'' Church', 'P.O. Box 132', '', 'Wyncote', 'PA', '19095', '2158851641', '2158857458', 'www.allhallowswyncote.org', 'Montgomery', '40.086673', '-75.152417', 0, '2006-06-19 19:21:56'),
(73, 'Church of St. Philip-in-the-Fields, Oreland', '317 Oreland Mill Road', '', 'Oreland', 'PA', '19075', '2152330409', '2152334983', 'members.aol.com/stphilipinfield/index.html', 'Montgomery', '40.116567', '-75.192881', 0, '2006-06-19 19:21:56'),
(74, 'St. Aidan''s, Cheltenham', 'One Central Avenue', '', 'Cheltenham', 'PA', '19012', '2153794974', '', 'staidans.ringworld.org', 'Montgomery', '40.065188', '-75.090359', 0, '2006-06-19 19:21:56'),
(75, 'Church of the Messiah, Gwynedd', 'P.O. Box 127', '', 'Gwynedd', 'PA', '194360127', '2156999204', '2156992031', 'www.messiahgwynedd.org', 'Montgomery', '40.202089', '-75.250746', 0, '2006-06-19 19:21:56'),
(76, 'Church of the Holy Nativity, Rockledge', '205 Huntingdon Pike', '', 'Rockledge', 'PA', '190464444', '2156639903', '', 'www.holynativityrockledge.org', 'Montgomery', '40.079691', '-75.088167', 0, '2006-06-19 19:21:56'),
(77, 'St. John''s Church, Huntingdon Valley', '1333 Old Welsh Road', '', 'Huntingdon Valley', 'PA', '19006', '2159473212', '2159476294', 'www.stjohnshv.org', 'Montgomery', '40.127183', '-75.08876', 0, '2006-06-19 19:21:56'),
(78, 'St. Peter''s Church, Glenside', '654 North Easton Road', '', 'Glenside', 'PA', '190384310', '2158871765', '2158871046', 'www.stpetersglenside.org', 'Montgomery', '40.111465', '-75.142873', 0, '2006-06-19 19:21:56'),
(79, 'St. Paul''s Church, Elkins Park', '7809 Old York Road', '', 'Elkins Park', 'PA', '19027', '2156354185', '2156352473', '', 'Montgomery', '40.071695', '-75.133185', 0, '2006-06-19 19:21:56'),
(80, 'St. Thomas'' Church, Whitemarsh', 'P.O. Box 247', '', 'Fort Washington', 'PA', '190340247', '2152333970', '2152332893', 'www.stthomaswhitemarsh.org', 'Montgomery', '40.138592', '-75.202175', 0, '2006-06-19 19:21:56'),
(81, 'St. Dunstan''s Church, Blue Bell', '750 Skippack Pike', '', 'Blue Bell', 'PA', '194221712', '2156430522', '2156436537', 'www.stdunstans-bluebellpa.com', 'Montgomery', '40.155661', '-75.2715', 0, '2006-06-19 19:21:56'),
(82, 'St. Anne''s Church, Abington', '2119 Old Welsh Road', '', 'Abington', 'PA', '19001', '2156591674', '2156596880', 'www.saint-annes.net', 'Montgomery', '40.135218', '-75.115766', 0, '2006-06-19 19:21:56'),
(83, 'Trinity Church, Ambler', '708 S. Bethlehem Pike', '', 'Ambler', 'PA', '19002', '2156460416', '2156463157', 'www.trinityambler.com', 'Montgomery', '40.159569', '-75.21524', 0, '2006-06-19 19:21:56'),
(84, 'St. Matthew''s Church, Maple Glen', 'P.O. Box 3069', '', 'Maple Glen', 'PA', '190028069', '2156464092', '2156463840', 'www.stmattsmapleglen.org', 'Montgomery', '40.166318', '-75.207234', 0, '2006-06-19 19:21:56'),
(85, 'Advent, Hatboro', '12 Byberry Avenue', '', 'Hatboro', 'PA', '190403895', '2156755737', '2678030851', 'www.advent-hatboro.org', 'Montgomery', '40.174622', '-75.106531', 0, '2006-06-19 19:21:56'),
(86, 'Church of the Resurrection, Mayfair', '3301 Wellington Street', '', 'Philadelphia', 'PA', '191491689', '2156244858', '2156244818', '', 'Pennypack', '40.038423', '-75.046808', 0, '2006-06-19 19:21:56'),
(87, 'Grace Church and the Incarnation', '2645 E. Venango Street', '', 'Philadelphia', 'PA', '19134', '2154235851', '2154235851', '', 'Pennypack', '39.989449', '-75.093529', 0, '2006-06-19 19:21:56'),
(88, 'Emmanuel Church, Holmesburg', '8201 Frankford Avenue', '', 'Philadelphia', 'PA', '19136', '2156248520', '2156248885', '', 'Pennypack', '40.042935', '-75.02377', 0, '2006-06-19 19:21:56'),
(89, 'Holy Innocents St. Paul''s Church, Tacony', 'P.O. Box 17719', '', 'Philadelphia', 'PA', '19135', '2156241144', '2156245974', '', 'Pennypack', '40.024694', '-75.051827', 0, '2006-06-19 19:21:56'),
(90, 'Free Church of St. John', 'P.O. Box 14798', '', 'Philadelphia', 'PA', '19134', '2154252933', '', '', 'Pennypack', '39.99252', '-75.113284', 0, '2006-06-19 19:21:56'),
(91, 'All Saints'', Crescentville', '6301 Crescentville Road', '', 'Philadelphia', 'PA', '19120', '2152241035', '', '', 'Pennypack', '40.045242', '-75.112819', 0, '2006-06-19 19:21:56'),
(92, 'All Saints'', Rhawnhurst', '1811 Loney Street', '', 'Philadelphia', 'PA', '191112911', '2153426310', '2153429131', '', 'Pennypack', '40.062471', '-75.06068', 0, '2006-06-19 19:21:56'),
(93, 'All Saints'', Torresdale', '9601 Frankford Avenue', '', 'Philadelphia', 'PA', '19114', '2156378787', '2156375103', 'www.allsaintstorresdale.org', 'Pennypack', '40.058832', '-74.995397', 0, '2006-06-19 19:21:56'),
(94, 'La Iglesia de Christo y San Ambrosio', 'P.O. Box 38109', '', 'Philadelphia', 'PA', '19140', '2152265310', '2152261040', '', 'Pennypack', '40.011771', '-75.145626', 0, '2006-06-19 19:21:56'),
(95, 'Emmanuel &amp; The Good Shepherd', '2136 East Firth Street', '', 'Philadelphia', 'PA', '19125', '2154263147', '', '', 'Pennypack', '39.982894', '-75.124616', 0, '2006-06-19 19:21:56'),
(96, 'St. Mark''s Church, Frankford', '4442 Frankford Avenue', '', 'Philadelphia', 'PA', '19124', '2155350635', '2155350614', 'www.stmarksfrankford.org', 'Pennypack', '40.013117', '-75.087027', 0, '2006-06-19 19:21:56'),
(97, 'St. Gabriel''s Church', '101 E. Roosevelt Blvd.', '', 'Philadelphia', 'PA', '19120', '2153293807', '2153293883', 'www.geocities.com/stgabrielschurch', 'Pennypack', '40.025925', '-75.123208', 0, '2006-06-19 19:21:56'),
(98, 'Memorial Church of St. Luke', '1946 Welsh Road', '', 'Philadelphia', 'PA', '191154654', '2159693645', '2159698844', 'memorialchurchofstluke.org', 'Pennypack', '40.080881', '-75.037288', 0, '2006-06-19 19:21:56'),
(99, 'Trinity Church, Oxford', '6901 Rising Sun Avenue', '', 'Philadelphia', 'PA', '19111', '2157456114', '2157451258', 'www.trinitychurchoxford.org', 'Pennypack', '40.055848', '-75.089383', 0, '2006-06-19 19:21:56'),
(100, 'St. Andrew''s-in-the-Field, Somerton', '500 Somerton Avenue', '', 'Philadelphia', 'PA', '19116', '2156735938', '2156730548', '', 'Pennypack', '40.123062', '-75.019524', 0, '2006-06-19 19:21:56'),
(101, 'St. George St. Barnabas Church', '520 S. 61st Street', '', 'Philadelphia', 'PA', '19143', '2157472605', '2157475165', '', 'Schuylkill', '39.953355', '-75.244566', 0, '2006-06-19 19:21:56'),
(102, 'African Episcopal Church of St. Thomas, Overbrook', '6361 Lancaster Avenue', '', 'Philadelphia', 'PA', '19151', '2154733065', '2154733529', '', 'Schuylkill', '39.987162', '-75.251823', 0, '2006-06-19 19:21:56'),
(103, 'St. Martin''s Episcopal Korean Congregation', 'c/o 3723 Chestnut Street', '', 'Philadelphia', 'PA', '19104', '2153860234', '2153865009', 'my.dreamwiz.com/johnjkkim', 'Schuylkill', '', '', 0, '2006-06-19 19:21:56'),
(104, 'St. Mary''s Church, Hamilton Village', '3916 Locust Walk', '', 'Philadelphia', 'PA', '191046152', '2153863916', '2153867288', 'www.stmarysatpenn.org', 'Schuylkill', '39.952726', '-75.200991', 0, '2006-06-19 19:21:56'),
(105, 'Philadelphia Cathedral', '3723 Chestnut Street', '', 'Philadelphia', 'PA', '19104', '2153860234', '2153865009', 'www.philadelphiacathedral.org', 'Schuylkill', '39.954928', '-75.196955', 0, '2006-06-19 19:21:56'),
(106, 'Church of St. James, Kingsessing', '6838 Woodland Avenue', '', 'Philadelphia', 'PA', '19142', '2157275265', '', '', 'Schuylkill', '39.922333', '-75.238951', 0, '2006-06-19 19:21:56'),
(107, 'Calvary Church, N.L.', '814 North 41st Street', '', 'Philadelphia', 'PA', '19104', '2152222070', '2152225860', 'www.calvaryepiscopalnl.org', 'Schuylkill', '39.967773', '-75.205756', 0, '2006-06-19 19:21:56'),
(108, 'Church of the Holy Apostles and the Mediator', '51st and Spruce Streets', '', 'Philadelphia', 'PA', '19139', '2154723000', '2154722099', 'www.hamphilly.org', 'Schuylkill', '39.9544', '-75.22396', 0, '2006-06-19 19:21:56'),
(109, 'Church of St. Andrew and St. Monica', '3600 Baring Street', '', 'Philadelphia', 'PA', '19104', '2152227606', '2152228199', '', 'Schuylkill', '39.961102', '-75.194158', 0, '2006-06-19 19:21:56'),
(110, 'All Souls'' Church for the Deaf', 'P.O. Box 27459', '', 'Philadelphia', 'PA', '191180459', '2152471059', '2152471059', '', 'Southwark', '40.081247', '-75.2006', 0, '2006-06-19 19:21:56'),
(111, 'Church of the Crucifixion', '620 South Eighth Street', '', 'Philadelphia', 'PA', '19147', '2159221128', '', '', 'Southwark', '39.941802', '-75.155648', 0, '2006-06-19 19:21:56'),
(112, 'Church of St. John the Evangelist, Philadelphia', '1332 So. Third Street', '', 'Philadelphia', 'PA', '191476031', '2154684020', '', '', 'Southwark', '39.930864', '-75.149923', 0, '2006-06-19 19:21:56'),
(113, 'Gloria Dei Church', '916 S. Swanson Street', '', 'Philadelphia', 'PA', '19147', '2153891513', '2153897817', 'www.old-swedes.org', 'Southwark', '39.935189', '-75.143291', 0, '2006-06-19 19:21:56'),
(114, 'St. Stephen''s, Philadelphia', 'P.O. Box 1103', '', 'Philadelphia', 'PA', '191051103', '2159223807', '2158294561', 'www.ststephensphl.org/index.html', 'Southwark', '39.952222', '-75.164167', 0, '2006-06-19 19:21:56'),
(115, 'St. Simon the Cyrenian Church', '1401 South 22nd Street', '', 'Philadelphia', 'PA', '19146', '2154681926', '2154681923', '', 'Southwark', '39.93453', '-75.180971', 0, '2006-06-19 19:21:56'),
(116, 'St. Philip''s Memorial Church', '2635 Wharton Street', '', 'Philadelphia', 'PA', '191463835', '2153341054', '2153349651', 'www.philbro.org', 'Southwark', '39.936756', '-75.187897', 0, '2006-06-19 19:21:56'),
(117, 'Church of St. Luke and Epiphany', '330 South 13th Street', '', 'Philadelphia', 'PA', '191075916', '2157321918', '2157325081', 'www.stlukeandtheepiphany.org', 'Southwark', '39.945758', '-75.162819', 0, '2006-06-19 19:21:56'),
(118, 'St. Peter''s Church, Philadelphia', '313 Pine Street', '', 'Philadelphia', 'PA', '19106', '2159255968', '2159254331', 'www.stpetersphila.org', 'Southwark', '39.94341', '-75.14772', 0, '2006-06-19 19:21:56'),
(119, 'Christ Church, Philadelphia', '20 No. American Street', '', 'Philadelphia', 'PA', '19106', '2159221695', '2159223578', 'www.christchurchphila.org', 'Southwark', '39.950747', '-75.14403', 0, '2006-06-19 19:21:56'),
(120, 'Trinity Memorial Church', '2212 Spruce Street', '', 'Philadelphia', 'PA', '19103', '2157322515', '2157322512', 'www.trinityphiladelphia.org', 'Southwark', '39.948606', '-75.178084', 0, '2006-06-19 19:21:56'),
(121, 'St. Mark''s Church, Philadelphia', '1625 Locust Street', '', 'Philadelphia', 'PA', '19103', '2157351416', '2157350572', 'www.saintmarksphiladelphia.org', 'Southwark', '39.948569', '-75.168233', 0, '2006-06-19 19:21:56'),
(122, 'St. Clement''s Church', '2013 Appletree Street', '', 'Philadelphia', 'PA', '19103', '2155631876', '2155637627', 'www.s-clements.org', 'Southwark', '39.956096', '-75.172935', 0, '2006-06-19 19:21:56'),
(123, 'Church of the Holy Trinity, Rittenhouse Square', '1904 Walnut Street', '', 'Philadelphia', 'PA', '19103', '2155671267', '2155673766', 'www.htrit.org', 'Southwark', '39.950341', '-75.172813', 0, '2006-06-19 19:21:56'),
(124, 'St. Mary''s Church, Philadelphia', '1831 Bainbridge Street', '', 'Philadelphia', 'PA', '19146', '2159850360', '2159850427', '', 'Southwark', '39.943596', '-75.172625', 0, '2006-06-19 19:21:56'),
(125, 'Church of St. Jude and the Nativity', '203 Germantown Pike', '', 'Lafayette Hill', 'PA', '194441323', '6109416666', '6108283927', 'stjudeandthenativity.org', 'Valley Forge', '40.097448', '-75.268538', 0, '2006-06-19 19:21:56'),
(126, 'All Saints'', Norristown', '535 Haws Avenue', '', 'Norristown', 'PA', '194014542', '6102793990', '6102793001', 'www.allsaints535.org', 'Valley Forge', '40.120543', '-75.352549', 0, '2006-06-19 19:21:56'),
(127, 'St. Dismas Mission Congregation', '1831 Bainbridge St.', '', 'Philadelphia', 'PA', '19146', '2159850360', '2159850427', '', 'Valley Forge', '39.943596', '-75.172625', 0, '2006-06-19 19:21:56'),
(128, 'Church of St. Augustine of Hippo, Norristown', '1208 Green Street', '', 'Norristown', 'PA', '19401', '6102798890', '', '', 'Valley Forge', '40.121033', '-75.335171', 0, '2006-06-19 19:21:56'),
(129, 'St. John''s Church, Norristown', '23 East Airy Street', '', 'Norristown', 'PA', '19401', '6102724092', '6102721755', 'www.stjohnsnorristown.org', 'Valley Forge', '40.115752', '-75.342718', 0, '2006-06-19 19:21:56'),
(130, 'Christ Church, Upper Merion', '740 River Road', '', 'Bridgeport', 'PA', '19405', '6102726036', '', '', 'Valley Forge', '40.103212', '-75.326776', 0, '2006-06-19 19:21:56'),
(131, 'Trinity Church, Gulph Mills', '966 Trinity Lane', '', 'King of Prussia', 'PA', '19406', '6108281500', '6108280411', 'www.trinitygmills.org', 'Valley Forge', '40.071776', '-75.34244', 0, '2006-06-19 19:21:56'),
(132, 'St. James'' Church, Perkiomen', '3768 Germantown Pike', '', 'Collegeville', 'PA', '19426', '6104897564', '6104897651', 'www.stjames-episcopal.org', 'Valley Forge', '40.180459', '-75.428464', 0, '2006-06-19 19:21:56'),
(133, 'Church of the Holy Spirit, Harleysville', '2871 Barndt Road', '', 'Harleysville', 'PA', '19438', '2152348020', '2152348024', 'www.churchoftheholyspirit.us', 'Valley Forge', '40.265922', '-75.4352', 0, '2006-06-19 19:21:56'),
(134, 'St. Paul''s Church, Oaks', 'P.O. Box 404', '', 'Oaks', 'PA', '194560404', '6106509336', '6106500343', 'www.stpaulsoaks.org', 'Valley Forge', '40.131667', '-75.46', 0, '2006-06-19 19:21:56'),
(135, 'St. Peter''s Church, Phoenixville', '121 Church Street', '', 'Phoenixville', 'PA', '19460', '6109332195', '6109336565', '', 'Valley Forge', '40.13314', '-75.513386', 0, '2006-06-19 19:21:56'),
(136, 'Christ Church, Pottstown', '316 High Street, P.O. Box 252', '', 'Pottstown', 'PA', '19464', '6103232895', '6103233745', 'www.christpottstown.org', 'Valley Forge', '40.245162', '-75.646645', 0, '2006-06-19 19:21:56'),
(137, 'Church of the Epiphany, Royersford', '209 So. Third Avenue', '', 'Royersford', 'PA', '19468', '6109489655', '', 'www.epiphanyc.org', 'Valley Forge', '40.182046', '-75.538625', 0, '2006-06-19 19:21:56'),
(138, 'Washington Memorial Chapel', 'Route 23, P.O. Box 98', '', 'Valley Forge', 'PA', '194810009', '6107830120', '6107830330', 'www.washingtonmemorialchapel.org', 'Valley Forge', '', '', 0, '2006-06-19 19:21:56'),
(139, 'Calvary Church, Conshohocken', 'P.O. Box 546', '', 'Conshohocken', 'PA', '19428', '6108255959', '6108255959', '', 'Valley Forge', '40.079848', '-75.301332', 0, '2006-06-19 19:21:56'),
(140, 'Christ Church and St. Michael''s', '29 West Tulpehocken Street', '', 'Philadelphia', 'PA', '19144', '2158447274', '2158446438', 'www.christchurchand.com', 'Wissahickon', '40.041594', '-75.180623', 0, '2006-06-19 19:21:56'),
(141, 'St. Timothy''s Church, Roxborough', '5720 Ridge Avenue', '', 'Philadelphia', 'PA', '19128', '2154831529', '2154834476', 'www.geocities.com/sttimothys1859', 'Wissahickon', '40.027403', '-75.209682', 0, '2006-06-19 19:21:56'),
(142, 'Church of St. Martin''s-in-the-Fields,Chestnut Hill', '8000 St. Martin''s Lane', '', 'Philadelphia', 'PA', '19118', '2152477466', '2152472638', 'www.stmartinec.org', 'Wissahickon', '40.06543', '-75.206352', 0, '2006-06-19 19:21:56'),
(143, 'St. Paul''s Church, Chestnut Hill', '22 East Chestnut Hill Avenue', '', 'Philadelphia', 'PA', '191182715', '2152422055', '2152421620', 'www.stpaulschestnuthill.org', 'Wissahickon', '40.079429', '-75.209235', 0, '2006-06-19 19:21:56'),
(144, 'Grace Epiphany Church, Mt. Airy', '224 East Gowen Avenue', '', 'Philadelphia', 'PA', '19119', '2152482950', '2157530354', 'www.grace-epi.org', 'Wissahickon', '40.065487', '-75.190008', 0, '2006-06-19 19:21:56'),
(145, 'Church of the Annunciation', '324 Carpenter Lane', '', 'Philadelphia', 'PA', '191193003', '2158443059', '2158447330', '', 'Wissahickon', '40.049924', '-75.192116', 0, '2006-06-19 19:21:56'),
(146, 'George W. South Memorial Church of the Advocate', '1801 Diamond Street', '', 'Philadelphia', 'PA', '191211520', '2152360568', '2152365253', 'www.churchoftheadvocate.org', 'Wissahickon', '39.985548', '-75.163066', 0, '2006-06-19 19:21:56'),
(147, 'St. David''s Church, Manayunk', 'P.O. Box 29102', '', 'Philadelphia', 'PA', '19127', '2154822345', '', 'www.stdavidsmanayunk.org', 'Wissahickon', '40.027512', '-75.224167', 0, '2006-06-19 19:21:56'),
(148, 'St. Luke''s Church, Germantown', '5421 Germantown Avenue', '', 'Philadelphia', 'PA', '191442223', '2158448544', '2158440763', 'www.stlukesger.org', 'Wissahickon', '40.033356', '-75.170951', 0, '2006-06-19 19:21:56'),
(149, 'St. Mary''s Church, Cathedral Road', '630 East Cathedral Road', '', 'Philadelphia', 'PA', '19128', '2154826300', '2159858617', '', 'Wissahickon', '40.063038', '-75.241207', 0, '2006-06-19 19:21:56'),
(150, 'St. Peter''s Church, Germantown', '6008 Wayne Avenue', '', 'Philadelphia', 'PA', '19144', '2158441203', '2158441203', 'www.specog.org', 'Wissahickon', '40.034171', '-75.183129', 0, '2006-06-19 19:21:56'),
(151, 'Memorial Church of the Good Shepherd, East Falls', '3820 The Oak Road', '', 'Philadelphia', 'PA', '19129', '2158440580', '2158440581', 'www.goodshepherd-eastfalls.org', 'Wissahickon', '40.022292', '-75.182533', 0, '2006-06-19 19:21:56'),
(152, 'St. Augustine''s Church of the Covenant', '2701 W. Girard Avenue', '', 'Philadelphia', 'PA', '19130', '2157630624', '2157630624', '', 'Wissahickon', '39.974137', '-75.180505', 0, '2006-06-19 19:21:56'),
(153, 'Church of St. James the Less', '3227 West Clearfield Street', '', 'Philadelphia', 'PA', '19132', '2152295767', '2152292445', '', 'Wissahickon', '40.003932', '-75.182446', 0, '2006-06-19 19:21:56'),
(154, 'House of Prayer', '1747 Church Lane', '', 'Philadelphia', 'PA', '19141', '2155497650', '', '', 'Wissahickon', '40.046283', '-75.148757', 0, '2006-06-19 19:21:56'),
(155, 'Calvary Church, Germantown', '5020 Pulaski Avenue', '', 'Philadelphia', 'PA', '19144', '2158430853', '', '', 'Wissahickon', '40.024058', '-75.169463', 0, '2006-06-19 19:21:56'),
(156, 'Church of the St. Alban, Roxborough', '6769B Ridge Avenue', '', 'Philadelphia', 'PA', '19128', '2154822627', '', '', 'Wissahickon', '40.041806', '-75.225705', 0, '2006-06-19 19:21:56'),
(157, 'Lutheran Episcopal Campus Ministry', '1801 North Broad Street', '', 'Philadelphia', 'PA', '19122', NULL, NULL, 'www.templelecm.org', 'Pennypack', '39.980200', '-75.157324', 0, '2006-10-09 19:37:21');

-- --------------------------------------------------------

-- 
-- Table structure for table `directory_people`
-- 

CREATE TABLE `church_finder_people` (
  `people_id` int(11) NOT NULL auto_increment,
  `people_first_name` varchar(100) default NULL,
  `people_last_name` varchar(100) default NULL,
  `people_home_address_line1` varchar(100) default NULL,
  `people_home_address_line2` varchar(100) default NULL,
  `people_home_address_city` varchar(50) default NULL,
  `people_home_address_state` char(2) default NULL,
  `people_home_address_zip` varchar(10) default NULL,
  `people_home_phone` varchar(14) default NULL,
  `people_home_fax` varchar(14) default NULL,
  `people_website_url` varchar(200) default NULL,
  `people_created` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`people_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `directory_people`
-- 

