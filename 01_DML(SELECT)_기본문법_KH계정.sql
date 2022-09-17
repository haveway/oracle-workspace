/*
    <SELECT>
    �����͸� ��ȸ�ϰų� �˻��� �� ���Ǵ� ��ɾ�

    [ ǥ���� ]
    SELECT ��ȸ�ϰ����ϴ� �÷�, �÷�, �÷�......
    FROM ���̺��;
    
    - ResultSet : SELECT ������ ���� ��ȸ�� �������� �����, ��ȸ�� ����� ����
    
    -- EMPLOYEE ���̺��� ��ü ������� ��� �÷��� �� ��ȸ
    SELECT * FROM EMPLOYEE;
    
    -- EMPLOYEE ���̺��� ��ü ������� ���, �̸�, �޿� �÷��鸸 ��ȸ
    SELECT EMP_ID, EMP_NAME, SALARY
    FROM EMPLYOEE;
*/

SELECT * FROM EMPLOYEE;
SELECT EMP_ID, EMP_NAME, SALARY FROM EMPLOYEE;

---------  �ǽ����� ----------
-- 1. JOB ���̺��� ��� �÷���ȸ
SELECT * FROM JOB;
-- 2. JOB ���̺��� ���޸� �÷��� ��ȸ
SELECT JOB_NAME FROM JOB;
-- 3. DEPARTMENT ���̺��� ��� �÷���ȸ
SELECT * FROM DEPARTMENT;
-- 4. EMPLOYEE ���̺��� ������, �̸���, ��ȭ��ȣ, �Ի��� �÷��� ��ȸ
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE FROM EMPLOYEE;
-- 5. EMPLOYEE ���̺��� �Ի���, ������, �޿��÷��� ��ȸ
SELECT HIRE_DATE, EMP_NAME, SALARY FROM EMPLOYEE;
-----------------------------------------------------




---------------------------------------------------------

/*
    < �÷����� ���� ��� ���� >
    ��ȸ�ϰ��� �ϴ� �÷����� �����ϴ� SELECT����
    �������(+, -, *, /)�� ����ؼ� ����� ��ȸ�� �� �ִ�.
*/

-- EMPLOYEE ���̺�κ��� ������, ����, ����(= ���� * 12)
SELECT EMP_NAME, SALARY, SALARY * 12
FROM EMPLOYEE;

-- EMPLOYEE ���̺�κ��� ������, ����, ���ʽ�, ���ʽ��� ���Ե� ����
-- ((���� + ���ʽ� * ����)) * 12)
SELECT EMP_NAME, SALARY, BONUS, ((SALARY + BONUS * SALARY) * 12)
FROM EMPLOYEE;
-- ��������ϴ� ������ NULL ���� ������ ��� ������� ��������� NULL�� �ȴ�.

-- DATEŸ�Գ����� ���� ����(DATE = > ��, ��, ��, ��, ��, ��)
-- EMPLOYEE ���̺�κ��� ������, �Ի���, �ٹ��ϼ�(���ó�¥ - �Ի���) ��ȸ
-- ���ó�¥ : SYSDATE
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE
FROM EMPLOYEE;
-- ������� �� �� ������ ���
-- ���� �������� ������ DATEŸ�� �ȿ� ���ԵǾ��ִ� ��/ ��/ �ʿ� ������ ����Ǳ� ������

-------------------------------------------------------------------------

/*
    < �÷��� ��Ī �����ϱ�>
    [ ǥ���� ]
    �÷��� AS ��Ī, �÷��� AS "��Ī", �÷��� "��Ī", �÷��� ��Ī

    AS�� ���̵� �Ⱥ��̵� ��� X
    ��Ī�� Ư������, ������� ���Եɰ�� �ݵ�� "" ��� ǥ���ؾ� ��
*/

SELECT EMP_NAME �̸�, SALARY "�޿�(��)", BONUS ���ʽ�
FROM EMPLOYEE;


-----------------------------------------------------------------

/*
    < ���ͷ� >
    ���Ƿ� ������ ���ڿ� ('')�� SELECT ���� ����ϸ�
    ���� �� ���̺� �����ϴ� ������ó�� ��ȸ�� �����ϴ�.
*/

SELECT EMP_ID, EMP_NAME, SALARY, '��'����
FROM EMPLOYEE;

------------------------------------------------------------------

