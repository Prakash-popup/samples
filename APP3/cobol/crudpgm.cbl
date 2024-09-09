       IDENTIFICATION DIVISION.
       PROGRAM-ID. CRUDPGM.

      ***************************************************
      *   CICS DB2 COBOL PROGRAM THAT PERFORMS CRUD     *
      *   OPERATIONS ON TABLE EMPLOYEE.                 *
      *   THE PROGRAM INTERACTS WITH THE CRUDSET MAPSET *
      *   TO RECEIVE AND SEND EMPLOYEE DATA.            *
      ***************************************************

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-SQLCODE  PIC -999.
       01 WS-COMMAREA PIC X(1).

       COPY DFHAID.
       COPY CRUDSET.


           EXEC SQL
             INCLUDE SQLCA
           END-EXEC.

           EXEC SQL
             INCLUDE EMPLOYEE
           END-EXEC.

       LINKAGE SECTION.

       01 DFHCOMMAREA PIC X(1).

       PROCEDURE DIVISION.

           EVALUATE TRUE

             WHEN EIBCALEN = ZERO
      *        LOGIC FOR THE FIRST CALL OF THE PROGRAM
               MOVE LOW-VALUES TO CRUDMAPO
               PERFORM SEND-MAP

             WHEN EIBAID = DFHCLEAR
      *        LOGIC FOR WHEN THE USER PRESSES THE CLEAR KEY
               MOVE LOW-VALUES TO CRUDMAPO
               PERFORM SEND-MAP

             WHEN EIBAID = DFHPF3
      *        LOGIC FOR WHEN THE USER PRESSES THE F3 KEY
               MOVE LOW-VALUES TO CRUDMAPO
               MOVE "END OF PROGRAM. PRESS CLEAR"
                 TO MSGO
               PERFORM SEND-MAP

               EXEC CICS
                 RETURN
               END-EXEC

             WHEN EIBAID = DFHENTER
      *        LOGIC FOR WHEN THE USER PRESSES THE ENTER KEY
               PERFORM RECEIVE-MAP

               EVALUATE ACTIONI
      *          CREATE
                 WHEN 1
                    IF FNAMEI = SPACES
                    OR LNAMEI = SPACES
                    OR SALARYI IS NOT NUMERIC
                       MOVE LOW-VALUES TO CRUDMAPO
                       MOVE 'FIRST NAME, LAST NAME AND SALARY ARE REQUIR
      -                     'ED.'
                         TO MSGO
                    ELSE
                       MOVE FNAMEI TO FIRST-NAME
                       MOVE LNAMEI TO LAST-NAME
                       MOVE SALARYI TO SALARY

                       EXEC SQL
                         INSERT INTO EMPLOYEE
                         (FIRST_NAME, LAST_NAME, SALARY)
                         VALUES
                         (:FIRST-NAME, :LAST-NAME, :SALARY)
                       END-EXEC

                       EVALUATE SQLCODE
                         WHEN 0
                           MOVE LOW-VALUES TO CRUDMAPO
                           MOVE 'EMPLOYEE CREATED' TO MSGO
                         WHEN OTHER
                           MOVE SQLCODE TO WS-SQLCODE
                           STRING 'AN ERROR OCCURRED. SQLCODE: '
                                   WS-SQLCODE
                                   DELIMITED BY SIZE
                                   INTO MSGO
                           END-STRING
                       END-EVALUATE
                    END-IF
      *          RETRIEVE
                 WHEN 2
                    IF EMPIDI IS NOT NUMERIC
                       MOVE LOW-VALUES TO CRUDMAPO
                       MOVE 'EMPLOYEE ID IS REQUIRED.' TO MSGO
                    ELSE
                       MOVE EMPIDI TO EMP-ID

                       EXEC SQL
                          SELECT FIRST_NAME,
                                 LAST_NAME,
                                 SALARY
                            INTO :FIRST-NAME,
                                 :LAST-NAME,
                                 :SALARY
                            FROM EMPLOYEE
                            WHERE EMP_ID = :EMP-ID
                       END-EXEC

                       EVALUATE SQLCODE
                         WHEN 0
                           MOVE LOW-VALUES TO CRUDMAPO
                           MOVE EMP-ID TO EMPIDO
                           MOVE FIRST-NAME TO FNAMEO
                           MOVE LAST-NAME TO LNAMEO
                           MOVE SALARY TO SALARYO
                           MOVE 'EMPLOYEE RETRIEVED' TO MSGO
                         WHEN 100
                           MOVE LOW-VALUES TO CRUDMAPO
                           MOVE 'EMPLOYEE NOT FOUND§' TO MSGO
                         WHEN OTHER
                           MOVE SQLCODE TO WS-SQLCODE
                           STRING 'AN ERROR OCCURRED. SQLCODE: '
                                   WS-SQLCODE
                                   DELIMITED BY SIZE
                                   INTO MSGO
                           END-STRING
                       END-EVALUATE
                    END-IF
      *          UPDATE
                 WHEN 3
                    IF FNAMEI = SPACES
                    OR LNAMEI = SPACES
                    OR SALARYI IS NOT NUMERIC
                    OR EMPIDI  IS NOT NUMERIC
                       MOVE LOW-VALUES TO CRUDMAPO
                       MOVE 'EMPLOYEE ID, FIRST NAME, LAST NAME AND SALA
      -                     'RY ARE REQUIRED.'
                         TO MSGO
                    ELSE
                       MOVE EMPIDI TO EMP-ID
                       MOVE FNAMEI TO FIRST-NAME
                       MOVE LNAMEI TO LAST-NAME
                       MOVE SALARYI TO SALARY

                       EXEC SQL
                          UPDATE EMPLOYEE
                          SET FIRST_NAME = :FIRST-NAME,
                              LAST_NAME = :LAST-NAME,
                              SALARY = :SALARY
                          WHERE EMP_ID = :EMP-ID
                       END-EXEC

                       EVALUATE SQLCODE
                         WHEN 0
                           MOVE LOW-VALUES TO CRUDMAPO
                           MOVE 'EMPLOYEE UPDATED' TO MSGO
                         WHEN 100
                           MOVE LOW-VALUES TO CRUDMAPO
                           MOVE 'EMPLOYEE NOT FOUND§' TO MSGO
                         WHEN OTHER
                           MOVE SQLCODE TO WS-SQLCODE
                           STRING 'AN ERROR OCCURRED. SQLCODE: '
                                   WS-SQLCODE
                                   DELIMITED BY SIZE
                                   INTO MSGO
                           END-STRING
                       END-EVALUATE
                    END-IF
      *          DELETE
                 WHEN 4
                    IF EMPIDI IS NOT NUMERIC
                       MOVE LOW-VALUES TO CRUDMAPO
                       MOVE 'EMPLOYEE ID IS REQUIRED.' TO MSGO
                    ELSE
                       MOVE EMPIDI TO EMP-ID

                       EXEC SQL
                          DELETE FROM EMPLOYEE
                          WHERE EMP_ID = :EMP-ID
                       END-EXEC

                       EVALUATE SQLCODE
                         WHEN 0
                           MOVE LOW-VALUES TO CRUDMAPO
                           MOVE 'EMPLOYEE DELETED' TO MSGO
                         WHEN 100
                           MOVE LOW-VALUES TO CRUDMAPO
                           MOVE 'EMPLOYEE NOT FOUND§' TO MSGO
                         WHEN OTHER
                           MOVE SQLCODE TO WS-SQLCODE
                           STRING 'AN ERROR OCCURRED. SQLCODE: '
                                   WS-SQLCODE
                                   DELIMITED BY SIZE
                                   INTO MSGO
                           END-STRING
                       END-EVALUATE
                    END-IF
                 WHEN OTHER
                    MOVE LOW-VALUES TO CRUDMAPO
                    MOVE "INVALID ACTION" TO MSGO
               END-EVALUATE

               PERFORM SEND-MAP

             WHEN OTHER
      *        LOGIC FOR ANY OTHER CASES
               MOVE LOW-VALUES TO CRUDMAPO
               MOVE "INVALID KEY PRESSED" TO MSGO
               PERFORM SEND-MAP

           END-EVALUATE

           EXEC CICS
              RETURN TRANSID('U01C')
              COMMAREA (WS-COMMAREA)
           END-EXEC.

       SEND-MAP.

           EXEC CICS SEND
              MAP    ('CRUDMAP')
              MAPSET ('CRUDSET')
              FROM   (CRUDMAPO)
              ERASE
           END-EXEC.

           EXIT.

       RECEIVE-MAP.

           EXEC CICS RECEIVE
              MAP    ('CRUDMAP')
              MAPSET ('CRUDSET')
              INTO   (CRUDMAPI)
           END-EXEC.

           EXIT.
