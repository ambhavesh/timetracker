namespace timetracker.db.schema;

entity EMPLOYEE {
    key EMP_ID     : Integer;
        FIRST_NAME : String;
        LAST_NAME  : String;
        GENDER     : String;
        EMAIL      : String;
        PHONE_NO   : Integer64;
        QR_CODE    : String;
};

entity PUNCHING_DETAILS {
    key EMP_CODE   : Association to EMPLOYEE;
    key PUNCH_DATE : String;
        PUNCH_IN   : String;
        PUNCH_OUT  : String;
};
