interface Hour {
  fxTime : string
  temp : string
  icon : string
  text : string
  wind360 : string
  windDir : string
  windScale : string
  windSpeed : string
  humidity : string
  pop : string | null
  precip : string
  pressure : string
  cloud : String | null
  dew : String | null
}

export default class HourInfo {
  code : string = ""
  updateTime : string = ""
  fxLink : string = ""
  hourly : Array<Hour> = []
}