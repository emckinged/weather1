interface air {
  fxDate : string
  aqi : string
  level : string
  category : string
  primary : string
}

export default class NowInfo {
  code : string = '';
  updateTime : string = '';
  fxLink : string = '';
  daily : air[] = []
}