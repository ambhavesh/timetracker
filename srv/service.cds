namespace timetracker.srv.service;

using {timetracker.db.schema as db} from '../db/schema';
using {timetracker.db.views as views} from '../db/views';


service TIME_TRACKER_SRV @(path: '/odata') {
    entity Employees               as projection on db.EMPLOYEE;

    @readonly: true
    entity PunchingDetails         as projection on db.PUNCHING_DETAILS;

    entity LeaveBalances           as projection on db.LEAVE_BALANCE;
    entity LeaveRequests           as projection on db.LEAVE_REQUEST;
    entity EmployeePunchingDetails as projection on views.EMPLOYEE_PUNCHING_VIEW;
    entity TimeTrackerMasterView     as projection on views.EMPLOYEE_PUNCHING_MASTER_VIEW;
    entity TimeTrackerDetailView     as projection on views.EMPLOYEE_PUNCHING_DETAIL_VIEW;

    @open
    type object {};

    action Punch(Action : String, EmpId : Integer)           returns object;
    action ApproveLeave(LeaveType : String, EmpId : Integer) returns object;
    action RejectLeave(LeaveType : String, EmpId : Integer)  returns object;
}
