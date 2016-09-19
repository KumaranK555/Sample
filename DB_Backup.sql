/*
Navicat Oracle Data Transfer
Oracle Client Version : 12.1.0.2.0

Source Server         : OracleConnect
Source Server Version : 120100
Source Host           : 10.2.2.45:1521
Source Schema         : QVDDATA

Target Server Type    : ORACLE
Target Server Version : 110100
File Encoding         : 65001

Date: 2016-09-20 19:37:23
*/


-- ----------------------------
-- Procedure structure for "BINDUSERS"
-- ----------------------------
CREATE OR REPLACE PROCEDURE "BINDUSERS" (UserDetails OUT TYPES.cursortype)
AS
BEGIN
	OPEN UserDetails FOR
      SELECT * FROM users ;
END;

/

-- ----------------------------
-- Procedure structure for "CREATEQUERY"
-- ----------------------------
CREATE OR REPLACE PROCEDURE "CREATEQUERY" (P_Category IN VARCHAR2, P_Report IN VARCHAR2, P_QueryTitle IN VARCHAR2, P_Query IN VARCHAR2, P_MaxId OUT INT)
AS
BEGIN
		INSERT INTO CategoryDetails (ID,CATEGORY,REPORT,SUBREPORT) VALUES(seq_category_id.nextVal,P_Category,P_Report,P_QueryTitle);
	  INSERT INTO queryTable (ID,TITLE,QUERY) VALUES(seq_query_id.nextVal,P_QueryTitle,P_Query);
		SELECT MAX(ID) INTO  P_MaxId FROM QUERYTABLE;
	-- routine body goes here, e.g.
	-- DBMS_OUTPUT.PUT_LINE('Navicat for Oracle');
END;

/

-- ----------------------------
-- Procedure structure for "CREATEUSER"
-- ----------------------------
CREATE OR REPLACE PROCEDURE "CREATEUSER" (P_LoginUserId IN INT, P_UserId IN VARCHAR2, P_Name IN VARCHAR2, P_Branch IN INT, P_Usertype IN INT, 
P_Email IN VARCHAR2, P_Mode IN VARCHAR2, P_Status IN INT, P_Message OUT INT)
AS
BEGIN

IF(P_Mode = 'Add') THEN
BEGIN
INSERT INTO USERS (ID, Name, UserId, Branch, UserType, Email, LOGINSTATUS) 
VALUES  
(seq_order_id.nextVal, P_Name, P_UserId, P_Branch, P_Usertype,P_Email,P_Status);
P_Message := sql%rowcount;
END;
ELSE
UPDATE USERS SET NAME = P_Name, BRANCH = P_Branch, USERID = P_UserId, USERTYPE = P_Usertype,EMAIL = P_Email WHERE ID = P_LoginUserId;
P_Message := sql%rowcount;
END IF;
END;

/

-- ----------------------------
-- Procedure structure for "FETCHACTUALDATA"
-- ----------------------------
CREATE OR REPLACE PROCEDURE "FETCHACTUALDATA" (P_Head IN NVARCHAR2, P_Account IN NVARCHAR2, 
P_Profit IN NVARCHAR2, P_CostCenter IN NVARCHAR2, P_Level IN INT, 
ReportDetails OUT TYPES.cursortype)
AS
BEGIN
  DECLARE
	v_startDate VARCHAR2(100);
  v_fiscalyear VARCHAR2(100);
		BEGIN
		SELECT DEFAULTFILTERVALUE INTO v_startDate FROM FILTERTABLE WHERE QUERYID = 201 
		AND FILTERNAME = '{Month}';
    
    SELECT Max(FISCALYEAR_RYEAR) INTO v_fiscalyear FROM GLPCP;

    IF (P_Level = 1)
    THEN
      BEGIN
		   OPEN ReportDetails FOR
		   SELECT ACCOUNTNUMBER_RACCT,
		   SUM(CompanyCurrency_HSL) AS Total FROM GLPCP WHERE TABFLAG='Actual'
		   AND MONTHS = v_startDate AND FISCALYEAR_RYEAR = v_fiscalyear AND 
		   (NEWF2 = P_Head or NEWF3 = P_Head or NEWF4 = P_Head)
		   GROUP BY ACCOUNTNUMBER_RACCT ORDER BY ACCOUNTNUMBER_RACCT ASC;
		  END; 

  ELSE IF (P_Level = 2)
     THEN
       BEGIN
        OPEN ReportDetails FOR
        SELECT PROFITCENTER_RPRCTR,
        SUM(CompanyCurrency_HSL) AS Total FROM GLPCP WHERE TABFLAG = 'Actual'
        AND MONTHS = v_startDate AND FISCALYEAR_RYEAR = v_fiscalyear AND
        (NEWF2 = P_Head OR NEWF3 = P_Head OR NEWF4 = P_Head) 
        AND ACCOUNTNUMBER_RACCT = P_Account
        GROUP BY PROFITCENTER_RPRCTR ORDER BY PROFITCENTER_RPRCTR ASC;
       END;
  
  ELSE IF (P_Level = 3)
    THEN
      BEGIN
        OPEN ReportDetails FOR
        SELECT COSTCENTER_KOSTL,
        SUM(CompanyCurrency_HSL) AS Total FROM GLPCP WHERE TABFLAG = 'Actual'
        AND MONTHS = v_startDate AND FISCALYEAR_RYEAR = v_fiscalyear AND
        (NEWF2 = P_Head OR NEWF3 = P_Head OR NEWF4 = P_Head) 
			  AND ACCOUNTNUMBER_RACCT = P_Account AND PROFITCENTER_RPRCTR = P_Profit
			  GROUP BY COSTCENTER_KOSTL ORDER BY COSTCENTER_KOSTL ASC;
      END;

  ELSE IF (P_Level = 4)
    THEN
      BEGIN
        OPEN ReportDetails FOR
        SELECT ORDERNUMBER,
        SUM(CompanyCurrency_HSL) AS Total FROM GLPCP WHERE TABFLAG = 'Actual'
        AND MONTHS = v_startDate AND
        FISCALYEAR_RYEAR = v_fiscalyear AND
        (NEWF2 = P_Head OR NEWF3 = P_Head OR NEWF4 = P_Head) 
			  AND ACCOUNTNUMBER_RACCT = P_Account AND PROFITCENTER_RPRCTR = P_Profit
        AND COSTCENTER_KOSTL = P_CostCenter
			  GROUP BY ORDERNUMBER ORDER By ORDERNUMBER ASC;
      END;

  ELSE
    BEGIN
	    OPEN ReportDetails FOR
      SELECT ACCOUNTNUMBER_RACCT,PROFITCENTER_RPRCTR,COSTCENTER_KOSTL,ORDERNUMBER,
	  	SUM(CompanyCurrency_HSL) AS Total FROM GLPCP WHERE TABFLAG='Actual'
		  AND MONTHS = v_startDate AND FISCALYEAR_RYEAR = v_fiscalyear AND 
		  (NEWF2 = P_Head or NEWF3 = P_Head or NEWF4 = P_Head)
		  GROUP BY ACCOUNTNUMBER_RACCT,PROFITCENTER_RPRCTR,COSTCENTER_KOSTL,ORDERNUMBER;
    END;
  END IF; --condition finished in level 1
  END IF; -- condition finished in level 2
  END IF; -- condition finished in level 3
  END IF; -- condition finished in level 4
    END;
