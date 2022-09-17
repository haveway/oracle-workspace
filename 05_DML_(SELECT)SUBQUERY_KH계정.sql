-- 노옹철 사원과 같은 부서인 사원들
-- 1) 먼저 노옹철사원의 부서코드 조회
SELECT DEPT_CODE
  FROM EMPLOYEE
  WHERE EMP_NAME = '노옹철';
  
-- 2) 부서코드가 D9인 사원들 조회
SELECT EMP_NAME
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D9';
 
-- 위의 두 단계를 하나의 쿼리문으로 합치기
SELECT EMP_NAME
  FROM EMPLOYEE
 WHERE DEPT_CODE = (SELECT DEPT_CODE
                      FROM EMPLOYEE
                     WHERE EMP_NAME = '노옹철');

/*
    < SUBQUERY (서브쿼리) >

    하나의 주된 SQL문(SELECT, INSERT, UPDATE, DELETE, CREATE...)
    안에 포함된 또 하나의 SELECT문
    메인 SQL문을 보조해주는 쿼리문
*/

-- 간단 서브쿼리 예시
-- 전체 사원의 평균급여보다 더 많은 급여를 받고 있는 사원들의 사번, 이름, 직급코드 조회
-- 1) 전체 사원의 평균 급여 구하기
SELECT ROUND(AVG(SALARY))
  FROM EMPLOYEE; -- 대략 3,047,663원
-- 2) 급여가 3,047,663원 이상인 사원들 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE
  FROM EMPLOYEE
 WHERE SALARY > 3047663;

-- 합치기
SELECT EMP_ID, EMP_NAME, JOB_CODE
  FROM EMPLOYEE
 WHERE SALARY > (SELECT ROUND(AVG(SALARY))
                   FROM EMPLOYEE);


--------------------------------------------------------------------------------
/*
    서브쿼리 구분
    서브쿼리를 수행한 결과값이 몇 행 몇 열이냐에 따라서 분류

    - 단일행 서브쿼리 : 서브쿼리를 수행한 결과값이 오로지 1개 일 때
    - 다중행 서브쿼리 : 서브쿼리를 수행한 결과값이 여러 행일 때
    - 다중열 서브쿼리 : 서브쿼리를 수행한 결과값이 여러 열일 때
    - 다중행 다중열 서브쿼리 : 서브쿼리를 수행한 결과값이 여러 행 여러 열 일 때
    
    => 서브쿼리를 수행한 결과가 몇 행 몇 열이냐에 따라 사용가능한 연산자도 달라짐
*/

/*
    1. 단일행 서브쿼리 (SINGLE ROW SUBQUERY)
    서브쿼리의 조회 결과값이 오로지 1개 일 때

    일반 연산자 사용가능(=, !=, >=, <)
*/

-- 전 직원의 평균 급여보다 더 적게 받는 사원들의 사원명, 직급코드, 급여 조회
SELECT EMP_NAME, JOB_CODE, SALARY
  FROM EMPLOYEE
 WHERE SALARY < (SELECT AVG(SALARY)  -- 결과값 1행 1열, 딱 1개있는 값
                   FROM EMPLOYEE);
                   
-- 최저급여를 받는 사원의 사번, 사원명, 직급코드, 급여, 입사일 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, HIRE_DATE
  FROM EMPLOYEE
 WHERE SALARY = (SELECT MIN(SALARY)
                   FROM EMPLOYEE);


-- 노옹철 사원의 급여보다 더 많이 받는 사원들의 사번, 이름, 부서코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY
                  FROM EMPLOYEE
                 WHERE EMP_NAME = '노옹철');


-- 노옹철 사원의 급여보다 더 많이 받는 사원들의 사번, 이름, 부서명, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE, DEPARTMENT
WHERE SALARY > (SELECT SALARY
                  FROM EMPLOYEE
                 WHERE EMP_NAME = '노옹철')
  AND DEPT_CODE = DEPT_ID; -- JOIN도 가능하다!

