/*

    �ȳ��ϼ��� ~ ������ �ּ��̿��� ~
    �� ���̰� ���� �� �ּ��� �Ǵ°��� ~~~
    
    ����Ŭ ��ġ �� :
    
    ��� : �������
    ��й�ȣ : oracle
    ��й�ȣ Ȯ�� : oracle
    
    cmd -> sqlplus -> sys as sysdba // oracle  -> exit 

    sql Developer ����
*/

select * from DBA_USERS;
-- � �������� �ִ��� Ȯ��

-- �Ϲ� ����� ������ �����ϴ� ����(������ ����������!!!!!)
-- [ǥ����] CREATE(����) USER ������̸� IDENTIFIED BY ��й�ȣ;
CREATE USER kh IDENTIFIED BY kh; -- ���̵�� ��ҹ��� ���о��� // ����� ��ҹ��� ����

-- �����ִ� ��ɾ�

-- ������ ������ �Ϲ� ����� �������� �ּ����� ����(����, ������) �ο�
-- [ǥ����] GRANT ����1, ����2, .... TO ������;

GRANT CONNECT, RESOURCE TO kh;