END;
/

-- ----------------------------
-- Procedure structure for "FETCHACTUALSJWDATA"
-- ----------------------------
CREATE OR REPLACE PROCEDURE "FETCHACTUALSJWDATA" (P_Head IN NVARCHAR2, P_Account IN NVARCHAR2, 
P_Profit IN NVARCHAR2, P_CostCenter IN NVARCHAR2, P_Level IN NVARCHAR2,
ReportDetails OUT TYPES.cursortype)
AS
BEGIN
	DECLARE
	v_startDate VARCHAR2(100);
  v_fiscalyear VARCHAR2(100);
		BEGIN
		SELECT DEFAULTFILTERVALUE INTO v_startDate FROM FILTERTABLE WHERE QUERYID = 201 
		AND FILTERNAME = '{Month}';
    
    SELECT Max(FISCALYEAR_RYEAR) INTO v_fiscalyear FROM GLPCP;

    IF (P_Level = 1)
    THEN
      BEGIN
		   OPEN ReportDetails FOR
		   SELECT ACCOUNTNUMBER_RACCT,
		   SUM(CompanyCurrency_HSL) AS Total FROM GLPCP WHERE TABFLAG='Actual'
       AND Origin_RHOART IN('03','05') AND MONTHS = v_startDate 
       AND FISCALYEAR_RYEAR = v_fiscalyear AND 
		   (NEWF2 = P_Head or NEWF3 = P_Head or NEWF4 = P_Head) 
			 GROUP BY ACCOUNTNUMBER_RACCT ORDER BY ACCOUNTNUMBER_RACCT ASC;
		  END; 

  ELSE IF (P_Level = 2)
     THEN
       BEGIN
        OPEN ReportDetails FOR
        SELECT PROFITCENTER_RPRCTR,
        SUM(CompanyCurrency_HSL) AS Total FROM GLPCP WHERE TABFLAG = 'Actual'
				AND Origin_RHOART IN('03','05') AND MONTHS = v_startDate 
				AND FISCALYEAR_RYEAR = v_fiscalyear AND 
				(NEWF2 = P_Head OR NEWF3 = P_Head OR NEWF4 = P_Head) 
        AND ACCOUNTNUMBER_RACCT = P_Account 
			  GROUP BY PROFITCENTER_RPRCTR ORDER BY PROFITCENTER_RPRCTR ASC;
       END;
  
  ELSE IF (P_Level = 3)
    THEN
      BEGIN
        OPEN ReportDetails FOR
        SELECT COSTCENTER_KOSTL,
        SUM(CompanyCurrency_HSL) AS Total FROM GLPCP WHERE TABFLAG = 'Actual'
				AND Origin_RHOART IN('03','05') AND MONTHS = v_startDate 
				AND FISCALYEAR_RYEAR = v_fiscalyear AND
        (NEWF2 = P_Head OR NEWF3 = P_Head OR NEWF4 = P_Head) 
			  AND ACCOUNTNUMBER_RACCT = P_Account AND PROFITCENTER_RPRCTR = P_Profit
			  GROUP BY COSTCENTER_KOSTL ORDER BY COSTCENTER_KOSTL ASC;
      END;

  ELSE IF (P_Level = 4)
    THEN
      BEGIN
        OPEN ReportDetails FOR
        SELECT ORDERNUMBER,
        SUM(CompanyCurrency_HSL) AS Total FROM GLPCP WHERE TABFLAG = 'Actual'
        AND MONTHS = v_startDate AND  Origin_RHOART IN('03','05') AND
        FISCALYEAR_RYEAR = v_fiscalyear AND
        (NEWF2 = P_Head OR NEWF3 = P_Head OR NEWF4 = P_Head) 
			  AND ACCOUNTNUMBER_RACCT = P_Account AND PROFITCENTER_RPRCTR = P_Profit
        AND COSTCENTER_KOSTL = P_CostCenter
			  GROUP BY ORDERNUMBER ORDER BY ORDERNUMBER ASC;
      END;

  ELSE
    BEGIN
	    OPEN ReportDetails FOR
      SELECT ACCOUNTNUMBER_RACCT,PROFITCENTER_RPRCTR,COSTCENTER_KOSTL,ORDERNUMBER,
	  	SUM(CompanyCurrency_HSL) AS Total FROM GLPCP WHERE TABFLAG='Actual'
		  AND MONTHS = v_startDate AND FISCALYEAR_RYEAR = v_fiscalyear AND 
		  (NEWF2 = P_Head or NEWF3 = P_Head or NEWF4 = P_Head)
		  GROUP BY ACCOUNTNUMBER_RACCT,PROFITCENTER_RPRCTR,COSTCENTER_KOSTL,ORDERNUMBER;
    END;
  END IF; --condition finished in level 1
  END IF; -- condition finished in level 2
  END IF; -- condition finished in level 3
  END IF; -- condition finished in level 4
    END;
END;
/