-- 전지연과 같은 부서인 사원들의 사번, 사원명, 전화번호, 직급명 조회(단, 전지연은 제외)
-- ORACLE
SELECT EMP_ID, EMP_NAME, PHONE, JOB_NAME
  FROM EMPLOYEE E, JOB J
 WHERE E.JOB_CODE = J.JOB_CODE
   AND DEPT_CODE = (SELECT DEPT_CODE
                      FROM EMPLOYEE
                     WHERE EMP_NAME = '전지연')
   AND EMP_NAME != '전지연';
-- ANSI
SELECT EMP_ID, EMP_NAME, PHONE, JOB_NAME
  FROM EMPLOYEE
  JOIN JOB USING(JOB_CODE)
 WHERE DEPT_CODE = (SELECT DEPT_CODE
                      FROM EMPLOYEE
                     WHERE EMP_NAME = '전지연')
  AND EMP_NAME != '전지연';

--------------------------------------------------------------------------------
-- 부서별 급여 합이 가장 큰 부서 하나만을 조회 부서코드, 부서명, 급여합 조회
SELECT MAX(SUM(SALARY))
  FROM EMPLOYEE
 GROUP BY DEPT_CODE;

SELECT DEPT_CODE, DEPT_TITLE, SUM(SALARY)
  FROM EMPLOYEE
  JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
 GROUP BY DEPT_CODE, DEPT_TITLE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                        FROM EMPLOYEE
                       GROUP BY DEPT_CODE);
--------------------------------------------------------------------------------
/*
    2. 다중행 서브쿼리 (MULTI ROW SUBQUERY)
    서브쿼리의 조회 결과값이 여러행일 때

    - IN : 여러개의 결과값 중에서 한개라도 일치하는 값이 있으면
    - NOT IN : 아예 없으면
    
    - > ANY : 여러개의 결과 값 중에서 "하나라도" 클 경우
    - < ANY : 여러개의 결개 값 중에서 "하나라도" 작을 경우
    
*/

-- 사원 < 대리 < 과장 < 차장 < 부장
-- 대리 직급임에도 불구하고 과장 직급의 급여보다 많이 받는 직원 조회(사번, 이름, 직급명, 급여)

-- 1) 과장 직급의 급여를 조회
SELECT SALARY
  FROM EMPLOYEE E, JOB J
 WHERE E.JOB_CODE = J.JOB_CODE
   AND JOB_NAME = '과장'; -- 2200000, 2500000, 3760000
   
-- 2) 위의 급여보다 높은 급여를 받는 직원들 조회(사번, 이름, 직급명, 급여)
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
  FROM EMPLOYEE E, JOB J
 WHERE E.JOB_CODE = J.JOB_CODE
   AND SALARY > ANY(2200000, 2500000, 3760000);

-- 3) 합치기
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
  FROM EMPLOYEE E, JOB J
 WHERE E.JOB_CODE = J.JOB_CODE
   AND SALARY > ANY(SELECT SALARY
                      FROM EMPLOYEE E, JOB J
                     WHERE E.JOB_CODE = J.JOB_CODE
                       AND JOB_NAME = '과장')
   AND JOB_NAME = '대리';


-- 각 부서별 최고급여를 받는 사원의 이름, 직급코드, 급여 조회
-- 1) 각 부서별 최고급여
SELECT MAX(SALARY)
  FROM EMPLOYEE
 GROUP BY DEPT_CODE; -- 2890000, 3660000, 8000000, 3760000, 3900000, 2490000, 2550000

-- 2) 위의 급여를 받는 사원들 조회(사원의 이름, 직급코드, 급여)
SELECT EMP_NAME, JOB_CODE, SALARY
  FROM EMPLOYEE
 WHERE SALARY IN (2890000, 3660000, 8000000, 3760000, 3900000, 2490000, 2550000);

-- 합치기
SELECT EMP_NAME, JOB_CODE, SALARY
  FROM EMPLOYEE
 WHERE SALARY IN (SELECT MAX(SALARY)
                    FROM EMPLOYEE
                   GROUP BY DEPT_CODE);


