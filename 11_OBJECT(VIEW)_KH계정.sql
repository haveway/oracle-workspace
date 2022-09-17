/*
    < VIEW �� >
    
    SELECT(������)�� �����ص� �� �ִ� ��ü
    (���� ���� �� SELECT���� �����صθ� �� SELECT���� �Ź� �ٽ� ����� �ʿ䰡 ����)
    �ӽ����̺�(���� �����Ͱ� ���°��� �ƴϴ�)
*/

---------------------------�ǽ�����---------------------------
-- '�ѱ�'���� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ�������, ���޸��� ��ȸ�Ͻÿ�.
        -- EMPLOYEE       DEPARTMENT            NATIONAL    JOB
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME
  FROM EMPLOYEE E, DEPARTMENT, LOCATION L, NATIONAL N, JOB J
 WHERE DEPT_CODE = DEPT_ID
   AND LOCATION_ID = LOCAL_CODE
   AND L.NATIONAL_CODE = N.NATIONAL_CODE
   AND E.JOB_CODE = J.JOB_CODE
   AND NATIONAL_NAME = '�ѱ�';

--------------------------------------------------------------------------------

/*
    1. VIEW �������

    [ ǥ���� ]
    CREATE VIEW ���
    AS ��������;

    CREATE OR REPLACE VIEW ���
    AS ��������; -> OR REPLACE�� ������ �����ϴ�.
    �� ���� �� ������ �ߺ��� �̸��� ���ٸ� ���� �����
              ������ �ߺ��� �̸��� �䰡 �ֵ��� �ش� �並 ����(����)�ϴ� �ɼ�

*/

-- ���̸� : VW_EMPLOYEE
CREATE VIEW VW_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME
     FROM EMPLOYEE E, DEPARTMENT, LOCATION L, NATIONAL N, JOB J
    WHERE DEPT_CODE = DEPT_ID
      AND LOCATION_ID = LOCAL_CODE
      AND L.NATIONAL_CODE = N.NATIONAL_CODE
      AND E.JOB_CODE = J.JOB_CODE
      AND NATIONAL_NAME = '�ѱ�';
-- KH������ �� ���������� ���⶧���� ���� �߻�
-- �����ڰ������� GRANT CREATE VIEW TO KH; �����ָ� �ذ��
GRANT CREATE VIEW TO KH;


SELECT * 
  FROM (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME
     FROM EMPLOYEE E, DEPARTMENT, LOCATION L, NATIONAL N, JOB J
    WHERE DEPT_CODE = DEPT_ID
      AND LOCATION_ID = LOCAL_CODE
      AND L.NATIONAL_CODE = N.NATIONAL_CODE
      AND E.JOB_CODE = J.JOB_CODE
      AND NATIONAL_NAME = '�ѱ�');

SELECT * FROM VW_EMPLOYEE;
-- �� ���� �� ���������� �̿��Ͽ� �׶��׶� ����� �ʹ��ʹ� �����ϰ� �˾ƺ��� ���� �����͵��� ��ȸ�ϴ°ͺ���
-- �ѹ� ���� �並 ���ؼ� ���ϰ� ��ȸ�� �����ϴ�.

-- �ѹ��ο� ���ϴ� ���
SELECT * FROM VW_EMPLOYEE
 WHERE DEPT_TITLE = '�ѹ���';
 
 -- �λ�����ο��� ���ϴ� ���
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, BONUS
  FROM VW_EMPLOYEE
 WHERE DEPT_TITLE = '�λ������';
 
-- ���ʽ��÷��� ���� �� ���������....
-- CREATE OR REPLACE VIEW ��� �Ẹ��!!!!
CREATE OR REPLACE VIEW VW_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME, BONUS
     FROM EMPLOYEE E, DEPARTMENT, LOCATION L, NATIONAL N, JOB J
    WHERE DEPT_CODE = DEPT_ID
      AND LOCATION_ID = LOCAL_CODE
      AND L.NATIONAL_CODE = N.NATIONAL_CODE
      AND E.JOB_CODE = J.JOB_CODE
      AND NATIONAL_NAME = '�ѱ�';
 
-- ��� ������ �������̺� ==> ���������� �����͸� �����ϰ� ���� ����(�������� TEXT�� ����)
-- ����) �ش� ������ ������ �ִ� VIEW�鿡 ���� ������ ��ȸ�ϰ��� �Ѵٸ� ������ ��ųʸ� �� USER_VIEWS�� ��ȸ�ϸ�ȴ�.

