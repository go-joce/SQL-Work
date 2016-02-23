-- Assign5.sql
-- Jocelynne Gonzales
-- CSC 453 Winter 2016

--Report three weights found in the WEIGHTS table
--Output the name of each student in the STUDENT table and their overall score

CREATE OR REPLACE FUNCTION
	calculateGrade (score IN DECIMAL) RETURN VARCHAR
	AS
	grade VARCHAR(10);
	
	begin
	IF (score >= 90 AND score <= 100) THEN
		grade := 'A';
	ELSIF (score >= 80 AND score <= 89.99) THEN
		grade := 'B';
	ELSIF (score >= 65 AND score <= 79.99) THEN
		grade := 'C';
	ELSIF (score >= 0 AND score <= 64.99) THEN
		grade := 'F';
	end if;
	return grade;
	end;
/
	
declare

	studentID 				STUDENT.ID%type;
	studentName 			STUDENT.NAME%type;
	studentMidtermScore 	STUDENT.MIDTERM%type;
	studentFinalScore		STUDENT.FINAL%type;
	studentHomeworkScore	STUDENT.HOMEWORK%type;
	x NUMBER(2); 
	y NUMBER(2);
	z NUMBER(2);
	calculatedScore DECIMAL(3,1);
	
	--Sets up weight cursor
	cursor weightPtr is SELECT * FROM WEIGHTS;
	cursor studentPtr is SELECT * FROM STUDENT;
	
begin
	
	DBMS_OUTPUT.PUT_LINE ('Weights are ');
	
	
	open weightPtr;
	loop
		fetch weightPtr into x, y, z;
		
		if(weightPtr%found) then
				DBMS_OUTPUT.PUT_LINE( x|| ', ' || y || ', ' || z);
		else
				exit;
		end if;
	end loop;
	close weightPtr;
	
	
	open studentPtr;
	loop
		fetch studentPtr into studentID, studentName, studentMidtermScore, studentFinalScore, studentHomeworkScore;
		
		if(studentPtr%found) then
				calculatedScore := ((studentHomeworkScore*(z)+studentMidtermScore*(x)+studentFinalScore*(y))*.01);
				DBMS_OUTPUT.PUT_LINE( studentID ||' '|| studentName || ' '|| calculatedScore || ' Grade: ' || calculateGrade(calculatedScore));
		else
				exit;
		end if;
		end loop;
		
		close studentPtr;
	
end;
/