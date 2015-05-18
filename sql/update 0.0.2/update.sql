-- Create sequence for files.
CREATE SEQUENCE FILE_SEQUENCE START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

-- Create file table.
CREATE TABLE T_FILE
(
  FILE_ID      BIGINT       NOT NULL,
  NAME         VARCHAR(256) NOT NULL,
  CONTENT_TYPE VARCHAR(256) NOT NULL,
  SIZE         BIGINT       NOT NULL,
  UPLOADED_BY  VARCHAR(64),
  CREATED      TIMESTAMP WITH TIME ZONE,
  DATA         BYTEA,
  CHECKSUM     BIGINT       NOT NULL,
  CONSTRAINT FILE_PKEY PRIMARY KEY (FILE_ID)
);