import ballerina/http;
import ballerina/log;
import ballerina/io;

# Description  
service / on new http:Listener(9090) {

    # Description
    # + return - Return Value Description  
    resource function post sfdc/info(http:Caller caller, http:Request req ) returns json|error {
        json|error rep = req.getJsonPayload();
        if rep is json {
            log:printInfo(rep.toString());
            json|error productunit = rep.productunit;
            json|error stagename = rep.stagename;
            json|error pssupportenddaterollup = rep.pssupportenddaterollup;
            json|error pssupportstartdaterollup = rep.pssupportstartdaterollup;

            io:println("productunit: ", productunit);
            io:println("stagename: ", stagename);
            io:println("pssupportenddaterollup: ", pssupportenddaterollup);

            string product_unit = "";
            string stage_name = "";
            string ps_supportenddaterollup = "";
            string ps_supportstartdaterollup = "";

            if productunit is json && stagename is json && pssupportenddaterollup is json && pssupportstartdaterollup is json  {
                product_unit = productunit.toJsonString();
                stage_name = stagename.toJsonString();
                ps_supportenddaterollup = pssupportenddaterollup.toJsonString();
                ps_supportstartdaterollup = pssupportstartdaterollup.toJsonString();
            }
            else{
                return {
                succses: false,
                errormessage: "Not a valid json input...",
                data: []
            };
            }
            
            json|error salesforcePayload = getSFDCInfo(product_unit, stage_name, ps_supportenddaterollup, ps_supportstartdaterollup);

            if salesforcePayload is json {
                return {succses: true, data: salesforcePayload};
            } else {
                return {
                    succses: false,
                    errormessage: salesforcePayload.toString(),
                    data: []
                };
            }
        } else {
            io:println("Not a valid json input...!");

            return {
                succses: false,
                errormessage: "Not a valid json input...",
                data: []
            };
        }

    }

    # Description
    # + return - Return Value Description  
    resource function post personjson/info/[string series]() returns json|error {
    //return check getSFDCInfo(series);
    }
}
