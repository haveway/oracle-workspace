



--           EMP_NO, EMP_NAME, DEPT_CODE, DEPT_TITLE
-- ��ü ������� ���,    �����,   �μ��ڵ�,   �μ������ �� �� ��ȸ�غ��� ~ ?
--          EMPLOYEE                           DEPARTMENT

SELECT EMP_ID, EMP_NAME, DEPT_CODE
  FROM EMPLOYEE;
  
SELECT DEPT_TITLE
  FROM DEPARTMENT;
  
  
-- ��ü ������� ���, �����, �����ڵ�, ���޸��� �˰� ������???

SELECT EMP_ID, EMP_NAME, JOB_CODE
  FROM EMPLOYEE;
  
  
SELECT JOB_CODE, JOB_NAME
  FROM JOB;
  
--> JOIN�� ���ؼ� ������� �ش��ϴ� �÷��� ����� ��Ī��Ű��
--> ��ġ �ϳ��� �����ó�� ��ȸ ����
  

/*
    < JOIN >
    
    �� �� �̻��� ���̺��� �����͸� ���� ��ȸ�ϰ��� �� �� ���Ǵ� ����
    ��ȸ����� �ϳ��� �����(RESULT SET)�� ����
    
    ������ �����ͺ��̽������� �ּ����� �����ͷ� ������ ���̺� �����͸� �����ϰ� ����
    -> ���踦 �ξ���� ����
    
    JOIN������ �̿��ؼ� �������� ���̺� �� "����"�� �ξ ��ȸ�ϴ¹��� �����Ұ��̴�!!!!!

    ������ JOIN�� ����ؼ� ��ȸ�ϴ°��� �ƴ϶� ���̺� �� "�����"�� �ش��ϴ� �÷��� ��Ī ���Ѿ���
    
    JOIN�� ũ�� "����Ŭ ���� ����"��
    "ANSI(�̱� ���� ǥ����ȸ) ����"���� ������.
    
    
    ----------------------------------------------------------------------
               ����Ŭ ���뱸��       |      ANSI(����Ŭ + �ٸ� DBMS)����
    ----------------------------------------------------------------------
        �����                    |  ��������(INNER JOIN)
       (EQUAL JOIN)                |  �ܺ�����(OUTER JOIN)
    ----------------------------------------------------------------------
       ��������                      | ���� �ܺ�����(LEFT OUTER JOIN)
       (LEFT OUTER)                 | ������ �ܺ�����(RIGHT OUTER JOIN)
       (RIGHT OUTER)                | ��ü �ܺ�����)FULL OUTER JOIN) ==> ����Ŭ������ �Ұ�
    ----------------------------------------------------------------------
        ī�׽þȰ�(CARTESIAN PRODUCT) | ��������(CROSSJOIN)
    ----------------------------------------------------------------------
        ��ü����(SELF JOIN)
    
*/
  
  -----------------------------------------------------------
  
  /*
    1. �����(EQUAL JOIN) / ��������(INNER JOIN)
  
    �����Ű�� �÷��� ���� ��ġ�ϴ� ��鸸 ���εǼ� ��ȸ  
    (== ��ġ���� �ʴ� ������ ��ȸ���� ����)
  */
  
  --> ����Ŭ ���뱸��
  -- FROM���� ��ȸ�ϰ����ϴ� ���̺���� ����(,)
  -- WHERE���� ��Ī��ų �÷���(�����)�� ���� ������ ������
  
  -- ��ü ������� ���, �����, �μ��ڵ� �μ����� ���� ��ȸ
  -- 1) ������ �� �÷����� �ٸ� ���
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
  
-- ���, �����, �����ڵ�, ���޸�(EMPLYOEE - JOB_CODE / JOB - JOB_NAME)
-- 2) ������ �� �÷����� �������

SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
  FROM EMPLOYEE, JOB
 WHERE JOB_CODE = JOB_CODE;
-- ����(AMBIGOUOSLY : �ָ��ϴ�, ��ȣ�ϴ�) => � ���̺��� �÷�?

-- ��� 1. ���̺���� �̿��ϴ� ���
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME
  FROM EMPLOYEE, JOB
 WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

-- ��� 2. ���̺��� ��Ī ��� ( �� ���̺��� ��Ī �ο� )
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
  FROM EMPLOYEE E, JOB J
 WHERE E.JOB_CODE = J.JOB_CODE;  
  
  
