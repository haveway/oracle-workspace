/*
    < TCL : TRANSACTION CONTROL LANGUAGE >
    트랜잭션을 제어하는 언어

    * 트랜잭션 (TRANSACTION)
    
    - 데이터베이스의 논리적 연산단위
    
    - 데이터의 변경사항(DML)들을 하나의 트랜잭션으로 묶어서 처리
    COMMIT(확정)하기 전까지는 변경사항들을 하나의 트랜젝션에 담는다.
    - 트랜잭션의 대상이 되는 SQL : (INSERT, UPDATE, DELETE)DML
    
    COMMIT(트랜잭션 종료처리 후 확정)
    ROLLBACK(트랜잭션 취소)
    SAVEPOINT(임시저장)
*/


-- 테이블명 EMP_02
-- EMPLOYEE테이블을 복사하고 싶다.

CREATE TABLE EMP_02
AS SELECT * FROM EMPLOYEE;

SELECT *
  FROM EMP_02;
  
-- 사번이 221인 사원 삭제
DELETE FROM EMP_02
 WHERE EMP_ID = 221;
 
-- 사번이 220인 사원 삭제
DELETE FROM EMP_02
 WHERE EMP_ID = 220;
  
SELECT * FROM EMP_02;

ROLLBACK;
  
SELECT * FROM EMP_02;
  -- 1단계 끝

--------------------------------------------------------------------------------

-- 사번이 220인 사원삭제
DELETE FROM EMP_02
 WHERE EMP_ID = 220;

-- 사번 800, 이름 홍길동인 사원 추가
INSERT INTO EMP_02 (EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL)
VALUES(800, '홍길동', '234324', 'J9', 'S1');

-- NOT NULL == EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL

COMMIT;

SELECT * FROM EMP_02;

ROLLBACK;

-- 2단계 끝

--------------------------------------------------------------------------------

-- 사번이 217, 216, 214인 사원 삭제

DELETE FROM EMP_02
 WHERE EMP_ID IN (217, 216, 214);

-- 3개 행이 삭제된 시점에 SAVEPOINT 지정
SAVEPOINT SP1;

DELETE FROM EMP_02
 WHERE EMP_ID = 200;
 
SELECT * FROM EMP_02;

INSERT INTO EMP_02(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL)
VALUES (801, '김길동', '2323', 'J9', 'S1');

ROLLBACK TO SP1;

SELECT * FROM EMP_02;

COMMIT;

--------------------------------------------------------------------------------

SELECT * FROM EMP_02;

-- 사번이 800번인 사원 없애기
DELETE FROM EMP_02
 WHERE EMP_ID = 800;

-- 테이블 생성(DDL)
CREATE TABLE TEST(
    TID NUMBER
);

ROLLBACK;

/*
    DDL 구문(CREATE, ALTER, DROP)을 실행하는 순간

    기존에 트랜잭션에 있는 모든 변경사항들음 무조건 실제 DB에 반영(COMMIT)
    시킨 후 DDL이 수행 됨

    => DDL 수행 전 변경사항이 있다면 정확히 픽스(COMMIT, ROLLBACK)하고 DDL을 실행해야 한다.
*/

/*
    COMMIT; 하나의 트랜잭션에 담겨있는 변경사항들을 실제 DB에 반영하겠다.
            실제 반영시킨 후 트랜잭션은 비워짐
    ROLLBACK; 하나의 트랜잭션에 담겨있는 변경사항들을 삭제한 후 마지막 COMMIT시점으로 돌아감
    SAVEPOINT 이름 : 지금 시점 임시저장점 정의
*/


/*
    DDL : CREATE(만들고), ALTER(고치고), DROP(버리고)
    DQL : SELECT(조회)
    DML : INSERT(삽입), UPDATE(갱신), DELETE(삭제)
    DCL : GRANT(주기), REVOKE(뺏기)
    TCL : COMMIT(절대안바꿔), ROLLBACK(돌아간다~), SAVEPOINT(중간저장??)
*/















