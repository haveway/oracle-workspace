/*
    < 함수 FUNCTION >
    자바로 따지면 메소드와 같은 존재
    전달된 값들을 읽어서 계산한 결과를 반환
    
    - 단일행 함수 : N개의 값을 읽어서 N개의 값을 리턴
    - 그룹 함수 : N개의 값을 읽어서 1개의 결과를 리턴
    
    단일행 함수와 그룹함수는 함께 사용할 수 없음!!!!
    : 결과 행의 갯수가 다르기 때문에

*/

-------- < 단일행 함수 > --------

/*
    < 문자열과 관련된 함수 >
    LENGTH / LENGTHB
    
    - LENGTH(STR) : 해당 전달된 문자열의 글자 수 반환
    - LENGTHB(STR) : 해당 전달된 문자열의 바이트 수 반환
    
    결과 값은 NUMBER타입으로 반환
    
        
    숫자, 영문, 특수문자 : '!', '~', 'A', '1' => 한글자당 1Byte
    한글 : 'ㄱ', 'ㅏ', '강'.... => 한글자당 3Byte
*/
SELECT LENGTH('ORACLE'), LENGTHB('ORACLE')
FROM DUAL; -- 가상테이블(DUMMY TABLE)

SELECT LENGTH('오라클'), LENGTHB('오라클')
FROM DUAL; -- 가상테이블(DUMMY TABLE)

SELECT EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL), EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME)
FROM EMPLOYEE;

-------------------------------------------------------------------------
/*
    < INSTR >
    - INSTR(STR) : 문자열로부터 특정 문자의 위치값 반환
    INSTR(STR, '특정문자', 찾을 위치의 시작값, 순번)

    결과값은 NUMBER 타입으로 반환
    찾을 위치의 시작값, 순번은 생략 가능
    1 : 앞에서부터 찾겠다.
    -1 : 뒤에서부터 찾겠다.

*/


SELECT INSTR('AABAACAABBAA', 'B')
FROM DUAL; -- 찾을 위치, 순번 생략 시 기본적으로 앞에서부터 첫번째 글자 검색

SELECT INSTR('AABAACAABBAA', 'B', 1)
FROM DUAL;

SELECT INSTR('AABAACAABBAA', 'B', -1)
FROM DUAL; -- 해당 문자열 첫번째 B가 뒤에서부터 몇번째에 있는가!

SELECT INSTR('AAAAABCAAAABA', 'B', 1, 2)
FROM DUAL;

SELECT INSTR('AAAAABCAAAABA', 'B', -1, 2)
FROM DUAL; -- 해당 문자열의 뒤에서부터 두번째 B가 앞에서부터 몇번째에 있는가

-- EMPLOYEE테이블에서 EMAIL컬럼의 @의 위치를 찾아보자!!
SELECT EMP_NAME "누구꺼니?", INSTR(EMAIL, '@') "@이 어디있니?"
FROM EMPLOYEE;

----------------------------------------------------------------------

/*
    < SUBSTR >
    문자열로부터 특정문자열 추출 -> 반환
    .subString()

    결과값이 CHARACTER 타입으로 반환
    -SUBSTR(STR, POSITION, LENGTH)
    
    - STR : '문자열'또는 문자 타입 컬럼
    - POSITION : 시작위치값
    - LENGTH : 추출할 문자 갯수(생략 시 끝까지)
*/


SELECT SUBSTR('leehightmetalbest', 7)
FROM DUAL;

SELECT SUBSTR('leehightmetalbest', 7, 5)
FROM DUAL;

SELECT SUBSTR('leehightmetalbest', -10, 5)
FROM DUAL;


-- 주민번호 성별 부분을 추출해서 남자(1)/여자(2)를 체크
SELECT EMP_NAME, SUBSTR(EMP_NO, 8, 1) 성별
FROM EMPLOYEE;

-- 남자사원들만 조회(사원명, 급여)
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = '1' OR SUBSTR(EMP_NO, 8, 1) = '3';

-- 여자 사원들만 조회(사원명, 급여) 2, 4
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('2', '4');

-- 이메일에서 ID부분만 추출해서 조회(이름, 이메일, ID)
-- EMAIL문자열에서 @앞까지만
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1)
FROM EMPLOYEE;

-----------------------------------------------------------------------

/*
    LPAD / RPAD
    
    - LPAD / RPAD(STR, 최종적으로 반환할 문자의길이(바이트), 덧붙이고자하는 문자

    결과값은 CHARTER 타입으로 반환
    덧붙이고자 하는 문자는 생략 가능
*/

SELECT LPAD(EMAIL, 20, 'a')
FROM EMPLOYEE;

SELECT RPAD(EMAIL, 20, '!')
FROM EMPLOYEE;

-- 112323-9****** 14 = 14Byte
SELECT RPAD('121212-2', 14, '*') 주민번호
FROM DUAL;

-- SELECT * FROM EMPLOYEE;
-- 모든 직원의 주민등록번호 뒤 6자리를 마스킹처리해서 표현해보자
-- 이름, 주민번호

-- 1단계, SUBSTR을 이용해서 주민등록번호 앞 8자리만 추출
SELECT EMP_NAME, SUBSTR(EMP_NO, 1, 8)
FROM EMPLOYEE;

-- 2단계, RPAD를 주민등록번호 뒤 6자리에 * 붙이기
SELECT EMP_NAME 이름 , RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*') 주민번호
FROM EMPLOYEE;

---------------------------------------------------------------------

/*
    < LOWER / UPPER / INITCAP >
    - LOWER(STR)
    : 전부 다 소문자로 변경
    - UPPER(STR)
    : 전부 다 대문자로 변경
    - INITCAP(STR)
    : 각 단어 앞글자만 대문자로 변경
*/

SELECT LOWER('Welcome To Oracle')
FROM DUAL;

SELECT UPPER('welcome to oracle')
FROM DUAL;

SELECT INITCAP('welcome to oracle')
FROM DUAL;

-------------------------------------------------------------------------

/*
    < CONCAT >
    
    - CONCAT(STR1, STR2)
    : 전달된 두 개의 문자열을 하나로 합친 결과로 반환

    결과값은 CHARTER 반환
*/

SELECT '가나다' || 'ABC' || 'asd'
FROM DUAL;

SELECT CONCAT('가나다', 'ABC')
FROM DUAL; -- CONCAT함수는 세 개 이상 합치기 불가!


---------------------------------------------

/*
    REPLACE
    
    - REPLACE(STR, 찾을문자, 바꿀문자)
    : STR로부터 찾을 문자를 찾아서 바꿀문자로 변환 후 반환
    
    결과값은 CHARACTER로 반환

*/

SELECT REPLACE('서울시 강남구 역삼동', '역삼동', '삼성동')
FROM DUAL;

SELECT EMAIL, REPLACE(EMAIL, 'kh.or.kr', 'iei.com')
FROM EMPLOYEE;
----------------------------------------------------------------------

/*
    < TRIM >
    (BOTH(양쪽) / LEADING(앞쪽) / TRAILING(뒤쪽)) -> 생략 가능
    : 문자열 앞/뒤/양쪽에 있는 특정 문자를 제거한 나머지 문자열을 반환
    결과값은 CHARACTER로 반환
*/

SELECT TRIM('Z' FROM 'ZZZKHZZZ')
FROM DUAL; -- 양쪽(기본값) : BOTH

SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZ')
FROM DUAL; -- 앞쪽 : LEADING

SELECT TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ')
FROM DUAL; -- 뒤쪽 : TRAILING
-------------------------------------------------------------------------







