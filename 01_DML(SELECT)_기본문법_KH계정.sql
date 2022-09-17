/*
    <SELECT>
    데이터를 조회하거나 검색할 때 사용되는 명령어

    [ 표현법 ]
    SELECT 조회하고자하는 컬럼, 컬럼, 컬럼......
    FROM 테이블명;
    
    - ResultSet : SELECT 구문을 통해 조회된 데이터의 결과물, 조회된 행들의 집합
    
    -- EMPLOYEE 테이블의 전체 사원들의 모든 컬럼을 다 조회
    SELECT * FROM EMPLOYEE;
    
    -- EMPLOYEE 테이블의 전체 사원들의 사번, 이름, 급여 컬럼들만 조회
    SELECT EMP_ID, EMP_NAME, SALARY
    FROM EMPLYOEE;
*/

SELECT * FROM EMPLOYEE;
SELECT EMP_ID, EMP_NAME, SALARY FROM EMPLOYEE;

---------  실습문제 ----------
-- 1. JOB 테이블의 모든 컬럼조회
SELECT * FROM JOB;
-- 2. JOB 테이블의 직급명 컬럼만 조회
SELECT JOB_NAME FROM JOB;
-- 3. DEPARTMENT 테이블의 모든 컬럼조회
SELECT * FROM DEPARTMENT;
-- 4. EMPLOYEE 테이블의 직원명, 이메일, 전화번호, 입사일 컬럼만 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE FROM EMPLOYEE;
-- 5. EMPLOYEE 테이블의 입사일, 직원명, 급여컬럼만 조회
SELECT HIRE_DATE, EMP_NAME, SALARY FROM EMPLOYEE;
-----------------------------------------------------




---------------------------------------------------------

/*
    < 컬럼값을 통한 산술 연산 >
    조회하고자 하는 컬럼들을 나열하는 SELECT절에
    산술연살(+, -, *, /)을 기술해서 결과를 조회할 수 있다.
*/

-- EMPLOYEE 테이블로부터 직원명, 월급, 연봉(= 월급 * 12)
SELECT EMP_NAME, SALARY, SALARY * 12
FROM EMPLOYEE;

-- EMPLOYEE 테이블로부터 직원명, 월급, 보너스, 보너스가 포함된 연봉
-- ((월급 + 보너스 * 월급)) * 12)
SELECT EMP_NAME, SALARY, BONUS, ((SALARY + BONUS * SALARY) * 12)
FROM EMPLOYEE;
-- 산술연산하는 과정에 NULL 값이 존재할 경우 산술연산 결과마저도 NULL이 된다.

-- DATE타입끼리도 연산 가능(DATE = > 년, 월, 일, 시, 분, 초)
-- EMPLOYEE 테이블로부터 직원명, 입사일, 근무일수(오늘날짜 - 입사일) 조회
-- 오늘날짜 : SYSDATE
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE
FROM EMPLOYEE;
-- 결과값은 일 수 단위로 출력
-- 값이 지저분한 이유는 DATE타입 안에 포함되어있는 시/ 분/ 초에 연산이 수행되기 때문에

-------------------------------------------------------------------------

/*
    < 컬럼명에 별칭 지정하기>
    [ 표현법 ]
    컬럼명 AS 별칭, 컬럼명 AS "별칭", 컬럼명 "별칭", 컬럼명 별칭

    AS를 붙이든 안붙이든 상관 X
    별칭에 특수문자, 띄워쓰기 포함될경우 반드시 "" 묶어서 표기해야 함
*/

SELECT EMP_NAME 이름, SALARY "급여(월)", BONUS 보너스
FROM EMPLOYEE;


-----------------------------------------------------------------

/*
    < 리터럴 >
    임의로 지정한 문자열 ('')을 SELECT 절에 기술하면
    실제 그 테이블에 존재하는 데이터처럼 조회가 가능하다.
*/

SELECT EMP_ID, EMP_NAME, SALARY, '원'단위
FROM EMPLOYEE;

------------------------------------------------------------------

