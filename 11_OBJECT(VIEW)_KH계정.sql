/*
    < VIEW 뷰 >
    
    SELECT(쿼리문)을 저장해둘 수 있는 객체
    (자주 쓰는 긴 SELECT문을 저장해두면 긴 SELECT문을 매번 다시 기술할 필요가 없음)
    임시테이블(실제 데이터가 들어가는것은 아니다)
*/

---------------------------실습문제---------------------------
-- '한국'에서 근무하는 사원들의 사번, 이름, 부서명, 급여, 근무국가명, 직급명을 조회하시오.
        -- EMPLOYEE       DEPARTMENT            NATIONAL    JOB
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME
  FROM EMPLOYEE E, DEPARTMENT, LOCATION L, NATIONAL N, JOB J
 WHERE DEPT_CODE = DEPT_ID
   AND LOCATION_ID = LOCAL_CODE
   AND L.NATIONAL_CODE = N.NATIONAL_CODE
   AND E.JOB_CODE = J.JOB_CODE
   AND NATIONAL_NAME = '한국';

--------------------------------------------------------------------------------

/*
    1. VIEW 생성방법

    [ 표현법 ]
    CREATE VIEW 뷰명
    AS 서브쿼리;

    CREATE OR REPLACE VIEW 뷰명
    AS 서브쿼리; -> OR REPLACE는 생략이 가능하다.
    뷰 생성 시 기존에 중복된 이름이 없다면 새로 만들고
              기존에 중복된 이름의 뷰가 있따면 해당 뷰를 변경(갱신)하는 옵션

*/

-- 뷰이름 : VW_EMPLOYEE
CREATE VIEW VW_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME
     FROM EMPLOYEE E, DEPARTMENT, LOCATION L, NATIONAL N, JOB J
    WHERE DEPT_CODE = DEPT_ID
      AND LOCATION_ID = LOCAL_CODE
      AND L.NATIONAL_CODE = N.NATIONAL_CODE
      AND E.JOB_CODE = J.JOB_CODE
      AND NATIONAL_NAME = '한국';
-- KH계정에 뷰 생성권한이 없기때문에 오류 발생
-- 관리자계정에서 GRANT CREATE VIEW TO KH; 권한주면 해결됨
GRANT CREATE VIEW TO KH;


SELECT * 
  FROM (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME
     FROM EMPLOYEE E, DEPARTMENT, LOCATION L, NATIONAL N, JOB J
    WHERE DEPT_CODE = DEPT_ID
      AND LOCATION_ID = LOCAL_CODE
      AND L.NATIONAL_CODE = N.NATIONAL_CODE
      AND E.JOB_CODE = J.JOB_CODE
      AND NATIONAL_NAME = '한국');

SELECT * FROM VW_EMPLOYEE;
-- 뷰 생성 시 서브쿼리를 이용하여 그때그때 힘들게 너무너무 복잡하게 알아보기 힘든 데이터들을 조회하는것보다
-- 한번 만든 뷰를 통해서 편하게 조회가 가능하다.

-- 총무부에 일하는 사원
SELECT * FROM VW_EMPLOYEE
 WHERE DEPT_TITLE = '총무부';
 
 -- 인사관리부에서 일하는 사원
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, BONUS
  FROM VW_EMPLOYEE
 WHERE DEPT_TITLE = '인사관리부';
 
-- 보너스컬럼도 같이 좀 보고싶은데....
-- CREATE OR REPLACE VIEW 요걸 써보자!!!!
CREATE OR REPLACE VIEW VW_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME, BONUS
     FROM EMPLOYEE E, DEPARTMENT, LOCATION L, NATIONAL N, JOB J
    WHERE DEPT_CODE = DEPT_ID
      AND LOCATION_ID = LOCAL_CODE
      AND L.NATIONAL_CODE = N.NATIONAL_CODE
      AND E.JOB_CODE = J.JOB_CODE
      AND NATIONAL_NAME = '한국';
 
-- 뷰는 논리적인 가상테이블 ==> 실질적으로 데이터를 저장하고 있지 않음(쿼리문이 TEXT로 저장)
-- 참고) 해당 계정이 가지고 있는 VIEW들에 대한 내용을 조회하고자 한다면 데이터 딕셔너리 중 USER_VIEWS를 조회하면된다.

SELECT * FROM USER_VIEWS;

