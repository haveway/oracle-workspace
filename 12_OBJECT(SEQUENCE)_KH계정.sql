/*         
    < ������ SEQUENCE >
    �ڵ����� ��ȣ�� �߻������ִ� ������ �ϴ� ��ü
    �������� �ڵ����� ���������� ��������
    
    �� ) ȸ����ȣ, ���, �Խñ� ��ȣ ���... ä�� �� �� ���
    
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
    
    
    1. ������ ��ü ���� ����
    CREATE SEQUENCE ��������
    START WITH ���ۼ���       => ��������, ó�� �߻���ų ���۰� ����
    INCREMENT BY ������       => ��������, �� �� ������ų���� ����
    MAXVALUE                 => ��������, �ִ밪 ����
    MINVALUE                 => ��������, �ּҰ� ����
    CYCLE/NOCYCLE            => ��������, �� ��ȯ ����
    CACHE ����Ʈũ��/NOCACHE   => ��������, ĳ�ø޸� ���ž�? �⺻���� 20Byte
    
    
    * SEQUENCE CACHE MEMORY : �̸� �߻��� ������ �����ؼ� �����صδ� ����
                              �Ź� ȣ���� �� ���� ��ȣ�� �����ϴ°� ��ȿ�����̴�
                              ĳ�ø޸� ������ �̸� ������ ������ ������ �����ؼ�
                              �ӵ��� ����
                              ������ ����� �������� ������ �����Ǿ��ִ� ������ ���ư�
*/
    /*
        * ���λ�, ���̻�
        - ���̺�� : TB_
        - ��� : VW_
        - ������ : SEQ_
    */
    
CREATE SEQUENCE SEQ_TEST;
    
-- ���� ������ ������ �����ϰ� �ִ� �������鿡 ���� ���� ��ȸ�� ������ ��ųʸ�
-- USER_TABLES, USER_VIEWS ���...

SELECT * FROM USER_SEQUENCES;

CREATE SEQUENCE SEQ_EMPNO
START WITH 300 -- ���۰�
INCREMENT BY 5 -- ������
MAXVALUE 310 -- �ִ밪
NOCYCLE -- �ȵ���
NOCACHE; -- ĳ�þȽ�


------------------------------------------------------------------------
/*
    2. ������ ��� ����

    ��������.CURRVAL : ���� �������� �� (���������� ���������� �߻��� NEXTVAL ��)
    ��������.NEXTVAL : ���������� ������Ű�� ������ �������� ��
                    ������ ������ ������ INCREMENT BY ����ŭ ������ ��
                    (��������.CURRVAL + INCREMENT BY ��)

*/

SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
--> NEXTVAL �� �ѹ��̶� �������� �ʴ� �̻� CURRVAL�� ������ �� ����

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 300
SELECT * FROM USER_SEQUENCES;
-- LAST_NUMBER: ���� ��Ȳ���� NEXTVAL�� ������ ��� ���� ��

SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 300
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 305
SELECT * FROM USER_SEQUENCES;

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 310
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;
-- ������ MAXVALUE ��(310)�� �ʰ��߱� ������ ���� �߻�

SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 310
-- �������� ���������� ����� NEXTVAL ��
----------------------------------------------------------

/*
    3. ������ ����

    [ ǥ���� ]
    ALTER SEQUENCE ��������
    INCREMENT BY ������
    MAXVALUE �ִ밪
    MINVALUE �ּҰ�
    CYCLE/NOCYCLE
    CACHE ����Ʈũ�� / NOCACHE
    
    * START WITH�� ���� �Ұ�
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

-- EMPLOYEE ���̺� ����� �߰��غ��ڽ��ϴ�!

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL)
     VALUES (SEQ_EID.NEXTVAL, '�������', '123123213', 'J3', 'S3'); -- 300


INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL)
     VALUES (SEQ_EID.NEXTVAL, '����', '123123123', 'J3', 'S4'); -- 301

SELECT * FROM EMPLOYEE;



-------------------Java------------- ��� �� �̻� ����ִ� 

-------------------Oracle----------- ��̾��� ��ƴ� (�ڹٺ��� ��վ���)

-------------------Java------------- API(Math) / Collection ���� �����

--/ I/O ����� ���丸 �˸� ��        / (Network) ���ϸ��Ҽ�������

-------------------JDBC------------- �巴�� �����(�������ؾ���)

-------------------HTML/CSS--------- �巴�� ���� �ʹ��ʹ������� ����













SELECT *
FROM DEPARTMENT;








/*
�������� �Ǽ��� ������� ����ó�� ����Ǿ����ϴ�.
      ��� ������� ����ó �� 4�ڸ��� '*'�� ä���
      (����ó�� ���� ������� ������� ����)
      ���, ����̸�, ����ó, �μ����� ��ȸ�ϴ� �������� �ۼ��Ͻÿ�.
*/
SELECT EMP_ID, EMP_NAME, RPAD(SUBSTR(PHONE,1,7), 11,'*') ����ȣ, DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
/*
���� 1)
����ó�� �����ϴ� ����, 011, 017 ��ȣ�� ���� �������� ����
�ֽ� ������ ��Ʈ 10+�� ȸ�� ���� �������� �����ϱ�� �ߴ�.
����ó�� '011', '017'�� �����ϴ� �������� ���, �����, ����ó, �μ���, ���޸���
��ȸ�ϰ� ����ó�� '010'���� �����ϴ� ��ȣ�� �����ϴ� �������� �ۼ��Ͻÿ�.
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
���� 2)
�ټӿ��� �� ������� ������踦 ������ �Ѵ�.
EMP_COPY_TEST���� �ټӿ����� �������
�ټӿ����� 10�� �̻��� �������
�ټӿ����� ��ձ޿��� �ְ�޿��� ���Ͽ�, �ټӿ����� ������������ �����Ͻÿ�.
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
���� 3)
����������� �ο��� �����Ͽ� �μ��� ���� �������� ��������η� ��������� �����Ͽ���.
�μ��� ���� �������� ��������η� �̵��� ��
����������� ��� ����� �޿� ���޸� �μ����� ��ȸ�Ͻÿ�.
*/

SELECT * FROM DEPARTMENT;

UPDATE EMPLOYEE SET DEPT_CODE = 'D8'
WHERE DEPT_CODE IS NULL;

SELECT EMP_ID, EMP_NAME, SALARY, JOB_NAME, DEPT_TITLE
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE = '���������';






