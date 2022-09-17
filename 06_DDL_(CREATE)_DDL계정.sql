/*
    * DDL (DATA DEFINITION LANGUAGE) : ������ ���� ���
    
    ����Ŭ���� �����ϴ� ��ü(OBJECT)��
    ������ �����(CREATE), ������ �����ϰ�(ALTER), ������ü�� �����ϴ�(DROP)�ϴ� ��ɹ�
    ��, ������ü�� �����ϴ� ���� �ַ� DB������, �����ڰ� �����
    
    ����Ŭ������ ��ü(����) : ���̺�(TABLE), ��(VIEW), ������(SEQUENCE)
    
                           �ε���(INDEX), ��Ű��(PACKAGE), Ʈ����(TRIGGER)
                           ���ν���(PROCEDUER), �Լ�(FUNCTION),
                           ���Ǿ�(SYNONYM), �����(USER)
*/


/*
    < CREATE TABLE >
    
    
    ���̺��̶�?? : ��(ROW), ��(COLUMN)�� �����Ǵ� ���� �⺻���� �����ͺ��̽� ��ü
    ��� �����ʹ� ���̺��� ���ؼ� �����(�����͸� �����ϰ��� �Ѵٸ� ���̺��� ������ ��)
    
    [ ǥ���� ]
    CREATE TABLE ���̺�� (
        �÷��� �ڷ���,
        �÷��� �ڷ���,
        �÷��� �ڷ���,
        ......
    );

    < �ڷ��� >
    
    - ����(CHAR(ũ��) / VARCHAR2(ũ��) : ũ��� BYTE����
                                    (����, ������, Ư������ => 1���� �� 1BYTE
                                                     �ѱ� => 1���ڴ� 3BYTE)


    CHAR(����Ʈ��) : �ִ� 2000BYTE���� ��������
                    ��������(�ƹ��� �������� ���͵� �������� ä���� ó�� �Ҵ�� ũ�� ����)
                    �ַ� ���� ���� ���ڼ��� ������ ���� ���
                    �� ) ���� : �� / ��, M / F

    VARCHAR2(����Ʈ��) : �ִ� 4000BYTE���� ��������
                        ��������(���� ���� ������ �� ��䰪�� ���缭 ũ�Ⱑ �پ��)
                        VAR�� '����'�� �ǹ�, 2�� '2��'�� �ǹ��Ѵ�.
                        
    - ���� (NUMBER) : ���� / �Ǽ� ������� NUMBER

    - ��¥ (DATE)
*/

--> ȸ������ ������(���̵�, ��й�ȣ, �̸�, ȸ��������)�� ������� ���̺�
-- MEMBER ���̺� �����ϱ�!

CREATE TABLE MEMBER(
    MEMBER_ID VARCHAR2(20),
    MEMBER_PWD VARCHAR2(20),
    MEMBER_NAME VARCHAR2(20),
    MEMBER_DATE DATE
);

SELECT * FROM MEMBER;
-------------------------------------------------------------------------------
/*
    �÷��� �ּ��ޱ� (�÷��� ���� ����)

    [ǥ����]
    COMMENT ON COLUMN ���̺��.�÷��� IS '�ּ�����';
*/

COMMENT ON COLUMN MEMBER.MEMBER_ID IS 'ȸ�����̵�';
-- ȸ����й�ȣ, ȸ���̸�, ȸ��������
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS 'ȸ���̸�';
COMMENT ON COLUMN MEMBER.MEMBER_DATE IS 'ȸ��������';

-- ������ ��ųʸ� : �پ��� ��ü���� ������ �����ϰ� �ִ� �ý��� ���̺�
-- USER_TABLES : ���� �� ������ ������ �ִ� ���̺���� �������� ������ Ȯ���� �� �ִ� ������ ��ųʸ�

SELECT * FROM USER_TABLES;

-- USER_TAB_COLUMNS
SELECT * FROM USER_TAB_COLUMNS;

SELECT * FROM MEMBER;


-- �����͸� �߰��� �� �ִ� ����(INSERT : �� ������ �߰�, ���� ���� �߿�)
-- INSERT INTO ���̺�� VALUES(ù ��° �÷��ǰ�, �ι�° �÷��ǰ�, ����°....)
INSERT INTO MEMBER VALUES('user01', 'pass01', 'ȫ�浿', '2022-05-02');
INSERT INTO MEMBER VALUES('user02', 'pass02', '��浿', SYSDATE);
INSERT INTO MEMBER VALUES('user03', 'pass03', '�̱浿', '21/12/12');
INSERT INTO MEMBER VALUES(NULL, NULL, NULL, SYSDATE); -- ���̵�, ��й�ȣ, �̸�
-- NULL������ ��
INSERT INTO MEMBER VALUES('user03', 'pass03', '�谳��', SYSDATE);
-- �ߺ��� ���̵� ����

-- NULL���̳� �ߺ��Ⱦ��̵��� ��ȿ���� ���� �����̴�.
-- ��ȿ�� �����Ͱ��� �����ϱ� ���ؼ� ���������� �ɾ���� �Ѵ�.
------------------------------------------------------------------------------
/*
    < �������� CONSTRAINTS >

    - ���� : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
    
    - ���ϴ� �����Ͱ����� �����ϱ� ���ؼ�(�����ϱ� ���ؼ�) Ư�� �÷����� �����ϴ� ����
    (�������� ���Ἲ ������ ��������)
    - �������� �ο��� �÷��� ���� �����Ͱ� ������ �ִ��� ������ �ڵ����� �˻�

    - �÷��� ���������� �ο��ϴ� ��� : �÷����� / ���̺���
*/

/*

    1. NOT NULL ��������
    
    �ش� �÷��� �ݵ�� ���� �����ؾ߸� �� ��� ���(NULL���� ���� ���ͼ��� �ȵǴ� �÷�)
    ���� / ���� �� NULL���� ������� �ʵ��� ����

    ��, NOT NULL �������� �÷����� ��� �ۿ� �ȵ�
*/


-- NOT NULL �������Ǹ� ������ ���̺� �����
-- �÷����� ��� : �÷��� �ڷ��� �������� => ���������� �ο��ϰ��� �ϴ� �÷� �ڿ� ���
CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30)
);

SELECT * FROM MEM_NOTNULL;

INSERT INTO MEM_NOTNULL
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1234-5678', 'hgd@hdg.com');
INSERT INTO MEM_NOTNULL
VALUES(2, NULL, NULL, NULL, NULL, NULL, NULL); -- NOT NULL �������ǿ� ���� ���� �߻�!
INSERT INTO MEM_NOTNULL
VALUES(2, 'user02', 'pass02', '��浿', NULL, NULL, NULL);
-- NOT NULL ���������� �ο��Ǿ��ִ� �÷����� �ݵ�� ���� �����ؾ��� !

INSERT INTO MEM_NOTNULL
VALUES(3, 'user01', 'pass03', '������', '��', NULL, NULL);

--------------------------------------------------------------------------------
/*
    2. UNIQUE ��������


    �÷��� �ߺ����� �����ϴ� ��������
    ���� / ���� �� ������ �ش� �÷����߿� �ߺ����� ���� ��� �߰� �Ǵ� ������ �����ʰ� ����!!!!
    
    �÷�����/���̺��� ��� �� �� ����!!!
*/

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, -- �÷�����
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30)
);

DROP TABLE MEM_UNIQUE;

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    UNIQUE(MEM_ID) -- ���̺� ���� ���
);

INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', NULL, NULL);
INSERT INTO MEM_UNIQUE VALUES(2, 'user02', 'pass02', '��浿', '��', NULL, NULL);
INSERT INTO 
            MEM_UNIQUE 
    VALUES 
            (
            3
          , 'user02'
          , 'pass03'
          , '�踻��'
          , '��'
          , NULL
          , NULL
            );
-- UNIQUE �������ǿ� ����Ǿ����Ƿ� INSERT����!
-- ������������ �������Ǹ� �˷��� ( � �÷��� ������ �ִ��� �÷����� �˷����� ����)
-- ���������� �𸣸� �ľ��ϱ� �����(ORA-00001 : unique constraint)
-- �������Ǹ��� �������� �� ����

SELECT * FROM MEM_UNIQUE;

--------------------------------------------------------------------------------
/*
    * �������� �ο� �� �������Ǹ� �����ϴ� ǥ����

    > �÷����� ���
    CREATE TABLE ���̺��(
        �÷��� �ڷ��� CONSTRAINT �������Ǹ� ��������,
        �÷��� �ڷ���,
        �÷��� �ڷ���,
    )
    
    > ���̺��� ���
     CREATE TABLE ���̺��(
        �÷��� �ڷ���,
        �÷��� �ڷ���,
        �÷��� �ڷ���,
        CONSTRAINT �������Ǹ� �������� (�÷���)
    )
*/

CREATE TABLE MEM_CON_NN(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEM_NAME_NN NOT NULL, -- �÷����� ���
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    CONSTRAINT MEM_ID_UQ UNIQUE(MEM_ID) -- ���̺��� ���
);

INSERT INTO MEM_CON_NN VALUES(1, 'user01', 'pass01', 'ȫ�浿', NULL, NULL, NULL);
INSERT INTO MEM_CON_NN VALUES(1, 'user01', 'pass02', '��浿', NULL, NULL, NULL);


