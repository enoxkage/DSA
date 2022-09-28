import ballerina/graphql;

public type Covid19Details record {|
    string date;
   readonly string region;
    decimal deaths?;
    decimal confirmed_cases?;
    decimal recoveries?;
     decimal tested?;
|};

table<Covid19Details> key(region) covidTable = table [
    {date: "12/09/2021", region: "khomas", deaths: 39, confirmed_cases: 465, recoveries: 67, tested:1200}

];

public distinct service class CovidData {
    private final readonly & Covid19Details entryRecord;

    function init(Covid19Details entry) {
        self.entryRecord = entry.cloneReadOnly();
    }

    resource function get date() returns string {
        return self.entryRecord.date;

    }

    resource function get region() returns string {
        return self.entryRecord.region;

    }
    resource function get deaths() returns decimal? {
        if self.entryRecord.deaths is decimal {
            return self.entryRecord.deaths;
        }
        return;
    
    }

    resource function get confirmed_cases() returns decimal? {
       if self.entryRecord.confirmed_cases is decimal {
            return self.entryRecord.confirmed_cases;
        }
        return;
    }
    resource function get recoveries() returns decimal? {
        if self.entryRecord.recoveries is decimal {
            return self.entryRecord.recoveries ;
        }
        return;
    }
    resource function get tested() returns decimal? {
           if self.entryRecord.tested is decimal {
            return self.entryRecord.tested;
        }
        return;
    }
    
   


  

    
}
service /covid19 on new graphql:Listener(4000) {
resource function get all() returns CovidData[] {
        Covid19Details[] covidEntries = covidTable.toArray().cloneReadOnly();
        return covidEntries.map(entry => new CovidData(entry));
    }

 resource function get filter(string date) returns CovidData? {
        Covid19Details? covidEntry = covidTable[date];
        if covidEntry is Covid19Details {
            return new (covidEntry);
        }
        return;
    }
 remote function add(Covid19Details entry) returns CovidData {
        covidTable.add(entry);
        return new CovidData(entry);
    }
 

}
 
 




