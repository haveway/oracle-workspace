-- ���ö ����� ���� �μ��� �����
-- 1) ���� ���ö����� �μ��ڵ� ��ȸ
SELECT DEPT_CODE
  FROM EMPLOYEE
  WHERE EMP_NAME = '���ö';
  
-- 2) �μ��ڵ尡 D9�� ����� ��ȸ
SELECT EMP_NAME
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D9';
 
-- ���� �� �ܰ踦 �ϳ��� ���������� ��ġ��
SELECT EMP_NAME
  FROM EMPLOYEE
 WHERE DEPT_CODE = (SELECT DEPT_CODE
                      FROM EMPLOYEE
                     WHERE EMP_NAME = '���ö');

/*
    < SUBQUERY (��������) >

    �ϳ��� �ֵ� SQL��(SELECT, INSERT, UPDATE, DELETE, CREATE...)
    �ȿ� ���Ե� �� �ϳ��� SELECT��
    ���� SQL���� �������ִ� ������
*/

-- ���� �������� ����
-- ��ü ����� ��ձ޿����� �� ���� �޿��� �ް� �ִ� ������� ���, �̸�, �����ڵ� ��ȸ
-- 1) ��ü ����� ��� �޿� ���ϱ�
SELECT ROUND(AVG(SALARY))
  FROM EMPLOYEE; -- �뷫 3,047,663��
-- 2) �޿��� 3,047,663�� �̻��� ����� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE
  FROM EMPLOYEE
 WHERE SALARY > 3047663;

-- ��ġ��
SELECT EMP_ID, EMP_NAME, JOB_CODE
  FROM EMPLOYEE
 WHERE SALARY > (SELECT ROUND(AVG(SALARY))
                   FROM EMPLOYEE);


--------------------------------------------------------------------------------
/*
    �������� ����
    ���������� ������ ������� �� �� �� ���̳Ŀ� ���� �з�

    - ������ �������� : ���������� ������ ������� ������ 1�� �� ��
    - ������ �������� : ���������� ������ ������� ���� ���� ��
    - ���߿� �������� : ���������� ������ ������� ���� ���� ��
    - ������ ���߿� �������� : ���������� ������ ������� ���� �� ���� �� �� ��
    
    => ���������� ������ ����� �� �� �� ���̳Ŀ� ���� ��밡���� �����ڵ� �޶���
*/

/*
    1. ������ �������� (SINGLE ROW SUBQUERY)
    ���������� ��ȸ ������� ������ 1�� �� ��

    �Ϲ� ������ ��밡��(=, !=, >=, <)
*/

-- �� ������ ��� �޿����� �� ���� �޴� ������� �����, �����ڵ�, �޿� ��ȸ
SELECT EMP_NAME, JOB_CODE, SALARY
  FROM EMPLOYEE
 WHERE SALARY < (SELECT AVG(SALARY)  -- ����� 1�� 1��, �� 1���ִ� ��
                   FROM EMPLOYEE);
                   
-- �����޿��� �޴� ����� ���, �����, �����ڵ�, �޿�, �Ի��� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, HIRE_DATE
  FROM EMPLOYEE
 WHERE SALARY = (SELECT MIN(SALARY)
                   FROM EMPLOYEE);


-- ���ö ����� �޿����� �� ���� �޴� ������� ���, �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY
                  FROM EMPLOYEE
                 WHERE EMP_NAME = '���ö');


-- ���ö ����� �޿����� �� ���� �޴� ������� ���, �̸�, �μ���, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE, DEPARTMENT
WHERE SALARY > (SELECT SALARY
                  FROM EMPLOYEE
                 WHERE EMP_NAME = '���ö')
  AND DEPT_CODE = DEPT_ID; -- JOIN�� �����ϴ�!

-- �������� ���� �μ��� ������� ���, �����, ��ȭ��ȣ, ���޸� ��ȸ(��, �������� ����)
-- ORACLE
SELECT EMP_ID, EMP_NAME, PHONE, JOB_NAME
  FROM EMPLOYEE E, JOB J
 WHERE E.JOB_CODE = J.JOB_CODE
   AND DEPT_CODE = (SELECT DEPT_CODE
                      FROM EMPLOYEE
                     WHERE EMP_NAME = '������')
   AND EMP_NAME != '������';
-- ANSI
SELECT EMP_ID, EMP_NAME, PHONE, JOB_NAME
  FROM EMPLOYEE
  JOIN JOB USING(JOB_CODE)
 WHERE DEPT_CODE = (SELECT DEPT_CODE
                      FROM EMPLOYEE
                     WHERE EMP_NAME = '������')
  AND EMP_NAME != '������';

