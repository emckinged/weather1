//城市卡片
import PreferenceUtil from '../utils/PreferenceUtil'
import TodayInfo from '../Model/TodayInfo'
import TodayModel from '../ViewModel/todayModel';
import AqiInfo from '../Model/AqiInfo'
import AqiModel from '../ViewModel/aqiModel'
import WeatherInfo from '../Model/WeatherInfo'
import WeatherModel from '../ViewModel/weatherModel'

@Entry
@Component
export default struct load {
  @State today: TodayInfo[] = []
  @State weathers: WeatherInfo[] = []
  @State aqi: AqiInfo[] = []
  @State key1 : string = ''
  @State cityName : string = '西安市'
  aboutToAppear(): void {
    this.loadWeatherInfo()
    this.loadTodayInfo()
    this.loadAqiInfo()
  }
  build() {
    if (this.today.length && this.weathers.length && this.aqi.length) {
      Row({ space: 8 }) {
        Column({ space: 8 }) {
          Text(this.cityName)
            .fontSize(50)
            .fontColor(Color.White)
          Row({ space: 8 }) {
            Text(this.aqi[0].daily[0].category)
              .fontSize(20)
              .fontColor('#E0F3FF')
            Text(this.weathers[0].daily[0].tempMax+'°/'+this.weathers[0].daily[0].tempMin+'°')
              .fontSize(20)
              .fontColor('#E0F3FF')
          }
        }
        .width(200)
        .alignItems(HorizontalAlign.Start)

        Text(this.today[0].now.temp+'°')
          .fontSize(50)
          .fontColor(Color.White)
      }
      .width('100%')
      .padding(20)
      .justifyContent(FlexAlign.SpaceBetween)
    }
  }
  loadWeatherInfo(){
    // 加载数据
    WeatherModel.getWeatherList(this.key1)
      .then(resp => {
        // this.weathers = this.weathers.concat(resp)
        // console.log(this.weathers[0].code)
        this.weathers = this.weathers.concat(resp); // 将新获取的天气信息合并到现有数组中
        if (this.weathers.length > 0) {
          // 打印最新添加的 WeatherInfo 的 code（注意索引可能超出范围，但这里假设至少有一个元素）
          console.log(this.weathers[this.weathers.length - 1].code);
        }
        console.log(this.weathers[0].daily[0].fxDate)
        console.log('bb', JSON.stringify(this.weathers[0].daily));
      })
      .catch((error:Error) => {
        console.error('Failed to load weather list:', error);
      });
  }

  loadTodayInfo(){
    // 加载数据
    TodayModel.getTodayList(this.key1)
      .then(resp => {
        // this.weathers = this.weathers.concat(resp)
        // console.log(this.weathers[0].code)
        this.today = this.today.concat(resp); // 将新获取的天气信息合并到现有数组中
        if (this.today.length > 0) {
          // 打印最新添加的 WeatherInfo 的 code（注意索引可能超出范围，但这里假设至少有一个元素）
          console.log(this.today[this.today.length - 1].code);
        }
        console.log('ha',this.today[0].now.temp)
      })
      .catch((error:Error) => {
        console.error('Failed to load weather list:', error);
      });
  }

  loadAqiInfo(){
    // 加载数据
    AqiModel.getAqiList(this.key1)
      .then(resp => {

        this.aqi = this.aqi.concat(resp); // 将新获取的天气信息合并到现有数组中
        if (this.aqi.length > 0) {
          // 打印最新添加的 WeatherInfo 的 code（注意索引可能超出范围，但这里假设至少有一个元素）
          console.log('aqi code',this.aqi[this.aqi.length - 1].code);
        }
        console.log('aqi',this.aqi[0].daily[1].aqi)
      })
      .catch((error:Error) => {
        console.error('Failed to load weather list:', error);
      });
  }
}