/*
    <DISTINCT>
    조회하고자하는 컬럼의 중복된 값을 딱 한번씩만 조회할 때
    해당 컬럼명 앞에 기술
    
    [ 표현법 ]
    DISTINCT 컬럼명

    SELECT절에 DISTINCT 구문은 단 한개만 가능하다!!!
*/
SELECT DISTINCT DEPT_CODE FROM EMPLOYEE;

SELECT JOB_CODE FROM JOB;
-------------------------------------------------------------
/*
    < WHERE 절 >
    조회하고자 하는 테이블에 특정 조건을 제시
    그 조건에 만족하는 데이터만을 조회하고자 할 때 기술하는 구문

    [ 표현법 ]
    SELECT 조회하고자 하는 컬럼, 컬럼, ......
    FROM 테이블명
    WHERE 조건식;
    
    
    - 조건식에 다양한 연산자 사용 가능
    
    < 비교 연산자 >
    >, <, >=, <=
    = (일치하는가? : 자바에서는 ==)
    !=, ^=, <> (일치하지 않는가?)

*/

-- EMPLOYEE 테이블로부터 급여가 400만원 잇아인 사원들만 조회(모든컬럼)
SELECT *
  FROM EMPLOYEE
 WHERE SALARY >= 4000000;

------------실습문제---------------------
-- EMPLOYEE 테이블로부터 부서코드가 D9인 사원들의 사원명, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D9';
-- EMPLOYEE 테이블로부터 부서코드가 D9가 아닌 사원들의 사원명, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
  FROM EMPLOYEE
 WHERE DEPT_CODE != 'D9';
-- EMPLOYEE 테이블에서 급여가 300만원 이상인 사원들의 이름, 급여, 입사일 조회
SELECT EMP_NAME, SALARY, HIRE_DATE
  FROM EMPLOYEE
 WHERE SALARY >= 3000000;
-- EMPLOYEE 테이블로부터 직급코드가 J2인 사원들의 이름, 급여, 보너스 조회
SELECT EMP_NAME, SALARY, BONUS
  FROM EMPLOYEE
 WHERE JOB_CODE = 'J2';
-- EMPLOYEE 테이블로부터 연봉(급여 * 12)이 5000만원 이상인 사원들의 이름, 급여, 연봉, 입사일 조회
SELECT EMP_NAME, SALARY, SALARY * 12 AS 연봉, HIRE_DATE
  FROM EMPLOYEE
 WHERE SALARY * 12 >= 50000000;

------------------------------------------------------------------------------------------

/*
    < 논리 연산자 >
    여러 개의 조건을 엮을 때 사용

    AND(그리고, ~ 이면서), OR(또는, ~ 이거나)
*/

-- 부서코드가 'D9'이면서 급여가 500만원 이상인 사원들의 이름, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
  FROM EMPLOYEE 
 WHERE DEPT_CODE = 'D9' AND SALARY >= 5000000;


-- 부서코드가 'D6'이거나 급여가 300만원 이상인 사원들의 이름, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D6' OR SALARY >= 3000000;

-- 급여가 350만원 이상이고 600만원 이하인 사원들의 이름, 사번, 급여, 직급코드 조회
SELECT EMP_NAME, EMP_ID, SALARY, JOB_CODE
  FROM EMPLOYEE
 WHERE 3500000 <= SALARY AND SALARY <= 6000000;

-------------------------------------------------------------------------------

/*
    < BETWEEN AND >
    몇 이상 몇 이하인 범위에 대한 조건을 제시할 때 사용
    
    [ 표현법 ]
    비교대상 컬럼명 BETWEEN 하한값 AND 상한값;

*/

-- 급여가 350만원 이상이고 600만원 이하인 사원들의 이름, 사번, 급여, 직급코드 조회
SELECT EMP_NAME, EMP_ID, SALARY, JOB_CODE
  FROM EMPLOYEE
 WHERE SALARY BETWEEN 3500000 AND 6000000;

