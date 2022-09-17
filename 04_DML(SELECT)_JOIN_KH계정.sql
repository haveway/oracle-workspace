



--           EMP_NO, EMP_NAME, DEPT_CODE, DEPT_TITLE
-- 전체 사원들의 사번,    사원명,   부서코드,   부서명까지 한 번 조회해볼까 ~ ?
--          EMPLOYEE                           DEPARTMENT

SELECT EMP_ID, EMP_NAME, DEPT_CODE
  FROM EMPLOYEE;
  
SELECT DEPT_TITLE
  FROM DEPARTMENT;
  
  
-- 전체 사원들의 사번, 사원명, 직급코드, 직급명을 알고 싶은데???

SELECT EMP_ID, EMP_NAME, JOB_CODE
  FROM EMPLOYEE;
  
  
SELECT JOB_CODE, JOB_NAME
  FROM JOB;
  
--> JOIN을 통해서 연결고리에 해당하는 컬럼만 제대로 매칭시키면
--> 마치 하나의 결과물처럼 조회 가능
  

/*
    < JOIN >
    
    두 개 이상의 테이블에서 데이터를 같이 조회하고자 할 때 사용되는 구문
    조회결과는 하나의 결과물(RESULT SET)로 나옴
    
    관계형 데이터베이스에서는 최소한의 데이터로 각각의 테이블에 데이터를 보관하고 있음
    -> 관계를 맺어본적이 없음
    
    JOIN구문을 이용해서 여러개의 테이블 간 "관계"를 맺어서 조회하는법을 공부할것이다!!!!!

    무작정 JOIN을 사용해서 조회하는것이 아니라 테이블 간 "연결고리"에 해당하는 컬럼을 매칭 시켜야함
    
    JOIN은 크게 "오라클 전용 구문"과
    "ANSI(미국 국립 표준협회) 구문"으로 나뉜다.
    
    
    ----------------------------------------------------------------------
               오라클 전용구문       |      ANSI(오라클 + 다른 DBMS)구문
    ----------------------------------------------------------------------
        등가조인                    |  내부조인(INNER JOIN)
       (EQUAL JOIN)                |  외부조인(OUTER JOIN)
    ----------------------------------------------------------------------
       포괄조인                      | 왼쪽 외부조인(LEFT OUTER JOIN)
       (LEFT OUTER)                 | 오른쪽 외부조인(RIGHT OUTER JOIN)
       (RIGHT OUTER)                | 전체 외부조인)FULL OUTER JOIN) ==> 오라클에서는 불가
    ----------------------------------------------------------------------
        카테시안곱(CARTESIAN PRODUCT) | 교차조인(CROSSJOIN)
    ----------------------------------------------------------------------
        자체조인(SELF JOIN)
    
*/
  
  -----------------------------------------------------------
  
  /*
    1. 등가조인(EQUAL JOIN) / 내부조인(INNER JOIN)
  
    연결시키는 컬럼의 값이 일치하는 행들만 조인되서 조회  
    (== 일치하지 않는 값들은 조회에서 제외)
  */
  
  --> 오라클 전용구문
  -- FROM절에 조회하고자하는 테이블들을 나열(,)
  -- WHERE절에 매칭시킬 컬럼명(연결고리)에 대한 조건을 제시함
  
  -- 전체 사원들의 사번, 사원명, 부서코드 부서명을 같이 조회
  -- 1) 연결할 두 컬럼명이 다른 경우
  -- EMPLOYEE - "DEPT_CODE" / DEPARTMENT - "DEPT_ID"
SELECT DEPT_CODE FROM EMPLOYEE;
SELECT DEPT_ID FROM DEPARTMENT;
  
SELECT EMP_ID, EMP_NAME, /*DEPT_CODE, DEPT_ID ,*/DEPT_TITLE
  FROM EMPLOYEE, DEPARTMENT
 WHERE DEPT_CODE = DEPT_ID;
 
SELECT EMP_ID, EMP_NAME, DEPT_CODE
  FROM EMPLOYEE;
SELECT DEPT_ID
  FROM DEPARTMENT;
  
-- 사번, 사원명, 직급코드, 직급명(EMPLYOEE - JOB_CODE / JOB - JOB_NAME)
-- 2) 연결할 두 컬럼명이 같은경우

SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
  FROM EMPLOYEE, JOB
 WHERE JOB_CODE = JOB_CODE;
-- 에러(AMBIGOUOSLY : 애매하다, 모호하다) => 어떤 테이블의 컬럼?

-- 방법 1. 테이블명을 이용하는 방법
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME
  FROM EMPLOYEE, JOB
 WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

