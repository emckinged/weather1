//推荐
interface Daily {
  date : string;
  type : string;
  name : string;
  level : string;
  category : string;
  text : string | null;
  sources : string | null;
  license : string | null;
}

export default class RecommendInfo {
  code : string = '';
  updateTime : string = '';
  fxLink : string = '';
  daily : Daily[] = []
}