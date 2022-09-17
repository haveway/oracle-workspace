-- ���̺��� ������!!!
CREATE TABLE TEST(
    TEST_ID NUMBER
);

-- 3_1. SAMPLE������ ���̺��� ������ �� �ִ� ������ ���� ������ ���� �߻�
-- ORA-01031 : isufficient privileges

-- CREATE TABLE���� �ο� ���� ��
CREATE TABLE TEST(
    TEST_ID NUMBER
);

-- 3_2. TABLESPACE�� �Ҵ���� �ʾƼ� ���� �߻�
-- ORA-01950 : no privileges on tablespace 'SYSTEM'

-- TABLESPACE�Ҵ� ���� ��
CREATE TABLE TEST(
    TEST_ID NUMBER
);
-- ���̺� ���� �Ϸ�

-- ���̺� ���������� �ο��ް� �Ǹ�
-- ������ '����'�ϰ� �ִ� ���̺���� �����ϴ°͵� ��������
SELECT * FROM TEST;
INSERT INTO TEST VALUES(1);

-- �� ������
CREATE VIEW V_TEST
AS SELECT * FROM TEST;

-- 4. �� ��ü�� ������ �� �ִ� CREATE VIEW������ ���� ������ ���� �߻�
-- ORA-01031 : insufficient privileges
CREATE VIEW V_TEST
AS SELECT * FROM TEST;


-- SAMPLE �������� KH������ ���̺� �����ؼ� ��ȸ�غ���

SELECT *
  FROM KH.EMPLOYEE;

-- 5. KH������ ���̺� �����ؼ� ��ȸ�� �� �ִ� ������ ���� ������ ���� �߻�
-- ORA--00942 : table or view does not exist

-- SELECT ON ���� �ο� ��
SELECT *
  FROM KH.EMPLOYEE;
  -- EMPLOYEE���̺� ��ȸ ����!

SELECT * FROM KH.DEPARTMENT;

-- SAMPLE�������� KH������ ���̺� �����ؼ� �� �����غ���
INSERT INTO KH.DEPARTMENT VALUES('D0', 'ȸ���', 'L2');
-- 6. KH������ DEPARTMENT ���̺� ������ �� �ִ� ������ ���� ������ ����

-- INSERT ON ���� �ο� ��
INSERT INTO KH.DEPARTMENT VALUES('D0', 'ȸ���', 'L2');
-- KH.DEPARTMENT ���̺� �� INSERT���� ~ ~ ~ ~ 

ROLLBACK;

-- ���̺� ������??
CREATE TABLE TEST2(
    TEST_ID NUMBER
);


-- 7. SAMPLE�������� ���̺��� ������ �� ������ ������ ȸ���߱� ������ ���� �߻�!!