-- 방법 2. 테이블의 별칭 사용 ( 각 테이블마다 별칭 부여 )
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
  FROM EMPLOYEE E, JOB J
 WHERE E.JOB_CODE = J.JOB_CODE;  
  
  
--> ANSI구문 (오라클 말고 다른 DBMS에서도 사용 가능)
-- FROM절에 기준 테이블 하나 기술
-- 그 뒤에 JOIN절에 같이 조회하고자하는 테이블 기술
-- (매칭시킬 컬럼에 대한 조건도 기술)
-- USING구문 / ON구문
  
-- 사번, 사원명, 부서코드, 부서명
-- 1. 연결할 두 컬럼명이 다른 경우
-- EMPLOYEE - DEPT_CODE / DEPARTMENT - DEPT_ID
-- 무조건 ON구문만 사용 가능(USING죽었다 깨나도 못씀)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
  FROM EMPLOYEE
  /*INNER*/ JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- 사번, 사원명, 직급코드, 직급명
-- 2. 연결할 두 컬럼명이 같은 경우
-- EMPLOYEE - JOB_CODE / JOB - JOB_CODE
-- ON, USING구문
-- 2-1. ON 구문 이용 : AMBIGUOUSLY 가 발생할 수 있기 때문에 명시!!!
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
  FROM EMPLOYEE E
  JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);
  
-- 2-2. USING 구문 이용 : AMBIGUOUSLY 발생 X
-- 알아서 매칭할게 ~~~
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
  FROM EMPLOYEE
  JOIN JOB USING(JOB_CODE);
  
  
-- 위의 예시인데 NATURAL_JOIN(자연조인)
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
  FROM EMPLOYEE
NATURAL JOIN JOB;
-- 운좋게도 두개의 테이블에 일치하는 컬럼이 유일하게 딱 한개 존재 => 알아서 매칭


-- 추가적인 조건도 제시 가능
-- 직급이 대리인 사원들의 정보 조회

-- 대리들의 사번, 이름, 급여, 직급 이름

-- > 오라클 전용 구문
--          EMPLOYEE         JOB
-- EMP_ID, EMP_NAME, SALARY, JOB_NAME

SELECT 
       EMP_ID
     , EMP_NAME
     , SALARY
     , JOB_NAME
  FROM 
       EMPLOYEE E
     , JOB J
 WHERE 
       E.JOB_CODE = J.JOB_CODE
   AND JOB_NAME = '대리';
-- 협업 시 가독성을 높이기 우해 보통 컬럼이나 조건이나 다 띄워쓴다


-- ANSI구문
SELECT EMP_ID, EMP_NAME, SALARY, JOB_NAME
  FROM EMPLOYEE
  JOIN JOB USING(JOB_CODE)
 WHERE JOB_NAME = '대리';
  
  
--------------------------------------------------------------------------------

-- 1. 부서가 '인사관리부'인 사원들의 사번, 사원명, 보너스를 조회
-- EMPLOYEE, DEPARTMENT
--> ORACLE
SELECT EMP_ID, EMP_NAME, BONUS
  FROM EMPLOYEE, DEPARTMENT
 WHERE DEPT_CODE = DEPT_ID
   AND DEPT_TITLE = '인사관리부';
--> ANSI
SELECT EMP_ID, EMP_NAME, BONUS
  FROM EMPLOYEE
  JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
 WHERE DEPT_TITLE = '인사관리부';

-- 2. 부서가 '총무부'가 아닌 사원들의 사원명, 급여, 입사일을 조회
-- EMP_NAME, SALARY, HIRE_DATE

SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;

SELECT EMP_NAME, SALARY, HIRE_DATE
  FROM EMPLOYEE
 WHERE DEPT_CODE != 'D9';
 
SELECT EMP_NAME, SALARY, HIRE_DATE
  FROM EMPLOYEE, DEPARTMENT
 WHERE DEPT_CODE = DEPT_ID;
   AND DEPT_TITLE != '총무부';
   
   
SELECT EMP_NAME, DEPT_CODE
  FROM EMPLOYEE, DEPARTMENT
 WHERE DEPT_CODE = DEPT_ID;
   
SELECT EMP_NAME, SALARY, HIRE_DATE
  FROM EMPLOYEE
  JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
 WHERE DEPT_TITLE != '총무부';


-- 3. 보너스를 받는 사원들의 사번, 사원명, 보너스, 부서명 조회
-- ORACLE
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
  FROM EMPLOYEE, DEPARTMENT
 WHERE DEPT_CODE = DEPT_ID
   AND BONUS IS NOT NULL;
   
