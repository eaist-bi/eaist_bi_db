create or replace PACKAGE N_UTILITS AS 
  TYPE T_SUB_EXPRESSION IS RECORD(
    CODE NUMBER,
    FIRST_IND NUMBER,
    SECOND_IND NUMBER,
    OPER VARCHAR2(1),
    FORMULA VARCHAR2(1000),
    SQL_QUERY CLOB);
    
  TYPE T_SUB_EXPRESS_ARR IS TABLE OF T_SUB_EXPRESSION
  INDEX BY BINARY_INTEGER;  

  TYPE T_FIELDS IS TABLE OF VARCHAR2(40)
  INDEX BY BINARY_INTEGER;
  
  TYPE SOURCE_INFO IS RECORD(
    SOURCE_SQL CLOB,
    SOURCE_TYPE NUMBER); -- 1=TABLE;2=QUERY
  
  TYPE INDICATOR_INFO IS RECORD(
      INDICATOR_ID NUMBER,
      IND_FIELDS T_FIELDS,
      IND_SOURCE SOURCE_INFO); 
      
  TYPE T_INDICATORS IS TABLE OF INDICATOR_INFO
    INDEX BY BINARY_INTEGER;    
  
  TYPE REPORT_PARAM IS RECORD(
    NAME VARCHAR2(100),
    TYPE VARCHAR2(100),
    VALUE VARCHAR2(100));
    
  TYPE REPORT_PARAM_ARRAY IS TABLE OF REPORT_PARAM
    INDEX BY BINARY_INTEGER;
  
  --�������� ��������� �������
  FUNCTION FORMATE_CONDITION_SQL (V_VERSION_DATE IN DATE, inExpression in varchar2, cond_level in number := -1) RETURN VARCHAR2;
  --���������� ������ ��� �������� ���������� � ��� ������� ����
  FUNCTION GET_INDICATOR_QUERY (V_VERSION_DATE IN DATE, V_TABLE_NAME IN VARCHAR2, V_INDICATOR_ID IN NUMBER) RETURN CLOB;
  --��������� ��� ���������� � ��� ������� ����
  FUNCTION LOAD_CUBE_2LVL(V_VERSION_DATE IN DATE, V_TABLE_NAME VARCHAR2) RETURN NUMBER;
  --��������� ���������� ���������� � ��� ������� ����
  FUNCTION LOAD_CUBE_2LVL_INDICATOR(V_VERSION_DATE IN DATE, V_TABLE_NAME VARCHAR2, V_INDICATOR_ID NUMBER) RETURN NUMBER;
  --��������� ������ � ��� ������� ����
  FUNCTION LOAD_CUBE_1LVL (V_VERSION_DATE IN DATE, V_TABLE_NAME IN VARCHAR2) RETURN NUMBER;
  --��������� ������ �� ��� ���� ������� ����
  FUNCTION LOAD_CUBE_1LVL_ALL (V_VERSION_DATE IN DATE) RETURN NUMBER;
  --���������� ������ ��� �������� ������ �� ����������� ����������
  FUNCTION GET_CALCULATED_INDICATOR_QUERY (V_VERSION_DATE IN DATE, V_TABLE_NAME IN VARCHAR2, V_INDICATOR_ID IN NUMBER) RETURN CLOB;
  --���������� ������� � USER_TAB_COLUMNS, ������� ������� ������� ��� ��� � ��������� ������� ��� ����, � ��� �����������
  PROCEDURE UPDATE_1LVL_METADATA;
  
  PROCEDURE UPDATE_UNITED_CUSTOMER_ID(V_VERSION_DATE IN DATE, V_TABLE_NAME IN VARCHAR2, V_INDICATOR_ID IN NUMBER);
  
  FUNCTION GET_SUB_EXPRESSION_ARR(V_IN_FORMULA IN VARCHAR2) RETURN T_SUB_EXPRESS_ARR;
  
  FUNCTION CHECK_DATA(V_VERSION_DATE IN DATE, V_TABLE_NAME IN VARCHAR2) RETURN BOOLEAN;

END N_UTILITS;