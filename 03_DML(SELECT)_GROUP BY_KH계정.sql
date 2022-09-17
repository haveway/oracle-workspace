/*
    < GROUP BY 절 >
    그룹을 묶어줄 기준을 제시할 수 있는 구문


    여러개 값들을 그룹별로 나눠서 처리할 목적으로 사용.
*/

-- 전체 사원의 총 급여합
SELECT SUM(SALARY)
  FROM EMPLOYEE;  --> 현재 조회된 전체사원들을 하나의 그룹으로 묶어서 총합을 구한 결과
  
-- 각 부서별 총 급여 합
SELECT DEPT_CODE, SUM(SALARY)
  FROM EMPLOYEE
 GROUP BY DEPT_CODE;
 
 
-- 전체사원 수
SELECT COUNT(*)
  FROM EMPLOYEE;
  
-- 각 부서별 사원수
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;
  
-- 각 부서별 총 급여 합 부서별 오름차순 정렬해서 조회
SELECT DEPT_CODE, SUM(SALARY) -- 3. SELECT 절
  FROM EMPLOYEE            -- 1. FROM절
 GROUP BY DEPT_CODE        -- 2. GROUP BY절
 ORDER BY DEPT_CODE ASC;   -- 4. 오도바이 ~
  
-- 성별 별 사원 수
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남자', 2, '여자'), COUNT(*)
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8, 1);
  
--------------------------------------------------------------------------------

-- 부서별 평균 급여 300만원 이상인 부서들만 조회
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
WHERE AVG(SALARY) >= 3000000
GROUP BY DEPT_CODE;

/*
    < HAVING 절 >

    그룹에 대한 조건을 제시하고자 할 때 사용되는 구문
    (대부분의 경우 그룹함수를 가지고 조건 제시)
*/



SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000;


-------------------------------------------------------------------------------
/*
    < 실행 순서 >
    5 : SELECT * /조회하려는 컬럼 /산술연산 /함수식  "별명"
    1 : FROM 조회테이블
    2 : WHERE 조건식
    3 : GROUP BY 그룹 기준에 해당하는 컬럼명 / 함수식
    4 : HAVING 그룹함수식에 대한 조건식
    6 : ORDER BY 정렬 기준에 해당하는 컬럼명 / 별칭 / 컬럼 순번 ASC/DESC NULL F / NULL L
*/
-------------------------------------------------------------------------------



  
  
  
  
  