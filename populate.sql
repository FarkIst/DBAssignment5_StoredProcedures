show variables like '%local_infile%';


set global local_infile = 1;


DROP TABLE IF EXISTS badges, comments, post_history, post_links, posts, tags, users, votes;


create table badges (
  Id INT NOT NULL PRIMARY KEY,
  UserId INT,
  Name VARCHAR(50),
  Date DATETIME
);

CREATE TABLE comments (
    Id INT NOT NULL PRIMARY KEY,
    PostId INT NOT NULL,
    Score INT NOT NULL DEFAULT 0,
    Text TEXT,
    CreationDate DATETIME,
    UserId INT NOT NULL
);

CREATE TABLE post_history (
    Id INT NOT NULL PRIMARY KEY,
    PostHistoryTypeId SMALLINT NOT NULL,
    PostId INT NOT NULL,
    RevisionGUID VARCHAR(36),
    CreationDate DATETIME,
    UserId INT NOT NULL,
    Text TEXT
);
CREATE TABLE post_links (
  Id INT NOT NULL PRIMARY KEY,
  CreationDate DATETIME DEFAULT NULL,
  PostId INT NOT NULL,
  RelatedPostId INT NOT NULL,
  LinkTypeId INT DEFAULT NULL
);


CREATE TABLE posts (
    Id INT NOT NULL PRIMARY KEY,
    PostTypeId SMALLINT,
    AcceptedAnswerId INT,
    ParentId INT,
    Score INT NULL,
    ViewCount INT NULL,
    Body text NULL,
    OwnerUserId INT NOT NULL,
    LastEditorUserId INT,
    LastEditDate DATETIME,
    LastActivityDate DATETIME,
    Title varchar(256) NOT NULL,
    Tags VARCHAR(256),
    AnswerCount INT NOT NULL DEFAULT 0,
    CommentCount INT NOT NULL DEFAULT 0,
    FavoriteCount INT NOT NULL DEFAULT 0,
    CreationDate DATETIME
);

CREATE TABLE tags (
  Id INT NOT NULL PRIMARY KEY,
  TagName VARCHAR(50) CHARACTER SET latin1 DEFAULT NULL,
  Count INT DEFAULT NULL,
  ExcerptPostId INT DEFAULT NULL,
  WikiPostId INT DEFAULT NULL
);


CREATE TABLE users (
    Id INT NOT NULL PRIMARY KEY,
    Reputation INT NOT NULL,
    CreationDate DATETIME,
    DisplayName VARCHAR(50) NULL,
    LastAccessDate  DATETIME,
    Views INT DEFAULT 0,
    WebsiteUrl VARCHAR(256) NULL,
    Location VARCHAR(256) NULL,
    AboutMe TEXT NULL,
    Age INT,
    UpVotes INT,
    DownVotes INT,
    EmailHash VARCHAR(32)
);

CREATE TABLE votes (
    Id INT NOT NULL PRIMARY KEY,
    PostId INT NOT NULL,
    VoteTypeId SMALLINT,
    CreationDate DATETIME
);

load xml local infile 'D:/CphBusinessBachelor/Databases/Assignment5/Badges.xml' into table badges rows identified by '<row>';
load xml local infile 'D:/CphBusinessBachelor/Databases/Assignment5/Comments.xml' into table comments rows identified by '<row>';
load xml local infile 'D:/CphBusinessBachelor/Databases/Assignment5/PostHistory.xml' into table post_history rows identified by '<row>';
load xml local infile 'D:/CphBusinessBachelor/Databases/Assignment5/PostLinks.xml' into table post_links rows identified by '<row>';
load xml local infile 'D:/CphBusinessBachelor/Databases/Assignment5/Posts.xml' into table posts rows identified by '<row>';
load xml local infile 'D:/CphBusinessBachelor/Databases/Assignment5/Tags.xml' into table tags rows identified by '<row>';
load xml local infile 'D:/CphBusinessBachelor/Databases/Assignment5/Users.xml' into table users rows identified by '<row>';
load xml local infile 'D:/CphBusinessBachelor/Databases/Assignment5/Votes.xml' into table votes rows identified by '<row>';



alter table posts change Title Title varchar(256) null;
alter table posts change FavoriteCount FavoriteCount int null, change AnswerCount AnswerCount int null;

