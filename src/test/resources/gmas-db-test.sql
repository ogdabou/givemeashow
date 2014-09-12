
-- LIKE, REFERENCEMENT ACTOR->TEXT; TEXT->ACTOR
DROP TABLE IF EXISTS TEXT_MENTIONS_ACTOR;



-- USE_CASE TABLE
CREATE TABLE USE_CASE (
    ID 						    BIGINT 			GENERATED BY DEFAULT AS IDENTITY,
    NAME 						VARCHAR(255) 	DEFAULT NULL,
    DESCRIPTION 				VARCHAR(255) 	DEFAULT NULL,
    BASKET						VARCHAR(255)			DEFAULT NULL,
    PRIMARY KEY (ID),
  	CONSTRAINT UNIQUE_USE_CASE_NAME UNIQUE (NAME)
);