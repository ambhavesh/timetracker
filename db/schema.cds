namespace timetracker.db.schema;

entity EMPLOYEE {
    key EMP_ID      : Integer;
        FIRST_NAME  : String;
        LAST_NAME   : String;
        GENDER      : String;
        EMAIL       : String;
        EXPERIENCE  : Integer;
        DESIGNATION : String;
        MODULE      : String;
        MODULE_TYPE : String;
        PHONE_NO    : Integer64;
        QR_CODE     : String;
};

entity PUNCHING_DETAILS {
    key EMP_CODE   : Association to EMPLOYEE;
    key PUNCH_DATE : String;
        PUNCH_IN   : String;
        PUNCH_OUT  : String;
};

entity LEAVE_BALANCE {
    key LEAVE_BALANCE_ID      : UUID;
        TOTAL_LEAVE_COUNT     : Integer;
        AVAILABLE_LEAVE_COUNT : Integer;
        EMP                   : Association to EMPLOYEE;
};

entity LEAVE_REQUEST {
    key LEAVE_REQUEST_ID : UUID;
        APPLIED_BY       : Association to EMPLOYEE;
        FROM_DATE        : String;
        TO_DATE          : String;
        TYPE             : String;
        PRIORITY         : String;
        REASON           : String;
};
