/*
    < �Լ� FUNCTION >
    �ڹٷ� ������ �޼ҵ�� ���� ����
    ���޵� ������ �о ����� ����� ��ȯ
    
    - ������ �Լ� : N���� ���� �о N���� ���� ����
    - �׷� �Լ� : N���� ���� �о 1���� ����� ����
    
    ������ �Լ��� �׷��Լ��� �Բ� ����� �� ����!!!!
    : ��� ���� ������ �ٸ��� ������

*/

-------- < ������ �Լ� > --------

/*
    < ���ڿ��� ���õ� �Լ� >
    LENGTH / LENGTHB
    
    - LENGTH(STR) : �ش� ���޵� ���ڿ��� ���� �� ��ȯ
    - LENGTHB(STR) : �ش� ���޵� ���ڿ��� ����Ʈ �� ��ȯ
    
    ��� ���� NUMBERŸ������ ��ȯ
    
        
    ����, ����, Ư������ : '!', '~', 'A', '1' => �ѱ��ڴ� 1Byte
    �ѱ� : '��', '��', '��'.... => �ѱ��ڴ� 3Byte
*/
SELECT LENGTH('ORACLE'), LENGTHB('ORACLE')
FROM DUAL; -- �������̺�(DUMMY TABLE)

SELECT LENGTH('����Ŭ'), LENGTHB('����Ŭ')
FROM DUAL; -- �������̺�(DUMMY TABLE)

SELECT EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL), EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME)
FROM EMPLOYEE;

-------------------------------------------------------------------------
/*
    < INSTR >
    - INSTR(STR) : ���ڿ��κ��� Ư�� ������ ��ġ�� ��ȯ
    INSTR(STR, 'Ư������', ã�� ��ġ�� ���۰�, ����)

    ������� NUMBER Ÿ������ ��ȯ
    ã�� ��ġ�� ���۰�, ������ ���� ����
    1 : �տ������� ã�ڴ�.
    -1 : �ڿ������� ã�ڴ�.

*/


SELECT INSTR('AABAACAABBAA', 'B')
FROM DUAL; -- ã�� ��ġ, ���� ���� �� �⺻������ �տ������� ù��° ���� �˻�

SELECT INSTR('AABAACAABBAA', 'B', 1)
FROM DUAL;

SELECT INSTR('AABAACAABBAA', 'B', -1)
FROM DUAL; -- �ش� ���ڿ� ù��° B�� �ڿ������� ���°�� �ִ°�!

SELECT INSTR('AAAAABCAAAABA', 'B', 1, 2)
FROM DUAL;

SELECT INSTR('AAAAABCAAAABA', 'B', -1, 2)
FROM DUAL; -- �ش� ���ڿ��� �ڿ������� �ι�° B�� �տ������� ���°�� �ִ°�

-- EMPLOYEE���̺��� EMAIL�÷��� @�� ��ġ�� ã�ƺ���!!
SELECT EMP_NAME "��������?", INSTR(EMAIL, '@') "@�� ����ִ�?"
FROM EMPLOYEE;

----------------------------------------------------------------------

/*
    < SUBSTR >
    ���ڿ��κ��� Ư�����ڿ� ���� -> ��ȯ
    .subString()

    ������� CHARACTER Ÿ������ ��ȯ
    -SUBSTR(STR, POSITION, LENGTH)
    
    - STR : '���ڿ�'�Ǵ� ���� Ÿ�� �÷�
    - POSITION : ������ġ��
    - LENGTH : ������ ���� ����(���� �� ������)
*/


SELECT SUBSTR('leehightmetalbest', 7)
FROM DUAL;

SELECT SUBSTR('leehightmetalbest', 7, 5)
FROM DUAL;

SELECT SUBSTR('leehightmetalbest', -10, 5)
FROM DUAL;


-- �ֹι�ȣ ���� �κ��� �����ؼ� ����(1)/����(2)�� üũ
SELECT EMP_NAME, SUBSTR(EMP_NO, 8, 1) ����
FROM EMPLOYEE;