-- ----------------------------
-- Procedure structure for "FETCHANNUALDATA"
-- ----------------------------
CREATE OR REPLACE PROCEDURE "FETCHANNUALDATA" (P_Head IN NVARCHAR2, P_Account IN NVARCHAR2, 
P_Profit IN NVARCHAR2, P_CostCenter IN NVARCHAR2, P_Level IN INT, 
ReportDetails OUT TYPES.cursortype)
AS
BEGIN
	DECLARE
	v_startDate VARCHAR2(100);
		BEGIN
		SELECT DEFAULTFILTERVALUE INTO v_startDate FROM FILTERTABLE WHERE QUERYID = 201 
		AND FILTERNAME = '{Month}';
    --start level one if condition
  IF (P_Level = 1)
    THEN
      BEGIN
		   OPEN ReportDetails FOR
		   SELECT ACCOUNTNUMBER_RACCT,
		   SUM(CompanyCurrency_HSL) AS Total FROM GLPCP WHERE TABFLAG='Budget'
		   AND PRODUCT !='JJ' AND MONTHS = v_startDate AND 
		   FISCALYEAR_RYEAR=(SELECT Max(FISCALYEAR_RYEAR) FROM GLPCP) AND 
		   (NEWF2 = P_Head or NEWF3 = P_Head or NEWF4 = P_Head)
		   GROUP BY ACCOUNTNUMBER_RACCT ORDER BY ACCOUNTNUMBER_RACCT ASC;
		  END; 

  ELSE IF (P_Level = 2)
     THEN
       BEGIN
        OPEN ReportDetails FOR
        SELECT PROFITCENTER_RPRCTR,
        SUM(CompanyCurrency_HSL) AS Total FROM GLPCP WHERE TABFLAG = 'Budget'
        AND PRODUCT != 'JJ' AND MONTHS = v_startDate AND
        FISCALYEAR_RYEAR=(SELECT MAX(FISCALYEAR_RYEAR) FROM GLPCP) AND
        (NEWF2 = P_Head OR NEWF3 = P_Head OR NEWF4 = P_Head) 
        AND ACCOUNTNUMBER_RACCT = P_Account
        GROUP BY PROFITCENTER_RPRCTR ORDER BY PROFITCENTER_RPRCTR ASC;
       END;
  
  ELSE IF (P_Level = 3)
    THEN
      BEGIN
        OPEN ReportDetails FOR
        SELECT COSTCENTER_KOSTL,
        SUM(CompanyCurrency_HSL) AS Total FROM GLPCP WHERE TABFLAG = 'Budget'
        AND PRODUCT != 'JJ' AND MONTHS = v_startDate AND
        FISCALYEAR_RYEAR=(SELECT MAX(FISCALYEAR_RYEAR) FROM GLPCP) AND
        (NEWF2 = P_Head OR NEWF3 = P_Head OR NEWF4 = P_Head) 
			  AND ACCOUNTNUMBER_RACCT = P_Account AND PROFITCENTER_RPRCTR = P_Profit
			  GROUP BY COSTCENTER_KOSTL ORDER BY COSTCENTER_KOSTL ASC;
      END;

  ELSE IF (P_Level = 4)
    THEN
      BEGIN
        OPEN ReportDetails FOR
        SELECT ORDERNUMBER,
        SUM(CompanyCurrency_HSL) AS Total FROM GLPCP WHERE TABFLAG = 'Budget'
        AND PRODUCT != 'JJ' AND MONTHS = v_startDate AND
        FISCALYEAR_RYEAR=(SELECT MAX(FISCALYEAR_RYEAR) FROM GLPCP) AND
        (NEWF2 = P_Head OR NEWF3 = P_Head OR NEWF4 = P_Head) 
			  AND ACCOUNTNUMBER_RACCT = P_Account AND PROFITCENTER_RPRCTR = P_Profit
        AND COSTCENTER_KOSTL = P_CostCenter
			  GROUP BY ORDERNUMBER ORDER BY ORDERNUMBER ASC;
      END;

  ELSE
    BEGIN
	    OPEN ReportDetails FOR
      SELECT ACCOUNTNUMBER_RACCT,PROFITCENTER_RPRCTR,COSTCENTER_KOSTL,ORDERNUMBER,
	  	SUM(CompanyCurrency_HSL) AS Total FROM GLPCP WHERE TABFLAG='Budget'
		  AND PRODUCT !='JJ' AND MONTHS = v_startDate AND 
		  FISCALYEAR_RYEAR=(SELECT Max(FISCALYEAR_RYEAR) FROM GLPCP) AND 
		  (NEWF2 = P_Head or NEWF3 = P_Head or NEWF4 = P_Head)
		  GROUP BY ACCOUNTNUMBER_RACCT,PROFITCENTER_RPRCTR,COSTCENTER_KOSTL,ORDERNUMBER;
    END;
  END IF; --condition finished in level 1
  END IF; -- condition finished in level 2
  END IF; -- condition finished in level 3
  END IF; -- condition finished in level 4
    END;
END;
/

-- ----------------------------
-- Procedure structure for "FETCHREPORTDATA"
-- ----------------------------
CREATE OR REPLACE PROCEDURE "FETCHREPORTDATA" (P_Id IN INT, P_Condition IN VARCHAR2, P_UserId IN INT,
ReportDetails OUT TYPES.cursortype, TableConfig OUT TYPES.cursortype, Title OUT TYPES.cursortype)
AS
BEGIN
	DECLARE
	v_startDate VARCHAR2(100); -- declare
	v_endDate VARCHAR2(100);
	v_branch VARCHAR2(100);
	v_result VARCHAR2(4000);
	v_title VARCHAR2(100); 
	v_id INT;
	v_selbranch VARCHAR2(100);
  v_selstate VARCHAR2(100);
	v_selNewf2 VARCHAR2(100);
	v_selNewf3 VARCHAR2(100);
	v_selNewf4 VARCHAR2(100);
	v_selAccount VARCHAR2(100);
	v_selProduct VARCHAR2(100);
	v_selBusiness VARCHAR2(100);
  v_State VARCHAR2(100);
	v_Newf2 VARCHAR2(100);
	v_Newf3 VARCHAR2(100);
	v_Newf4 VARCHAR2(100);
	v_Account VARCHAR2(100);
	v_Product VARCHAR2(100);
	v_Business VARCHAR2(100);
	v_dimensions VARCHAR2(1000);
	v_expression VARCHAR2(100);
  v_monthname VARCHAR2(100);
	v_qry VARCHAR2(20000);
	v_index			INT;
	BEGIN
	 IF(P_Id = 0)
   THEN
		BEGIN
			v_qry := '';
			v_index := 0;
      SELECT defaultfiltervalue INTO v_dimensions FROM filtertable WHERE  queryid = 61
      AND filtername = '{Dimensions}';

      SELECT defaultfiltervalue INTO v_expression FROM filtertable WHERE  queryid = 61
      AND filtername = '{Expression}';   

      SELECT defaultfiltervalue INTO v_monthname FROM filtertable WHERE queryid = 61
			AND filtername = '{MonthName}';

			OPEN TableConfig FOR SELECT DEFAULTFILTERVALUE FROM FILTERTABLE WHERE QUERYID = 61 AND COLUMNNAME = 'DIMENSIONS';
			OPEN Title FOR 'SELECT Title FROM queryTable WHERE ID in (' || v_expression || ')';

			FOR rec IN
      (
        SELECT Regexp_substr(v_expression,'[^,]+', 1, LEVEL) AS SPLITVALUES
        FROM   dual
        CONNECT BY Regexp_substr(v_expression, '[^,]+', 1, LEVEL) IS NOT NULL)
        LOOP
          --DBMS_OUTPUT.PUT_LINE(rec.SPLITVALUES);
				v_index := v_index + 1;
        SELECT multiple_replace((SELECT query FROM   querytable
               WHERE  id = rec.splitvalues), NEW t_text( '''{Dimensions}''','{MonthName}'), NEW t_text( v_index || ',' || v_dimensions,v_monthname ) )
          INTO   v_result FROM   dual;
          v_qry := v_qry || v_result || ' UNION ALL ';
        END LOOP;
				v_qry := SUBSTR(v_qry, 1, LENGTH(v_qry) - LENGTH(' UNION ALL '));
				v_qry := 'SELECT * FROM (' || v_qry || ')ORDER BY SORTID ASC';
			OPEN reportdetails FOR v_qry;
		END;
   ELSE
		IF(P_Condition = 'Expand')
		THEN
			BEGIN
				SELECT BRANCHTABLE.BRANCHNAME INTO v_branch FROM USERS LEFT JOIN BRANCHTABLE ON USERS.BRANCH = BRANCHTABLE.ID WHERE USERS.ID = P_UserId;

				IF (v_branch = 'All') THEN
					BEGIN
					v_selbranch := '''{State_Link}''';
					v_branch := 'STATECODE';
					END;
				ELSE
					v_selbranch := '{State_Link}';
				END IF;
				
				SELECT DEFAULTFILTERVALUE INTO v_startDate FROM FILTERTABLE WHERE QUERYID = P_Id AND FILTERNAME = '{StartDate}';
				SELECT DEFAULTFILTERVALUE INTO v_endDate FROM FILTERTABLE WHERE QUERYID = P_Id AND FILTERNAME = '{EndDate}';
				SELECT multiple_replace( (SELECT QUERY FROM QUERYTABLE WHERE ID = P_Id),
                       NEW t_text( '{StartDate}', '{EndDate}', v_selbranch),
                       NEW t_text( v_startDate, v_endDate, v_branch )
                    ) INTO v_result FROM dual;
				OPEN ReportDetails FOR v_result;
				OPEN TableConfig FOR SELECT RowFieldName, ColumnFieldName, AggregateFiledName FROM TableConfiguration WHERE QueryId = P_Id;
				OPEN Title FOR SELECT Title FROM queryTable WHERE ID = P_Id;
				--EXECUTE IMMEDIATE  v_result INTO ReportDetails;
			END;

			ELSE IF (P_Condition = 'OPEX')
			THEN
				BEGIN

					SELECT DEFAULTFILTERVALUE INTO v_startDate FROM FILTERTABLE WHERE QUERYID = P_Id AND FILTERNAME = '{Month}';
					SELECT DEFAULTFILTERVALUE INTO v_endDate FROM FILTERTABLE WHERE QUERYID = P_Id AND FILTERNAME = '{period}';
          SELECT DEFAULTFILTERVALUE INTO v_State FROM FILTERTABLE WHERE QUERYID = P_Id AND FILTERNAME = '{State}';