/*
    <DISTINCT>
    ��ȸ�ϰ����ϴ� �÷��� �ߺ��� ���� �� �ѹ����� ��ȸ�� ��
    �ش� �÷��� �տ� ���
    
    [ ǥ���� ]
    DISTINCT �÷���

    SELECT���� DISTINCT ������ �� �Ѱ��� �����ϴ�!!!
*/
SELECT DISTINCT DEPT_CODE FROM EMPLOYEE;

SELECT JOB_CODE FROM JOB;
-------------------------------------------------------------
/*
    < WHERE �� >
    ��ȸ�ϰ��� �ϴ� ���̺� Ư�� ������ ����
    �� ���ǿ� �����ϴ� �����͸��� ��ȸ�ϰ��� �� �� ����ϴ� ����

    [ ǥ���� ]
    SELECT ��ȸ�ϰ��� �ϴ� �÷�, �÷�, ......
    FROM ���̺��
    WHERE ���ǽ�;
    
    
    - ���ǽĿ� �پ��� ������ ��� ����
    
    < �� ������ >
    >, <, >=, <=
    = (��ġ�ϴ°�? : �ڹٿ����� ==)
    !=, ^=, <> (��ġ���� �ʴ°�?)

*/

-- EMPLOYEE ���̺�κ��� �޿��� 400���� �վ��� ����鸸 ��ȸ(����÷�)
SELECT *
  FROM EMPLOYEE
 WHERE SALARY >= 4000000;

------------�ǽ�����---------------------
-- EMPLOYEE ���̺�κ��� �μ��ڵ尡 D9�� ������� �����, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D9';
-- EMPLOYEE ���̺�κ��� �μ��ڵ尡 D9�� �ƴ� ������� �����, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
  FROM EMPLOYEE
 WHERE DEPT_CODE != 'D9';
-- EMPLOYEE ���̺��� �޿��� 300���� �̻��� ������� �̸�, �޿�, �Ի��� ��ȸ
SELECT EMP_NAME, SALARY, HIRE_DATE
  FROM EMPLOYEE
 WHERE SALARY >= 3000000;
-- EMPLOYEE ���̺�κ��� �����ڵ尡 J2�� ������� �̸�, �޿�, ���ʽ� ��ȸ
SELECT EMP_NAME, SALARY, BONUS
  FROM EMPLOYEE
 WHERE JOB_CODE = 'J2';
-- EMPLOYEE ���̺�κ��� ����(�޿� * 12)�� 5000���� �̻��� ������� �̸�, �޿�, ����, �Ի��� ��ȸ
SELECT EMP_NAME, SALARY, SALARY * 12 AS ����, HIRE_DATE
  FROM EMPLOYEE
 WHERE SALARY * 12 >= 50000000;

------------------------------------------------------------------------------------------

/*
    < �� ������ >
    ���� ���� ������ ���� �� ���

    AND(�׸���, ~ �̸鼭), OR(�Ǵ�, ~ �̰ų�)
*/

-- �μ��ڵ尡 'D9'�̸鼭 �޿��� 500���� �̻��� ������� �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
  FROM EMPLOYEE 
 WHERE DEPT_CODE = 'D9' AND SALARY >= 5000000;


-- �μ��ڵ尡 'D6'�̰ų� �޿��� 300���� �̻��� ������� �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D6' OR SALARY >= 3000000;

-- �޿��� 350���� �̻��̰� 600���� ������ ������� �̸�, ���, �޿�, �����ڵ� ��ȸ
SELECT EMP_NAME, EMP_ID, SALARY, JOB_CODE
  FROM EMPLOYEE
 WHERE 3500000 <= SALARY AND SALARY <= 6000000;

-------------------------------------------------------------------------------

/*
    < BETWEEN AND >
    �� �̻� �� ������ ������ ���� ������ ������ �� ���
    
    [ ǥ���� ]
    �񱳴�� �÷��� BETWEEN ���Ѱ� AND ���Ѱ�;

*/

-- �޿��� 350���� �̻��̰� 600���� ������ ������� �̸�, ���, �޿�, �����ڵ� ��ȸ
SELECT EMP_NAME, EMP_ID, SALARY, JOB_CODE
  FROM EMPLOYEE
 WHERE SALARY BETWEEN 3500000 AND 6000000;

