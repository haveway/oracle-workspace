/*         
    < 시퀀스 SEQUENCE >
    자동으로 번호를 발생시켜주는 역할을 하는 객체
    정수값을 자동으로 순차적으로 생성해줌
    
    예 ) 회원번호, 사번, 게시글 번호 등등... 채번 할 때 사용
    
    INSERT INTO I VALUES(1, 'user01', pass01',....)
    INSERT INTO I VALUES(2, 'user01', pass01',....)
    INSERT INTO I VALUES(3, 'user01', pass01',....)
    INSERT INTO I VALUES(4, 'user01', pass01',....)
    INSERT INTO I VALUES(5, 'user01', pass01',....)
    INSERT INTO I VALUES(6, 'user01', pass01',....)
    INSERT INTO I VALUES(7, 'user01', pass01',....)
    INSERT INTO I VALUES(9, 'user01', pass01',....)
    INSERT INTO I VALUES(10, 'user01', pass01',....)
    INSERT INTO I VALUES(11, 'user01', pass01',....)
    INSERT INTO I VALUES(12, 'user01', pass01',....)
    ...
    INSERT INTO I VALUES(124358, 'user01', pass01',....)
    INSERT INTO I VALUES(124359, 'user01', pass01',....)
    INSERT INTO I VALUES(124360, 'user01', pass01',....)
    INSERT INTO I VALUES(123458, 'user01', pass01',....)
    
    
    1. 시퀀스 객체 생성 구문
    CREATE SEQUENCE 시퀀스명
    START WITH 시작숫자       => 생략가능, 처음 발생시킬 시작값 지정
    INCREMENT BY 증가값       => 생략가능, 몇 씩 증가시킬건지 결정
    MAXVALUE                 => 생략가능, 최대값 지정
    MINVALUE                 => 생략가능, 최소값 지정
    CYCLE/NOCYCLE            => 생략가능, 값 순환 여부
    CACHE 바이트크기/NOCACHE   => 생략가능, 캐시메모리 쓸거야? 기본값은 20Byte
    
    
    * SEQUENCE CACHE MEMORY : 미리 발생할 값들을 생성해서 저장해두는 공간
                              매번 호출할 때 새로 번호를 생성하는건 비효율적이니
                              캐시메모리 공간에 미리 생성된 값들을 가져다 쓰게해서
                              속도를 높임
                              접속이 끊기면 재접속후 기존에 생성되어있는 값들은 날아감
*/
    /*
        * 접두사, 접미사
        - 테이블명 : TB_
        - 뷰명 : VW_
        - 시퀀스 : SEQ_
    */
    
CREATE SEQUENCE SEQ_TEST;
    
-- 현재 접속한 계정이 소유하고 있는 시퀀스들에 대한 정보 조회용 데이터 딕셔너리
-- USER_TABLES, USER_VIEWS 등등...

SELECT * FROM USER_SEQUENCES;

CREATE SEQUENCE SEQ_EMPNO
START WITH 300 -- 시작값
INCREMENT BY 5 -- 증가값
MAXVALUE 310 -- 최대값
NOCYCLE -- 안돌려
NOCACHE; -- 캐시안써


------------------------------------------------------------------------
/*
    2. 시퀀스 사용 구문

    시퀀스명.CURRVAL : 현재 시퀀스의 값 (마지막으로 성공적으로 발생된 NEXTVAL 값)
    시퀀스명.NEXTVAL : 시퀀스값을 증가시키고 증가된 시퀀스의 값
                    기존의 시퀀스 값에서 INCREMENT BY 값만큼 증가된 값
                    (시퀀스명.CURRVAL + INCREMENT BY 값)

*/

SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
--> NEXTVAL 을 한번이라도 수행하지 않는 이상 CURRVAL을 수행할 수 없음

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 300
SELECT * FROM USER_SEQUENCES;
-- LAST_NUMBER: 현재 상황에서 NEXTVAL를 실행할 경우 예정 값

SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 300
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 305
SELECT * FROM USER_SEQUENCES;

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 310
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;
-- 지정한 MAXVALUE 값(310)을 초과했기 때문에 오류 발생

SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 310
-- 마지막에 성공적으로 수행된 NEXTVAL 값
----------------------------------------------------------

/*
    3. 시퀀스 변경

    [ 표현법 ]
    ALTER SEQUENCE 시퀀스명
    INCREMENT BY 증가값
    MAXVALUE 최대값
    MINVALUE 최소값
    CYCLE/NOCYCLE
    CACHE 바이트크기 / NOCACHE
    
    * START WITH는 변경 불가
*/

ALTER SEQUENCE SEQ_EMPNO
INCREMENT BY 10
MAXVALUE 400;

SELECT * FROM USER_SEQUENCES;

SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 310
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 340

---------------------------------------------

CREATE SEQUENCE SEQ_EID
START WITH 300;

-- EMPLOYEE 테이블에 사원을 추가해보겠습니다!

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL)
     VALUES (SEQ_EID.NEXTVAL, '내맘대로', '123123213', 'J3', 'S3'); -- 300


INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL)
     VALUES (SEQ_EID.NEXTVAL, '뭔데', '123123123', 'J3', 'S4'); -- 301

SELECT * FROM EMPLOYEE;



-------------------Java------------- 상상 그 이상 재미있다 

-------------------Oracle----------- 재미없고 어렵다 (자바보다 재밌었따)

-------------------Java------------- API(Math) / Collection 쉬움 재밌음

--/ I/O 어려움 개념만 알면 됨        / (Network) 잘하면할수도있음

-------------------JDBC------------- 드럽게 어려움(열심히해야함)

-------------------HTML/CSS--------- 드럽게 쉬움 너무너무쉬워서 노잼













SELECT *
FROM DEPARTMENT;








/*
개발팀의 실수로 사원들의 연락처가 유출되었습니다.
      모든 사원들의 연락처 뒤 4자리를 '*'로 채우고
      (연락처가 없는 사람들은 고려하지 않음)
      사번, 사원이름, 연락처, 부서명을 조회하는 쿼리문을 작성하시오.
*/
SELECT EMP_ID, EMP_NAME, RPAD(SUBSTR(PHONE,1,7), 11,'*') 폰번호, DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
/*
문제 1)
연락처를 수정하다 보니, 011, 017 번호를 쓰는 직원들을 위해
최신 갤럭시 노트 10+를 회사 복지 차원으로 지급하기로 했다.
연락처가 '011', '017'로 시작하는 직원들의 사번, 사원명, 연락처, 부서명, 직급명을
조회하고 연락처를 '010'으로 시작하는 번호로 수정하는 쿼리문을 작성하시오.
*/
SELECT EMP_ID, EMP_NAME, PHONE, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE)
WHERE SUBSTR(PHONE, 1, 3) IN ('011','017');

UPDATE EMPLOYEE
SET PHONE = '0103654485'
WHERE SUBSTR(PHONE, 1, 3) = '011';

UPDATE EMPLOYEE
SET PHONE = '0109964233'
WHERE SUBSTR(PHONE, 1, 3) = '017';

/*
문제 2)
근속연수 별 사원들의 연봉통계를 내고자 한다.
EMP_COPY_TEST에서 근속연수별 사원들의
근속연수가 10년 이상인 사원들의
근속연수별 평균급여과 최고급여를 구하여, 근속연수별 내림차순으로 정렬하시오.
*/
CREATE TABLE EMP_COPY_TEST
AS SELECT * FROM EMPLOYEE;

SELECT EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE),
        AVG(SALARY),
        MAX(SALARY)
FROM EMPLOYEE
GROUP BY EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
HAVING EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) >= 10
ORDER BY 1 DESC;














/*
문제 3)
기술지원부의 인원이 부족하여 부서가 없는 직원들을 기술지원부로 데려오기로 결정하였다.
부서가 없는 직원들을 기술지원부로 이동한 후
기술지원부의 사번 사원명 급여 직급명 부서명을 조회하시오.
*/

SELECT * FROM DEPARTMENT;

UPDATE EMPLOYEE SET DEPT_CODE = 'D8'
WHERE DEPT_CODE IS NULL;

SELECT EMP_ID, EMP_NAME, SALARY, JOB_NAME, DEPT_TITLE
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE = '기술지원부';






