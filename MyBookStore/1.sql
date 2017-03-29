CREATE TABLE Books
(
  id				    int(10)  NOT NULL AUTO_INCREMENT ,
  name       			varchar(40)  NOT NULL UNIQUE,     
  price 				float(7,2) NOT NULL ,
  number				int(10) NOT NULL ,
  type     				varchar(20) NOT NULL ,
  author				varchar(40) NOT NULL ,
  src  					varchar(80) NOT NULL ,
  publishTime			datetime    NOT NULL ,
  primary key(id)
);
CREATE TABLE usersBook
(
	id				    int(10)  NOT NULL AUTO_INCREMENT ,
	bookId 	int(10)  NOT NULL ,
	userId 	int(10)  NOT NULL ,
    number int(10)  NOT NULL ,
    primary key(id)
);
CREATE TABLE bookComments
(
	bookId 	int(10)  NOT NULL ,
	userId 	int(10)  NOT NULL ,
    comment varchar(60) NOT NULL
);
CREATE TABLE bookUser
(
  id				    int(10)  NOT NULL AUTO_INCREMENT ,
  name       			varchar(40)  NOT NULL UNIQUE,     
  email 				varchar(40) NOT NULL ,
  phone				varchar(20) NOT NULL ,
  password     				varchar(20) NOT NULL ,
  money				int(10) NOT NULL ,
  primary key(id)
);
insert into bookuser values('1','null','null','null','null','99999999.99');