-- ANSI
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
  FROM EMPLOYEE
  JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
 WHERE BONUS IS NOT NULL;

-- 4. DEPARTMENT테이블, LOCATION테이블을 참고해서
-- 부서코드, 부서명, 지역코드, 지역명(LOCAL_NAME) 조회

SELECT * FROM DEPARTMENT; -- DEPT_ID, DEPT_TITLE, LOCATION_ID
SELECT * FROM LOCATION; -- LOCAL_CODE, NATIONAL_CODE, LOCAL_NAME

--> ORACLE 
SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
  FROM DEPARTMENT, LOCATION
 WHERE LOCATION_ID = LOCAL_CODE;

--> ANSI
SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
  FROM DEPARTMENT
  JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);

-- ORACLE / ANSI
  
-- 등가조인 / 내부조인 : 일치하지않는 행들은 애초에 조회되지 않음
--------------------------------------------------------------------------------
/*
    포괄조인 / 외부조인 (OUTER JOIN)


    테이블간의 JOIN시 일치하지 않는 행도 포함시켜서 조회 가능
    단, 반드시 LEFT / RIGHT를 지정해야 함(기준이 되는 테이블을 지정)
*/

-- "전체" 사원들의 사원명, 급여, 부서명 조회
-- DEPT_CODE가 NULL인 두명의 사원 조회 X EMPLOYEE
-- 부서에 배정된 사원이 없는 부서 (D3, D4, D7) 조회 X DEPARTMENT
SELECT * FROM EMPLOYEE;

SELECT EMP_NAME, SALARY, DEPT_TITLE
  FROM EMPLOYEE
  JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- 1) LEFT [OUTER] JOIN : 
-- 두 테이블 중 왼편에 기술된 테이블을 기준으로 JOIN
-- 즉, 뭐가 되었든 간에 왼편에 기술된 테이블의 데이터는 무조건 조회(null)
-- (일치하는게 없어도 조회를 하겠다)

-- ANSI 구문
SELECT EMP_NAME, SALARY, DEPT_TITLE
  FROM EMPLOYEE 
  LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
-- EMPLYOEE테이블을 기준으로 조회했기 때문에
-- EMPLOYEE에 존재하는 데이터가 뭐가되었든 간에 무조건 조회되게끔 한다.

-- ORACLE
SELECT EMP_NAME, SALARY, DEPT_TITLE
  FROM EMPLOYEE, DEPARTMENT
 WHERE DEPT_CODE = DEPT_ID(+);
-- 내가 기준으로 삼을 테이블의 컬럼명에 반대쪽에 '(+)'를 붙여준다.

-- 2) RIGHT [OUTER] JOIN
-- 두 테이블의 오른편에 기술된 테이블을 기준으로 JOIN

--> ANSI
SELECT EMP_NAME, SALARY, DEPT_TITLE
  FROM EMPLOYEE 
  RIGHT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

--> ORACLE
SELECT EMP_NAME, SALARY, DEPT_TITLE
  FROM EMPLOYEE, DEPARTMENT
 WHERE DEPT_CODE(+) = DEPT_ID;


-- 3) FULL [ OUTER ] JOIN : 두 테이블이 가진 모든 행을 조회
--> ANSI
SELECT EMP_NAME, SALARY, DEPT_TITLE
  FROM EMPLOYEE
  FULL OUTER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

--> ORALCE (에러남 : only one out-joined table)
SELECT EMP_NAME, SALARY, DEPT_TITLE
  FROM EMPLOYEE, DEPARTMENT
 WHERE DEPT_CODE(+) = DEPT_ID(+);

------------------------------------------------------------------------------

/*
    3. 카테시안 곱(CARTESIAN PRODUCT) / 교차조인 (CROSS JOIN)
    모든 테이블의 각 행들이 서로서로 매핑된 데이터가 조회됨(곱집합)
    
    두 테이블의 행들이 모두 곱해진 조합 출력
    => 방대한 데이터 출력
    => 과부하의 위험
    
*/

-- 사원명, 부서명
-- ORACLE
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT;

-- ANSI
SELECT EMP_NAME, DEPT_TITLE
  FROM EMPLOYEE
  CROSS JOIN DEPARTMENT;


--------------------------------------------------------------------------------

/*
    4. 비등가 조인(NON EQUAL JOIN)
    '='를 사용하지 않는 조인문
    
    지정해주는 컬럼값이 일치하는 경우 가아닌
    "범위"에 포함되는 경우 매칭
*/

-- 사원명, 급여

SELECT EMP_NAME, SALARY
  FROM EMPLOYEE;

SELECT * FROM SAL_GRADE;
SELECT * FROM EMPLOYEE;