SELECT * FROM USER_VIEWS;

--------------------------------------------------------------------------------
/*
    * �� �÷��� ��Ī �ο�
    ���������� SELECT���� �Լ��� ���������� ����Ǿ� �ִ� ��� �ݵ�� ��Ī ����
*/

-- ����� ���, �̸�, ���޸�, ����, �ٹ����

CREATE OR REPLACE VIEW VW_EMP_JOB
AS SELECT EMP_ID, EMP_NAME, JOB_NAME,
          DECODE(SUBSTR(EMP_NO, 8, 1), '1','��','2','��') ����,
          EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) �ٹ����
     FROM EMPLOYEE
     JOIN JOB USING(JOB_CODE);
     -- ��Ī�� ���������ʾƼ� ������ �߻�
     -- 00998 : must name this expression with a column alias

SELECT * FROM VW_EMP_JOB;

CREATE OR REPLACE VIEW VW_EMP_JOB(���, �����, ���޸�, ����, �ٹ����)
AS SELECT EMP_ID, EMP_NAME, JOB_NAME,
          DECODE(SUBSTR(EMP_NO, 8, 1), '1','��','2','��'),
          EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
     FROM EMPLOYEE
     JOIN JOB USING(JOB_CODE);


SELECT �����, �ٹ���� FROM VW_EMP_JOB;

-- �ٹ���� 15���̻��� ����鸸 ����
SELECT * FROM VW_EMP_JOB WHERE �ٹ���� >= 15;

-- �並 �����غ���!!!
DROP VIEW VW_EMP_JOB;

--------------------------------------------------------------------------------
/*
    �並 �̿��ؼ� DML(INSERT, UDPATE, DELETE) ��� ����
    �信�ٰ� ���� => ���� �����Ͱ� ����ִ� ���̽����̺� ������ �ȴ�.
*/

CREATE OR REPLACE VIEW VW_JOB
    AS SELECT * FROM JOB;


SELECT * FROM VW_JOB;
SELECT * FROM JOB;

-- �信 INSERT
INSERT INTO VW_JOB
VALUES('J8', '����');

SELECT * FROM JOB;

-- JOB_CODE�� J8�� JOB_NAME�� �˹ٷ� UPDATE
UPDATE VW_JOB
   SET JOB_NAME = '�˹�'
 WHERE JOB_CODE = 'J8';
 
SELECT * FROM JOB;

DELETE FROM VW_JOB
 WHERE JOB_CODE = 'J8';
 
SELECT * FROM JOB;
--------------------------------------------------------------------------------
/*  
    ������ �並 ������ DML�� �Ұ����� ��찡 �� ����

    1) �信 ���ǵ��� ���� �÷��� �����ϴ� ���
    2) NOT NULL���������� ������ ���
    3) �������� �Ǵ� �Լ��� ���ؼ� ���ǵǾ� �ִ� ���
    4) �׷��Լ� GROUP BY���� ���Ե� ���
    5) DISTINCT ������ ���Ե� ���
    6) JOIN�� �̿��ؼ� ���� ���̺��� ��Ī���ѳ��� ���
*/



---------------------------------------------------------------------------------
/*
    * VIEW �ɼ�
    
    [ �� ǥ���� ]
    CREATE OR REPLACE FORCE/NOFORCE VIEW ���
    AS ��������
    WITH CHECK OPTION
    WITH READ ONLY;
    
    
    1) OR REPLACE : �ش� �䰡 �������� ������ ���� ���� / �����ϸ� ���Ž����ִ� �ɼ�
    2) FORCE / NOFORCE
        - FORCE : ���������� ����� ���̺��� �������� �ʾƵ� �䰡 ����
        - NOFORCE(�⺻��) : ���������� ����� ���̺��� �ݵ�� �����ؾ߸� �䰡 ����
    3) WITH CHECK OPTION : ���������� �������� ����� ���뿡 �����ϴ� �����θ� DML ����
                            ���ǿ� �������� ���� ������ �����ϴ� ��� ������ �߻�
    4) WITH READ ONLY : �信 ���ؼ� ��ȸ�� ����(DML���� �Ұ�)
*/

-- 2) FORCE/ NOFORCE
CREATE OR REPLACE /*NOFORCE*/ VIEW VW_TEST
    AS SELECT FORCE, NOFORCE
         FROM STARWARS;