/* Kumaran Latest Update */
         /* SELECT DEFAULTFILTERVALUE INTO v_Newf2 FROM FILTERTABLE WHERE QUERYID = P_Id AND FILTERNAME = '{MainGroup}';
					SELECT DEFAULTFILTERVALUE INTO v_Newf3 FROM FILTERTABLE WHERE QUERYID = P_Id AND FILTERNAME = '{SubAGroup}';
					SELECT DEFAULTFILTERVALUE INTO v_Newf4 FROM FILTERTABLE WHERE QUERYID = P_Id AND FILTERNAME = '{SubBGroup}';
					SELECT DEFAULTFILTERVALUE INTO v_Account FROM FILTERTABLE WHERE QUERYID = P_Id AND FILTERNAME = '{AccNumber}';
					SELECT DEFAULTFILTERVALUE INTO v_Product FROM FILTERTABLE WHERE QUERYID = P_Id AND FILTERNAME = '{Product}';
					SELECT DEFAULTFILTERVALUE INTO v_Business FROM FILTERTABLE WHERE QUERYID = P_Id AND FILTERNAME = '{BusinessArea}';


			 IF(v_Newf2 = 'All') THEN
					BEGIN
					v_selNewf2 := '''{MainGroup}''';
					v_Newf2 := 'NEWF2';
					END;
					ELSE
					v_selNewf2 := '{MainGroup}';
				END IF;

				IF(v_Newf3 = 'All') THEN
					BEGIN
					v_selNewf3 := '''{SubAGroup}''';
					v_Newf3 := 'NEWF3';
					END;
					ELSE
					v_selNewf3 := '{SubAGroup}';
				END IF;

				IF(v_Newf4 = 'All') THEN
					BEGIN
					v_selNewf4 := '''{SubBGroup}''';
					v_Newf4 := 'NEWF4';
					END;
					ELSE
					v_selNewf4 := '{SubBGroup}';
				END IF;

				IF(v_Account = 'All') THEN
					BEGIN
					v_selAccount := '''{AccNumber}''';
					v_Account := 'ACCOUNTNUMBER_RACCT';
					END;
					ELSE
					v_selAccount := '{AccNumber}';
				END IF;

				IF(v_Product = 'All') THEN
					BEGIN
					v_selProduct := '''{Product}''';
					v_Product := 'PRODUCT';
					END;
					ELSE
					v_selProduct := '{Product}';
				END IF;

				IF(v_Business = 'All') THEN
					BEGIN
					v_selBusiness := '''{BusinessArea}''';
					v_Business := 'BUSINESSAREA_GSBER';
					END;
					ELSE
					v_selBusiness := '{BusinessArea}';
				END IF;
*/
/*End Update*/
       IF (v_state = 'All') THEN
					BEGIN
					v_selstate := '''{State}''';
					v_state := 'State';
					END;
  				ELSE
					v_selstate := '{State}';
				END IF;

					/*SELECT multiple_replace( (SELECT QUERY FROM QUERYTABLE WHERE ID = P_Id),
                       NEW t_text( '{Month}', '{period}',v_selstate,v_selNewf2,v_selNewf3,v_selNewf4,v_selAccount,v_selProduct,v_selBusiness),
                       NEW t_text( v_startDate, v_endDate, v_State,v_Newf2,v_Newf3,v_Newf4,v_Account,v_Product,v_Business)
                    ) INTO v_result FROM dual;
					OPEN ReportDetails FOR v_result;*/

          SELECT multiple_replace( (SELECT QUERY FROM QUERYTABLE WHERE ID = P_Id),
                       NEW t_text( '{Month}', '{period}',v_selstate),
                       NEW t_text( v_startDate, v_endDate, v_State)
                    ) INTO v_result FROM dual;
					OPEN ReportDetails FOR v_result;
					OPEN TableConfig FOR SELECT RowFieldName, ColumnFieldName, AggregateFiledName FROM TableConfiguration WHERE QueryId = P_Id;
					OPEN Title FOR SELECT Title FROM queryTable WHERE ID = P_Id;
				END;

		ELSE
			BEGIN
				SELECT Title INTO v_title FROM QUERYTABLE WHERE ID = P_Id;
				v_title := v_title || ' Collapse';
				SELECT ID INTO v_id FROM QUERYTABLE WHERE TITLE = v_title;

				SELECT BRANCHTABLE.BRANCHNAME INTO v_branch FROM USERS LEFT JOIN BRANCHTABLE ON USERS.BRANCH = BRANCHTABLE.ID WHERE USERS.ID = P_UserId;

				IF (v_branch = 'All') THEN
					BEGIN
					v_selbranch := '''{State_Link}''';
					v_branch := 'STATECODE';
					END;
				ELSE
					v_selbranch := '{State_Link}';
				END IF;

				SELECT DEFAULTFILTERVALUE INTO v_startDate FROM FILTERTABLE WHERE QUERYID = v_id AND FILTERNAME = '{StartDate}';
				SELECT DEFAULTFILTERVALUE INTO v_endDate FROM FILTERTABLE WHERE QUERYID = v_id AND FILTERNAME = '{EndDate}';
				SELECT multiple_replace( (SELECT QUERY FROM QUERYTABLE WHERE ID = v_id),
                       NEW t_text( '{StartDate}', '{EndDate}', v_selbranch),
                       NEW t_text( v_startDate, v_endDate, v_branch )
                    ) INTO v_result FROM dual;
				OPEN ReportDetails FOR v_result;
				OPEN TableConfig FOR SELECT RowFieldName, ColumnFieldName, AggregateFiledName FROM TableConfiguration WHERE QueryId = v_id;
				OPEN Title FOR SELECT Title FROM queryTable WHERE ID = v_id;
				--EXECUTE IMMEDIATE  v_result INTO ReportDetails; 
				END;
			END IF;
		 END IF;
		END IF;
	END;
END;


/

