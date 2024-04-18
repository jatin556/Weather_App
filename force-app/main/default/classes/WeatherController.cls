public with sharing class WeatherController {
    @AuraEnabled
    public static WeatherWrapper getWeatherDetails(String cityName){

            //setting Enpoint URL
            String apiKey = '4c53506e8deb62164afa7ee289ec232b';
            String endpoint = 'http://api.openweathermap.org/data/2.5/weather';
            endpoint += '?q=' + cityName;
            endpoint += '&units=metric';
            endpoint += '&APPID=' + apiKey;

            //Setting the callout to Weather API
            Http http = new Http();

            HttpRequest request = new HttpRequest();
            request.setEndpoint(endpoint);
            request.setMethod('GET');

            HttpResponse response = http.send(request);
            System.debug('res: ' + response + 'response result: '+ JSON.deserializeUntyped(response.getBody()));

            WeatherWrapper weatherDet = new WeatherWrapper();
            if(response.getStatusCode() == 200){
                Map<String,Object> result = (Map<String,Object>) JSON.deserializeUntyped(response.getBody());
                weatherDet.city = String.valueOf(result.get('name'));
                Map<String,Object> mainResult = (Map<String, Object>)(result.get('main'));
                weatherDet.feelsLike = String.valueOf(mainResult.get('feels_like'));
                weatherDet.humidity = String.valueOf(mainResult.get('humidity'));
                weatherDet.pressure = String.valueOf(mainResult.get('pressure'));
                weatherDet.tempMax = String.valueOf(mainResult.get('temp_max'));
                weatherDet.tempMin = String.valueOf(mainResult.get('temp_min'));
                weatherDet.tempreture = String.valueOf(mainResult.get('temp'));
            }
            System.debug('Weather Det: ' + weatherDet);
            return weatherDet;
    }

    public class WeatherWrapper {
        @AuraEnabled public string city {get; set;}
        @AuraEnabled public string tempreture {get; set;}
        @AuraEnabled public string pressure {get; set;}
        @AuraEnabled public string humidity {get; set;}
        @AuraEnabled public string feelsLike {get; set;}
        @AuraEnabled public string tempMin {get; set;}
        @AuraEnabled public string tempMax {get; set;}
        
    }
}