import ballerina/io;
import ballerinax/mysql;

configurable string dbHost = ?;
configurable string dbUser = ?;
configurable string dbPassword = ?;
configurable string dbName = ?;
configurable int dbPort = ?;

mysql:Client mysqlClient = check new (host = dbHost, user = dbUser, password = dbPassword, database = dbName, port = 
dbPort);

# Description
#
# + stagename - Parameter Description  
# + pssupportstartdaterollup - Parameter Description  
# + pssupportenddaterollup - Parameter Description  
# + productunit - Parameter Description
# + return - Return Value Description
public function getSFDCInfo(string productunit, string stagename, string pssupportenddaterollup, 
                            string pssupportstartdaterollup) returns json[]|error {

    json[] resultJSON = [];
    
    stream<record { }, error> resultStream = mysqlClient->query(getSFDCInfoQuery(productunit, stagename, 
    pssupportenddaterollup, pssupportstartdaterollup));

    error? e = resultStream.forEach(function(record { } result) {
                                        resultJSON.push(result.toJson());

                                    });
    error? close = resultStream.close();
    if (close is error) {
        io:println("Stream close failed!", close);
        json[] errorJson = [{Error:close.toString()}];
        return errorJson;
    }
    if (e is error) {
        io:println("ForEach operation on the stream failed!", e);
        json[] errorJson = [{Error:e.toString()}];
        return errorJson;
    }
    
    return resultJSON;
}