--> ANSI���� (����Ŭ ���� �ٸ� DBMS������ ��� ����)
-- FROM���� ���� ���̺� �ϳ� ���
-- �� �ڿ� JOIN���� ���� ��ȸ�ϰ����ϴ� ���̺� ���
-- (��Ī��ų �÷��� ���� ���ǵ� ���)
-- USING���� / ON����
  
-- ���, �����, �μ��ڵ�, �μ���
-- 1. ������ �� �÷����� �ٸ� ���
-- EMPLOYEE - DEPT_CODE / DEPARTMENT - DEPT_ID
-- ������ ON������ ��� ����(USING�׾��� ������ ����)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
  FROM EMPLOYEE
  /*INNER*/ JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- ���, �����, �����ڵ�, ���޸�
-- 2. ������ �� �÷����� ���� ���
-- EMPLOYEE - JOB_CODE / JOB - JOB_CODE
-- ON, USING����
-- 2-1. ON ���� �̿� : AMBIGUOUSLY �� �߻��� �� �ֱ� ������ ���!!!
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
  FROM EMPLOYEE E
  JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);
  
-- 2-2. USING ���� �̿� : AMBIGUOUSLY �߻� X
-- �˾Ƽ� ��Ī�Ұ� ~~~
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
  FROM EMPLOYEE
  JOIN JOB USING(JOB_CODE);
  
  
-- ���� �����ε� NATURAL_JOIN(�ڿ�����)
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
  FROM EMPLOYEE
NATURAL JOIN JOB;
-- �����Ե� �ΰ��� ���̺� ��ġ�ϴ� �÷��� �����ϰ� �� �Ѱ� ���� => �˾Ƽ� ��Ī


-- �߰����� ���ǵ� ���� ����
-- ������ �븮�� ������� ���� ��ȸ

-- �븮���� ���, �̸�, �޿�, ���� �̸�

-- > ����Ŭ ���� ����
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
   AND JOB_NAME = '�븮';
-- ���� �� �������� ���̱� ���� ���� �÷��̳� �����̳� �� �������


-- ANSI����
SELECT EMP_ID, EMP_NAME, SALARY, JOB_NAME
  FROM EMPLOYEE
  JOIN JOB USING(JOB_CODE)
 WHERE JOB_NAME = '�븮';
  
  
--------------------------------------------------------------------------------

-- 1. �μ��� '�λ������'�� ������� ���, �����, ���ʽ��� ��ȸ
-- EMPLOYEE, DEPARTMENT
--> ORACLE
SELECT EMP_ID, EMP_NAME, BONUS
  FROM EMPLOYEE, DEPARTMENT
 WHERE DEPT_CODE = DEPT_ID
   AND DEPT_TITLE = '�λ������';
--> ANSI
SELECT EMP_ID, EMP_NAME, BONUS
  FROM EMPLOYEE
  JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
 WHERE DEPT_TITLE = '�λ������';

-- 2. �μ��� '�ѹ���'�� �ƴ� ������� �����, �޿�, �Ի����� ��ȸ
-- EMP_NAME, SALARY, HIRE_DATE

SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;

SELECT EMP_NAME, SALARY, HIRE_DATE
  FROM EMPLOYEE
 WHERE DEPT_CODE != 'D9';
 
SELECT EMP_NAME, SALARY, HIRE_DATE
  FROM EMPLOYEE, DEPARTMENT
 WHERE DEPT_CODE = DEPT_ID;
   AND DEPT_TITLE != '�ѹ���';
   
   
SELECT EMP_NAME, DEPT_CODE
  FROM EMPLOYEE, DEPARTMENT
 WHERE DEPT_CODE = DEPT_ID;
   
SELECT EMP_NAME, SALARY, HIRE_DATE
  FROM EMPLOYEE
  JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
 WHERE DEPT_TITLE != '�ѹ���';


-- 3. ���ʽ��� �޴� ������� ���, �����, ���ʽ�, �μ��� ��ȸ
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

-- 4. DEPARTMENT���̺�, LOCATION���̺��� �����ؼ�
-- �μ��ڵ�, �μ���, �����ڵ�, ������(LOCAL_NAME) ��ȸ

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
  
