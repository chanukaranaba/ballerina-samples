import ballerina/sql;

function getSFDCInfoQuery(string productunit,string stagename,string pssupportenddaterollup,string pssupportstartdaterollup) returns sql:ParameterizedQuery{
return  `
        SELECT  account_.Id as acc_Id,
		account_.Name as acc_Name,
        account_.Account_Classification__c as acc_Classification,
        account_.Sales_Regions__c as acc_SalesRegion,
        account_.Sub_Region__c as acc_Sub_Region,
        account_.Owner as acc_Owner,
        opportunity_.Id as opp_Id,
        opportunity_.AccountId as opp_AccountId,
        opportunity_.Name  as opp_Name,
        opportunity_.Technical_Owner__c as opp_Technical_Owner,
        opportunity_.StageName as opp_StageName,
		opportunity_.PS_Support_Account_End_Date_Roll_Up__c as opp_PS_Support_Account_End_Date_Roll_Up__c,
        opportunity_.PS_Support_Account_Start_Date_Roll_Up__c as opp_PS_Support_Account_Start_Date_Roll_Up__c,
        lineitem_.Id as lineItem_Id,
		lineitem_.OpportunityId as lineItem_OpportunityId,
		lineitem_.Name as lineItem_Name,
        lineitem_.Product_Unit__c as lineItem_Product_Unit__c,
        lineitem_.Classification__c as lineItem_Classification__c,
		lineitem_.Unit_Price__c as lineItem_Unit_Price,
		lineitem_.TotalPrice as lineItem_TotalPrice,
        lineitem_.Classification__c as lineItem_Classification,
        lineitem_.Type__c as lineItem_Type
FROM    SF_ACCOUNT account_
        INNER JOIN SF_OPPORTUNITY opportunity_
            ON account_.Id = opportunity_.AccountId
        INNER JOIN SF_OPPOLINEITEM lineitem_
            ON opportunity_.Id = lineitem_.OpportunityId
WHERE   lineitem_.Product_Unit__c = ${productunit}  AND 
        opportunity_.StageName =${stagename}  AND 
        opportunity_.PS_Support_Account_End_Date_Roll_Up__c >= ${pssupportenddaterollup}
        AND opportunity_.PS_Support_Account_Start_Date_Roll_Up__c <= ${pssupportstartdaterollup}
LIMIT 500

    `;
}