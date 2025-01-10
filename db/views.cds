namespace timetracker.db.views;

using {timetracker.db.schema as db} from './schema';

define view EMPLOYEE_PUNCHING_VIEW as
    select from db.EMPLOYEE as E
    join db.PUNCHING_DETAILS as PD
        on E.EMP_ID = PD.EMP_CODE.EMP_ID
    {
        key E.EMP_ID      as EMP_ID,
        key PD.PUNCH_DATE as PUNCH_DATE,
            E.FIRST_NAME  as FIRST_NAME,
            E.LAST_NAME   as LAST_NAME,
            E.GENDER      as GENDER,
            E.EMAIL       as EMAIL,
            E.DESIGNATION as DESIGNATION,
            E.MODULE      as MODULE,
            E.MODULE_TYPE as MODULE_TYPE,
            E.EXPERIENCE  as EXPERIENCE,
            E.PHONE_NO    as PHONE_NO,
            PD.PUNCH_IN   as PUNCH_IN,
            PD.PUNCH_OUT  as PUNCH_OUT,
            case
                when
                    cast(
                        PD.PUNCH_IN as        Time
                    ) > '10:10:00'
                then
                    'Late'
                else
                    'On Time'
            end           as ARRIVAL_STATUS : String
    };

define view EMPLOYEE_PUNCHING_MASTER_VIEW as
    select from db.EMPLOYEE as E
    join db.PUNCHING_DETAILS as PD
        on E.EMP_ID = PD.EMP_CODE.EMP_ID
    {
        key E.EMP_ID      as EMP_ID,
        key PD.PUNCH_DATE as PUNCH_DATE,
            E.FIRST_NAME  as FIRST_NAME,
            E.LAST_NAME   as LAST_NAME,
            E.GENDER      as GENDER,
            E.EMAIL       as EMAIL,
            PD.PUNCH_IN   as PUNCH_IN,
            PD.PUNCH_OUT  as PUNCH_OUT,
            case
                when
                    cast(
                        PD.PUNCH_IN as        Time
                    ) > '10:10:00'
                then
                    'Late'
                else
                    'On Time'
            end           as ARRIVAL_STATUS : String
    };

define view EMPLOYEE_PUNCHING_DETAIL_VIEW as
    select from db.EMPLOYEE as E
    join db.PUNCHING_DETAILS as PD
        on E.EMP_ID = PD.EMP_CODE.EMP_ID
    {
        key E.EMP_ID      as EMP_ID,
        key PD.PUNCH_DATE as PUNCH_DATE,
            E.FIRST_NAME  as FIRST_NAME,
            E.LAST_NAME   as LAST_NAME,
            E.GENDER      as GENDER,
            E.EMAIL       as EMAIL,
            E.DESIGNATION as DESIGNATION,
            E.MODULE      as MODULE,
            E.MODULE_TYPE as MODULE_TYPE,
            E.EXPERIENCE  as EXPERIENCE,
            E.PHONE_NO    as PHONE_NO,
            PD.PUNCH_IN   as PUNCH_IN,
            PD.PUNCH_OUT  as PUNCH_OUT,
            case
                when
                    cast(
                        PD.PUNCH_IN as        Time
                    ) > '10:10:00'
                then
                    'Late'
                else
                    'On Time'
            end           as ARRIVAL_STATUS : String
    };
