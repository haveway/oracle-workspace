DROP TABLE "VOTE_MEMBER";
DROP TABLE "VOTE_ITEM";
DROP TABLE "VOTE";

CREATE TABLE "VOTE_ITEM" (
	"ITEM_NO"	NUMBER		NOT NULL,
	"ITEM_NAME"	VARCHAR2(200)		NOT NULL,
	"ORIGIN_NAME"	VARCHAR2(200)		NULL,
	"CHANGE_NAME"	VARCHAR2(200)		NULL,
	"VOTE_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "VOTE_ITEM"."ITEM_NO" IS 'SEQ_INO';

COMMENT ON COLUMN "VOTE_ITEM"."VOTE_NO" IS 'SEQ_VONO';

CREATE TABLE "VOTE" (
	"VOTE_NO"	NUMBER		NOT NULL,
	"VOTE_TITLE"	VARCHAR2(100)		NOT NULL,
	"VOTE_START"	DATE		NULL,
	"VOTE_END"	DATE		NULL,
	"VOTE_CREATE"	DATE	DEFAULT SYSDATE	NULL,
	"VOTE_TYPE"	NUMBER	DEFAULT 1	NULL,
	"STATUS"	VARCHAR2(5)	DEFAULT 'Y'	NOT NULL
);

COMMENT ON COLUMN "VOTE"."VOTE_NO" IS 'SEQ_VONO';

COMMENT ON COLUMN "VOTE"."VOTE_TYPE" IS '1=가능, 0=불가능';

COMMENT ON COLUMN "VOTE"."STATUS" IS 'Y=투표중, N=투표끝';

CREATE TABLE "VOTE_MEMBER" (
	"USER_NO"	NUMBER		NOT NULL,
	"VOTE_NO"	NUMBER		NOT NULL,
	"ITEM_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "VOTE_MEMBER"."USER_NO" IS 'SEQ_UNO';

COMMENT ON COLUMN "VOTE_MEMBER"."VOTE_NO" IS 'SEQ_VONO';

COMMENT ON COLUMN "VOTE_MEMBER"."ITEM_NO" IS 'SEQ_INO';


ALTER TABLE "VOTE_ITEM" ADD CONSTRAINT "PK_VOTE_ITEM" PRIMARY KEY (
	"ITEM_NO"
);

ALTER TABLE "VOTE" ADD CONSTRAINT "PK_VOTE" PRIMARY KEY (
	"VOTE_NO"
);

ALTER TABLE "VOTE_MEMBER" ADD CONSTRAINT "PK_VOTE_MEMBER" PRIMARY KEY (
	"USER_NO",
	"VOTE_NO"
);

ALTER TABLE "VOTE_ITEM" ADD CONSTRAINT "FK_VOTE_TO_VOTE_ITEM_1" FOREIGN KEY (
	"VOTE_NO"
)
REFERENCES "VOTE" (
	"VOTE_NO"
);

ALTER TABLE "VOTE_MEMBER" ADD CONSTRAINT "FK_MEMBER_TO_VOTE_MEMBER_1" FOREIGN KEY (
	"USER_NO"
)
REFERENCES "MEMBER" (
	"USER_NO"
);

ALTER TABLE "VOTE_MEMBER" ADD CONSTRAINT "FK_VOTE_TO_VOTE_MEMBER_1" FOREIGN KEY (
	"VOTE_NO"
)
REFERENCES "VOTE" (
	"VOTE_NO"
);

ALTER TABLE "VOTE_MEMBER" ADD CONSTRAINT "FK_VOTE_ITEM_TO_VOTE_MEMBER_1" FOREIGN KEY (
	"ITEM_NO"
)
REFERENCES "VOTE_ITEM" (
	"ITEM_NO"
);

CREATE SEQUENCE SEQ_VONO
NOCACHE;

CREATE SEQUENCE SEQ_INO
NOCACHE;