-- ���ڻ���鸸 ��ȸ(�����, �޿�)
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = '1' OR SUBSTR(EMP_NO, 8, 1) = '3';

-- ���� ����鸸 ��ȸ(�����, �޿�) 2, 4
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('2', '4');

-- �̸��Ͽ��� ID�κи� �����ؼ� ��ȸ(�̸�, �̸���, ID)
-- EMAIL���ڿ����� @�ձ�����
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1)
FROM EMPLOYEE;

-----------------------------------------------------------------------

/*
    LPAD / RPAD
    
    - LPAD / RPAD(STR, ���������� ��ȯ�� �����Ǳ���(����Ʈ), �����̰����ϴ� ����

    ������� CHARTER Ÿ������ ��ȯ
    �����̰��� �ϴ� ���ڴ� ���� ����
*/

SELECT LPAD(EMAIL, 20, 'a')
FROM EMPLOYEE;

SELECT RPAD(EMAIL, 20, '!')
FROM EMPLOYEE;

-- 112323-9****** 14 = 14Byte
SELECT RPAD('121212-2', 14, '*') �ֹι�ȣ
FROM DUAL;

-- SELECT * FROM EMPLOYEE;
-- ��� ������ �ֹε�Ϲ�ȣ �� 6�ڸ��� ����ŷó���ؼ� ǥ���غ���
-- �̸�, �ֹι�ȣ

-- 1�ܰ�, SUBSTR�� �̿��ؼ� �ֹε�Ϲ�ȣ �� 8�ڸ��� ����
SELECT EMP_NAME, SUBSTR(EMP_NO, 1, 8)
FROM EMPLOYEE;

-- 2�ܰ�, RPAD�� �ֹε�Ϲ�ȣ �� 6�ڸ��� * ���̱�
SELECT EMP_NAME �̸� , RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*') �ֹι�ȣ
FROM EMPLOYEE;

---------------------------------------------------------------------

/*
    < LOWER / UPPER / INITCAP >
    - LOWER(STR)
    : ���� �� �ҹ��ڷ� ����
    - UPPER(STR)
    : ���� �� �빮�ڷ� ����
    - INITCAP(STR)
    : �� �ܾ� �ձ��ڸ� �빮�ڷ� ����
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
    : ���޵� �� ���� ���ڿ��� �ϳ��� ��ģ ����� ��ȯ

    ������� CHARTER ��ȯ
*/

SELECT '������' || 'ABC' || 'asd'
FROM DUAL;

SELECT CONCAT('������', 'ABC')
FROM DUAL; -- CONCAT�Լ��� �� �� �̻� ��ġ�� �Ұ�!


---------------------------------------------

/*
    REPLACE
    
    - REPLACE(STR, ã������, �ٲܹ���)
    : STR�κ��� ã�� ���ڸ� ã�Ƽ� �ٲܹ��ڷ� ��ȯ �� ��ȯ
    
    ������� CHARACTER�� ��ȯ

*/

SELECT REPLACE('����� ������ ���ﵿ', '���ﵿ', '�Ｚ��')
FROM DUAL;

SELECT EMAIL, REPLACE(EMAIL, 'kh.or.kr', 'iei.com')
FROM EMPLOYEE;
----------------------------------------------------------------------

/*
    < TRIM >
    (BOTH(����) / LEADING(����) / TRAILING(����)) -> ���� ����
    : ���ڿ� ��/��/���ʿ� �ִ� Ư�� ���ڸ� ������ ������ ���ڿ��� ��ȯ
    ������� CHARACTER�� ��ȯ
*/

SELECT TRIM('Z' FROM 'ZZZKHZZZ')
FROM DUAL; -- ����(�⺻��) : BOTH

SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZ')
FROM DUAL; -- ���� : LEADING

SELECT TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ')
FROM DUAL; -- ���� : TRAILING
-------------------------------------------------------------------------







