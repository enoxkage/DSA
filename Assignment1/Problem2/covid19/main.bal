import ballerina/graphql;

service /covid19 on new graphql:Listener(4000) {
private Covid19Details [] details;
function init() {
    self.details=[];
}

resource function get details () returns Covid19Details [] {
 return self.details;   
}
 remote function addregion(string date, string region, int deaths, int confirmed_cases, int recoveries, int tested ) {

  Covid19Details C19D =new (date, region, deaths, confirmed_cases, recoveries, tested);
  self.details.push(C19D);
  
 }

 remote function update_details(string date, string region, int deaths, int confirmed_cases, int recoveries, int tested) returns error? {
  Covid19Details[] detail = self.details.filter(item =>item.getRegion() == region);
    if detail.length() != 1 {
        return error(string `invalid name`);
    } else {
        detail[0].setRegion(region);
    }
 

 
}

}
 
 




public service class Covid19Details {
    private string date;
    private string region;
    private int deaths;
    private int confirmed_cases;
    private int recoveries;
    private int tested;

    function init(string date, string region, int deaths, int confirmed_cases, int recoveries, int tested ) {
        self.date = date;
        self.region = region;
        self.deaths = deaths;
        self.confirmed_cases = confirmed_cases;
        self.recoveries = recoveries;
        self.tested = tested;
    }

    resource function get date() returns string {
        return self.date;

    }

    resource function get region() returns string {
        return self.region;

    }
    resource function get deaths() returns int {
        return self.deaths;
    }

    resource function get confirmed_cases() returns int {
        return self.confirmed_cases;
    }
    resource function get recoveries() returns int {
        return self.recoveries;
    }
    resource function get tested() returns int {
        return self.tested;
    }
    function setDate(string date) {
        self.date = date;

    }
    function setRegion(string region) {
        self.region = region;

    }
    function setDeaths(int deaths) {
      self.deaths = deaths;
    }
    function setConfirmed_cases(int confirmed_cases) {
      self.confirmed_cases = confirmed_cases;
    }
    function setRecoveries(int recoveries) {
      self.recoveries = recoveries;
    }
    function setTested(int tested) {
      self.tested = tested;
    }
    public function getRegion() returns string {
        return self.region;
    }


  

}