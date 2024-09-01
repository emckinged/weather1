//实时
interface Today {
  obsTime : string;
  temp : string;
  feelsLike : string;
  icon : string;
  text : string;
  wind360 : string;
  windDir : string;
  windScale : string;
  windSpeed : string;
  humidity : string;
  precip : string;
  pressure : string;
  vis : string;
  cloud : string | null;
  dew : string | null;
}

export default class NowInfo {
  code : string = '';
  updateTime : string = '';
  fxLink : string = '';
  now: Today = {
    obsTime: '',
    temp: '',
    feelsLike: '',
    icon: '',
    text: '',
    wind360: '',
    windDir: '',
    windScale: '',
    windSpeed: '',
    humidity: '',
    precip: '',
    pressure: '',
    vis: '',
    cloud: null,
    dew: null,
  };
}