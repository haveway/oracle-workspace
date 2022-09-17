/*
    < GROUP BY �� >
    �׷��� ������ ������ ������ �� �ִ� ����


    ������ ������ �׷캰�� ������ ó���� �������� ���.
*/

-- ��ü ����� �� �޿���
SELECT SUM(SALARY)
  FROM EMPLOYEE;  --> ���� ��ȸ�� ��ü������� �ϳ��� �׷����� ��� ������ ���� ���
  
-- �� �μ��� �� �޿� ��
SELECT DEPT_CODE, SUM(SALARY)
  FROM EMPLOYEE
 GROUP BY DEPT_CODE;
 
 
-- ��ü��� ��
SELECT COUNT(*)
  FROM EMPLOYEE;
  
-- �� �μ��� �����
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;
  
-- �� �μ��� �� �޿� �� �μ��� �������� �����ؼ� ��ȸ
SELECT DEPT_CODE, SUM(SALARY) -- 3. SELECT ��
  FROM EMPLOYEE            -- 1. FROM��
 GROUP BY DEPT_CODE        -- 2. GROUP BY��
 ORDER BY DEPT_CODE ASC;   -- 4. �������� ~
  
-- ���� �� ��� ��
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), 1, '����', 2, '����'), COUNT(*)
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8, 1);
  
--------------------------------------------------------------------------------

-- �μ��� ��� �޿� 300���� �̻��� �μ��鸸 ��ȸ
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
WHERE AVG(SALARY) >= 3000000
GROUP BY DEPT_CODE;

/*
    < HAVING �� >

    �׷쿡 ���� ������ �����ϰ��� �� �� ���Ǵ� ����
    (��κ��� ��� �׷��Լ��� ������ ���� ����)
*/



SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000;


-------------------------------------------------------------------------------
/*
    < ���� ���� >
    5 : SELECT * /��ȸ�Ϸ��� �÷� /������� /�Լ���  "����"
    1 : FROM ��ȸ���̺�
    2 : WHERE ���ǽ�
    3 : GROUP BY �׷� ���ؿ� �ش��ϴ� �÷��� / �Լ���
    4 : HAVING �׷��Լ��Ŀ� ���� ���ǽ�
    6 : ORDER BY ���� ���ؿ� �ش��ϴ� �÷��� / ��Ī / �÷� ���� ASC/DESC NULL F / NULL L
*/
-------------------------------------------------------------------------------



  
  
  
  
  