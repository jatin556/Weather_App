import { LightningElement } from 'lwc';
import getWeatherDetails from '@salesforce/apex/WeatherController.getWeatherDetails';

export default class WeatherApp extends LightningElement {
    cityName='';
    showWeatherInfo = false;
    weatherResult = {}

    handleInputChange = (event) => {
        this.cityName = event.target.value;
    }

    handleWeatherInfo = (event) => {
        getWeatherDetails({cityName: this.cityName})
        .then((result) => {
            this.showWeatherInfo = true;
            this.weatherResult = result;
        }) 
        .catch ((error) => {
            this.showWeatherInfo = false;
            alert("Some error has occured!");
        });

        console.log('result : ', JSON.stringify(this.weatherResult));
    }
}