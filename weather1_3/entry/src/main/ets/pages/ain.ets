//能力
import router from '@ohos.router';

//ViewModel
import TodayInfo from '../Model/TodayInfo'
import TodayModel from '../ViewModel/todayModel';
import WeatherInfo from '../Model/WeatherInfo'
import WeatherModel from '../ViewModel/weatherModel'
import HourInfo from '../Model/HourInfo'
import HourModel from '../ViewModel/hourModel'
import AqiInfo from '../Model/AqiInfo'
import AqiModel from '../ViewModel/aqiModel'
import RecommendInfo from '../Model/RecommendInfo'
import RecommendModel from '../ViewModel/recommendModel'

//Views
import MyCentre from '../views/indexview/MyCentre'
import MyHeader from '../views/indexview/MyHeader'
import List_1_1 from '../views/indexview/List_1_1';
import List_1_2 from '../views/indexview/List_1_2'
import List_2_1 from '../views/indexview/List_2_1'
import List_2_2 from '../views/indexview/List_2_2'
import List_3_1 from '../views/indexview/List_3_1'
import List_3_2 from '../views/indexview/List_3_2'

@Component
export default struct ain {
  @State hour: HourInfo[] = []
  @State today: TodayInfo[] = []
  @State weathers: WeatherInfo[] = []
  @State aqi: AqiInfo[] = []
  @State recommend: RecommendInfo[] = []
  @Prop key1 : string = ' '
  aboutToAppear() {
    this.loadWeatherInfo()
    this.loadTodayInfo()
    this.loadHourInfo()
    this.loadAqiInfo()
    this.loadRecommendInfo()
    let research1 : number[] = []
  }


  //画图暂时用
  @State wi : number = 20
  //用来配置CanvasRenderingContext2D对象的参数，包括是否开启抗锯齿，true表明开启抗锯齿。
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  //用来创建CanvasRenderingContext2D对象，通过在canvas中调用CanvasRenderingContext2D对象来绘制。
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)


  build() {

    Column() {
      List() {
        //中间部分
        ListItem() {

          if (this.today.length && this.weathers.length && this.hour.length && this.aqi.length){
            MyCentre({
              name : this.today[0].now.temp,
              text : this.today[0].now.text,
              tempMax : this.weathers[0].daily[0].tempMax,
              tempMin : this.weathers[0].daily[0].tempMin,
              level : this.aqi[0].daily[0].level,
              aqi : this.aqi[0].daily[0].aqi,
              category : this.aqi[0].daily[0].category,
              rainfall1 : this.hour[0].hourly[0].precip,
              rainfall2 : this.hour[0].hourly[1].precip,
            })
          }
          else {
            MyCentre()
          }
        }

        //底部小栏1
        ListItem() {
          if (this.today.length && this.weathers.length && this.hour.length && this.aqi.length){
            List_1_1({
              weather : this.weathers,
              category : this.aqi,
            })
          }
          else {
            List_1_2()
          }
        }

        //底部小栏2
        ListItem() {
          if (this.today.length && this.weathers.length && this.hour.length && this.aqi.length) {
            Column() {
              List_3_1({
                hour : this.hour
              })
            }
          }
          else {
            Column() {
              List_3_2()
            }
          }
        }

        //底部小栏3,用的List_2
        ListItem() {
          if (this.today.length && this.weathers.length && this.hour.length && this.aqi.length) {
            List_2_1({
              today : this.today,
              weather : this.weathers,
            })
          }
          else {
            List_2_2()
          }
        }
        .width('100%')
        .padding({
          left : 10,
          right : 10,
          bottom : 10,
        })

        ListItem() {
          if (this.recommend.length) {
            Grid() {
              ForEach(this.recommend[0].daily,(item : string,Index) => {
                GridItem() {
                  Column({space:10}) {
                    Image($r(`app.media.research${Index}`))
                      .width(70)
                      .fillColor(Color.White)
                    // if (this.recommend[0].daily[Index].text !== null) {
                    //   Text(this.recommend[0].daily[Index].text?.substring(0,this.recommend[0].daily[Index].text?.indexOf('，')) )
                    //     .fontSize(24)
                    //     .fontColor(Color.White)
                    // }
                    Text(this.recommend[0].daily[Index].name.replace("指数", "")+this.recommend[0].daily[Index].category)
                      .fontSize(24)
                      .fontColor(Color.White)
                  }
                }
                .width('99%')
                .height(150)
                .padding(10)

                .backgroundColor('#8296AF')
              })
            }
            .width('100%')
            .height('100%')
            .columnsTemplate(' 1fr 1fr 1fr ')
            .rowsTemplate('1fr 1fr')

            .borderRadius(20)
          }
        }
        .width('100%')
        .height(322)
        .borderRadius(20)
        .padding(10)

        //占位先看个效果
        ListItem() {
          Column() {
            Text(' ')
              .fontSize(120)

          }
        }
      }
      .scrollBar(BarState.Off)

    }
    .width('100%')
    // .height('110%')
    // .backgroundColor('#8DA1B9')
    // .backgroundImage($r('app.media.yintian'))
    // .backgroundImageSize(ImageSize.Cover)

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

  loadHourInfo(){
    // 加载数据
    HourModel.getHourList(this.key1)
      .then(resp => {

        this.hour = this.hour.concat(resp); // 将新获取的天气信息合并到现有数组中
        if (this.hour.length > 0) {
          // 打印最新添加的 WeatherInfo 的 code（注意索引可能超出范围，但这里假设至少有一个元素）
          console.log('hour code',this.hour[this.hour.length - 1].code);
        }
        console.log('hour',this.hour[0].hourly[1].temp)
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

  loadRecommendInfo(){
    // 加载数据
    RecommendModel.getRecommendList(this.key1)
      .then(resp => {

        this.recommend = this.recommend.concat(resp); // 将新获取的天气信息合并到现有数组中
        if (this.recommend.length > 0) {
          // 打印最新添加的 WeatherInfo 的 code（注意索引可能超出范围，但这里假设至少有一个元素）
          console.log('recommend code',this.recommend[this.recommend.length - 1].code);
        }
        console.log('recommend',this.recommend[0].daily[0].name)
      })
      .catch((error:Error) => {
        console.error('Failed to load weather list:', error);
      });
  }

}