--------------------------------------------------------------------------------
-- �μ��� �޿� ���� ���� ū �μ� �ϳ����� ��ȸ �μ��ڵ�, �μ���, �޿��� ��ȸ
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
    2. ������ �������� (MULTI ROW SUBQUERY)
    ���������� ��ȸ ������� �������� ��

    - IN : �������� ����� �߿��� �Ѱ��� ��ġ�ϴ� ���� ������
    - NOT IN : �ƿ� ������
    
    - > ANY : �������� ��� �� �߿��� "�ϳ���" Ŭ ���
    - < ANY : �������� �ᰳ �� �߿��� "�ϳ���" ���� ���
    
*/

-- ��� < �븮 < ���� < ���� < ����
-- �븮 �����ӿ��� �ұ��ϰ� ���� ������ �޿����� ���� �޴� ���� ��ȸ(���, �̸�, ���޸�, �޿�)

-- 1) ���� ������ �޿��� ��ȸ
SELECT SALARY
  FROM EMPLOYEE E, JOB J
 WHERE E.JOB_CODE = J.JOB_CODE
   AND JOB_NAME = '����'; -- 2200000, 2500000, 3760000
   
-- 2) ���� �޿����� ���� �޿��� �޴� ������ ��ȸ(���, �̸�, ���޸�, �޿�)
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
  FROM EMPLOYEE E, JOB J
 WHERE E.JOB_CODE = J.JOB_CODE
   AND SALARY > ANY(2200000, 2500000, 3760000);

-- 3) ��ġ��
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
  FROM EMPLOYEE E, JOB J
 WHERE E.JOB_CODE = J.JOB_CODE
   AND SALARY > ANY(SELECT SALARY
                      FROM EMPLOYEE E, JOB J
                     WHERE E.JOB_CODE = J.JOB_CODE
                       AND JOB_NAME = '����')
   AND JOB_NAME = '�븮';


-- �� �μ��� �ְ�޿��� �޴� ����� �̸�, �����ڵ�, �޿� ��ȸ
-- 1) �� �μ��� �ְ�޿�
SELECT MAX(SALARY)
  FROM EMPLOYEE
 GROUP BY DEPT_CODE; -- 2890000, 3660000, 8000000, 3760000, 3900000, 2490000, 2550000

-- 2) ���� �޿��� �޴� ����� ��ȸ(����� �̸�, �����ڵ�, �޿�)
SELECT EMP_NAME, JOB_CODE, SALARY
  FROM EMPLOYEE
 WHERE SALARY IN (2890000, 3660000, 8000000, 3760000, 3900000, 2490000, 2550000);

-- ��ġ��
SELECT EMP_NAME, JOB_CODE, SALARY
  FROM EMPLOYEE
 WHERE SALARY IN (SELECT MAX(SALARY)
                    FROM EMPLOYEE
                   GROUP BY DEPT_CODE);


-- ������ �Ǵ� ����� ����� ���� �μ��� ������� ��ȸ(�����, �μ��ڵ�, �޿�)
SELECT EMP_NAME, DEPT_CODE, SALARY
  FROM EMPLOYEE
 WHERE DEPT_CODE IN (SELECT DEPT_CODE
                       FROM EMPLOYEE
                      WHERE EMP_NAME IN('�����', '������'));

-- ��� < �븮 < ���� < ���� < ����
-- ���� �����ӿ��� �ұ��ϰ� ��� ���� ������ �޿����� ���� �޴� ���� ��ȸ(���, �̸�, ���޸�, �޿�)
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
  FROM EMPLOYEE
  JOIN JOB USING(JOB_CODE)
 WHERE SALARY > ALL(SELECT SALARY
                      FROM EMPLOYEE
                      JOIN JOB USING(JOB_CODE)
                     WHERE JOB_NAME = '����')
                -- 2800000, 1550000, 2490000, 2480000
                /*
                   EX ) 2000000
                   
                    > ANY : True
                    > ALL : False
                */
AND JOB_NAME = '����';

--------------------------------------------------------------------------------
/*
    3. ���߿� ��������
    ��ȸ ��� ���� �� �������� ������ �÷����� ���� ���� ��
*/

-- ������ ����� ���� �μ��ڵ� AND �����ڵ忡 �ش��ϴ� ����� ��ȸ
SELECT DEPT_CODE, JOB_CODE
  FROM EMPLOYEE
 WHERE EMP_NAME = '������'; -- D5 / J5

-- > �μ��ڵ尡 D5�̸鼭 �����ڵ尡 J5�� ��� ��ȸ
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D5'
   AND JOB_CODE = 'J5';

-- ��ġ��
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
  FROM EMPLOYEE
 WHERE DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '������')
   AND JOB_CODE = (SELECT JOB_CODE FROM EMPLOYEE WHERE EMP_NAME = '������');


--> ���߿� ��������
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
  FROM EMPLOYEE
 WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE
                                  FROM EMPLOYEE
                                 WHERE EMP_NAME = '������');

-- �ڳ��� ����� ���� �����ڵ�, ���� �������� ���� �������
-- ���, �̸�, �����ڵ�, ������ ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE (JOB_CODE, MANAGER_ID) = (SELECT JOB_CODE, MANAGER_ID
                                  FROM EMPLOYEE
                                 WHERE EMP_NAME = '�ڳ���');