-- ----------------------------
-- Procedure structure for "FETCHTRENDDATA"
-- ----------------------------
CREATE OR REPLACE PROCEDURE "FETCHTRENDDATA" (P_Head IN NVARCHAR2, P_Account IN NVARCHAR2, 
P_Profit IN NVARCHAR2, P_CostCenter IN NVARCHAR2, P_Level IN INT,
ReportDetails OUT TYPES.cursortype)
AS
BEGIN
	DECLARE
	v_startDate VARCHAR2(100);
  v_fiscalyear VARCHAR2(100);
		BEGIN
		SELECT DEFAULTFILTERVALUE INTO v_startDate FROM FILTERTABLE WHERE QUERYID = 201 
		AND FILTERNAME = '{Month}';
    
    SELECT Max(FISCALYEAR_RYEAR) INTO v_fiscalyear FROM GLPCP;

    IF (P_Level = 1)
    THEN
      BEGIN
		   OPEN ReportDetails FOR
		   WITH tBudget AS (  
			 select ACCOUNTNUMBER_RACCT, sum(CompanyCurrency_HSL) as Budget from GLPCP where Tabflag='Budget' 
			 and Product !='JJ' and MONTHS=v_startDate AND (NEWF2 = P_Head or NEWF3 = P_Head or NEWF4 = P_Head) and FISCALYEAR_RYEAR=(select Max(FISCALYEAR_RYEAR) from glpcp) group by ACCOUNTNUMBER_RACCT 
			 ), tActual  as(select ACCOUNTNUMBER_RACCT, sum(CompanyCurrency_HSL) as Actual from GLPCP where Tabflag='Actual'  
			 and Product !='JJ' and MONTHS=v_startDate AND (NEWF2 = P_Head or NEWF3 = P_Head or NEWF4 = P_Head) and FISCALYEAR_RYEAR=(select Max(FISCALYEAR_RYEAR) from glpcp) 
       group by ACCOUNTNUMBER_RACCT), tJobWork as (
			 select ACCOUNTNUMBER_RACCT, sum(CompanyCurrency_HSL) as JobWork from GLPCP where (Origin_RHOART ='03' or ORIGIN_RHOART='05') AND (NEWF2 = P_Head or NEWF3 = P_Head or NEWF4 = P_Head)
			 and Product !='JJ' and MONTHS=v_startDate and FISCALYEAR_RYEAR=(select Max(FISCALYEAR_RYEAR) from glpcp) 
			 group by ACCOUNTNUMBER_RACCT ) select tBudget.ACCOUNTNUMBER_RACCT,
			 Round(NVL(tBudget.Budget,0),0) as Budget,
       Round(NVL(tActual.Actual,0),0) as Actual,
       Round(NVL(tJobWork.JobWork,0) ,0) as JobWork,
       Round((NVL(tActual.Actual,0)) - (NVL(tJobWork.JobWork,0)),0) as AdjustedActual,
       Round((NVL(tBUDGET.BUDGET,0) - NVL(tACTUAL.ACTUAL,0) - (NVL(tJobWork.JobWork,0))),0) as Variance
       from tBudget left join tActual ON tBUDGET.ACCOUNTNUMBER_RACCT=tActual.ACCOUNTNUMBER_RACCT 
       LEFT JOIN tJobWork on tBUDGET.ACCOUNTNUMBER_RACCT=tJobWork.ACCOUNTNUMBER_RACCT;
		  END; 

  ELSE IF (P_Level = 2)
     THEN
       BEGIN
        OPEN ReportDetails FOR
        WITH tBudget AS (  
				select PROFITCENTER_RPRCTR, sum(CompanyCurrency_HSL) as Budget from GLPCP where Tabflag='Budget' 
				and Product !='JJ' and MONTHS=v_startDate AND (NEWF2 = P_Head or NEWF3 = P_Head or NEWF4 = P_Head) AND ACCOUNTNUMBER_RACCT = P_Account and FISCALYEAR_RYEAR=(select Max(FISCALYEAR_RYEAR) from glpcp) group by PROFITCENTER_RPRCTR 
				), tActual  as(select PROFITCENTER_RPRCTR, sum(CompanyCurrency_HSL) as Actual from GLPCP where Tabflag='Actual'  
				and Product !='JJ' and MONTHS=v_startDate AND (NEWF2 = P_Head or NEWF3 = P_Head or NEWF4 = P_Head) and FISCALYEAR_RYEAR=(select Max(FISCALYEAR_RYEAR) from glpcp) AND ACCOUNTNUMBER_RACCT = P_Account
				group by PROFITCENTER_RPRCTR
				),tJobWork as (select PROFITCENTER_RPRCTR, sum(CompanyCurrency_HSL) as JobWork from GLPCP where (Origin_RHOART ='03' or ORIGIN_RHOART='05') AND (NEWF2 = P_Head or NEWF3 = P_Head or NEWF4 = P_Head)
				and Product !='JJ' and MONTHS=v_startDate and FISCALYEAR_RYEAR=(select Max(FISCALYEAR_RYEAR) from glpcp) AND ACCOUNTNUMBER_RACCT = P_Account
				group by PROFITCENTER_RPRCTR ) select tBudget.PROFITCENTER_RPRCTR, Round(NVL(tBudget.Budget,0),0) as Budget,
				Round(NVL(tActual.Actual,0),0) as Actual,
				Round(NVL(tJobWork.JobWork,0) ,0) as JobWork,
				Round((NVL(tActual.Actual,0)) - (NVL(tJobWork.JobWork,0)),0) as AdjustedActual,
				Round((NVL(tBUDGET.BUDGET,0) - NVL(tACTUAL.ACTUAL,0) - (NVL(tJobWork.JobWork,0))),0) as Variance
				from tBudget left join tActual ON
				tBUDGET.PROFITCENTER_RPRCTR=tActual.PROFITCENTER_RPRCTR 
				left join tJobWork on	
				tBUDGET.PROFITCENTER_RPRCTR=tJobWork.PROFITCENTER_RPRCTR;
       END;
  
  ELSE IF (P_Level = 3)
    THEN
      BEGIN
        OPEN ReportDetails FOR
        WITH tBudget AS (  
				select COSTCENTER_KOSTL, sum(CompanyCurrency_HSL) as Budget from GLPCP where Tabflag='Budget' 
				and Product !='JJ' and MONTHS=v_startDate AND (NEWF2 = P_Head or NEWF3 = P_Head or NEWF4 = P_Head) AND ACCOUNTNUMBER_RACCT = P_Account AND PROFITCENTER_RPRCTR = P_Profit and FISCALYEAR_RYEAR=(select Max(FISCALYEAR_RYEAR) from glpcp) group by COSTCENTER_KOSTL 
				), tActual  as(
				select COSTCENTER_KOSTL, sum(CompanyCurrency_HSL) as Actual from GLPCP where Tabflag='Actual'  
				and Product !='JJ' and MONTHS=v_startDate AND (NEWF2 = P_Head or NEWF3 = P_Head or NEWF4 = P_Head) and FISCALYEAR_RYEAR=(select Max(FISCALYEAR_RYEAR) from glpcp) AND ACCOUNTNUMBER_RACCT = P_Account AND PROFITCENTER_RPRCTR = P_Profit
				group by COSTCENTER_KOSTL ), tJobWork as (
				select COSTCENTER_KOSTL, sum(CompanyCurrency_HSL) as JobWork from GLPCP where (Origin_RHOART ='03' or ORIGIN_RHOART='05') AND (NEWF2 = P_Head or NEWF3 = P_Head or NEWF4 = P_Head)
				and Product !='JJ' and MONTHS=v_startDate and FISCALYEAR_RYEAR=(select Max(FISCALYEAR_RYEAR) from glpcp) AND ACCOUNTNUMBER_RACCT = P_Account AND PROFITCENTER_RPRCTR = P_Profit
				group by COSTCENTER_KOSTL) select tBudget.COSTCENTER_KOSTL, Round(NVL(tBudget.Budget,0),0) as Budget,
				Round(NVL(tActual.Actual,0),0) as Actual,
				Round(NVL(tJobWork.JobWork,0) ,0) as JobWork,
				Round((NVL(tActual.Actual,0)) - (NVL(tJobWork.JobWork,0)),0) as AdjustedActual,
				Round((NVL(tBUDGET.BUDGET,0) - NVL(tACTUAL.ACTUAL,0) - (NVL(tJobWork.JobWork,0))),0) as Variance
				from tBudget left join tActual ON
				tBUDGET.COSTCENTER_KOSTL=tActual.COSTCENTER_KOSTL 
				left join tJobWork on
				tBUDGET.COSTCENTER_KOSTL=tJobWork.COSTCENTER_KOSTL ;
      END;

  ELSE IF (P_Level = 4)
    THEN
      BEGIN
        OPEN ReportDetails FOR
        WITH tBudget AS (  
				select ORDERNUMBER, sum(CompanyCurrency_HSL) as Budget from GLPCP where Tabflag='Budget' 
				and Product !='JJ' and MONTHS=v_startDate AND (NEWF2 = P_Head or NEWF3 = P_Head or NEWF4 = P_Head) AND ACCOUNTNUMBER_RACCT = P_Account AND PROFITCENTER_RPRCTR = P_Profit AND PROFITCENTER_RPRCTR = P_Profit and FISCALYEAR_RYEAR=(select Max(FISCALYEAR_RYEAR) from glpcp) group by ORDERNUMBER 
				), tActual  as( select ORDERNUMBER, sum(CompanyCurrency_HSL) as Actual from GLPCP where Tabflag='Actual'  
				and Product !='JJ' and MONTHS=v_startDate AND (NEWF2 = P_Head or NEWF3 = P_Head or NEWF4 = P_Head) and FISCALYEAR_RYEAR=(select Max(FISCALYEAR_RYEAR) from glpcp) AND ACCOUNTNUMBER_RACCT = P_Account AND PROFITCENTER_RPRCTR = P_Profit AND PROFITCENTER_RPRCTR = P_Profit
				group by ORDERNUMBER), tJobWork as ( select ORDERNUMBER, sum(CompanyCurrency_HSL) as JobWork from GLPCP where (Origin_RHOART ='03' or ORIGIN_RHOART='05') AND (NEWF2 = P_Head or NEWF3 = P_Head or NEWF4 = P_Head)
				and Product !='JJ' and MONTHS=v_startDate and FISCALYEAR_RYEAR=(select Max(FISCALYEAR_RYEAR) from glpcp) AND ACCOUNTNUMBER_RACCT = P_Account AND PROFITCENTER_RPRCTR = P_Profit AND PROFITCENTER_RPRCTR = P_Profit
				group by ORDERNUMBER ) select tBudget.ORDERNUMBER, Round(NVL(tBudget.Budget,0),0) as Budget,
				Round(NVL(tActual.Actual,0),0) as Actual,
				Round(NVL(tJobWork.JobWork,0) ,0) as JobWork,
				Round((NVL(tActual.Actual,0)) - (NVL(tJobWork.JobWork,0)),0) as AdjustedActual,
				Round((NVL(tBUDGET.BUDGET,0) - NVL(tACTUAL.ACTUAL,0) - (NVL(tJobWork.JobWork,0))),0) as Variance
				from tBudget left join tActual ON
				tBUDGET.ORDERNUMBER=tActual.ORDERNUMBER 
				left join tJobWork on
				tBUDGET.ORDERNUMBER=tJobWork.ORDERNUMBER ;
      END;

  ELSE
    BEGIN
	    OPEN ReportDetails FOR
      SELECT ACCOUNTNUMBER_RACCT,PROFITCENTER_RPRCTR,COSTCENTER_KOSTL,ORDERNUMBER,
	  	SUM(CompanyCurrency_HSL) AS Total FROM GLPCP WHERE TABFLAG='Actual'
		  AND MONTHS = v_startDate AND FISCALYEAR_RYEAR = v_fiscalyear AND 
		  (NEWF2 = P_Head or NEWF3 = P_Head or NEWF4 = P_Head)
		  GROUP BY ACCOUNTNUMBER_RACCT,PROFITCENTER_RPRCTR,COSTCENTER_KOSTL,ORDERNUMBER;
    END;
  END IF; --condition finished in level 1
  END IF; -- condition finished in level 2
  END IF; -- condition finished in level 3
  END IF; -- condition finished in level 4
    END;
