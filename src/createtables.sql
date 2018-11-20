
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
    COPY userTP FROM '../resources/Users.tsv' (DELIMITER ' ');
    COPY badges FROM '../resources/Badges.tsv' (DELIMITER ' ');

    DROP TABLE userTP;
    DROP TABLE badges;
END;
$$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION upVotesRep() RETURNS Trigger AS $$
BEGIN
    IF new.upVotes >= 0 THEN
        new.reputation := old.reputation + (new.upVotes - old.upVotes) * 5;
    ELSE
        new.reputation := old.reputation - (old.upVotes) * 5;
        new.upVotes := 0;
        END IF;

    IF new.reputation < 1 THEN
        new.reputation := 1;
    END IF;

    RETURN new;
END;

$$ LANGUAGE plpgsql;

CREATE TRIGGER UPVOTESTOPREF
BEFORE UPDATE OF upVotes ON USERTP
FOR EACH ROW
EXECUTE PROCEDURE upVotesRep();



CREATE OR REPLACE FUNCTION downVotesRep() RETURNS Trigger AS $$
BEGIN
    IF new.downVotes >= 0 THEN
        new.reputation := old.reputation - (new.downVotes - old.downVotes) * 2;
    ELSE
        new.reputation := old.reputation + (old.downVotes) * 2;
        new.downVotes := 0;
    END IF;

    IF new.reputation < 1 THEN
        new.reputation := 1;
    END IF;

    RETURN new;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER DOWNVOTESTOPREF
BEFORE UPDATE OF downVotes ON USERTP
FOR EACH ROW
EXECUTE PROCEDURE downVotesRep();

SELECT * FROM migrate();
SELECT * FROM userTP;
SELECT * FROM badges;
