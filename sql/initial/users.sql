
-------------------------------- TEST DATA ------------------------------------------

-- admin SHA-512-> 'x61Ey612Kl2gpFL56FT9weDnpSo4AV8j8+qx2AuTHdRyY036xxzTTrw10Wq3+4qQyB+XURPWx1ONxp3Y3pB37A=='

-- admin SHA-256-> 'jGl25bVBBBW96Qi9Te4V37Fnqchz/Eu4qB9vKrRIqRg='

-- Generate 'admin' SH256 password hash
-- java -cp $WILDFLY_HOME/modules/system/layers/base/org/picketbox/main/picketbox-4.0.21.Final.jar org.jboss.security.Base64Encoder admin SHA-256
-- java -cp /Users/artyom/Documents/Tools/wildfly-10.1.0.Final//modules/system/layers/base/org/picketbox/main/picketbox-4.9.6.Final.jar org.jboss.security.Base64Encoder admin SHA-256

INSERT INTO ACCOUNT (ID, USERNAME, STATUS, CREATED) VALUES (DEFAULT, '***', 'APPROVED', CURRENT_TIMESTAMP);
INSERT INTO ACCOUNT_VERSION (ID, ACCOUNT_FK, NAME, LAST_NAME, MAIL, CREATED) VALUES (DEFAULT, 1, '***', '***', '***', CURRENT_TIMESTAMP);
INSERT INTO CREDENTIAL_VERSION (ID, ACCOUNT_FK, PASSWORD, CREATED) VALUES (DEFAULT, 1, '***=', CURRENT_TIMESTAMP);
INSERT INTO USER_ROLE (ID, ACCOUNT_FK, ROLE, CREATED) VALUES (DEFAULT, 1, 'ADMIN', CURRENT_TIMESTAMP);
INSERT INTO USER_ROLE (ID, ACCOUNT_FK, ROLE, CREATED) VALUES (DEFAULT, 1, 'USER', CURRENT_TIMESTAMP);
UPDATE ACCOUNT SET ACCOUNT_VERSION_FK = 1, CREDENTIAL_VERSION_FK = 1 WHERE ID = 1;

INSERT INTO ACCOUNT (ID, USERNAME, STATUS, CREATED) VALUES (DEFAULT, '***', 'APPROVED', CURRENT_TIMESTAMP);
INSERT INTO ACCOUNT_VERSION (ID, ACCOUNT_FK, NAME, LAST_NAME, MAIL, CREATED) VALUES (DEFAULT, 2, '***', '***', '***', CURRENT_TIMESTAMP);
INSERT INTO CREDENTIAL_VERSION (ID, ACCOUNT_FK, PASSWORD, CREATED) VALUES (DEFAULT, 2, '***+f7SY=', CURRENT_TIMESTAMP);
INSERT INTO USER_ROLE (ID, ACCOUNT_FK, ROLE, CREATED) VALUES (DEFAULT, 2, 'USER', CURRENT_TIMESTAMP);
UPDATE ACCOUNT SET ACCOUNT_VERSION_FK = 2, CREDENTIAL_VERSION_FK = 2 WHERE ID = 2;
--
INSERT INTO ACCOUNT (ID, USERNAME, STATUS, CREATED) VALUES (DEFAULT, '***', 'APPROVED', CURRENT_TIMESTAMP);
INSERT INTO ACCOUNT_VERSION (ID, ACCOUNT_FK, NAME, LAST_NAME, MAIL, CREATED) VALUES (DEFAULT, 3, '***', '***', '***', CURRENT_TIMESTAMP);
INSERT INTO CREDENTIAL_VERSION (ID, ACCOUNT_FK, PASSWORD, CREATED) VALUES (DEFAULT, 3, '***', CURRENT_TIMESTAMP);
-- INSERT INTO USER_ROLE (ID, ACCOUNT_FK, ROLE, CREATED) VALUES (DEFAULT, 3, 'ADMIN', CURRENT_TIMESTAMP);
INSERT INTO USER_ROLE (ID, ACCOUNT_FK, ROLE, CREATED) VALUES (DEFAULT, 3, 'USER', CURRENT_TIMESTAMP);
UPDATE ACCOUNT SET ACCOUNT_VERSION_FK = 3, CREDENTIAL_VERSION_FK = 3 WHERE ID = 3;

---------------------------------------------------------------------------------------