--------------------------------------------------------------------------------
/*
    * 뷰 컬럼에 별칭 부여
    서브쿼리의 SELECT절에 함수나 산술연산식이 기술되어 있는 경우 반드시 별칭 지정
*/

-- 사원의 사번, 이름, 직급명, 성별, 근무년수

CREATE OR REPLACE VIEW VW_EMP_JOB
AS SELECT EMP_ID, EMP_NAME, JOB_NAME,
          DECODE(SUBSTR(EMP_NO, 8, 1), '1','남','2','여') 성별,
          EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) 근무년수
     FROM EMPLOYEE
     JOIN JOB USING(JOB_CODE);
     -- 별칭을 지정하지않아서 문제가 발생
     -- 00998 : must name this expression with a column alias

SELECT * FROM VW_EMP_JOB;

CREATE OR REPLACE VIEW VW_EMP_JOB(사번, 사원명, 직급명, 성별, 근무년수)
AS SELECT EMP_ID, EMP_NAME, JOB_NAME,
          DECODE(SUBSTR(EMP_NO, 8, 1), '1','남','2','여'),
          EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
     FROM EMPLOYEE
     JOIN JOB USING(JOB_CODE);


SELECT 사원명, 근무년수 FROM VW_EMP_JOB;

-- 근무년수 15년이상인 사원들만 전부
SELECT * FROM VW_EMP_JOB WHERE 근무년수 >= 15;

-- 뷰를 삭제해보자!!!
DROP VIEW VW_EMP_JOB;

--------------------------------------------------------------------------------
/*
    뷰를 이용해서 DML(INSERT, UDPATE, DELETE) 사용 가능
    뷰에다가 적용 => 실제 데이터가 담겨있는 베이스테이블에 적용이 된다.
*/

CREATE OR REPLACE VIEW VW_JOB
    AS SELECT * FROM JOB;


SELECT * FROM VW_JOB;
SELECT * FROM JOB;

-- 뷰에 INSERT
INSERT INTO VW_JOB
VALUES('J8', '인턴');

SELECT * FROM JOB;

-- JOB_CODE가 J8인 JOB_NAME을 알바로 UPDATE
UPDATE VW_JOB
   SET JOB_NAME = '알바'
 WHERE JOB_CODE = 'J8';
 
SELECT * FROM JOB;

DELETE FROM VW_JOB
 WHERE JOB_CODE = 'J8';
 
SELECT * FROM JOB;
--------------------------------------------------------------------------------
/*  
    하지만 뷰를 가지고 DML이 불가능한 경우가 더 많음

    1) 뷰에 정의되지 않은 컬럼을 조작하는 경우
    2) NOT NULL제약조건이 지정된 경우
    3) 산술연산식 또는 함수를 통해서 정의되어 있는 경우
    4) 그룹함수 GROUP BY절이 포함된 경우
    5) DISTINCT 구문이 포함된 경우
    6) JOIN을 이용해서 여러 테이블을 매칭시켜놓은 경우
*/



---------------------------------------------------------------------------------
/*
    * VIEW 옵션
    
    [ 상세 표현법 ]
    CREATE OR REPLACE FORCE/NOFORCE VIEW 뷰명
    AS 서브쿼리
    WITH CHECK OPTION
    WITH READ ONLY;
    
    
    1) OR REPLACE : 해당 뷰가 존재하지 않으면 새로 생성 / 존재하면 갱신시켜주는 옵션
    2) FORCE / NOFORCE
        - FORCE : 서브쿼리에 기술된 테이블이 존재하지 않아도 뷰가 생성
        - NOFORCE(기본값) : 서브쿼리에 기술된 테이블이 반드시 존재해야만 뷰가 생성
    3) WITH CHECK OPTION : 서브쿼리에 조건절에 기술된 내용에 만족하는 값으로만 DML 가능
                            조건에 부합하지 않은 값으로 수정하는 경우 오류가 발생
    4) WITH READ ONLY : 뷰에 대해서 조회만 가능(DML수행 불가)
*/

-- 2) FORCE/ NOFORCE
CREATE OR REPLACE /*NOFORCE*/ VIEW VW_TEST
    AS SELECT FORCE, NOFORCE
         FROM STARWARS;
-- ORA-00942 : table or view does not exist

CREATE OR REPLACE FORCE VIEW VW_TEST
    AS SELECT FORCE, NOFORCE
         FROM STARWARS;
-- 경고 : 컴파일 오류와 함께 뷰가 생성되었습니다.