SELECT * FROM MEM_CON_NN;

INSERT INTO MEM_CON_NN VALUES(2, 'user02', 'pass02', '��浿', '��', NULL, NULL);
-- GENDER�÷��� '��' / '��' ���� ���� �ϰ����
--------------------------------------------------------------------------------
/*
    3. CHECK ��������
    �÷��� ��ϵ� �� �ִ� ���� ���� ������ ������ �� �� �ִ�.

    CHECK(���ǽ�)
*/

CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('��', '��')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE NOT NULL
);

INSERT INTO MEM_CHECK VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', NULL, NULL, SYSDATE);
INSERT INTO MEM_CHECK VALUES(2, 'user05', 'pass02', '��浿', '��', NULL, NULL, '37/02/28');

SELECT * FROM MEM_CHECK;
-- ȸ���������� �׻� SYSDATE������ �ް�ʹ�!! ���̺��� ���� �����ϴ�!!!
--------------------------------------------------------------------------------

/*
    * Ư�� �÷��� ���� ���� ���� �⺻�� ����!! => ���������� �ƴ�
*/

DROP TABLE MEM_CHECK;

CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL
);

/*
INSERT INTO ���̺��(�÷���1, �÷���2, �÷���3, �÷���4)
VALUES(��1, ��2, ��3, ��4)
*/
INSERT INTO MEM_CHECK(MEM_NO, MEM_ID, MEM_PWD, MEM_NAME)
VALUES(1, 'user01', 'pass01', 'ȫ�浿');
-- ���� �ȵ� �÷����� �⺻������ NULL���� ������
-- ���� DEFAULT���� �ο��Ǿ� �ִٸ� NULL���� �ƴ� DEFAULT���� ���� �ȴ�.

SELECT * FROM MEM_CHECK;

--------------------------------------------------------------------------------
/*
    4. PRIMARY KEY(�⺻Ű) ��������
    ���̺��� �� ����� ������ �����ϰ� �ĺ��� �� �ִ� �÷��� �ο��ϴ� ��������
    => �� ����� ������ �� �ִ� �ĺ����� ����
    �� ) ȸ����ȣ, �ֹ���ȣ, ���, �й�, �����ȣ
    => �ߺ����� �ʰ� ���� �����ؾ߸� �ϴ� �÷��� PRIMARY KEY�ο�(UNIQUE + NOT NULL)

    �� ���̺� �� �� ���� �÷��� ���� ����
*/

CREATE TABLE MEM_PRIMARYKEY(
    MEM_NO NUMBER CONSTRAINT MEM_PK PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30)
);

INSERT INTO MEM_PRIMARYKEY VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', NULL, NULL);

INSERT INTO MEM_PRIMARYKEY VALUES(NULL, 'user02', 'pass02', '��浿', '��', NULL, NULL);
-- �⺻Ű �÷��� NULL���� ���� �� ����!!!

INSERT INTO MEM_PRIMARYKEY VALUES(1, 'user02', 'pass02', '��浿', '��', NULL, NULL);
-- �⺻Ű �÷��� �ߺ����� ���� �� ����!!!

INSERT INTO MEM_PRIMARYKEY VALUES(2, 'user02', 'pass02', '��浿', '��', NULL, NULL);
SELECT * FROM MEM_PRIMARYKEY;

CREATE TABLE MEM_PRIMARYKEY2(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) PRIMARY KEY,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30)
);
-- PRIMARY KEY�� �� ���̺� �ΰ��� �� �� ����!!!
-- table can have only one primary key
-- �� �÷��� �ϳ��� ��� PRIMARY KEY�ϳ��� ���� �����ϴ�!!

CREATE TABLE MEM_PRIMARYKEY2(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    PRIMARY KEY(MEM_NO, MEM_ID) -- �÷��� ��� PRIMARY KEY�ϳ��� ���� => ����Ű
);

INSERT INTO MEM_PRIMARYKEY2
VALUES(1, 'user01', 'pass01', 'hong',NULL, NULL, NULL);

SELECT * FROM MEM_PRIMARYKEY2;

INSERT INTO MEM_PRIMARYKEY2
VALUES(2, 'user01', 'pass01', 'hong', NULL, NULL, NULL);

SELECT * FROM MEM_PRIMARYKEY2;

INSERT INTO MEM_PRIMARYKEY2
VALUES(NULL, 'user02', 'pass02', 'hong', NULL, NULL, NULL);
-- �⺻Ű�� �����Ǿ��ִ� �÷��鿡�� NULL���� �� �� ����!





