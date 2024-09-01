//每日
interface WeatherForecastDay {
  fxDate: string;
  sunrise: string | null ;
  sunset: string | null;
  moonrise: string | null;
  moonset: string | null;
  moonPhase: string;
  moonPhaseIcon: string;
  tempMax: string;
  tempMin: string;
  iconDay: string;
  textDay: string;
  iconNight: string;
  textNight: string;
  wind360Day: string;
  windDirDay: string;
  windScaleDay: string;
  windSpeedDay: string;
  wind360Night: string;
  windDirNight: string;
  windScaleNight: string;
  windSpeedNight: string;
  humidity: string;
  precip: string;
  pressure: string;
  vis: string;
  cloud: string | null;
  uvIndex: string;
}

export default class WeatherInfo {
  code: string = ''
  updateTime: string = ''
  fxLink: string = ''
  daily: WeatherForecastDay[] = []
}