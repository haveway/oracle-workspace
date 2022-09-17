/*
    < DML : DATA MANIPULATION LANGUAGE >
    데이터 조작어

    테이블에 새로운 데이터를 삽입(INSERT)하거나,
    기존의 데이터를 수정(UPDATE)하거나,
    삭제(DELETE)하는 구문
*/


/*

    1. INSERT : 테이블에 행을 추가하는 구문
    
    [ 표현법 ]
    
    INSERT INTO 테이블명 VALUES(값, 값, 값, ....);
    => 해당 테이블에 모든 컬럼에 값을 추가하고자 할 때 INSERT구문을 사용할 수 있음.

    주의할 점 : 컬럼 순번을 지켜서 VALUES 괄호 안에 나열해야함
*/

SELECT * FROM EMPLOYEE;

INSERT INTO EMPLOYEE 
VALUES(900, '서영재', '123133-1231233', 'seo@0.jae', '01012345353', 'D1'
        , 'J1', 'S4', 50000000, 0.1, NULL, SYSDATE, NULL, DEFAULT);

SELECT *
  FROM EMPLOYEE
 WHERE EMP_ID = 900;
 
 
 /*
    2) INSERT INTO 테이블명(컬럼명1, 컬럼명2, 컬럼명3,...) VALUES(값1, 값2, 값3);
    => 해당 테이블에 특정 컬럼만 선택해서 그 컬럼에 추가할 값만 제시하고자 할 때 사용
    한 행 단위로 추가되기 때문에 선택이 안된 컬럼은 기본적으로 NULL값이 들어감
    (기본값 DEFAULT 지정되어있을 경우 기본값이 들어감)
 
    주의사항 : NOT NULL제약조건이 걸려있는 컬럼은 반드시 직접 값을 제시해야함
 */

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, SAL_LEVEL, HIRE_DATE)
     VALUES (901, '김명래', '324234-3434343', 'D2', 'J3', 'S4', SYSDATE);

SELECT * FROM EMPLOYEE;


/*
    3) INSERT INTO 테이블명(서브쿼리);
    
    => VALUES로 값을 기입하는것 대신에 서브쿼리로 조회한 결과값을 INSERT하는 구문
*/

CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(20)
);

SELECT * FROM EMP_01;

INSERT INTO EMP_01
(
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE
      FROM EMPLOYEE, DEPARTMENT
     WHERE DEPT_CODE = DEPT_ID(+)
);

DELETE FROM EMP_01;
SELECT * FROM EMP_01;

--------------------------------------------------------------------------------
/*
    2. INSERT ALL
    두 개 이상의 테이블에 각각 INSERT할 때 사용
    그 때 사용되는 서브쿼리 동일한 경우
*/
-- 새로운 테이블을 먼저 만들기
-- 첫번째 테이블 : 급여가 300만원 이상인 사원들의 사번, 사원명, 직급명에 대해 보관할 테이블
-- 테이블 이름 : EMP_JOB
-- 컬럼 : EMP_ID NUMBER, EMP_NAME VARCHAR2(30), JOB_NAME VARCHAR2(20)

CREATE TABLE EMP_JOB(
    EMP_ID NUMBER, EMP_NAME VARCHAR2(30), JOB_NAME VARCHAR2(20)
);

-- 두번째 테이블 : 급여가 300만원 이상인 사원들의 사번, 사원명, 부서명에 대해 보관할 테이블
-- 테이블 이름 : EMP_DEPT
-- 컬럼 EMP_ID NUMBER, EMP_NAME VARCHAR2(30), DEPT_TITLE VARCHAR2(20)

CREATE TABLE EMP_DEPT(
    EMP_ID NUMBER, EMP_NAME VARCHAR2(30), DEPT_TITLE VARCHAR2(20)
    );
    
    
SELECT * FROM EMP_JOB;
SELECT * FROM EMP_DEPT;
    
-- 급여가 300만원 이상인 사원들의 사번, 이름, 부서명, 직급명 조회

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
  FROM EMPLOYEE
  JOIN JOB USING(JOB_CODE)
  LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
 WHERE SALARY >= 3000000;

/*
    INSERT ALL
    INTO 테이블명1 VALUES(컬럼명, 컬럼명, 컬럼명)
    INTO 테이블명2 VALUES(컬럼명, 컬럼명, 컬럼명)
    서브쿼리;
*/

-- EMP_JOB 테이블에는 급여가 300만원 이상인 사원들의 EMP_ID, EMP_NAME, JOB_NAME을 삽입
-- EMP_DEPT 테이블에는 급여가 300만원 이상인 사원들의 EMP_ID, EMP_NAME, DEPT_TITLE을 삽입

INSERT ALL
  INTO EMP_JOB VALUES(EMP_ID, EMP_NAME, JOB_NAME) -- 9개의 행을 추가
  INTO EMP_DEPT VALUES(EMP_ID, EMP_NAME, DEPT_TITLE) -- 9개의 행을 추가
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
  FROM EMPLOYEE
  JOIN JOB USING(JOB_CODE)
  LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
 WHERE SALARY >= 3000000;

SELECT * FROM EMP_JOB;
SELECT * FROM EMP_DEPT;


-- 사번, 사원명, 입사일, 급여 // EMP_OLD, EMP_NEW
CREATE TABLE EMP_OLD
    AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
         FROM EMPLOYEE
        WHERE 1 = 0;

CREATE TABLE EMP_NEW
    AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
         FROM EMPLOYEE
        WHERE 1 = 0;
        
SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;

SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
  FROM EMPLOYEE
--WHERE HIRE_DATE < '2010/01/01';
 WHERE HIRE_DATE >= '2010/01/01';