END;
/

-- ----------------------------
-- Procedure structure for "GETCATEGORYDETAILS"
-- ----------------------------
CREATE OR REPLACE PROCEDURE "GETCATEGORYDETAILS" (P_Category IN VARCHAR2,CategoryReport OUT TYPES.cursortype)
AS
BEGIN
		IF(P_Category = 'MM') 
		THEN
			BEGIN
				OPEN CategoryReport FOR
				SELECT DISTINCT Report FROM CategoryDetails WHERE Category = P_Category;  
			END;
		ELSIF(P_Category = 'PP') 
		THEN
			BEGIN
					OPEN CategoryReport FOR
					SELECT DISTINCT Report FROM CategoryDetails WHERE Category = P_Category;  
			END;
		ELSIF(P_Category = 'Budget') 
		THEN
			BEGIN
					OPEN CategoryReport FOR
					SELECT DISTINCT Report FROM CategoryDetails WHERE Category = P_Category;  
			END;
		ELSE 
				OPEN CategoryReport FOR
				SELECT DISTINCT Category FROM CategoryDetails;	
		END IF;
END;


							 

/

-- ----------------------------
-- Procedure structure for "GETDEFAULTDATE"
-- ----------------------------
CREATE OR REPLACE PROCEDURE "GETDEFAULTDATE" (P_Id IN INT, P_Condition IN VARCHAR2, P_StartDate IN VARCHAR2, 
P_EndDate IN VARCHAR2, 
DefaultDates OUT TYPES.cursortype,
 P_Message OUT INT)
