/*
    * DDL (DATA DEFINITION LANGUAGE) : 데이터 정의 언어
    
    오라클에서 제공하는 객체(OBJECT)를
    새로이 만들고(CREATE), 구조를 변경하고(ALTER), 구조자체를 삭제하는(DROP)하는 명령문
    즉, 구조자체를 정의하는 언어로 주로 DB관리자, 설계자가 사용함
    
    오라클에서의 객체(구조) : 테이블(TABLE), 뷰(VIEW), 시퀀스(SEQUENCE)
    
                           인덱스(INDEX), 패키지(PACKAGE), 트리거(TRIGGER)
                           프로시져(PROCEDUER), 함수(FUNCTION),
                           동의어(SYNONYM), 사용자(USER)
*/


/*
    < CREATE TABLE >
    
    
    테이블이란?? : 행(ROW), 열(COLUMN)로 구성되는 가장 기본적인 데이터베이스 객체
    모든 데이터는 테이블을 통해서 저장됨(데이터를 보관하고자 한다면 테이블을 만들어야 함)
    
    [ 표현법 ]
    CREATE TABLE 테이블명 (
        컬럼명 자료형,
        컬럼명 자료형,
        컬럼명 자료형,
        ......
    );

    < 자료형 >
    
    - 문자(CHAR(크기) / VARCHAR2(크기) : 크기는 BYTE단위
                                    (숫자, 영문자, 특수문자 => 1글자 당 1BYTE
                                                     한글 => 1글자당 3BYTE)


    CHAR(바이트수) : 최대 2000BYTE까지 지정가능
                    고정길이(아무리 적은값이 들어와도 공백으로 채워서 처음 할당된 크기 유지)
                    주로 들어올 값의 글자수가 정해져 있을 경우
                    예 ) 성별 : 남 / 여, M / F

    VARCHAR2(바이트수) : 최대 4000BYTE까지 지정가능
                        가변길이(적은 값이 들어오면 그 담긴값에 맞춰서 크기가 줄어듬)
                        VAR는 '가변'을 의미, 2는 '2배'를 의미한다.
                        
    - 숫자 (NUMBER) : 정수 / 실수 상관없이 NUMBER

    - 날짜 (DATE)
*/

--> 회원들의 데이터(아이디, 비밀번호, 이름, 회원가입일)를 담기위한 테이블
-- MEMBER 테이블 생성하기!

CREATE TABLE MEMBER(
    MEMBER_ID VARCHAR2(20),
    MEMBER_PWD VARCHAR2(20),
    MEMBER_NAME VARCHAR2(20),
    MEMBER_DATE DATE
);

SELECT * FROM MEMBER;
-------------------------------------------------------------------------------
/*
    컬럼에 주석달기 (컬럼에 대한 설명)

    [표현법]
    COMMENT ON COLUMN 테이블명.컬럼명 IS '주석내용';
*/

COMMENT ON COLUMN MEMBER.MEMBER_ID IS '회원아이디';
-- 회원비밀번호, 회원이름, 회원가입일
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS '회원비밀번호';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS '회원이름';
COMMENT ON COLUMN MEMBER.MEMBER_DATE IS '회원가입일';

-- 데이터 딕셔너리 : 다양한 객체들의 정보를 저장하고 있는 시스템 테이블
-- USER_TABLES : 현재 이 계정이 가지고 있는 테이블들의 전반적인 구조를 확인할 수 있는 데이터 딕셔너리

SELECT * FROM USER_TABLES;

-- USER_TAB_COLUMNS
SELECT * FROM USER_TAB_COLUMNS;

SELECT * FROM MEMBER;


-- 데이터를 추가할 수 있는 구문(INSERT : 한 행으로 추가, 값의 순서 중요)
-- INSERT INTO 테이블명 VALUES(첫 번째 컬럼의값, 두번째 컬럼의값, 세번째....)
INSERT INTO MEMBER VALUES('user01', 'pass01', '홍길동', '2022-05-02');
INSERT INTO MEMBER VALUES('user02', 'pass02', '김길동', SYSDATE);
INSERT INTO MEMBER VALUES('user03', 'pass03', '이길동', '21/12/12');
INSERT INTO MEMBER VALUES(NULL, NULL, NULL, SYSDATE); -- 아이디, 비밀번호, 이름
-- NULL값으로 들어감
INSERT INTO MEMBER VALUES('user03', 'pass03', '김개똥', SYSDATE);
-- 중복된 아이디가 존재