-- ����� / �������� : ��ġ�����ʴ� ����� ���ʿ� ��ȸ���� ����
--------------------------------------------------------------------------------
/*
    �������� / �ܺ����� (OUTER JOIN)


    ���̺��� JOIN�� ��ġ���� �ʴ� �൵ ���Խ��Ѽ� ��ȸ ����
    ��, �ݵ�� LEFT / RIGHT�� �����ؾ� ��(������ �Ǵ� ���̺��� ����)
*/

-- "��ü" ������� �����, �޿�, �μ��� ��ȸ
-- DEPT_CODE�� NULL�� �θ��� ��� ��ȸ X EMPLOYEE
-- �μ��� ������ ����� ���� �μ� (D3, D4, D7) ��ȸ X DEPARTMENT
SELECT * FROM EMPLOYEE;

SELECT EMP_NAME, SALARY, DEPT_TITLE
  FROM EMPLOYEE
  JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- 1) LEFT [OUTER] JOIN : 
-- �� ���̺� �� ���� ����� ���̺��� �������� JOIN
-- ��, ���� �Ǿ��� ���� ���� ����� ���̺��� �����ʹ� ������ ��ȸ(null)
-- (��ġ�ϴ°� ��� ��ȸ�� �ϰڴ�)

-- ANSI ����
SELECT EMP_NAME, SALARY, DEPT_TITLE
  FROM EMPLOYEE 
  LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
-- EMPLYOEE���̺��� �������� ��ȸ�߱� ������
-- EMPLOYEE�� �����ϴ� �����Ͱ� �����Ǿ��� ���� ������ ��ȸ�ǰԲ� �Ѵ�.

-- ORACLE
SELECT EMP_NAME, SALARY, DEPT_TITLE
  FROM EMPLOYEE, DEPARTMENT
 WHERE DEPT_CODE = DEPT_ID(+);
-- ���� �������� ���� ���̺��� �÷��� �ݴ��ʿ� '(+)'�� �ٿ��ش�.

-- 2) RIGHT [OUTER] JOIN
-- �� ���̺��� ������ ����� ���̺��� �������� JOIN

--> ANSI
SELECT EMP_NAME, SALARY, DEPT_TITLE
  FROM EMPLOYEE 
  RIGHT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

--> ORACLE
SELECT EMP_NAME, SALARY, DEPT_TITLE
  FROM EMPLOYEE, DEPARTMENT
 WHERE DEPT_CODE(+) = DEPT_ID;


-- 3) FULL [ OUTER ] JOIN : �� ���̺��� ���� ��� ���� ��ȸ
--> ANSI
SELECT EMP_NAME, SALARY, DEPT_TITLE
  FROM EMPLOYEE
  FULL OUTER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

--> ORALCE (������ : only one out-joined table)
SELECT EMP_NAME, SALARY, DEPT_TITLE
  FROM EMPLOYEE, DEPARTMENT
 WHERE DEPT_CODE(+) = DEPT_ID(+);

------------------------------------------------------------------------------

/*
    3. ī�׽þ� ��(CARTESIAN PRODUCT) / �������� (CROSS JOIN)
    ��� ���̺��� �� ����� ���μ��� ���ε� �����Ͱ� ��ȸ��(������)
    
    �� ���̺��� ����� ��� ������ ���� ���
    => ����� ������ ���
    => �������� ����
    
*/

-- �����, �μ���
-- ORACLE
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT;

-- ANSI
SELECT EMP_NAME, DEPT_TITLE
  FROM EMPLOYEE
  CROSS JOIN DEPARTMENT;


--------------------------------------------------------------------------------

/*
    4. �� ����(NON EQUAL JOIN)
    '='�� ������� �ʴ� ���ι�
    
    �������ִ� �÷����� ��ġ�ϴ� ��� ���ƴ�
    "����"�� ���ԵǴ� ��� ��Ī
*/

-- �����, �޿�

SELECT EMP_NAME, SALARY
  FROM EMPLOYEE;

SELECT * FROM SAL_GRADE;
SELECT * FROM EMPLOYEE;

-- �����, �޿�, �޿����(SAL_LEVEL)
SELECT EMP_NAME, SALARY, S.SAL_LEVEL
  FROM EMPLOYEE E, SAL_GRADE S
  /*
 WHERE SALARY >= MIN_SAL 
   AND SALARY <= MAX_SAL;
   */
 WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;


-------------------------------------------------------------------------