AS
BEGIN
DECLARE
    v_title VARCHAR2(100); 
		v_id INT;
	BEGIN
		IF(P_StartDate = 'GetDate' AND P_EndDate = 'GetDate')
		THEN
			BEGIN
					IF(P_Condition = 'Expand')
					THEN
						BEGIN
							OPEN DefaultDates FOR
							SELECT DefaultFilterValue FROM FilterTable WHERE QueryID = P_Id AND ColumnName = 'PRODDATE' ORDER BY ID ASC;
						END;
            ELSE IF(P_Condition = 'OPEX')
             THEN
               BEGIN
                  OPEN DefaultDates FOR
							    SELECT DefaultFilterValue FROM FilterTable WHERE QueryID = P_Id AND ColumnName = 'Months' ORDER BY ID ASC;
               END;
						ELSE IF(P_Condition = 'adhoc')
             THEN
               BEGIN
                  OPEN DefaultDates FOR
							    SELECT DefaultFilterValue FROM FilterTable WHERE QueryID = 61 AND ColumnName = 'LINKPOSTMONTHNAME' ORDER BY ID ASC;
               END;
					  ELSE
						BEGIN
							SELECT Title INTO v_title FROM QUERYTABLE WHERE ID = P_Id;
							v_title := v_title || ' Collapse';
							SELECT ID INTO v_id FROM QUERYTABLE WHERE TITLE = v_title;							
							OPEN DefaultDates FOR
							SELECT DefaultFilterValue FROM FilterTable WHERE QueryID = v_id AND ColumnName = 'PRODDATE' ORDER BY ID ASC;
						END;
						END IF;
            END IF;
			END IF;
		END;
		ELSE
			BEGIN
					IF(P_Condition = 'Expand')
					THEN
						BEGIN
							UPDATE FilterTable SET DefaultFilterValue = P_StartDate WHERE FilterName = '{StartDate}' AND QueryID = P_Id;
							UPDATE FilterTable SET DefaultFilterValue = P_EndDate WHERE FilterName = '{EndDate}' AND QueryID = P_Id;
							P_Message := sql%rowcount;
							
							OPEN DefaultDates FOR
							SELECT DefaultFilterValue FROM FilterTable WHERE QueryID = v_id AND ColumnName = 'PRODDATE' ORDER BY ID ASC;
						END;
           ELSIF(P_Condition ='OPEX')
           THEN
            BEGIN  
						   UPDATE FilterTable SET DefaultFilterValue = P_StartDate WHERE FilterName = '{Month}' AND QueryID = P_Id;
						   UPDATE FilterTable SET DefaultFilterValue = P_EndDate WHERE FilterName = '{period}' AND QueryID = P_Id;
               P_Message := sql%rowcount;
               OPEN DefaultDates FOR
						   SELECT DefaultFilterValue FROM FilterTable WHERE QueryID = P_Id AND ColumnName = 'Months' ORDER BY ID ASC;
						END;	
					 ELSIF(P_Condition ='adhoc')
           THEN
            BEGIN  
						   UPDATE FilterTable SET DefaultFilterValue = P_StartDate WHERE FilterName = '{MonthName}' AND QueryID = 61;
               P_Message := sql%rowcount;
               OPEN DefaultDates FOR
						   SELECT DefaultFilterValue FROM FilterTable WHERE QueryID = 61 AND ColumnName = 'LINKPOSTMONTHNAME' ORDER BY ID ASC;
						END;						
					ELSE
						BEGIN
							SELECT Title INTO v_title FROM QUERYTABLE WHERE ID = P_Id;
							v_title := v_title || ' Collapse';
							SELECT ID INTO v_id FROM QUERYTABLE WHERE TITLE = v_title;
							
							UPDATE FilterTable SET DefaultFilterValue = P_StartDate WHERE FilterName = '{StartDate}' AND QueryID = v_id;
							UPDATE FilterTable SET DefaultFilterValue = P_EndDate WHERE FilterName = '{EndDate}' AND QueryID = v_id;
							P_Message := sql%rowcount;

							OPEN DefaultDates FOR
							SELECT DefaultFilterValue FROM FilterTable WHERE QueryID = v_id AND ColumnName = 'PRODDATE' ORDER BY ID ASC;
						END;
						END IF;
			END;
		END IF;
	END;
END;

/

-- ----------------------------
-- Procedure structure for "GETDEFAULTSTATE"
-- ----------------------------
CREATE OR REPLACE PROCEDURE "GETDEFAULTSTATE" (P_Id IN INT, P_Condition IN VARCHAR2, P_State IN VARCHAR2,DefaultState OUT TYPES.cursortype,P_Message OUT INT)
AS
	BEGIN
		IF(P_State = 'All')
		THEN
			BEGIN
					IF(P_Condition = 'OPEX')
             THEN
               BEGIN
                  OPEN DefaultState FOR
							    SELECT DefaultFilterValue FROM FilterTable WHERE QueryID = P_Id AND ColumnName = 'State' ORDER BY ID ASC;
               END;
			END IF;
		END;
		ELSE
			BEGIN
           IF(P_Condition ='OPEX')
           THEN
            BEGIN  
						   UPDATE FilterTable SET DefaultFilterValue = P_State WHERE FilterName = '{State}' AND QueryID = P_Id;
               P_Message := sql%rowcount;
               OPEN DefaultState FOR
						   SELECT DefaultFilterValue FROM FilterTable WHERE QueryID = P_Id AND ColumnName = 'State' ORDER BY ID ASC;
						END;				
						END IF;
			END;
		END IF;
	END;


/

-- ----------------------------
-- Procedure structure for "GETUSERDETAILS"
-- ----------------------------
CREATE OR REPLACE PROCEDURE "GETUSERDETAILS" (P_UserId IN INT, UserReport OUT TYPES.cursortype)
AS
BEGIN
	OPEN UserReport FOR
	SELECT * FROM USERS WHERE ID = P_UserId;
END;
/

-- ----------------------------
-- Procedure structure for "LOGINSTATUS"
-- ----------------------------
CREATE OR REPLACE PROCEDURE "LOGINSTATUS" (P_UserName IN VARCHAR2, outName OUT INT,
outId OUT INT)
AS
BEGIN
	DECLARE cnt NUMBER;
	refCur VARCHAR2(50);
	BEGIN
		SELECT COUNT(1) INTO cnt FROM "USERS" WHERE USERID = P_UserName AND LOGINSTATUS = 1;
    --AND PASSWORD = P_Password  AND LOGINSTATUS = 1;
		IF( cnt = 0 )
		THEN
			BEGIN
			--DBMS_OUTPUT.put_line('Not Exists !');
			outName := '0';
			outId := '0';
			--string_opp(outName);
			END;
		ELSE
		SELECT USERTYPE INTO outName FROM "USERS" WHERE USERID = P_UserName;
		SELECT ID INTO outId FROM "USERS" WHERE USERID = P_UserName;
		END IF;
	END;
END;

/

-- ----------------------------
-- Procedure structure for "SETADHOCFILTERCONDITION"
-- ----------------------------
CREATE OR REPLACE PROCEDURE "SETADHOCFILTERCONDITION" (P_Condition IN VARCHAR, P_Data IN VARCHAR, P_Message OUT INT)
AS
BEGIN
	IF(P_Condition = 'Dimensions')
	THEN
	BEGIN
		UPDATE FILTERTABLE SET DEFAULTFILTERVALUE = P_Data WHERE QUERYID = 61 AND COLUMNNAME = 'DIMENSIONS';
		P_Message := sql%rowcount;
	END;
	ELSE
		UPDATE FILTERTABLE SET DEFAULTFILTERVALUE = P_Data WHERE QUERYID = 61 AND COLUMNNAME = 'EXPRESSION';
		P_Message := sql%rowcount;
	END IF;
END;
/