-- 급여가 350만원 미만이고 600만원 초과인 사원들의 이름, 사번, 급여 직급코드 조회
SELECT EMP_NAME, EMP_ID, SALARY, JOB_CODE
  FROM EMPLOYEE
 WHERE SALARY NOT BETWEEN 3500000 AND 6000000;
-- >  오라클에서의 NOT은 자바의 논리부정연산자 !와 동일한 의미

-- BETWEEN AND 연산자 DATE형식간에도 사용가능

-- 입사일이 90/01/01 ~ 03/01/01인 사원들의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
--WHERE HIRE_DATE >= '90/01/01' AND HIRE_DATE <= '03/01/01';
WHERE HIRE_DATE BETWEEN '90/01/01' AND '03/01/01';

-- 입사일이 90/01/01 ~ 03/01/01이 아닌 사원들의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
--WHERE HIRE_DATE >= '90/01/01' AND HIRE_DATE <= '03/01/01';
WHERE NOT HIRE_DATE BETWEEN '90/01/01' AND '03/01/01';

------------------------------------------------------------------------------

/*
    < LIKE '특정패턴' >
    비교하려는 컬럼값이 내가 지정한 특정 패턴에 만족될 경우 조회
    
    [ 표현법 ]
    비교대상 컬럼명 LIKE '특정 패턴'

    - 특정 패턴에 와일드카드인 '%','_'를 가지고 제시할 수 있음
    '%' : 0글자 이상
    비교대상컬럼명 LIKE '문자%' => 컬럼값 중에 '문자'로 시작되는 것
    비교대상컬럼명 LIKE '%문자' => 컬럼값 중에 '문자'로 끝나는 것을 조회
    비교대상컬럼명 LIKE '%문자%' => 컬럼값 중에 '문자'가 포함되는 것을 조회
    '_' : 1글자
    비교대상컬럼명 LIKE '_문자' => 해당 컬럼값 중에 '문자'앞에 무조건 1글자가 있을 경우 조회
    비교대상컬럼명 LIKE '__문자' => 해당 컬럼값 중에 '문자'앞에 무조건 2글자가 있을 경우 조회
*/

-- 성이 전씨인 사원들의 이름, 급여, 입사일 조회
SELECT EMP_NAME, SALARY, HIRE_DATE
  FROM EMPLOYEE
 WHERE EMP_NAME LIKE '전%';

-- 이름 중에 '하'가 포함된 사원들의 이름, 주민번호, 부서코드 조회
SELECT EMP_NAME, EMP_NO, DEPT_CODE
  FROM EMPLOYEE
 WHERE EMP_NAME LIKE '%하%';
 
 
-- 전화번호 4번째 자리가 9로 시작하는 사원들의 사번, 사원명, 전화번호, 이메일 조회
SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
  FROM EMPLOYEE
 WHERE PHONE LIKE '___9%'; 
 
 
 -- 이름 가운데 글자가 '지'인 사원들의 모든 컬럼
SELECT * 
  FROM EMPLOYEE 
 WHERE EMP_NAME LIKE '_지_';

-- 그 외의 사원
SELECT *
  FROM EMPLOYEE
 WHERE EMP_NAME NOT LIKE '_지_';
 
 --------------실습문제------------------
 
 -- 1. 이름이 '연'으로 끝나는 사원들의 이름, 입사일 조회
 SELECT EMP_NAME, HIRE_DATE
   FROM EMPLOYEE
  WHERE EMP_NAME LIKE '%연';
 
 -- 2. 전화번호 처음 3글자가 010이 아닌 사원들의 이름, 전화번호 조회
 SELECT EMP_NAME, PHONE
   FROM EMPLOYEE
  WHERE NOT PHONE LIKE '010%';
 
 -- 3. DEPARTMENT 테이블에서 해외영업과 관련된 부서들의 모든 컬럼 조회
SELECT *
  FROM DEPARTMENT 
 WHERE DEPT_TITLE LIKE '해외영업%';

------------------------------------
/*

    < IS NULL >

    [ 표현법 ]
    비교대상컬럼 IS NULL : 컬럼값이 NULL일 경우
    비교대상컬럼 IS NOT NULL : 컬럼값이 NULL이 아닐 경우

*/
SELECT * FROM EMPLOYEE;