-- ORA-00942 : table or view does not exist

CREATE OR REPLACE FORCE VIEW VW_TEST
    AS SELECT FORCE, NOFORCE
         FROM STARWARS;
-- ��� : ������ ������ �Բ� �䰡 �����Ǿ����ϴ�.

SELECT * FROM VW_TEST;
-- ���� �߻�

SELECT * FROM USER_VIEWS;

CREATE TABLE STARWARS(
    FORCE NUMBER,
    NOFORCE NUMBER
);

SELECT * FROM VW_TEST;
-- ���̺� ���� �� �ٽ� �ѹ� ��ȸ�ϸ� ������ �߻����� ����

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
 WHERE EMP_NAME = '�����';
UPDATE VW_EMP
   SET SALARY = 2999999
 WHERE EMP_NAME = '�����';
-- ���������� ����� ���ǿ� �������� �ʱ� ������ ���� �Ұ�

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
    ���� 1 ) �����ڵ带 �������� ��� �̻� ���� �̸��� �������� ã��
            ���, �����, ���޸� ��ȸ

    ���� 2 ) ȸ�翡�� OFFICE���α׷��� �ҹ����� ����ϴ� ������ �ΰ��Ǿ���.
            �� ��� ȸ������ �� �����鿡�Ե� å���� �ִٸ� �޿��� 0.1%�� ������ ��ιްڴٰ� �ߴ�.
            �׷��ٸ� EMPLOYEE���̺��� Ȱ���Ͽ� ����� ����� ���� �� ���� �ݾ��� ����ϰԵǴ��� ��ȸ
            
            �� )   ���          �� ��α�
                ���ڻ��    (��ȭǥ��)34,444��
                ���ڻ��    (��ȭǥ��)22,333��
                
    ���� 3 ) EMPLOYEE���̺��� �Ŵ������� �����ϴ� ������� ��ȸ�Ͽ� �� �Ŵ����� �����ϴ� ������� �� �ο����� ���Ͽ�
            �Ŵ�����, ����������� ��ȸ
            �� )   �Ŵ�����   ������� ��
                    ������       1��
                    �����       2��
*/
/*
 ���� 1 ) �����ڵ带 �������� ��� �̻� ���� �̸��� �������� ã��
            ���, �����, ���޸� ��ȸ
*/


SELECT EMP_ID, EMP_NAME, JOB_NAME
  FROM EMPLOYEE
  JOIN JOB USING(JOB_CODE)
 WHERE JOB_CODE > 'J5' AND JOB_CODE <= 'J7';

/*
    ���� 2 ) ȸ�翡�� OFFICE���α׷��� �ҹ����� ����ϴ� ������ �ΰ��Ǿ���.
        �� ��� ȸ������ �� �����鿡�Ե� å���� �ִٸ� �޿��� 0.1%�� ������ ��ιްڴٰ� �ߴ�.
        �׷��ٸ� EMPLOYEE���̺��� Ȱ���Ͽ� ����� ����� ���� �� ���� �ݾ��� ����ϰԵǴ��� ��ȸ
        
        �� )   ���          �� ��α�
            ���ڻ��    (��ȭǥ��)34,444��
            ���ڻ��    (��ȭǥ��)22,333��
*/
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), '1', '���ڻ��', '2', '���ڻ��') ���
      ,TO_CHAR(SUM(SALARY) * 0.001, 'L999,999')||'��' "�� ��α�"
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8, 1);
                
                
/*
    ���� 3 ) EMPLOYEE���̺��� �Ŵ������� �����ϴ� ������� ��ȸ�Ͽ� �� �Ŵ����� �����ϴ� ������� �� �ο����� ���Ͽ�
            �Ŵ�����, ����������� ��ȸ
            
            �� )   �Ŵ�����   ������� ��
                    ������       1��
                    �����       2��
*/

SELECT MANAGER_ID
  FROM EMPLOYEE
 GROUP BY MANAGER_ID;

SELECT �Ŵ���, COUNT(�������)||'��' "������� ��"
FROM (SELECT E2.EMP_NAME �Ŵ���, E1.EMP_NAME �������
        FROM EMPLOYEE E1
        JOIN EMPLOYEE E2 ON(E1.MANAGER_ID = E2.EMP_ID))
GROUP BY �Ŵ���;























