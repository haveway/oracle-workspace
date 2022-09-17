/*
    < DML : DATA MANIPULATION LANGUAGE >
    ������ ���۾�

    ���̺� ���ο� �����͸� ����(INSERT)�ϰų�,
    ������ �����͸� ����(UPDATE)�ϰų�,
    ����(DELETE)�ϴ� ����
*/


/*

    1. INSERT : ���̺� ���� �߰��ϴ� ����
    
    [ ǥ���� ]
    
    INSERT INTO ���̺�� VALUES(��, ��, ��, ....);
    => �ش� ���̺� ��� �÷��� ���� �߰��ϰ��� �� �� INSERT������ ����� �� ����.

    ������ �� : �÷� ������ ���Ѽ� VALUES ��ȣ �ȿ� �����ؾ���
*/

SELECT * FROM EMPLOYEE;

INSERT INTO EMPLOYEE 
VALUES(900, '������', '123133-1231233', 'seo@0.jae', '01012345353', 'D1'
        , 'J1', 'S4', 50000000, 0.1, NULL, SYSDATE, NULL, DEFAULT);

SELECT *
  FROM EMPLOYEE
 WHERE EMP_ID = 900;
 
 
 /*
    2) INSERT INTO ���̺��(�÷���1, �÷���2, �÷���3,...) VALUES(��1, ��2, ��3);
    => �ش� ���̺� Ư�� �÷��� �����ؼ� �� �÷��� �߰��� ���� �����ϰ��� �� �� ���
    �� �� ������ �߰��Ǳ� ������ ������ �ȵ� �÷��� �⺻������ NULL���� ��
    (�⺻�� DEFAULT �����Ǿ����� ��� �⺻���� ��)
 
    ���ǻ��� : NOT NULL���������� �ɷ��ִ� �÷��� �ݵ�� ���� ���� �����ؾ���
 */

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, SAL_LEVEL, HIRE_DATE)
     VALUES (901, '���', '324234-3434343', 'D2', 'J3', 'S4', SYSDATE);

SELECT * FROM EMPLOYEE;


/*
    3) INSERT INTO ���̺��(��������);
    
    => VALUES�� ���� �����ϴ°� ��ſ� ���������� ��ȸ�� ������� INSERT�ϴ� ����
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
    �� �� �̻��� ���̺� ���� INSERT�� �� ���
    �� �� ���Ǵ� �������� ������ ���
*/
-- ���ο� ���̺��� ���� �����
-- ù��° ���̺� : �޿��� 300���� �̻��� ������� ���, �����, ���޸� ���� ������ ���̺�
-- ���̺� �̸� : EMP_JOB
-- �÷� : EMP_ID NUMBER, EMP_NAME VARCHAR2(30), JOB_NAME VARCHAR2(20)

CREATE TABLE EMP_JOB(
    EMP_ID NUMBER, EMP_NAME VARCHAR2(30), JOB_NAME VARCHAR2(20)
);

-- �ι�° ���̺� : �޿��� 300���� �̻��� ������� ���, �����, �μ��� ���� ������ ���̺�
-- ���̺� �̸� : EMP_DEPT
-- �÷� EMP_ID NUMBER, EMP_NAME VARCHAR2(30), DEPT_TITLE VARCHAR2(20)

CREATE TABLE EMP_DEPT(
    EMP_ID NUMBER, EMP_NAME VARCHAR2(30), DEPT_TITLE VARCHAR2(20)
    );
    
    
SELECT * FROM EMP_JOB;
SELECT * FROM EMP_DEPT;
    
-- �޿��� 300���� �̻��� ������� ���, �̸�, �μ���, ���޸� ��ȸ

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
  FROM EMPLOYEE
  JOIN JOB USING(JOB_CODE)
  LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
 WHERE SALARY >= 3000000;

/*
    INSERT ALL
    INTO ���̺��1 VALUES(�÷���, �÷���, �÷���)
    INTO ���̺��2 VALUES(�÷���, �÷���, �÷���)
    ��������;
*/

-- EMP_JOB ���̺��� �޿��� 300���� �̻��� ������� EMP_ID, EMP_NAME, JOB_NAME�� ����
-- EMP_DEPT ���̺��� �޿��� 300���� �̻��� ������� EMP_ID, EMP_NAME, DEPT_TITLE�� ����

INSERT ALL
  INTO EMP_JOB VALUES(EMP_ID, EMP_NAME, JOB_NAME) -- 9���� ���� �߰�
  INTO EMP_DEPT VALUES(EMP_ID, EMP_NAME, DEPT_TITLE) -- 9���� ���� �߰�
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
  FROM EMPLOYEE
  JOIN JOB USING(JOB_CODE)
  LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
 WHERE SALARY >= 3000000;

SELECT * FROM EMP_JOB;
SELECT * FROM EMP_DEPT;


-- ���, �����, �Ի���, �޿� // EMP_OLD, EMP_NEW
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
    WHEN ����1 THEN
        INTO ���̺��1 VALUES(�÷���, �÷���, ..)
    WHEN ����2 THEN
        INTO ���̺��2 VALUES(�÷���, �÷���, ..)
    ��������;
*/

INSERT ALL
WHEN HIRE_DATE < '2010/01/01' THEN
    INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY) -- 9���� ���� �߰�
WHEN HIRE_DATE >= '2010/01/01' THEn
    INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY) -- 16���� ���� �߰�
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
  FROM EMPLOYEE;

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;
--------------------------------------------------------------------------------
/*
    3. UPDATE
    ���̺� ��ϵ� �����͸� �����ϴ� ����
    
    [ ǥ���� ]
    UPDATE ���̺��
    SET �÷��� = �ٲܰ�
    , �÷��� = �ٲܰ�
    , �÷��� = �ٲܰ� => ���� ���� �÷� ���� ���� ����(","
    WHERE ����; => ������ ����, ���� �� ��ü ��� ���� �����Ͱ� �� ����
*/


-- ���̺� ����
CREATE TABLE DEPT_COPY
    AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_COPY;
-- D9�μ����� ������ȹ������ ����

UPDATE DEPT_COPY
   SET DEPT_TITLE = '������ȹ��';
   
ROLLBACK;

UPDATE DEPT_COPY
   SET DEPT_TITLE = '������ȹ��'
 WHERE DEPT_ID = 'D9';

-- ���̺� ����2
CREATE TABLE EMP_SALARY
    AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
         FROM EMPLOYEE;
         
SELECT * FROM EMP_SALARY;

ROLLBACK;


-- EMP_SALARY ���̺� ���ö����� �޿��� 1000�������� ����
UPDATE EMP_SALARY
   SET SALARY = 10000000
 WHERE EMP_NAME = '���ö';

SELECT * FROM EMP_SALARY;

-- ��ü����� �޿��� ���� �޿����� 20���� �λ��� �ݾ����� ����
UPDATE EMP_SALARY
   SET SALARY = SALARY * 1.2;

/*
    UPDATE�ÿ� ���������� ���
    ���������� ������ ��������� UPDATE�ϰڴ�.

    UPDATE ���̺��
    SET �÷��� = (��������)
    WHERE ����; => ���� ����
*/

-- EMP_SALARY ���̺� ���������� �μ��ڵ带 �����ϻ���� �μ��ڵ�� ����
UPDATE EMP_SALARY
   SET DEPT_CODE = (SELECT DEPT_CODE
                      FROM EMPLOYEE
                     WHERE EMP_NAME = '������')
 WHERE EMP_NAME = '������';
 
 -- ���� ����� �޿��� ���ʽ��� ����� ����� �޿��� ���ʽ������� ����
 
 -- TABLE == EMP_SALARY
 
 
UPDATE EMP_SALARY
   SET (SALARY, BONUS) = (SELECT SALARY, BONUS
                            FROM EMP_SALARY
                           WHERE EMP_NAME = '�����')
 WHERE EMP_NAME = '����';
 
SELECT * FROM EMP_SALARY;
--------------------------------------------------------------------------------
-- UPDATE ��� �� �����Ҷ� �ƹ��� ������ ������????

-- ��������!!!!!

-- ������ ����� ����� 200������ ����
UPDATE EMPLOYEE
   SET EMP_ID = 200
 WHERE EMP_NAME = '������'; -- PRIMARY KEY�������ǿ� ����
 
UPDATE EMPLOYEE
   SET EMP_NAME = NULL
 WHERE EMP_NAME = '������'; -- NOT NULL �������� ����
 
COMMIT;

--------------------------------------------------------------------------------
/*
    4. DELETE
    ���̺� ��ϵ� �����͸� �����ϴ� ����
    
    [ǥ����]
    DELETE FROM ���̺��
    WHERE ����; => WHERE ���� ���� ����, ���� �� �ش� ���̺��� ��ü �� ����
*/

DELETE FROM EMPLOYEE;
SELECT * FROM EMPLOYEE;
ROLLBACK; -- �ѹ� �� ������ Ŀ�Խ������� ���ư�

-- ������, ��� ����� ������ �����
DELETE FROM EMPLOYEE
 WHERE EMP_NAME IN('������','���');
 
COMMIT; -- ��� ��������� Ȯ�� ��

-- DEPARTMENT ���̺�κ��� DEPT_ID�� D1�� �μ� ����
DELETE FROM DEPARTMENT
 WHERE DEPT_ID = 'D1';

SELECT * FROM DEPARTMENT;

DELETE FROM DEPARTMENT
 WHERE DEPT_ID = 'D3';

ROLLBACK;

/*
    * TRUNCATE : ���̺��� ��ü ���� ������ �� ����ϴ� ����(����)
                 DELETE���� ����ӵ��� �� ����!!!
                 ������ ���� ���� �Ұ�, ROLLBACK �Ұ���!

    [ ǥ���� ]
        TRUNCATE TABLE ���̺��     |     DELETE FROM ���̺��;
        ----------------------------------------------------
        ������ �������� �Ұ�          |   Ư�� �������� ����
        ����ӵ� ����(DELETE����)     |  ����ӵ��� ����(TRUNCATE����)
        ROLLBACK�Ұ�!               |   ROLLBACK����!
        ----------------------------------------------------
*/

SELECT * FROM EMP_SALARY;

DELETE FROM EMP_SALARY; -- 0.037��

ROLLBACK;

TRUNCATE TABLE EMP_SALARY; -- 0.125��

-- Table EMP_SALARY��(��) �߷Ƚ��ϴ�.


