/*
    INSERT ALL
    WHEN 조건1 THEN
        INTO 테이블명1 VALUES(컬럼명, 컬럼명, ..)
    WHEN 조건2 THEN
        INTO 테이블명2 VALUES(컬럼명, 컬럼명, ..)
    서브쿼리;
*/

INSERT ALL
WHEN HIRE_DATE < '2010/01/01' THEN
    INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY) -- 9개의 행이 추가
WHEN HIRE_DATE >= '2010/01/01' THEn
    INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY) -- 16개의 행이 추가
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
  FROM EMPLOYEE;

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;
--------------------------------------------------------------------------------
/*
    3. UPDATE
    테이블에 기록된 데이터를 수정하는 구문
    
    [ 표현법 ]
    UPDATE 테이블명
    SET 컬럼명 = 바꿀값
    , 컬럼명 = 바꿀값
    , 컬럼명 = 바꿀값 => 여러 개의 컬럼 동시 변경 가능(","
    WHERE 조건; => 생략이 가능, 생략 시 전체 모든 행의 데이터가 다 변경
*/


-- 테이블 복사
CREATE TABLE DEPT_COPY
    AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_COPY;
-- D9부서명을 전략기획팀으로 수정

UPDATE DEPT_COPY
   SET DEPT_TITLE = '전략기획부';
   
ROLLBACK;

UPDATE DEPT_COPY
   SET DEPT_TITLE = '전략기획부'
 WHERE DEPT_ID = 'D9';

-- 테이블 복사2
CREATE TABLE EMP_SALARY
    AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
         FROM EMPLOYEE;
         
SELECT * FROM EMP_SALARY;

ROLLBACK;


-- EMP_SALARY 테이블에 노옹철사원의 급여를 1000만원으로 변경
UPDATE EMP_SALARY
   SET SALARY = 10000000
 WHERE EMP_NAME = '노옹철';

SELECT * FROM EMP_SALARY;

-- 전체사원의 급여를 기존 급여에서 20프로 인상한 금액으로 변경
UPDATE EMP_SALARY
   SET SALARY = SALARY * 1.2;

/*
    UPDATE시에 서브쿼리를 사용
    서브쿼리를 수행한 결과값으로 UPDATE하겠다.

    UPDATE 테이블명
    SET 컬럼명 = (서브쿼리)
    WHERE 조건; => 생략 가능
*/

-- EMP_SALARY 테이블에 서영재사원의 부서코드를 선동일사원의 부서코드로 변경
UPDATE EMP_SALARY
   SET DEPT_CODE = (SELECT DEPT_CODE
                      FROM EMPLOYEE
                     WHERE EMP_NAME = '선동일')
 WHERE EMP_NAME = '서영재';
 
 -- 방명수 사원의 급여와 보너스를 유재식 사원의 급여와 보너스값으로 변경
 
 -- TABLE == EMP_SALARY
 
 
UPDATE EMP_SALARY
   SET (SALARY, BONUS) = (SELECT SALARY, BONUS
                            FROM EMP_SALARY
                           WHERE EMP_NAME = '유재식')
 WHERE EMP_NAME = '방명수';
 
SELECT * FROM EMP_SALARY;
--------------------------------------------------------------------------------
-- UPDATE 사용 시 수정할때 아무런 문제가 없을까????

-- 제약조건!!!!!

-- 송종기 사원의 사번을 200번으로 변경
UPDATE EMPLOYEE
   SET EMP_ID = 200
 WHERE EMP_NAME = '송종기'; -- PRIMARY KEY제약조건에 위배
 
UPDATE EMPLOYEE
   SET EMP_NAME = NULL
 WHERE EMP_NAME = '송종기'; -- NOT NULL 제약조건 위배
 
COMMIT;

--------------------------------------------------------------------------------
/*
    4. DELETE
    테이블에 기록된 데이터를 삭제하는 구문
    
    [표현법]
    DELETE FROM 테이블명
    WHERE 조건; => WHERE 절은 생략 가능, 생략 시 해당 테이블의 전체 행 삭제
*/

DELETE FROM EMPLOYEE;
SELECT * FROM EMPLOYEE;
ROLLBACK; -- 롤백 시 마지막 커밋시점으로 돌아감

-- 서영재, 김명래 사원의 데이터 지우기
DELETE FROM EMPLOYEE
 WHERE EMP_NAME IN('서영재','김명래');
 
COMMIT; -- 모든 변경사항을 확정 함

-- DEPARTMENT 테이블로부터 DEPT_ID가 D1인 부서 삭제
DELETE FROM DEPARTMENT
 WHERE DEPT_ID = 'D1';

SELECT * FROM DEPARTMENT;

DELETE FROM DEPARTMENT
 WHERE DEPT_ID = 'D3';

ROLLBACK;

/*
    * TRUNCATE : 테이블의 전체 행을 삭제할 때 사용하는 구문(절삭)
                 DELETE보다 수행속도가 더 빠름!!!
                 별도의 조건 제시 불가, ROLLBACK 불가능!

    [ 표현법 ]
        TRUNCATE TABLE 테이블명     |     DELETE FROM 테이블명;
        ----------------------------------------------------
        별도의 조건제시 불가          |   특정 조건제시 가능
        수행속도 빠름(DELETE보다)     |  수행속도가 느림(TRUNCATE보다)
        ROLLBACK불가!               |   ROLLBACK가능!
        ----------------------------------------------------
*/

SELECT * FROM EMP_SALARY;

DELETE FROM EMP_SALARY; -- 0.037초

ROLLBACK;

TRUNCATE TABLE EMP_SALARY; -- 0.125초

-- Table EMP_SALARY이(가) 잘렸습니다.


























