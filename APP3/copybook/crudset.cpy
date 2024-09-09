       01  CRUDMAPI.
           02  FILLER PIC X(12).
           02  EMPIDL    COMP  PIC  S9(4).
           02  EMPIDF    PICTURE X.
           02  FILLER REDEFINES EMPIDF.
             03 EMPIDA    PICTURE X.
           02  FILLER   PICTURE X(2).
           02  EMPIDI  PIC 9(2).
           02  ACTIONL    COMP  PIC  S9(4).
           02  ACTIONF    PICTURE X.
           02  FILLER REDEFINES ACTIONF.
             03 ACTIONA    PICTURE X.
           02  FILLER   PICTURE X(2).
           02  ACTIONI  PIC 9(1).
           02  FNAMEL    COMP  PIC  S9(4).
           02  FNAMEF    PICTURE X.
           02  FILLER REDEFINES FNAMEF.
             03 FNAMEA    PICTURE X.
           02  FILLER   PICTURE X(2).
           02  FNAMEI  PIC X(15).
           02  LNAMEL    COMP  PIC  S9(4).
           02  LNAMEF    PICTURE X.
           02  FILLER REDEFINES LNAMEF.
             03 LNAMEA    PICTURE X.
           02  FILLER   PICTURE X(2).
           02  LNAMEI  PIC X(15).
           02  SALARYL    COMP  PIC  S9(4).
           02  SALARYF    PICTURE X.
           02  FILLER REDEFINES SALARYF.
             03 SALARYA    PICTURE X.
           02  FILLER   PICTURE X(2).
           02  SALARYI  PIC 9(5).
           02  MSGL    COMP  PIC  S9(4).
           02  MSGF    PICTURE X.
           02  FILLER REDEFINES MSGF.
             03 MSGA    PICTURE X.
           02  FILLER   PICTURE X(2).
           02  MSGI  PIC X(79).
       01  CRUDMAPO REDEFINES CRUDMAPI.
           02  FILLER PIC X(12).
           02  FILLER PICTURE X(3).
           02  EMPIDC    PICTURE X.
           02  EMPIDH    PICTURE X.
           02  EMPIDO PIC 9(2).
           02  FILLER PICTURE X(3).
           02  ACTIONC    PICTURE X.
           02  ACTIONH    PICTURE X.
           02  ACTIONO PIC 9(1).
           02  FILLER PICTURE X(3).
           02  FNAMEC    PICTURE X.
           02  FNAMEH    PICTURE X.
           02  FNAMEO  PIC X(15).
           02  FILLER PICTURE X(3).
           02  LNAMEC    PICTURE X.
           02  LNAMEH    PICTURE X.
           02  LNAMEO  PIC X(15).
           02  FILLER PICTURE X(3).
           02  SALARYC    PICTURE X.
           02  SALARYH    PICTURE X.
           02  SALARYO PIC 9(5).
           02  FILLER PICTURE X(3).
           02  MSGC    PICTURE X.
           02  MSGH    PICTURE X.
           02  MSGO  PIC X(79).
