/*
    < DCL : DATA CONTROL LANGUAGE > ������ ���� ���
    GRANT, REVOKE
    
    �������� ��ü���ٱ���, �ý��۱��� �ο�(GRANT)�ϰų� ȸ��(REVOKE)�ϴ� ���
    
    * ���� �ο�(GRANT)
    - �ý��� ���� : Ư�� DB�� �����ϴ� ����, ��ü���� ������ �� �ִ� ����
    - ��ü���ٱ��� : Ư�� ��ü�鿡 �����ؼ� ������ �� �ִ� ����
    
    [ ǥ���� ]
    GRANT ����1, ����2, ..... TO ������;
    
    - CREATE SESSION : ������ ������ �� �ִ� ����
    - CREATE TABLE : ���̺��� ������ �� �ִ� ����
    - CREATE VIEW : �並 ������ �� �ִ� ����
    - CREATE SEQUENCE : �������� ������ �� �ִ� ����
    - CREATE USER : ������ ������ �� �ִ� ����
    ....
*/

-- 1. SAMPLE ���� ����
CREATE USER SAMPLE IDENTIFIED BY SAMPLE;

-- 2. SAMPLE ������ �����ϱ� ���� CREATE SESSION ���� �ο�
GRANT CREATE SESSION TO SAMPLE;

-- 3_1. SAMPLE ������ ���̺��� ������ �� �ִ� CREATE TABLE ���� �ο�
GRANT CREATE TABLE TO SAMPLE;

-- 3_2. SAMPLE ������ ���̺����̽��� �Ҵ����ֱ�(SYSTEM ���� ����)
ALTER USER SAMPLE QUOTA 2M ON SYSTEM;

-- 4. SAMPLE ������ �並 ������ �� �ִ� CREATE VIEW ���� �ο�
GRANT CREATE VIEW TO SAMPLE;


/*

    * ��ü����
    Ư�� ��ü���� ����(SELECT, INSERT, UPDATE, DELETE)�� �� �ִ� ����

    [ ǥ���� ]
    GRANT �������� ON Ư����ü TO ������;

    * ��ü������ ����
    SELECT | TABLE, VIEW, SEQUENCE
    INSERT | TABLE, VIEW
    UPDATE | TABLE, VIEW
    DELETE | TABLE, VIEW

*/
-- 5. SAMPLE������ KH.EMPLOYEE���̺��� ��ȸ�� �� �ִ� ���� �ο�
GRANT SELECT ON KH.EMPLOYEE TO SAMPLE;

-- 6. SAMPLE������ KH.DEPARTMENT���̺� ���� ������ �� �ִ� ���� �ο�
GRANT INSERT ON KH.DEPARTMENT TO SAMPLE;


--------------------------------------------------------------------------------

/*
    * ���� ȸ��(REVOKE)
    ������ ȸ���� �� ����ϴ� ��ɾ�

    [ ǥ���� ] 
    REVOKE ����1, ����2, .... FROM ������̸�;
*/

-- 7. SAMPLE�������� ���̺��� ������ �� ������ ���� ȸ��
REVOKE CREATE TABLE FROM SAMPLE;
--------------------------------------------------------------------------------
-- GRANT CONNECT, RESOURCE TO ����;
-- �ּ����� ������ �ο��ϰ��� �� �� CONNECT, RESOURCE �� �ο��ϸ� �ȴ�.

SELECT *
  FROM ROLE_SYS_PRIVS
 WHERE ROLE IN ('CONNECT', 'RESOURCE');

/*
    < �� ROLE >
    Ư�� ���ѵ��� �ϳ��� �������� ��Ƴ�����
    
    CONNECT : CREATE SESSION (�����ͺ��̽��� ������ �� �ִ� ����)
    RESOURCE : CREATE TABLE, CREATE VIEW...(Ư�� ��ü���� ���� �� �����ϴ� ����)
*/

-- �ǽ�����

-- ����ڿ��� �ο��� ���� : CONNECT, RESOURCE
-- ������ �ο����� ����� : HAHA


CREATE USER HAHA IDENTIFIED BY HAHA;
GRANT CONNECT, RESOURCE TO HAHA;

DROP USER HAH;










