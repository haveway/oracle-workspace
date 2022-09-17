-- 테이블을 만들어보자!!!
CREATE TABLE TEST(
    TEST_ID NUMBER
);

-- 3_1. SAMPLE계정에 테이블을 생성할 수 있는 권한이 없기 때문에 오류 발생
-- ORA-01031 : isufficient privileges

-- CREATE TABLE권한 부여 받은 후
CREATE TABLE TEST(
    TEST_ID NUMBER
);

-- 3_2. TABLESPACE가 할당되지 않아서 오류 발생
-- ORA-01950 : no privileges on tablespace 'SYSTEM'

-- TABLESPACE할당 받은 후
CREATE TABLE TEST(
    TEST_ID NUMBER
);
-- 테이블 생성 완료

-- 테이블 생성권한을 부여받게 되면
-- 계정이 '소유'하고 있는 테이블들을 조작하는것도 가능해짐
SELECT * FROM TEST;
INSERT INTO TEST VALUES(1);

-- 뷰 만들어보기
CREATE VIEW V_TEST
AS SELECT * FROM TEST;

-- 4. 뷰 객체를 생성할 수 있는 CREATE VIEW권한이 없기 때문에 오류 발생
-- ORA-01031 : insufficient privileges
CREATE VIEW V_TEST
AS SELECT * FROM TEST;


-- SAMPLE 계정에서 KH계정의 테이블에 접근해서 조회해보기

SELECT *
  FROM KH.EMPLOYEE;

-- 5. KH계정의 테이블에 접근해서 조회할 수 있는 권한이 없기 때문에 오류 발생
-- ORA--00942 : table or view does not exist

-- SELECT ON 권한 부여 후
SELECT *
  FROM KH.EMPLOYEE;
  -- EMPLOYEE테이블 조회 성공!

SELECT * FROM KH.DEPARTMENT;

-- SAMPLE계정에서 KH계정의 테이블에 접근해서 행 삽입해보기
INSERT INTO KH.DEPARTMENT VALUES('D0', '회계부', 'L2');
-- 6. KH계정의 DEPARTMENT 테이블에 접근할 수 있는 권한이 없기 때문에 오류

-- INSERT ON 권한 부여 후
INSERT INTO KH.DEPARTMENT VALUES('D0', '회계부', 'L2');
-- KH.DEPARTMENT 테이블에 행 INSERT성공 ~ ~ ~ ~ 

ROLLBACK;

-- 테이블 만들어볼까??
CREATE TABLE TEST2(
    TEST_ID NUMBER
);


-- 7. SAMPLE계정에서 테이블을 생성할 수 없도록 권한을 회수했기 때문에 오류 발생!!