-- �޿��� 350���� �̸��̰� 600���� �ʰ��� ������� �̸�, ���, �޿� �����ڵ� ��ȸ
SELECT EMP_NAME, EMP_ID, SALARY, JOB_CODE
  FROM EMPLOYEE
 WHERE SALARY NOT BETWEEN 3500000 AND 6000000;
-- >  ����Ŭ������ NOT�� �ڹ��� ������������ !�� ������ �ǹ�

-- BETWEEN AND ������ DATE���İ����� ��밡��

-- �Ի����� 90/01/01 ~ 03/01/01�� ������� ��� �÷� ��ȸ
SELECT *
FROM EMPLOYEE
--WHERE HIRE_DATE >= '90/01/01' AND HIRE_DATE <= '03/01/01';
WHERE HIRE_DATE BETWEEN '90/01/01' AND '03/01/01';

-- �Ի����� 90/01/01 ~ 03/01/01�� �ƴ� ������� ��� �÷� ��ȸ
SELECT *
FROM EMPLOYEE
--WHERE HIRE_DATE >= '90/01/01' AND HIRE_DATE <= '03/01/01';
WHERE NOT HIRE_DATE BETWEEN '90/01/01' AND '03/01/01';

------------------------------------------------------------------------------

/*
    < LIKE 'Ư������' >
    ���Ϸ��� �÷����� ���� ������ Ư�� ���Ͽ� ������ ��� ��ȸ
    
    [ ǥ���� ]
    �񱳴�� �÷��� LIKE 'Ư�� ����'

    - Ư�� ���Ͽ� ���ϵ�ī���� '%','_'�� ������ ������ �� ����
    '%' : 0���� �̻�
    �񱳴���÷��� LIKE '����%' => �÷��� �߿� '����'�� ���۵Ǵ� ��
    �񱳴���÷��� LIKE '%����' => �÷��� �߿� '����'�� ������ ���� ��ȸ
    �񱳴���÷��� LIKE '%����%' => �÷��� �߿� '����'�� ���ԵǴ� ���� ��ȸ
    '_' : 1����
    �񱳴���÷��� LIKE '_����' => �ش� �÷��� �߿� '����'�տ� ������ 1���ڰ� ���� ��� ��ȸ
    �񱳴���÷��� LIKE '__����' => �ش� �÷��� �߿� '����'�տ� ������ 2���ڰ� ���� ��� ��ȸ
*/

-- ���� ������ ������� �̸�, �޿�, �Ի��� ��ȸ
SELECT EMP_NAME, SALARY, HIRE_DATE
  FROM EMPLOYEE
 WHERE EMP_NAME LIKE '��%';

-- �̸� �߿� '��'�� ���Ե� ������� �̸�, �ֹι�ȣ, �μ��ڵ� ��ȸ
SELECT EMP_NAME, EMP_NO, DEPT_CODE
  FROM EMPLOYEE
 WHERE EMP_NAME LIKE '%��%';
 
 
-- ��ȭ��ȣ 4��° �ڸ��� 9�� �����ϴ� ������� ���, �����, ��ȭ��ȣ, �̸��� ��ȸ
SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
  FROM EMPLOYEE
 WHERE PHONE LIKE '___9%'; 
 
 
 -- �̸� ��� ���ڰ� '��'�� ������� ��� �÷�
SELECT * 
  FROM EMPLOYEE 
 WHERE EMP_NAME LIKE '_��_';

-- �� ���� ���
SELECT *
  FROM EMPLOYEE
 WHERE EMP_NAME NOT LIKE '_��_';
 
 --------------�ǽ�����------------------
 
 -- 1. �̸��� '��'���� ������ ������� �̸�, �Ի��� ��ȸ
 SELECT EMP_NAME, HIRE_DATE
   FROM EMPLOYEE
  WHERE EMP_NAME LIKE '%��';
 
 -- 2. ��ȭ��ȣ ó�� 3���ڰ� 010�� �ƴ� ������� �̸�, ��ȭ��ȣ ��ȸ
 SELECT EMP_NAME, PHONE
   FROM EMPLOYEE
  WHERE NOT PHONE LIKE '010%';
 
 -- 3. DEPARTMENT ���̺��� �ؿܿ����� ���õ� �μ����� ��� �÷� ��ȸ
SELECT *
  FROM DEPARTMENT 
 WHERE DEPT_TITLE LIKE '�ؿܿ���%';

