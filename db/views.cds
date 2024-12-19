namespace timetracker.db.views;

using {timetracker.db.schema as db} from './schema';

define view EMPLOYEE_PUNCHING_VIEW as
    select from db.EMPLOYEE as E
    join db.PUNCHING_DETAILS as PD
        on E.EMP_ID = PD.EMP_CODE.EMP_ID
    {
        key E.EMP_ID      as Id,
        key PD.PUNCH_DATE as PunchDate,
            E.FIRST_NAME  as FirstName,
            E.LAST_NAME   as LastName,
            E.GENDER      as Gender,
            E.EMAIL       as Email,
            E.PHONE_NO    as PhoneNo,
            PD.PUNCH_IN   as PunchIn,
            PD.PUNCH_OUT  as PunchOut
    };