--------------------------------------------------------------------------------
/*
    4. ������ ���߿� ��������
    �������� ��ȸ ������� ���� �� ���� �÷��� ���
*/

-- �� ���޺� �ּұ޿��� �޴� ����� ��ȸ(���, �̸�, �����ڵ�, �޿�)
-- 1) �� ���޺� �ּ� �޿� ��ȸ
SELECT JOB_CODE, MIN(SALARY)
  FROM EMPLOYEE
 GROUP BY JOB_CODE;

-- 2) ���� ��ϵ� �߿� ��ġ�ϴ� ��� // ���, �̸�, �����ڵ�, �޿�


-- �̸�
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
                                
-- ��ġ��

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
  FROM EMPLOYEE
 WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, MIN(SALARY)
                                FROM EMPLOYEE
                               GROUP BY JOB_CODE);
                               
                               
-- �� �μ��� �ְ�޿��� �޴� ����� ��ȸ(���, �̸�, �μ��ڵ�, �޿�) ���ı���(��������)
SELECT EMP_ID, EMP_NAME, NVL(DEPT_CODE, '�μ�����'), SALARY
  FROM EMPLOYEE
 WHERE (NVL(DEPT_CODE, '�μ�����'), SALARY) IN (SELECT NVL(DEPT_CODE, '�μ�����'), MAX(SALARY)
                                                FROM EMPLOYEE
                                               GROUP BY DEPT_CODE)
 ORDER BY EMP_ID;

--------------------------------------------------------------------------------
-- ���ʽ� ���� ������ 3000���� �̻��� ������� ���, �̸�, ���ʽ����Կ���, �μ��ڵ带 ��ȸ

SELECT EMP_ID, EMP_NAME, (SALARY + (SALARY * NVL(BONUS, 0))) * 12 "���ʽ� ����",DEPT_CODE
  FROM EMPLOYEE;
 WHERE (SALARY + (SALARY * NVL(BONUS, 0))) * 12 >= 30000000;


-- �ζ��� �並 ����غ���!

SELECT "���ʽ� ����"
  FROM (SELECT EMP_ID, EMP_NAME, (SALARY + (SALARY * NVL(BONUS, 0))) * 12 "���ʽ� ����",DEPT_CODE
          FROM EMPLOYEE)
 WHERE "���ʽ� ����" >= 30000000;

/*
    5. �ζ��� ��(INLINE-VIEW)
    FROM���� ���������� ����!!

    ���������� ������ ���!(RESULT SET)�� ���̺� ��� �����
*/

--> �ζ��κ並 �ַ� ����ϴ� ��
-- TOP-N�м� : �����ͺ��̽� �� �����ϴ� �ڷ� �� �ֻ��� �� �� �ڷḦ ���� ���� ���

-- ������ �� �޿��� ���� ���� 5��
-- * ROWNUM : ����Ŭ���� �������ִ� �÷�, ��ȸ�� ������� 1���� .... ������ �ο��� ��

SELECT ROWNUM, EMP_NAME, SALARY         -- 3
  FROM EMPLOYEE                         -- 1
 WHERE ROWNUM <= 5                      -- 2
 ORDER BY SALARY DESC;                  -- 4
 
 
SELECT ROWNUM, EMP_NAME, SALARY
  FROM (SELECT EMP_NAME, SALARY
        FROM EMPLOYEE
       ORDER BY SALARY DESC)
 WHERE ROWNUM <= 5;
 
 
 -- �� �μ��� ��ձ޿��� ���� 3���� �μ��ڵ�, ��� �޿� ��ȸ
 
SELECT ROWNUM, DEPT_CODE, ROUND("��� �޿�")
FROM (SELECT DEPT_CODE, AVG(SALARY) "��� �޿�"
        FROM EMPLOYEE
       GROUP BY DEPT_CODE
       ORDER BY AVG(SALARY) DESC)
WHERE ROWNUM <= 3;

--------------------------------------------------------------------------------
/*
    6. ���� �ű�� �Լ�
    
    ** SELECT�������� ����� ����!!!!
    
    RANK() OVER(���ı���)
    DENSE_RANK() OVER(���ı���)

    RANK() OVER : ���� 1���� 2���̶�� �Ѵٸ� �� ���� ������ 3���� �ϰڴ�.
    DENSE_RANK() OVER : ���� 1���� 2���̶�� �ص� �� ���� ������ 2���� �ϰڴ�.
*/

-- ������� �޿��� ���� ������� ������ �Űܼ�, �����, �޿�, ���� ��ȸ
SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) "����"
FROM EMPLOYEE;

-- 5�������� ��ȸ�ϰڴ�.
SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) "����"
FROM EMPLOYEE
WHERE RANK() OVER(ORDER BY SALARY DESC) <= 5;

SELECT *
  FROM (SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) "����"
          FROM EMPLOYEE)
 WHERE ���� <= 5;











