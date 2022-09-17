/*
    < TCL : TRANSACTION CONTROL LANGUAGE >
    Ʈ������� �����ϴ� ���

    * Ʈ����� (TRANSACTION)
    
    - �����ͺ��̽��� ���� �������
    
    - �������� �������(DML)���� �ϳ��� Ʈ��������� ��� ó��
    COMMIT(Ȯ��)�ϱ� �������� ������׵��� �ϳ��� Ʈ�����ǿ� ��´�.
    - Ʈ������� ����� �Ǵ� SQL : (INSERT, UPDATE, DELETE)DML
    
    COMMIT(Ʈ����� ����ó�� �� Ȯ��)
    ROLLBACK(Ʈ����� ���)
    SAVEPOINT(�ӽ�����)
*/


-- ���̺�� EMP_02
-- EMPLOYEE���̺��� �����ϰ� �ʹ�.

CREATE TABLE EMP_02
AS SELECT * FROM EMPLOYEE;

SELECT *
  FROM EMP_02;
  
-- ����� 221�� ��� ����
DELETE FROM EMP_02
 WHERE EMP_ID = 221;
 
-- ����� 220�� ��� ����
DELETE FROM EMP_02
 WHERE EMP_ID = 220;
  
SELECT * FROM EMP_02;

ROLLBACK;
  
SELECT * FROM EMP_02;
  -- 1�ܰ� ��

--------------------------------------------------------------------------------

-- ����� 220�� �������
DELETE FROM EMP_02
 WHERE EMP_ID = 220;

-- ��� 800, �̸� ȫ�浿�� ��� �߰�
INSERT INTO EMP_02 (EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL)
VALUES(800, 'ȫ�浿', '234324', 'J9', 'S1');

-- NOT NULL == EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL

COMMIT;

SELECT * FROM EMP_02;

ROLLBACK;

-- 2�ܰ� ��

--------------------------------------------------------------------------------

-- ����� 217, 216, 214�� ��� ����

DELETE FROM EMP_02
 WHERE EMP_ID IN (217, 216, 214);

-- 3�� ���� ������ ������ SAVEPOINT ����
SAVEPOINT SP1;

DELETE FROM EMP_02
 WHERE EMP_ID = 200;
 
SELECT * FROM EMP_02;

INSERT INTO EMP_02(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL)
VALUES (801, '��浿', '2323', 'J9', 'S1');

ROLLBACK TO SP1;

SELECT * FROM EMP_02;

COMMIT;

--------------------------------------------------------------------------------

SELECT * FROM EMP_02;

-- ����� 800���� ��� ���ֱ�
DELETE FROM EMP_02
 WHERE EMP_ID = 800;

-- ���̺� ����(DDL)
CREATE TABLE TEST(
    TID NUMBER
);

ROLLBACK;

/*
    DDL ����(CREATE, ALTER, DROP)�� �����ϴ� ����

    ������ Ʈ����ǿ� �ִ� ��� ������׵��� ������ ���� DB�� �ݿ�(COMMIT)
    ��Ų �� DDL�� ���� ��

    => DDL ���� �� ��������� �ִٸ� ��Ȯ�� �Ƚ�(COMMIT, ROLLBACK)�ϰ� DDL�� �����ؾ� �Ѵ�.
*/

/*
    COMMIT; �ϳ��� Ʈ����ǿ� ����ִ� ������׵��� ���� DB�� �ݿ��ϰڴ�.
            ���� �ݿ���Ų �� Ʈ������� �����
    ROLLBACK; �ϳ��� Ʈ����ǿ� ����ִ� ������׵��� ������ �� ������ COMMIT�������� ���ư�
    SAVEPOINT �̸� : ���� ���� �ӽ������� ����
*/


/*
    DDL : CREATE(�����), ALTER(��ġ��), DROP(������)
    DQL : SELECT(��ȸ)
    DML : INSERT(����), UPDATE(����), DELETE(����)
    DCL : GRANT(�ֱ�), REVOKE(����)
    TCL : COMMIT(����ȹٲ�), ROLLBACK(���ư���~), SAVEPOINT(�߰�����??)
*/















