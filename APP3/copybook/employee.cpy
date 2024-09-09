      ******************************************************************
      * DCLGEN TABLE(EMP1.EMPLOYEE)                                    *
      *        LIBRARY(ADCDS.SPUFI.COBOL(DCLGEN9))                     *
      *        LANGUAGE(COBOL)                                         *
      *        QUOTE                                                   *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE EMP1.EMPLOYEE TABLE
           ( EMP_ID                         INTEGER NOT NULL,
             FIRST_NAME                     CHAR(15) NOT NULL,
             LAST_NAME                      CHAR(15) NOT NULL,
             SALARY                         INTEGER NOT NULL
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE EMP1.EMPLOYEE                      *
      ******************************************************************
       01  DCLEMPLOYEE.
           10 EMP-ID               PIC S9(9) USAGE COMP.
           10 FIRST-NAME           PIC X(15).
           10 LAST-NAME            PIC X(15).
           10 SALARY               PIC S9(9) USAGE COMP.
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 4       *
      ******************************************************************
