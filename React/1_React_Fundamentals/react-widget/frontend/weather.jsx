import React from 'react';
import { secret } from '../secret';

function toQueryString (obj) {
    const queryString = [];
    for (let key in obj) {
        queryString.push(`${encodeURIComponent(key)}=${encodeURIComponent(obj[key])}`)
    }
}

class Weather extends React.Component {
    
    constructor (props) {
        super(props);
        this.state = { weather: null };
        this.locCallback = this.locCallback.bind(this);
    }

    componentDidMount() {
        navigator.geolocation.getCurrentPosition( (loc) => this.locCallback(loc));
    }

    locCallback (location) {
        const lat = location.coords.latitude;
        const lon = location.coords.longitude;

        const params = {
            lat: lat,
            lon: lon
        }
        const queryParam = toQueryString(params);

        const request = new XMLHttpRequest();

        request.open('GET', `http://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&units=metric&APPID=${secret}`, true)

        request.onload = () => {
            if (request.status === 200 && request.readyState === XMLHttpRequest.DONE) {
                console.log('ok');
                const data = JSON.parse(request.responseText);
                this.setState({ weather: data });
            } else {
                console.log('Error');
            }
        }
        request.onerror = () => {
            console.log('Error');
        }

        request.send()
    }

    render() {
        let content = <div></div>;

        if (this.state.weather) {
            const weather = this.state.weather;
            const temp = weather.main.temp;
            const name = weather.name
            content = <div>
                        <p>{name}</p>
                        <p>{temp} °C</p>
                    </div> 
        } else {
            content = <div>loading weather...</div>
        }

        return (
            <div>
                <h1>Weather</h1>
                <div>
                    {content}
                </div>
            </div>
        );
    }
}

export default Weather;