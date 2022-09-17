/*

    안녕하세요 ~ 여러줄 주석이예요 ~
    이 사이가 이제 다 주석이 되는거죠 ~~~
    
    오라클 설치 시 :
    
    경로 : 마음대로
    비밀번호 : oracle
    비밀번호 확인 : oracle
    
    cmd -> sqlplus -> sys as sysdba // oracle  -> exit 

    sql Developer 실행
*/

select * from DBA_USERS;
-- 어떤 계정들이 있는지 확인

-- 일반 사용자 계정을 생성하는 구문(관리자 계정에서만!!!!!)
-- [표현법] CREATE(생성) USER 사용자이름 IDENTIFIED BY 비밀번호;
CREATE USER kh IDENTIFIED BY kh; -- 아이디는 대소문자 구분없음 // 비번은 대소문자 구분

-- 권한주는 명령어

-- 위에서 생성된 일반 사용자 계정에게 최소한의 권한(접속, 데이터) 부여
-- [표현법] GRANT 권한1, 권한2, .... TO 계정명;

GRANT CONNECT, RESOURCE TO kh;