SELECT * FROM VW_TEST;
-- 오류 발생

SELECT * FROM USER_VIEWS;

CREATE TABLE STARWARS(
    FORCE NUMBER,
    NOFORCE NUMBER
);

SELECT * FROM VW_TEST;
-- 테이블 생성 후 다시 한번 조회하면 오류가 발생하지 않음

-- 3) WITH CHECK OPTION

CREATE OR REPLACE VIEW VW_EMP
    AS
SELECT *
  FROM EMPLOYEE
 WHERE SALARY >= 3000000
  WITH CHECK OPTION;

SELECT * FROM VW_EMP;

UPDATE VW_EMP
   SET SALARY = 5000000
 WHERE EMP_NAME = '유재식';
UPDATE VW_EMP
   SET SALARY = 2999999
 WHERE EMP_NAME = '유재식';
-- 서브쿼리에 기술한 조건에 부합하지 않기 때문에 변경 불가

ROLLBACK;

-- 4) WITH READ ONLY;
CREATE OR REPLACE VIEW VW_EMPBOUNS
    AS SELECT EMP_ID, EMP_NAME, BONUS
         FROM EMPLOYEE
        WHERE BONUS IS NOT NULL
  WITH READ ONLY;
  
SELECT * FROM VW_EMPBOUNS;

DELETE FROM VW_EMPBOUNS
 WHERE EMP_ID = 213;

--------------------------------------------------------------------------------
/*
    문제 1 ) 직급코드를 기준으로 사원 이상 과장 미만의 직원들을 찾아
            사번, 사원명, 직급명 조회

    문제 2 ) 회사에서 OFFICE프로그램을 불법으로 사용하다 벌금이 부과되었다.
            그 결과 회사측은 전 직원들에게도 책임이 있다며 급여의 0.1%씩 강제로 기부받겠다고 했다.
            그렇다면 EMPLOYEE테이블을 활용하여 남사원 여사원 각각 총 얼마의 금액을 기부하게되는지 조회
            
            예 )   사원          총 기부금
                남자사원    (원화표기)34,444원
                여자사원    (원화표기)22,333원
                
    문제 3 ) EMPLOYEE테이블에서 매니저별로 관리하는 사원들을 조회하여 한 매니저가 관리하는 사원들의 총 인원수를 구하여
            매니저명, 관리사원수로 조회
            예 )   매니저명   관리사원 수
                    송종기       1명
                    유재식       2명
*/
/*
 문제 1 ) 직급코드를 기준으로 사원 이상 과장 미만의 직원들을 찾아
            사번, 사원명, 직급명 조회
*/


SELECT EMP_ID, EMP_NAME, JOB_NAME
  FROM EMPLOYEE
  JOIN JOB USING(JOB_CODE)
 WHERE JOB_CODE > 'J5' AND JOB_CODE <= 'J7';

/*
    문제 2 ) 회사에서 OFFICE프로그램을 불법으로 사용하다 벌금이 부과되었다.
        그 결과 회사측은 전 직원들에게도 책임이 있다며 급여의 0.1%씩 강제로 기부받겠다고 했다.
        그렇다면 EMPLOYEE테이블을 활용하여 남사원 여사원 각각 총 얼마의 금액을 기부하게되는지 조회
        
        예 )   사원          총 기부금
            남자사원    (원화표기)34,444원
            여자사원    (원화표기)22,333원
*/
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남자사원', '2', '여자사원') 사원
      ,TO_CHAR(SUM(SALARY) * 0.001, 'L999,999')||'원' "총 기부금"
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8, 1);
                
                
/*
    문제 3 ) EMPLOYEE테이블에서 매니저별로 관리하는 사원들을 조회하여 한 매니저가 관리하는 사원들의 총 인원수를 구하여
            매니저명, 관리사원수로 조회
            
            예 )   매니저명   관리사원 수
                    송종기       1명
                    유재식       2명
*/

SELECT MANAGER_ID
  FROM EMPLOYEE
 GROUP BY MANAGER_ID;

SELECT 매니저, COUNT(관리사원)||'명' "관리사원 수"
FROM (SELECT E2.EMP_NAME 매니저, E1.EMP_NAME 관리사원
        FROM EMPLOYEE E1
        JOIN EMPLOYEE E2 ON(E1.MANAGER_ID = E2.EMP_ID))
GROUP BY 매니저;