-- 사원명, 급여, 급여등급(SAL_LEVEL)
SELECT EMP_NAME, SALARY, S.SAL_LEVEL
  FROM EMPLOYEE E, SAL_GRADE S
  /*
 WHERE SALARY >= MIN_SAL 
   AND SALARY <= MAX_SAL;
   */
 WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;


-------------------------------------------------------------------------

/*
    5. 자체조인 (SELF JOIN)
    같은 테이블을 다시 한번 조인하는 경우
    자기 자신의 테이블과 조인을 맺는다.
*/

SELECT
        EMP_ID "사원 사번",
        EMP_NAME "사원명",
        SALARY "사원 급여",
        MANAGER_ID "사수사번"
  FROM 
        EMPLOYEE;

SELECT * FROM EMPLOYEE; -- 사원에 대한 정보 도출용 테이블
--> MANAGER_ID
SELECT * FROM EMPLOYEE; -- 사수에 대한 정보 도출용 테이블
--> EMP_ID

-- 사원사번, 사원명, 사원부서코드, 사원급여
-- 사수사번, 사수명, 사수부서코드, 사수급여

-- ORACLE

SELECT E.EMP_ID "사원 사번", E.EMP_NAME "사원명",
       E.DEPT_CODE "사원 부서코드", E.SALARY "사원급여",
       M.EMP_ID "사수 사번", M.EMP_NAME "사수명",
       M.DEPT_CODE "사수 부서코드", M.SALARY "사수급여"
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID(+);


--------------------------------------------------------------------------------

/*
    <다중 JOIN>
*/

-- 사번, 사원명, 부서명, 직급명
SELECT * FROM EMPLOYEE;     -- DEPT_CODE      JOB_CODE
SELECT * FROM DEPARTMENT;   -- DEPT_ID
SELECT * FROM JOB;                          --JOB_CODE

-- ORACLE
SELECT EMP_ID 사번, EMP_NAME 사원명, DEPT_TITLE 부서명, JOB_NAME 직급명
  FROM EMPLOYEE E, DEPARTMENT, JOB J
 WHERE DEPT_CODE = DEPT_ID(+)
   AND E.JOB_CODE = J.JOB_CODE;

-- ANSI
SELECT EMP_ID 사번, EMP_NAME 사원명, DEPT_TITLE 부서명, JOB_NAME 직급명
  FROM EMPLOYEE
  LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
  JOIN JOB USING(JOB_CODE);





-- 사번, 사원명, 부서명, 직급명, 지역명(LOCAL_NAME)
SELECT * FROM EMPLOYEE;   -- DEPT_CODE    JOB_CODE
SELECT * FROM DEPARTMENT; -- DEPT_ID                   LOCATION_ID
SELECT * FROM JOB;        --              JOB_CODE
SELECT * FROM LOCATION;   --                           LOCAL_CODE

-- 오라클

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, LOCAL_NAME
  FROM EMPLOYEE E, DEPARTMENT D, JOB J, LOCATION L
 WHERE DEPT_CODE = DEPT_ID(+)
   AND E.JOB_CODE = J.JOB_CODE
   AND LOCATION_ID = LOCAL_CODE(+);


-----------------------------------------------------------------------------

-- 1. 직급이 대리이면서 ASIA 지역에 근무하는 직원들의
-- 사번, 사원명, 직급명, 부서명, 근무지역명, 급여를 조회

-- ANSI구문
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME, SALARY
  FROM EMPLOYEE
  JOIN JOB USING(JOB_CODE)
  JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
  JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
  WHERE JOB_NAME = '대리'
    AND LOCAL_NAME LIKE 'ASIA%';
-- 2. 이름에 '형'자가 들어있는 직원들의
-- 사번, 사원명, 직급명을 조회하시오

-- ORACLE
SELECT EMP_NO, EMP_NAME, JOB_NAME
  FROM EMPLOYEE E, JOB J
 WHERE E.JOB_CODE = J.JOB_CODE
   AND EMP_NAME LIKE '%형%';

-- 3. 70년대생이면서, 여자이고, 성이 전씨인 직원들의
-- 사원명, 주민번호, 부서명, 직급명을 조회하시오.

SELECT EMP_NAME, EMP_NO, DEPT_TITLE, JOB_NAME
  FROM EMPLOYEE E, DEPARTMENT, JOB J
 WHERE E.JOB_CODE = J.JOB_CODE
   AND DEPT_CODE = DEPT_ID
   AND EMP_NAME LIKE '전%'
   AND SUBSTR(EMP_NO, 8, 1) = 2
   AND SUBSTR(EMP_NO, 1, 1) = 7;