------------------------------------
/*

    < IS NULL >

    [ ǥ���� ]
    �񱳴���÷� IS NULL : �÷����� NULL�� ���
    �񱳴���÷� IS NOT NULL : �÷����� NULL�� �ƴ� ���

*/
SELECT * FROM EMPLOYEE;

-- ���ʽ��� ���� �ʴ� �����(BONUS �÷��� ���� NULL)�� ���, �̸�, �޿�, ���ʽ�
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
  FROM EMPLOYEE
 WHERE BONUS IS NULL;
 
-- ���ʽ��� ���� �����
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
  FROM EMPLOYEE
 WHERE BONUS IS NOT NULL;
 
-- ����� ���� ������� �����, ������, �μ��ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, MANAGER_ID, DEPT_CODE
  FROM EMPLOYEE
 WHERE MANAGER_ID IS NULL;

-- ����� ���� �μ���ġ�� ���� ���� ������� ��� �÷� ��ȸ
SELECT *
  FROM EMPLOYEE
 WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;
 
-- �μ���ġ�� ���� �ʾ����� ���ʽ��� �޴� ����� �����, ���ʽ�, �μ��ڵ� ��ȸ
SELECT EMP_NAME, BONUS, DEPT_CODE
  FROM EMPLOYEE
 WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;



-----------------------------------------------------------------------------
/*
    < IN >
    �񱳴���÷� ���� ���� ������ ��ϵ� �߿� ��ġ�ϴ� ���� �ִ��� ~ ?

    [ ǥ���� ]
    �񱳴���÷� IN (��, ��, ��,.....)
*/

-- �μ��ڵ尡 D6�̰ų� �Ǵ� D8�̰ų� �Ǵ� D5�� ������� �̸�, �μ��ڵ� �޿�
SELECT EMP_NAME, DEPT_CODE, SALARY
  FROM EMPLOYEE
--WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D5';
 WHERE DEPT_CODE IN('D6', 'D8', 'D5');

-- �׿��� �����
SELECT EMP_NAME, DEPT_CODE, SALARY
  FROM EMPLOYEE
 WHERE DEPT_CODE NOT IN('D6', 'D8', 'D5');

---------------------------------------------------------------------------

/*
    <���Ῥ���� || >
    ���� �÷������� ��ġ �ϳ��� �÷��ΰ�ó�� ��������ִ� ������
    �÷��� ���ͷ�(�����ǹ��ڿ�)�� ������ �� �ִ�.
    
    System.out.println("num : " + num);
*/

SELECT EMP_ID || EMP_NAME || SALARY "�����"
FROM EMPLOYEE;


-----------------------------------------------------------------------------
/*
    < ������ �켱���� >
    0. ()
    1. ���������
    2. ���Ῥ����
    3. �񱳿�����
    4. IS NULL, LIKE, IN
    5. BETWEEN AND
    6. NOT
    7. AND
    8. OR
*/
-----------------------------------------------------------------------------
--SELECT * FROM EMPLOYEE;

/*  
    < ORDER BY �� >
    SELECT�� ���� �������� �����ϴ� ����
    ������� ���� ���� ������!!!
    
    [ ǥ���� ]
    SELECT ��ȸ�� �÷�, �÷� AS "����", �÷�..
      FROM ��ȸ�� ���̺� �̸�
     WHERE ���ǽ�(����)
     ORDER 
        BY [�������÷�/��Ī/�÷�����] [ASC/DESC]
        [NULLS FIRST / NULLS LAST](��������)

    - ASC : �������� ����(���� �� �⺻��)
    - DESC : �������� ����
    
    NULLS FIRST : NULL�� ���ԵǾ� ���� ��� ������ ��ġ
    (�������� �� �⺻��)
    NULLS LAST : NULL�� ���ԵǾ� ���� ��� �ڷ� ��ġ
    (�������� �� �⺻��)
*/

SELECT *
  FROM EMPLOYEE
--ORDER BY BONUS; -- ASC �Ǵ� DESC ���� �� �⺻���� ASC(��������)
-- ASC�� �⺻������ NULLS LAST���� �� �� �ִ�.
--ORDER BY BONUS ASC NULLS FIRST;
-- ORDER BY BONUS DESC;
-- DESC�� �⺻������ NULLS FIRST���� �� �� �ִ�.
ORDER BY BONUS DESC, SALARY ASC;














