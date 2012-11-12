/*create database*/
DROP DATABASE IF EXISTS creg;
CREATE DATABASE creg;
GRANT ALL PRIVILEGES ON creg.* to 'creg@localhost';
USE creg;

/*Create tables*/
DROP TABLE IF EXISTS events;
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS entities;
DROP TABLE IF EXISTS logs;

/*event-transactions object contains changes in an entity' attributes*/
CREATE TABLE events (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
date DATETIME NOT NULL,
/*entities_id INT UNSIGNED NOT NULL,*/
details VARCHAR(250),
modified TIMESTAMP NOT NULL , /*for debugging purpose*/
created TIMESTAMP NOT NULL, /*for debugging purpose*/
void TINYINT DEFAULT NULL);
/**/
CREATE TABLE transactions (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
event_id INT UNSIGNED NOT NULL,
date DATETIME NOT NULL, /*transactions of the same event may have different dates*/
type VARCHAR(25) NOT NULL,
details VARCHAR(250),
val BLOB,
actor_id INT, /*the same as entity_id, but points to the entity, which is part of transaction*/
entity_id INT,
modified TIMESTAMP NOT NULL, /*for debugging purpose*/
created TIMESTAMP NOT NULL, /*for debugging purpose*/
void TINYINT DEFAULT NULL);
/**/
/*all attributes are 'dynamically' set by records in transactions table*/
/*user's records are stored in entities table too*/
CREATE TABLE entities (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50) NOT NULL UNIQUE,
type VARCHAR(50) NOT NULL,
username VARCHAR(50),
password char(41),
modified TIMESTAMP NOT NULL , /*for debugging purpose*/
created TIMESTAMP, /*for debugging purpose*/
void TINYINT DEFAULT NULL);
/**/
CREATE TABLE logs (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
entity_id INT UNSIGNED NOT NULL, /*user, who invoked the event*/
transaction_id INT UNSIGNED,
type VARCHAR(25) NOT NULL,
details VARCHAR(250),
modified TIMESTAMP NOT NULL , /*for debugging purpose*/
created TIMESTAMP NOT NULL, 
old_val BLOB);
/*------------------------*/

/* test data */
INSERT INTO entities (name,type,username,password) 
	VALUES ('John Lennon','private','',''); /*1 */
INSERT INTO entities (name,type,username,password) 
	VALUES ('Evgeni Boson','private','',''); /*2 */
INSERT INTO entities (name,type,username,password) 
	VALUES ('Anika Marine','corp','',''); /*3  - 'external' entity*/
INSERT INTO entities (name,type,username,password) 
	VALUES ('Dolorosa Ltd','corp','',''); /*4*/
INSERT INTO entities (name,type,username,password) 
	VALUES ('Hellenic Bank','bank','',''); /*5*/
/* */
INSERT INTO events (date,details) VALUES (NOW(),'entity attribute change'); /*1*/
INSERT INTO events (date,details) VALUES (NOW(),'entity attribute change'); /*2*/
INSERT INTO events (date,details) VALUES (NOW(),'entity attribute change'); /*3*/
INSERT INTO events (date,details) VALUES (NOW(),'entity attribute change'); /*4*/
INSERT INTO events (date,details) VALUES (NOW(),'Company incorporation'); /*5*/
INSERT INTO events (date,details) VALUES (NOW(),'Change of director'); /*6*/
/*-------- entity attribute change--------------- */
INSERT INTO transactions (event_id,date,type,details,val,actor_id,entity_id)
 VALUES(1,ADDDATE(NOW(),-100),'addr-street','','Liverpool - 08','',1);
INSERT INTO transactions (event_id,date,type,details,val,actor_id,entity_id)
 VALUES(1,ADDDATE(NOW(),-100),'addr-country','','UK','',1);
INSERT INTO transactions (event_id,date,type,details,val,actor_id,entity_id)
 VALUES(1,ADDDATE(NOW(),-250),'id-passport','','passport-image.pdf','',1);
INSERT INTO transactions (event_id,date,type,details,val,actor_id,entity_id)
 VALUES(1,ADDDATE(NOW(),-90),'id-bankref','','scan-copy-of-letter.pdf','',1);
/* */
INSERT INTO transactions (event_id,date,type,details,val,actor_id,entity_id) 
 VALUES(2,ADDDATE(NOW(),-117),'addr-street','','23,Piraeus,2442','',2);
INSERT INTO transactions (event_id,date,type,details,val,actor_id,entity_id)
 VALUES(2,ADDDATE(NOW(),-117),'addr-country','','GR','',2);
INSERT INTO transactions (event_id,date,type,details,val,actor_id,entity_id)
 VALUES(2,ADDDATE(NOW(),-52),'id-passport','','passport-image.pdf','',2);
INSERT INTO transactions (event_id,date,type,details,val,actor_id,entity_id)
 VALUES(2,ADDDATE(NOW(),-127),'id-bankref','','scan-copy-of-letter.pdf','',2);
/* */
INSERT INTO transactions (event_id,date,type,details,val,actor_id,entity_id) 
 VALUES(3,ADDDATE(NOW(),-24),'addr-street','','442, Copenhagen, Taxhaaven','',3);
INSERT INTO transactions (event_id,date,type,details,val,actor_id,entity_id)
 VALUES(3,ADDDATE(NOW(),-24),'addr-country','','DK','',3);
INSERT INTO transactions (event_id,date,type,details,val,actor_id,entity_id)
 VALUES(3,ADDDATE(NOW(),-24),'id-cert-inc','','copy of certificate of incorporation.pdf','',2);
/* */
INSERT INTO transactions (event_id,date,type,details,val,actor_id,entity_id) 
 VALUES(4,ADDDATE(NOW(),-15),'addr-street','permanent change of residence','New York, Dakota 2','',1);
INSERT INTO transactions (event_id,date,type,details,val,actor_id,entity_id)
 VALUES(4,ADDDATE(NOW(),-15),'addr-country','','US','',1);
/*------------- Company incorporation --------------- */
INSERT INTO transactions (event_id,date,type,details,val,actor_id,entity_id)
 VALUES(5, ADDDATE(NOW(),-12),'equity-val','Initial issue of shares','800 EUR',3,4);
INSERT INTO transactions (event_id,date,type,details,val,actor_id,entity_id)
 VALUES(5,ADDDATE(NOW(),-12),'equity-qnt','Initial issue of shares',800,3,4);
INSERT INTO transactions (event_id,date,type,details,val,actor_id,entity_id)
 VALUES(5,ADDDATE(NOW(),-12),'addr-street','Registered address','','3B Omirou, Limassol',4);
INSERT INTO transactions (event_id,date,type,details,val,actor_id,entity_id)
 VALUES(5,ADDDATE(NOW(),-12),'addr-country','Company jurisdiction','CY','',4);
INSERT INTO transactions (event_id,date,type,details,val,actor_id,entity_id)
 VALUES(5,ADDDATE(NOW(),-12),'officers-dir','Appointment of first director',1,1,4);
/*------------- Change of director --------------- */
INSERT INTO transactions (event_id,date,type,details,val,actor_id,entity_id)
 VALUES(6,ADDDATE(NOW(),-10),'officers-dir','resignation of inumbent officer',-1,1,4);
INSERT INTO transactions (event_id,date,type,details,val,actor_id,entity_id)
 VALUES(6,ADDDATE(NOW(),-10),'officers-dir','appointment of new director',1,2,4); 