-- ----------------------------
-- Procedure structure for "UPDATEFILTER"
-- ----------------------------
CREATE OR REPLACE PROCEDURE "UPDATEFILTER" (P_Id IN INT, P_Condition IN NVARCHAR2, P_Value IN NVARCHAR2, P_Message OUT INT)
AS

   
	BEGIN
			IF(P_Condition = 'STATE')
					THEN
						BEGIN
							UPDATE FilterTable SET DefaultFilterValue = P_Value WHERE FilterName = '{STATE}'
                AND QueryID = P_Id;							
							P_Message := sql%rowcount;
							
      		  END;
      ELSIF(P_Condition ='NEWF2')
              THEN
                BEGIN
                UPDATE FilterTable SET DefaultFilterValue = P_Value WHERE FilterName = '{MainGroup}' AND QueryID = P_Id;							
							  P_Message := sql%rowcount;
                END;

      ELSIF(P_Condition = 'NEWF3')
              THEN
              BEGIN
                UPDATE FilterTable SET DefaultFilterValue = P_Value WHERE FilterName = '{SubAGroup}' AND QueryID = P_Id;							
							  P_Message := sql%rowcount;
                END;
              
       ELSIF(P_Condition = 'NEWF4')
              THEN
              BEGIN
                UPDATE FilterTable SET DefaultFilterValue = P_Value WHERE FilterName = '{SubBGroup}' AND QueryID = P_Id;							
							  P_Message := sql%rowcount;
                END;
        ELSIF(P_Condition = 'ACCOUNTNUMBER_RACCT')
              THEN
              BEGIN
                UPDATE FilterTable SET DefaultFilterValue = P_Value WHERE FilterName = '{AccNumber}' AND QueryID = P_Id;							
							  P_Message := sql%rowcount;
                END;
        ELSIF(P_Condition = 'PRODUCT')
              THEN
              BEGIN
                UPDATE FilterTable SET DefaultFilterValue = P_Value WHERE FilterName = '{Product}' AND QueryID = P_Id;							
							  P_Message := sql%rowcount;
                END;
          ELSIF(P_Condition = 'BUSINESSAREA_GSBER')
              THEN
              BEGIN
                UPDATE FilterTable SET DefaultFilterValue = P_Value WHERE FilterName = '{BusinessArea}' AND QueryID = P_Id;							
							  P_Message := sql%rowcount;
                END;
END IF;

END;
/

-- ----------------------------
-- Procedure structure for "UPDATESTATUS"
-- ----------------------------
CREATE OR REPLACE PROCEDURE "UPDATESTATUS" (P_UserId IN INT, P_Status IN CHAR,P_Message OUT INT)
AS
BEGIN
		UPDATE USERS SET LOGINSTATUS = P_Status WHERE ID = P_UserId;
			P_Message := sql%rowcount;
	-- routine body goes here, e.g.
	-- DBMS_OUTPUT.PUT_LINE('Navicat for Oracle');
END;

/

-- ----------------------------
-- Procedure structure for "VALIDATEEMAIL"
-- ----------------------------
CREATE OR REPLACE PROCEDURE "VALIDATEEMAIL" (EmailId IN NVARCHAR2, Status OUT VARCHAR2)
AS
BEGIN
DECLARE cnt NUMBER;
	BEGIN
		SELECT COUNT(1) INTO cnt FROM "USERS" WHERE EMAIL = EmailId;
		IF( cnt = 0 )
		THEN
			BEGIN
				Status := 'Failure';
			END;
		ELSE
				Status := 'Success';
		END IF;
	END;
END;

/

-- ----------------------------
-- Function structure for "MULTIPLE_REPLACE"
-- ----------------------------
CREATE OR REPLACE FUNCTION "MULTIPLE_REPLACE"
(in_text IN VARCHAR2, in_old IN t_text, in_new IN t_text)
RETURN VARCHAR2
AS
	v_result VARCHAR2(32767);
	BEGIN
	IF(in_old.COUNT <> in_new.COUNT) THEN
		RETURN in_text;
	END IF;
	v_result := in_text;
	FOR i IN 1 .. in_old.COUNT LOOP
		v_result := REPLACE(v_result, in_old(i), in_new(i));
	END LOOP;
	RETURN v_result;
	-- routine body goes here, e.g.
	-- DBMS_OUTPUT.PUT_LINE('Navicat for Oracle');
	-- RETURN NULL;
END;

/

-- ----------------------------
-- Sequence structure for "SEQ_BRANCH_ID"
-- ----------------------------
DROP SEQUENCE "SEQ_BRANCH_ID";
CREATE SEQUENCE "SEQ_BRANCH_ID"
 INCREMENT BY 1
 MINVALUE 1
 MAXVALUE 9999999999999999999999999999
 START WITH 21
 CACHE 20;

-- ----------------------------
-- Sequence structure for "SEQ_CATEGORY_ID"
-- ----------------------------
DROP SEQUENCE "SEQ_CATEGORY_ID";
CREATE SEQUENCE "SEQ_CATEGORY_ID"
 INCREMENT BY 1
 MINVALUE 1
 MAXVALUE 9999999999999999999999999999
 START WITH 47
 CACHE 20;

-- ----------------------------
-- Sequence structure for "SEQ_FILTERID"
-- ----------------------------
DROP SEQUENCE "SEQ_FILTERID";
CREATE SEQUENCE "SEQ_FILTERID"
 INCREMENT BY 1
 MINVALUE 1
 MAXVALUE 9999999999999999999999999999
 START WITH 691
 NOCACHE ;

-- ----------------------------
-- Sequence structure for "seq_order_id"
-- ----------------------------
DROP SEQUENCE "seq_order_id";
CREATE SEQUENCE "seq_order_id"
 INCREMENT BY 1
 MINVALUE 1
 MAXVALUE 9999999999999999999999999999
 START WITH 1
 CACHE 20;

-- ----------------------------
-- Sequence structure for "SEQ_ORDER_ID"
-- ----------------------------
DROP SEQUENCE "SEQ_ORDER_ID";
CREATE SEQUENCE "SEQ_ORDER_ID"
 INCREMENT BY 1
 MINVALUE 1
 MAXVALUE 9999999999999999999999999999
 START WITH 81
 CACHE 20;

-- ----------------------------
-- Sequence structure for "SEQ_QUERY_ID"
-- ----------------------------
DROP SEQUENCE "SEQ_QUERY_ID";
CREATE SEQUENCE "SEQ_QUERY_ID"
 INCREMENT BY 1
 MINVALUE 1
 MAXVALUE 9999999999999999999999999999
 START WITH 342
 NOCACHE ;

-- ----------------------------
-- Sequence structure for "SEQ_TABLECONFIGID"
-- ----------------------------
DROP SEQUENCE "SEQ_TABLECONFIGID";
CREATE SEQUENCE "SEQ_TABLECONFIGID"
 INCREMENT BY 1
 MINVALUE 1
 MAXVALUE 9999999999999999999999999999
 START WITH 467
 CACHE 20;

-- ----------------------------
-- Sequence structure for "SEQ_USERTYPE_ID"
-- ----------------------------
DROP SEQUENCE "SEQ_USERTYPE_ID";
CREATE SEQUENCE "SEQ_USERTYPE_ID"
 INCREMENT BY 1
 MINVALUE 1
 MAXVALUE 9999999999999999999999999999
 START WITH 21
 CACHE 20;