/*
    5. ��ü���� (SELF JOIN)
    ���� ���̺��� �ٽ� �ѹ� �����ϴ� ���
    �ڱ� �ڽ��� ���̺�� ������ �δ´�.
*/

SELECT
        EMP_ID "��� ���",
        EMP_NAME "�����",
        SALARY "��� �޿�",
        MANAGER_ID "������"
  FROM 
        EMPLOYEE;

SELECT * FROM EMPLOYEE; -- ����� ���� ���� ����� ���̺�
--> MANAGER_ID
SELECT * FROM EMPLOYEE; -- ����� ���� ���� ����� ���̺�
--> EMP_ID

-- ������, �����, ����μ��ڵ�, ����޿�
-- ������, �����, ����μ��ڵ�, ����޿�

-- ORACLE

SELECT E.EMP_ID "��� ���", E.EMP_NAME "�����",
       E.DEPT_CODE "��� �μ��ڵ�", E.SALARY "����޿�",
       M.EMP_ID "��� ���", M.EMP_NAME "�����",
       M.DEPT_CODE "��� �μ��ڵ�", M.SALARY "����޿�"
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID(+);


--------------------------------------------------------------------------------

/*
    <���� JOIN>
*/

-- ���, �����, �μ���, ���޸�
SELECT * FROM EMPLOYEE;     -- DEPT_CODE      JOB_CODE
SELECT * FROM DEPARTMENT;   -- DEPT_ID
SELECT * FROM JOB;                          --JOB_CODE

-- ORACLE
SELECT EMP_ID ���, EMP_NAME �����, DEPT_TITLE �μ���, JOB_NAME ���޸�
  FROM EMPLOYEE E, DEPARTMENT, JOB J
 WHERE DEPT_CODE = DEPT_ID(+)
   AND E.JOB_CODE = J.JOB_CODE;

-- ANSI
SELECT EMP_ID ���, EMP_NAME �����, DEPT_TITLE �μ���, JOB_NAME ���޸�
  FROM EMPLOYEE
  LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
  JOIN JOB USING(JOB_CODE);





-- ���, �����, �μ���, ���޸�, ������(LOCAL_NAME)
SELECT * FROM EMPLOYEE;   -- DEPT_CODE    JOB_CODE
SELECT * FROM DEPARTMENT; -- DEPT_ID                   LOCATION_ID
SELECT * FROM JOB;        --              JOB_CODE
SELECT * FROM LOCATION;   --                           LOCAL_CODE

-- ����Ŭ

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, LOCAL_NAME
  FROM EMPLOYEE E, DEPARTMENT D, JOB J, LOCATION L
 WHERE DEPT_CODE = DEPT_ID(+)
   AND E.JOB_CODE = J.JOB_CODE
   AND LOCATION_ID = LOCAL_CODE(+);


-----------------------------------------------------------------------------

-- 1. ������ �븮�̸鼭 ASIA ������ �ٹ��ϴ� ��������
-- ���, �����, ���޸�, �μ���, �ٹ�������, �޿��� ��ȸ

-- ANSI����
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME, SALARY
  FROM EMPLOYEE
  JOIN JOB USING(JOB_CODE)
  JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
  JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
  WHERE JOB_NAME = '�븮'
    AND LOCAL_NAME LIKE 'ASIA%';
-- 2. �̸��� '��'�ڰ� ����ִ� ��������
-- ���, �����, ���޸��� ��ȸ�Ͻÿ�

-- ORACLE
SELECT EMP_NO, EMP_NAME, JOB_NAME
  FROM EMPLOYEE E, JOB J
 WHERE E.JOB_CODE = J.JOB_CODE
   AND EMP_NAME LIKE '%��%';

-- 3. 70�����̸鼭, �����̰�, ���� ������ ��������
-- �����, �ֹι�ȣ, �μ���, ���޸��� ��ȸ�Ͻÿ�.

SELECT EMP_NAME, EMP_NO, DEPT_TITLE, JOB_NAME
  FROM EMPLOYEE E, DEPARTMENT, JOB J
 WHERE E.JOB_CODE = J.JOB_CODE
   AND DEPT_CODE = DEPT_ID
   AND EMP_NAME LIKE '��%'
   AND SUBSTR(EMP_NO, 8, 1) = 2
   AND SUBSTR(EMP_NO, 1, 1) = 7;







