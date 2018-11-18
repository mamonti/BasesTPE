CREATE OR REPLACE FUNCTION ReporteBadge (userDesde IN userTP.ID%type, userHasta IN userTP.ID%type) 
RETURNS void
AS $$

DECLARE
ID INT;
IDviejo INT;
rep userTP.reputation%type;
disp userTP.displayName%type;
bname badges.badgeName%type;
qtty INT;

mycursor CURSOR FOR
SELECT *
FROM
(SELECT userTP.ID AS ID, reputation, displayName, badgename, COUNT(badgename) AS qtty
FROM badges JOIN userTP ON badges.userID = userTP.ID
WHERE userID <= userHasta AND userID >= userDesde
GROUP BY userTP.ID, reputation, displayName, badgename
UNION 
SELECT userTP.ID AS ID, reputation, displayName, CASE badgeclass WHEN 1 THEN 'GOLD Badges:' WHEN 2 THEN 'SILVER Badges:' WHEN 3 THEN 'BRONZE Badges:' END AS badgename, COUNT(badgeclass) AS qtty
FROM badges JOIN userTP ON badges.userID = userTP.ID
WHERE userID <= userHasta AND userID >= userDesde
GROUP BY userTP.ID, reputation, displayName, badgeclass) AS auxiliar
ORDER BY ID;




BEGIN

OPEN mycursor;

PERFORM DBMS_OUTPUT.DISABLE();
PERFORM DBMS_OUTPUT.ENABLE();
PERFORM DBMS_OUTPUT.SERVEROUTPUT ('t'); 
PERFORM DBMS_OUTPUT.PUT_LINE ('BADGES REPORT');
PERFORM DBMS_OUTPUT.PUT_LINE ('ID       Display Name    Reputation      Badge Name      Qtty'); 
IDviejo := -10;

LOOP

FETCH mycursor INTO ID, rep, disp, bname, qtty;
EXIT WHEN NOT FOUND;
IF ID <> IDviejo THEN
IDViejo := ID;
PERFORM DBMS_OUTPUT.PUT_LINE ( ID::TEXT ||'     ' || disp ||'     ' || rep::TEXT ||'     ' || bname ||'     ' || qtty::TEXT);
ELSE 
PERFORM DBMS_OUTPUT.PUT_LINE ( bname ||'     ' || qtty::TEXT);
END IF;

END LOOP;

CLOSE mycursor;
 
END;

 $$ LANGUAGE plpgsql;
 

