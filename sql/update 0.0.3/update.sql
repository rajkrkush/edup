DROP VIEW public.v_student_balance RESTRICT;
DROP TABLE public.student_balance;
DROP SEQUENCE public.student_balance_sequence RESTRICT;

DROP VIEW public.v_students RESTRICT;
DROP TABLE public.student_properties;
DROP TABLE public.students_version_mapping;
DROP TABLE public.students;

DROP SEQUENCE public.student_id_sequence RESTRICT;
DROP SEQUENCE public.student_property_sequence RESTRICT;
DROP SEQUENCE public.student_version_sequence RESTRICT;
DROP FUNCTION public.getstudentid();
DROP FUNCTION public.update_current_student_version();


-- Create sequence for students.
CREATE SEQUENCE STUDENT_ID_SEQUENCE START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

-- Create sequence for students.
CREATE SEQUENCE STUDENT_VERSION_SEQUENCE START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
-- Create file table.
CREATE TABLE STUDENTS
(
  STUDENT_VERSION_ID BIGINT NOT NULL DEFAULT NEXTVAL('STUDENT_VERSION_SEQUENCE'),
  STUDENT_ID         BIGINT      NOT NULL,
  NAME               VARCHAR(64) NOT NULL,
  LAST_NAME          VARCHAR(64) NOT NULL,
  CREATED            TIMESTAMP WITH TIME ZONE,
  CONSTRAINT STUDENT_PKEY PRIMARY KEY (STUDENT_VERSION_ID)
);

-- Create sequence for student properties.
CREATE SEQUENCE STUDENT_PROPERTY_SEQUENCE START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
CREATE TABLE STUDENT_PROPERTIES (
  PROPERTY_ID        BIGINT NOT NULL DEFAULT NEXTVAL('STUDENT_PROPERTY_SEQUENCE'),
  STUDENT_VERSION_FK BIGINT NOT NULL REFERENCES STUDENTS (STUDENT_VERSION_ID),
  NAME               VARCHAR(64) NOT NULL,
  VALUE              VARCHAR(512),
  ORDER_NUMBER       INTEGER DEFAULT 0,
  REFERENCE_ID       BIGINT,
  CONSTRAINT STUDENT_PROPERTY_PKEY PRIMARY KEY (PROPERTY_ID)
);

CREATE TABLE STUDENTS_VERSION_MAPPING (
  STUDENT_FK         BIGINT NOT NULL UNIQUE,
  STUDENT_VERSION_FK BIGINT NOT NULL UNIQUE REFERENCES STUDENTS (STUDENT_VERSION_ID),
  CONSTRAINT STUDENT_ID_PKEY PRIMARY KEY (STUDENT_FK)
);

CREATE OR REPLACE VIEW V_STUDENTS AS
  SELECT
    s.STUDENT_ID,
    s.STUDENT_VERSION_ID,
    s.NAME,
    s.LAST_NAME,
    s.CREATED
  FROM STUDENTS s, STUDENTS_VERSION_MAPPING s_id
  WHERE
    s.STUDENT_VERSION_ID = s_id.STUDENT_VERSION_FK;


-- UPDATE CURRENT STUDENT VERSION PROCEDURE --
CREATE OR REPLACE FUNCTION update_current_student_version()
  RETURNS TRIGGER
AS $update_student$
BEGIN
  IF EXISTS(SELECT 1
            FROM STUDENTS_VERSION_MAPPING
            WHERE STUDENTS_VERSION_MAPPING.student_fk = NEW.student_id)
  THEN
    UPDATE STUDENTS_VERSION_MAPPING
    SET STUDENT_VERSION_FK = NEW.STUDENT_VERSION_ID
    WHERE STUDENT_FK = NEW.STUDENT_ID;
  ELSE
    INSERT INTO STUDENTS_VERSION_MAPPING (STUDENT_FK, STUDENT_VERSION_FK) VALUES (NEW.STUDENT_ID, NEW.STUDENT_VERSION_ID);
  END IF;

  RETURN NEW;
END;
$update_student$ LANGUAGE plpgsql;

CREATE TRIGGER update_student
AFTER INSERT ON STUDENTS
FOR EACH ROW
EXECUTE PROCEDURE update_current_student_version();


-- Generate student id --
CREATE OR REPLACE FUNCTION getStudentId()
  RETURNS BIGINT AS
  $$
  BEGIN
    RETURN nextval('student_id_sequence');
  END;
  $$ LANGUAGE plpgsql;