-- 보너스를 받지 않는 사원들(BONUS 컬럼의 값이 NULL)의 사번, 이름, 급여, 보너스
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
  FROM EMPLOYEE
 WHERE BONUS IS NULL;
 
-- 보너스를 받은 사원들
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
  FROM EMPLOYEE
 WHERE BONUS IS NOT NULL;
 
-- 사수가 없는 사원들의 사원명, 사수사번, 부서코드 조회
SELECT EMP_ID, EMP_NAME, MANAGER_ID, DEPT_CODE
  FROM EMPLOYEE
 WHERE MANAGER_ID IS NULL;

-- 사수가 없고 부서배치도 받지 않은 사원들의 모든 컬럼 조회
SELECT *
  FROM EMPLOYEE
 WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;
 
-- 부서배치는 받지 않았지만 보너스는 받는 사원의 사원명, 보너스, 부서코드 조회
SELECT EMP_NAME, BONUS, DEPT_CODE
  FROM EMPLOYEE
 WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;



-----------------------------------------------------------------------------
/*
    < IN >
    비교대상컬럼 값에 내가 제시한 목록들 중에 일치하는 값이 있는지 ~ ?

    [ 표현법 ]
    비교대상컬럼 IN (값, 값, 값,.....)
*/

-- 부서코드가 D6이거나 또는 D8이거나 또는 D5인 사원들의 이름, 부서코드 급여
SELECT EMP_NAME, DEPT_CODE, SALARY
  FROM EMPLOYEE
--WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D5';
 WHERE DEPT_CODE IN('D6', 'D8', 'D5');

-- 그외의 사원들
SELECT EMP_NAME, DEPT_CODE, SALARY
  FROM EMPLOYEE
 WHERE DEPT_CODE NOT IN('D6', 'D8', 'D5');

---------------------------------------------------------------------------

/*
    <연결연산자 || >
    여러 컬럼값들을 마치 하나의 컬럼인것처럼 연결시켜주는 연산자
    컬럼과 리터럴(임의의문자열)을 연결할 수 있다.
    
    System.out.println("num : " + num);
*/

SELECT EMP_ID || EMP_NAME || SALARY "연결됨"
FROM EMPLOYEE;


-----------------------------------------------------------------------------
/*
    < 연산자 우선순위 >
    0. ()
    1. 산술연산자
    2. 연결연산자
    3. 비교연산자
    4. IS NULL, LIKE, IN
    5. BETWEEN AND
    6. NOT
    7. AND
    8. OR
*/
-----------------------------------------------------------------------------
--SELECT * FROM EMPLOYEE;

/*  
    < ORDER BY 절 >
    SELECT문 가장 마지막에 기입하는 구문
    실행순서 또한 가장 마지막!!!
    
    [ 표현법 ]
    SELECT 조회할 컬럼, 컬럼 AS "별명", 컬럼..
      FROM 조회할 테이블 이름
     WHERE 조건식(생략)
     ORDER 
        BY [정렬할컬럼/별칭/컬럼순번] [ASC/DESC]
        [NULLS FIRST / NULLS LAST](생략가능)

    - ASC : 오름차순 정렬(생략 시 기본값)
    - DESC : 내림차순 정렬
    
    NULLS FIRST : NULL이 포함되어 있을 경우 앞으로 배치
    (내림차순 시 기본값)
    NULLS LAST : NULL이 포함되어 있을 경우 뒤로 배치
    (오름차순 시 기본값)
*/

SELECT *
  FROM EMPLOYEE
--ORDER BY BONUS; -- ASC 또는 DESC 생략 시 기본값이 ASC(오름차순)
-- ASC은 기본적으로 NULLS LAST임을 알 수 있다.
--ORDER BY BONUS ASC NULLS FIRST;
-- ORDER BY BONUS DESC;
-- DESC은 기본적으로 NULLS FIRST임을 알 수 있다.
ORDER BY BONUS DESC, SALARY ASC;