-- 선동일 또는 유재식 사원과 같은 부서인 사원들을 조회(사원명, 부서코드, 급여)
SELECT EMP_NAME, DEPT_CODE, SALARY
  FROM EMPLOYEE
 WHERE DEPT_CODE IN (SELECT DEPT_CODE
                       FROM EMPLOYEE
                      WHERE EMP_NAME IN('유재식', '선동일'));

-- 사원 < 대리 < 과장 < 차장 < 부장
-- 과장 직급임에도 불구하고 모든 차장 직급의 급여보다 많이 받는 직원 조회(사번, 이름, 직급명, 급여)
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
  FROM EMPLOYEE
  JOIN JOB USING(JOB_CODE)
 WHERE SALARY > ALL(SELECT SALARY
                      FROM EMPLOYEE
                      JOIN JOB USING(JOB_CODE)
                     WHERE JOB_NAME = '차장')
                -- 2800000, 1550000, 2490000, 2480000
                /*
                   EX ) 2000000
                   
                    > ANY : True
                    > ALL : False
                */
AND JOB_NAME = '과장';

--------------------------------------------------------------------------------
/*
    3. 다중열 서브쿼리
    조회 결과 값은 한 행이지만 나열된 컬럼수가 여러 개일 때
*/

-- 하이유 사원과 같은 부서코드 AND 직급코드에 해당하는 사원들 조회
SELECT DEPT_CODE, JOB_CODE
  FROM EMPLOYEE
 WHERE EMP_NAME = '하이유'; -- D5 / J5

-- > 부서코드가 D5이면서 직급코드가 J5인 사원 조회
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D5'
   AND JOB_CODE = 'J5';

-- 합치기
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
  FROM EMPLOYEE
 WHERE DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '하이유')
   AND JOB_CODE = (SELECT JOB_CODE FROM EMPLOYEE WHERE EMP_NAME = '하이유');


--> 다중열 서브쿼리
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
  FROM EMPLOYEE
 WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE
                                  FROM EMPLOYEE
                                 WHERE EMP_NAME = '하이유');

-- 박나라 사원과 같은 직급코드, 같은 사수사번을 가진 사원들의
-- 사번, 이름, 직급코드, 사수사번 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE (JOB_CODE, MANAGER_ID) = (SELECT JOB_CODE, MANAGER_ID
                                  FROM EMPLOYEE
                                 WHERE EMP_NAME = '박나라');
--------------------------------------------------------------------------------
/*
    4. 다중행 다중열 서브쿼리
    서브쿼리 조회 결과값이 여러 행 여러 컬럼일 경우
*/

-- 각 직급별 최소급여를 받는 사원들 조회(사번, 이름, 직급코드, 급여)
-- 1) 각 직급별 최소 급여 조회
SELECT JOB_CODE, MIN(SALARY)
  FROM EMPLOYEE
 GROUP BY JOB_CODE;

-- 2) 위의 목록들 중에 일치하는 사원 // 사번, 이름, 직급코드, 급여


-- 이름
SELECT EMP_NAME
  FROM EMPLOYEE
 WHERE (JOB_CODE = 'J2' AND SALARY = 3700000) 
    OR (JOB_CODE = 'J7' AND SALARY = 1380000) 
    OR (JOB_CODE = 'J3' AND SALARY = 3400000)
    OR (JOB_CODE = 'J6' AND SALARY = 2000000)
    OR (JOB_CODE = 'J5' AND SALARY = 2200000)
    OR (JOB_CODE = 'J1' AND SALARY = 8000000)
    OR (JOB_CODE = 'J4' AND SALARY = 1550000);

SELECT EMP_NAME
  FROM EMPLOYEE
 WHERE (JOB_CODE, SALARY) IN (('J2', 3700000), ('J7', 1380000), ('J3', 3400000),
                                ('J6', 2000000), ('J5', 2200000), ('J1', 8000000),
                                ('J4', 1550000));
                                
