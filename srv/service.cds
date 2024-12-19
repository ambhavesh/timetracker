namespace timetracker.srv.service;

using {timetracker.db.schema as db} from '../db/schema';
using {timetracker.db.views as views} from '../db/views';


service TIME_TRACKER_SRV @(path: '/odata') {
    entity Employees               as projection on db.EMPLOYEE;
    entity PunchingDetails         as projection on db.PUNCHING_DETAILS;
    entity EmployeePunchingDetails as projection on views.EMPLOYEE_PUNCHING_VIEW;
    action   Punch(Action : String, EmpId : Integer) returns {};
    function EmployeeF4()                            returns {};

}
