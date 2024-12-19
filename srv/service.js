const cds = require("@sap/cds");
const QRCode = require('qrcode');
const nodemailer = require('nodemailer');

module.exports = (srv => {

    let { Employees, PunchingDetails } = srv.entities;

    srv.before("CREATE", Employees, async (req) => {
        let db = await cds.connect.to('db');
        let tx = db.tx();
        try {
            let { FIRST_NAME, LAST_NAME, EMAIL } = req.data;
            let maxId = await tx.run(`SELECT MAX(EMP_ID) AS COUNT FROM ${Employees}`);
            maxId[0].COUNT = maxId[0].COUNT + 1;
            req.data.EMP_ID = maxId[0].COUNT;

            const qrCodeData = `${req.data.EMP_ID}:${FIRST_NAME}`;
            const qrCodeUrl = await QRCode.toDataURL(qrCodeData, {
                width: 300,
                height: 300,
                color: {
                    dark: '#0000FF',
                    light: '#FFFFFF'
                }
            });
            req.data.QR_CODE = qrCodeUrl;
            await tx.update(Employees, req.data.EMP_ID).with(req.data);

            const transporter = nodemailer.createTransport({
                host: 'smtp.gmail.com',
                port: 587,
                auth: {
                    user: 'patelkurvesh8866@gmail.com', 
                    pass: 'rbwu mtdl tcaw rrdr'
                }
            });
            const mailInfo = await transporter.sendMail({
                from: "patelkurvesh8866@gmail.com",
                to: EMAIL,
                subject: 'Your Employee QR Code',
                text: `Hello ${FIRST_NAME} ${LAST_NAME},\n\nPlease find your QR code below.\n\nYour unique QR Code is:`,
                html: `<p>Hello ${FIRST_NAME} ${LAST_NAME},</p><p>Please find your QR code below.</p><img src="${qrCodeUrl}" alt="QR Code"/>`,
                attachments: [
                    {
                        filename: 'Qr_code.png',
                        content: qrCodeUrl.split(",")[1],
                        encoding: 'base64',
                        cid: 'qrCodeImage',
                    },
                ]
            });
            console.log(`Mail sent`, mailInfo.messageId);
        } catch (error) {
            console.log(error);
        }
    });

    srv.on("EmployeeF4", async(req)=> {
        var employee = await SELECT.from(Employees).columns('EMP_ID','FIRST_NAME','LAST_NAME');
        var oResponse = {
            "status" : 200,
            "results" : employee 
        };
        let {res} = req.http;
        res.send(oResponse); 
    });

    srv.on("Punch", async (req) => {
        let db = await cds.connect.to('db');
        let tx = db.tx();
        try {
            let oResponse = {};
            let { Action, EmpId } = req.data;
            const UTCDate = new Date(Date.now());
            const ISTDate = UTCDate.toLocaleString('en-IN', { timeZone: 'Asia/Kolkata' });
            const punchDate = ISTDate.split(",")[0];
            const punchInTime = ISTDate.split(",")[1].trim();
            let aEmployee = await tx.run(SELECT.from(PunchingDetails).where({ EMP_CODE_EMP_ID: EmpId, PUNCH_DATE: punchDate }));
            if (Action === "IN") {
                if (aEmployee.length > 0) {
                    return req.error(400, 'You are already punched in...');
                }
                let oPunchInObj = {
                    "EMP_CODE_EMP_ID": EmpId,
                    "PUNCH_DATE": punchDate,
                    "PUNCH_IN": punchInTime,
                    "PUNCH_OUT": ""
                };
                await INSERT.into(PunchingDetails, oPunchInObj);
                oResponse = {
                    "status": 200,
                    sResponsMsg: `Employeed Id ${EmpId} you have successfully punched in, have a great day.`
                };
            } else {
                const UTCDate = new Date(Date.now());
                const ISTDate = UTCDate.toLocaleString('en-IN', { timeZone: 'Asia/Kolkata' });
                const punchDate = ISTDate.split(",")[0];
                const punchOutTime = ISTDate.split(",")[1].trim();
                const aPunchOutData = await SELECT.from(PunchingDetails).where({ EMP_CODE_EMP_ID: EmpId, PUNCH_DATE: punchDate });
                if (aPunchOutData.length === 0) {
                    return req.error(400, `Employee ID ${EmpId}, you haven't punched in yet.`);
                }
                const oPunchOutObj = aPunchOutData[0];
                oPunchOutObj.PUNCH_OUT = punchOutTime;
                await tx.update(PunchingDetails)
                    .set(oPunchOutObj)
                    .where({
                        EMP_CODE_EMP_ID: oPunchOutObj.EMP_CODE_EMP_ID,
                        PUNCH_DATE: oPunchOutObj.PUNCH_DATE
                    });
                oResponse = {
                    "status": 200,
                    sResponsMsg: `Employeed Id ${EmpId} you've successfully punched out, hope you had a great day.`
                };
                await tx.commit();
            }
            let { res } = req.http;
            res.send(oResponse);
        } catch (error) {
            console.log(error);
        }

    });

});