-- 합치기

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
  FROM EMPLOYEE
 WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, MIN(SALARY)
                                FROM EMPLOYEE
                               GROUP BY JOB_CODE);
                               
                               
-- 각 부서별 최고급여를 받는 사원들 조회(사번, 이름, 부서코드, 급여) 정렬까지(오름차순)
SELECT EMP_ID, EMP_NAME, NVL(DEPT_CODE, '부서없음'), SALARY
  FROM EMPLOYEE
 WHERE (NVL(DEPT_CODE, '부서없음'), SALARY) IN (SELECT NVL(DEPT_CODE, '부서없음'), MAX(SALARY)
                                                FROM EMPLOYEE
                                               GROUP BY DEPT_CODE)
 ORDER BY EMP_ID;

--------------------------------------------------------------------------------
-- 보너스 포함 연봉이 3000만원 이상인 사원들의 사번, 이름, 보너스포함연봉, 부서코드를 조회

SELECT EMP_ID, EMP_NAME, (SALARY + (SALARY * NVL(BONUS, 0))) * 12 "보너스 연봉",DEPT_CODE
  FROM EMPLOYEE;
 WHERE (SALARY + (SALARY * NVL(BONUS, 0))) * 12 >= 30000000;


-- 인라인 뷰를 사용해보자!

SELECT "보너스 연봉"
  FROM (SELECT EMP_ID, EMP_NAME, (SALARY + (SALARY * NVL(BONUS, 0))) * 12 "보너스 연봉",DEPT_CODE
          FROM EMPLOYEE)
 WHERE "보너스 연봉" >= 30000000;

/*
    5. 인라인 뷰(INLINE-VIEW)
    FROM절에 서브쿼리를 제시!!

    서브쿼리를 수행한 결과!(RESULT SET)를 테이블 대신 사용함
*/

--> 인라인뷰를 주로 사용하는 예
-- TOP-N분석 : 데이터베이스 상에 존재하는 자료 중 최상위 몇 개 자료를 보기 위해 사용

-- 전직원 중 급여가 가장 높은 5명
-- * ROWNUM : 오라클에서 제공해주는 컬럼, 조회된 순서대로 1부터 .... 순번을 부여해 줌

SELECT ROWNUM, EMP_NAME, SALARY         -- 3
  FROM EMPLOYEE                         -- 1
 WHERE ROWNUM <= 5                      -- 2
 ORDER BY SALARY DESC;                  -- 4
 
 
SELECT ROWNUM, EMP_NAME, SALARY
  FROM (SELECT EMP_NAME, SALARY
        FROM EMPLOYEE
       ORDER BY SALARY DESC)
 WHERE ROWNUM <= 5;
 
 
 -- 각 부서별 평균급여가 높은 3개의 부서코드, 평균 급여 조회
 
SELECT ROWNUM, DEPT_CODE, ROUND("평균 급여")
FROM (SELECT DEPT_CODE, AVG(SALARY) "평균 급여"
        FROM EMPLOYEE
       GROUP BY DEPT_CODE
       ORDER BY AVG(SALARY) DESC)
WHERE ROWNUM <= 3;

--------------------------------------------------------------------------------
/*
    6. 순위 매기는 함수
    
    ** SELECT절에서만 사용이 가능!!!!
    
    RANK() OVER(정렬기준)
    DENSE_RANK() OVER(정렬기준)

    RANK() OVER : 공동 1위가 2명이라고 한다면 그 다음 순위를 3위로 하겠다.
    DENSE_RANK() OVER : 공동 1위가 2명이라고 해도 그 다음 순위를 2위로 하겠다.
*/

-- 사원들의 급여가 높은 순서대로 순위를 매겨서, 사원명, 급여, 순위 조회
SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) "순위"
FROM EMPLOYEE;

-- 5위까지만 조회하겠다.
SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) "순위"
FROM EMPLOYEE
WHERE RANK() OVER(ORDER BY SALARY DESC) <= 5;

SELECT *
  FROM (SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) "순위"
          FROM EMPLOYEE)
 WHERE 순위 <= 5;