-- NULL값이나 중복된아이디값은 유효하지 않은 값들이다.
-- 유효한 데이터값을 유지하기 위해서 제약조건을 걸어줘야 한다.
------------------------------------------------------------------------------
/*
    < 제약조건 CONSTRAINTS >

    - 종류 : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
    
    - 원하는 데이터값만을 유지하기 위해서(보관하기 위해서) 특정 컬럼마다 설정하는 제약
    (데이터의 무결성 보장을 목적으로)
    - 제약조건 부여된 컬럼에 들어올 데이터가 문제가 있는지 없는지 자동으로 검사

    - 컬럼에 제약조건을 부여하는 방식 : 컬럼레벨 / 테이블레벨
*/

/*

    1. NOT NULL 제약조건
    
    해당 컬럼에 반드시 값이 존재해야만 할 경우 사용(NULL값이 절대 들어와서는 안되는 컬럼)
    삽입 / 수정 시 NULL값을 허용하지 않도록 제한

    단, NOT NULL 제약조건 컬럼레벨 방식 밖에 안됨
*/


-- NOT NULL 제약조건만 설정한 테이블 만들기
-- 컬럼레벨 방식 : 컬럼명 자료형 제약조건 => 제약조건을 부여하고자 하는 컬럼 뒤에 기술
CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30)
);

SELECT * FROM MEM_NOTNULL;

INSERT INTO MEM_NOTNULL
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hgd@hdg.com');
INSERT INTO MEM_NOTNULL
VALUES(2, NULL, NULL, NULL, NULL, NULL, NULL); -- NOT NULL 제약조건에 위배 오류 발생!
INSERT INTO MEM_NOTNULL
VALUES(2, 'user02', 'pass02', '김길동', NULL, NULL, NULL);
-- NOT NULL 제약조건이 부여되어있는 컬럼에는 반드시 값이 존재해야함 !

INSERT INTO MEM_NOTNULL
VALUES(3, 'user01', 'pass03', '순순이', '남', NULL, NULL);

--------------------------------------------------------------------------------
/*
    2. UNIQUE 제약조건


    컬럼에 중복값을 제한하는 제약조건
    삽입 / 수정 시 기존에 해당 컬럼값중에 중복값이 있을 경우 추가 또는 수정이 되지않게 제약!!!!
    
    컬럼레벨/테이블레벨 방식 둘 다 가능!!!
*/

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, -- 컬럼레벨
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30)
);

DROP TABLE MEM_UNIQUE;

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    UNIQUE(MEM_ID) -- 테이블 레벨 방식
);

INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', '홍길동', '남', NULL, NULL);
INSERT INTO MEM_UNIQUE VALUES(2, 'user02', 'pass02', '김길동', '남', NULL, NULL);
INSERT INTO 
            MEM_UNIQUE 
    VALUES 
            (
            3
          , 'user02'
          , 'pass03'
          , '김말똥'
          , '남'
          , NULL
          , NULL
            );
-- UNIQUE 제약조건에 위배되었으므로 INSERT실패!
-- 오류구문으로 제약조건명 알려줌 ( 어떤 컬럼에 문제가 있는지 컬럼명을 알려주진 않음)
-- 제약조건을 모르면 파악하기 어려움(ORA-00001 : unique constraint)
-- 제약조건명을 지정해줄 수 있음

SELECT * FROM MEM_UNIQUE;

--------------------------------------------------------------------------------
/*
    * 제약조건 부여 시 제약조건명도 지정하는 표현식

    > 컬럼레벨 방식
    CREATE TABLE 테이블명(
        컬럼명 자료형 CONSTRAINT 제약조건명 제약조건,
        컬럼명 자료형,
        컬럼명 자료형,
    )
    
    > 테이블레벨 방식
     CREATE TABLE 테이블명(
        컬럼명 자료형,
        컬럼명 자료형,
        컬럼명 자료형,
        CONSTRAINT 제약조건명 제약조건 (컬럼명)
    )
*/

CREATE TABLE MEM_CON_NN(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEM_NAME_NN NOT NULL, -- 컬럼레벨 방식
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    CONSTRAINT MEM_ID_UQ UNIQUE(MEM_ID) -- 테이블레벨 방식
);

INSERT INTO MEM_CON_NN VALUES(1, 'user01', 'pass01', '홍길동', NULL, NULL, NULL);
INSERT INTO MEM_CON_NN VALUES(1, 'user01', 'pass02', '김길동', NULL, NULL, NULL);


SELECT * FROM MEM_CON_NN;

