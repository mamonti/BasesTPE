
CREATE TABLE userTP (
ID INT,
reputation INT,
creationDate TIMESTAMP,
displayName TEXT,
lastAccessDate TIMESTAMP,
websiteUrl TEXT,
loaction TEXT,
aboutMe TEXT,
views INT,
upVotes INT,
downVotes INT, 
acountID INT,

PRIMARY KEY(ID)
);

CREATE TABLE badges (
ID INT,
userID INT,
badgeName TEXT,
badgeDate TIMESTAMP,
badgeclass INT,
tagBased BOOLEAN,

PRIMARY KEY(ID),
FOREIGN KEY(userID) REFERENCES userTP
);

CREATE OR REPLACE FUNCTION migrate () RETURNS VOID 
AS $$
  BEGIN
    COPY userTP FROM '/Users/florenciamonti/Desktop/bases/Users.tsv' (DELIMITER ' ');
    COPY badges FROM '/Users/florenciamonti/Desktop/bases/Badges.tsv' (DELIMITER ' ');
  
    DROP TABLE userTP; 
    DROP TABLE badges;
END; 
$$ LANGUAGE PLPGSQL;


SELECT * FROM migrate(); 
SELECT * FROM userTP;
SELECT * FROM badges;