INSERT INTO MEM_CON_NN VALUES(2, 'user02', 'pass02', '김길동', '가', NULL, NULL);
-- GENDER컬럼은 '남' / '여' 값만 들어가게 하고싶음
--------------------------------------------------------------------------------
/*
    3. CHECK 제약조건
    컬럼에 기록될 수 있는 값에 대한 조건을 설정해 둘 수 있다.

    CHECK(조건식)
*/

CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('남', '여')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE NOT NULL
);

INSERT INTO MEM_CHECK VALUES(1, 'user01', 'pass01', '홍길동', '남', NULL, NULL, SYSDATE);
INSERT INTO MEM_CHECK VALUES(2, 'user05', 'pass02', '김길동', '여', NULL, NULL, '37/02/28');

SELECT * FROM MEM_CHECK;
-- 회원가입일을 항상 SYSDATE값으로 받고싶다!! 테이블에서 지정 가능하다!!!
--------------------------------------------------------------------------------

/*
    * 특정 컬럼에 들어올 값에 대한 기본값 설정!! => 제약조건은 아님
*/

DROP TABLE MEM_CHECK;

CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL
);

/*
INSERT INTO 테이블명(컬럼명1, 컬럼명2, 컬럼명3, 컬럼명4)
VALUES(값1, 값2, 값3, 값4)
*/
INSERT INTO MEM_CHECK(MEM_NO, MEM_ID, MEM_PWD, MEM_NAME)
VALUES(1, 'user01', 'pass01', '홍길동');
-- 지정 안된 컬럼에는 기본적으로 NULL값이 들어가지만
-- 만일 DEFAULT값이 부여되어 있다면 NULL값이 아닌 DEFAULT값이 들어가게 된다.

SELECT * FROM MEM_CHECK;

--------------------------------------------------------------------------------
/*
    4. PRIMARY KEY(기본키) 제약조건
    테이블에서 각 행들의 정보를 유일하게 식별할 수 있는 컬럼에 부여하는 제약조건
    => 각 행들을 구분할 수 있는 식별자의 역할
    예 ) 회원번호, 주문번호, 사번, 학번, 예약번호
    => 중복되지 않고 값이 존재해야만 하는 컬럼에 PRIMARY KEY부여(UNIQUE + NOT NULL)

    한 테이블 당 한 개의 컬럼만 설정 가능
*/

CREATE TABLE MEM_PRIMARYKEY(
    MEM_NO NUMBER CONSTRAINT MEM_PK PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남','여')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30)
);

INSERT INTO MEM_PRIMARYKEY VALUES(1, 'user01', 'pass01', '홍길동', '남', NULL, NULL);

INSERT INTO MEM_PRIMARYKEY VALUES(NULL, 'user02', 'pass02', '김길동', '남', NULL, NULL);
-- 기본키 컬럼에 NULL값을 넣을 수 없음!!!

INSERT INTO MEM_PRIMARYKEY VALUES(1, 'user02', 'pass02', '김길동', '남', NULL, NULL);
-- 기본키 컬럼에 중복값을 넣을 수 없음!!!

INSERT INTO MEM_PRIMARYKEY VALUES(2, 'user02', 'pass02', '김길동', '남', NULL, NULL);
SELECT * FROM MEM_PRIMARYKEY;

CREATE TABLE MEM_PRIMARYKEY2(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) PRIMARY KEY,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남','여')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30)
);
-- PRIMARY KEY가 한 테이블에 두개가 될 수 없다!!!
-- table can have only one primary key
-- 두 컬럼을 하나로 묶어서 PRIMARY KEY하나로 설정 가능하다!!

CREATE TABLE MEM_PRIMARYKEY2(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남','여')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    PRIMARY KEY(MEM_NO, MEM_ID) -- 컬럼을 묶어서 PRIMARY KEY하나로 설정 => 복합키
);

INSERT INTO MEM_PRIMARYKEY2
VALUES(1, 'user01', 'pass01', 'hong',NULL, NULL, NULL);

SELECT * FROM MEM_PRIMARYKEY2;

INSERT INTO MEM_PRIMARYKEY2
VALUES(2, 'user01', 'pass01', 'hong', NULL, NULL, NULL);

SELECT * FROM MEM_PRIMARYKEY2;

INSERT INTO MEM_PRIMARYKEY2
VALUES(NULL, 'user02', 'pass02', 'hong', NULL, NULL, NULL);
-- 기본키로 설정되어있는 컬럼들에는 NULL값이 들어갈 수 없다!





