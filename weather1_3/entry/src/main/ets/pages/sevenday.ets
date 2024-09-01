import router from '@ohos.router';
import WeatherInfo from '../Model/WeatherInfo'
import WeatherModel from '../ViewModel/weatherModel'

console.log('很重要',JSON.stringify(router.getParams()))

// console.log('还是很重要',this.weather[0].daily[0].fxDate)
class s {
  weather : WeatherInfo[] = []
}

@Entry
@Component
struct seven_day{
  @State wi : number = 20
  @State wi2 : number = 20
  @State weather : WeatherInfo[] = []

  aboutToAppear(): void {
    // this.loadWeatherInfo()
   const parmas = router.getParams() as s
    this.weather = parmas.weather
  }
  //用来配置CanvasRenderingContext2D对象的参数，包括是否开启抗锯齿，true表明开启抗锯齿。
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  //用来创建CanvasRenderingContext2D对象，通过在canvas中调用CanvasRenderingContext2D对象来绘制。
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  build() {
    Column({space:20}) {
      Column({space:20}) {
        Row() {
          Button() {
            Image($r('app.media.arrow_left'))
              .width(35)
          }
          .backgroundColor(Color.White)
          .onClick(() => {
            router.back()
          })
        }
        .width('100%')
        Row(){
          Text('7天趋势预报')
            .fontSize(42)
        }
        .width('100%')
      }
      .padding(10)

      if(this.weather.length) {
        Row() {
          Scroll() {
            Row() {

              Column() {

                Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
                  Canvas(this.context)
                    .width('100%')
                    .height('100%')
                    .backgroundColor(Color.White)
                    .onReady(() => {
                      this.context.strokeStyle = '#000000'; // 线条
                      this.context.lineWidth = 2;         //线条宽度
                      this.context.fillStyle = '#000000'; // 文本颜色为黑色
                      this.context.font = '50px Arial';   //文本大小

                      // let grad = this.context.createLinearGradient(0, 0, 0, 300)
                      // grad.addColorStop(0.0, '#ff0000')
                      // grad.addColorStop(1.0, '#00ff00')
                      // this.context.fillStyle = grad
                      //绘制直线max
                      this.context.beginPath();
                      this.context.moveTo(this.wi, (350 - Number(this.weather[0].daily[0].tempMax)*5 ));
                      this.context.fillText(this.weather[0].daily[0].tempMax, this.wi, (340 - Number(this.weather[0].daily[0].tempMax)*5 ))
                      for (let index = 1; index < this.weather[0].daily.length; index++) {
                        this.wi = this.wi + 80
                        this.context.lineTo(this.wi, (350 - Number(this.weather[0].daily[index].tempMax)*5 ))
                        this.context.fillText(this.weather[0].daily[index].tempMax, this.wi, (340 - Number(this.weather[0].daily[index].tempMax)*5 ))
                      }
                      this.context.stroke();

                      //绘制直线min
                      this.context.beginPath();
                      this.context.moveTo(this.wi2, (420 - Number(this.weather[0].daily[0].tempMin)*5 ));
                      this.context.fillText(this.weather[0].daily[0].tempMin, this.wi2, (410 - Number(this.weather[0].daily[0].tempMin)*5 ))
                      for (let index = 1; index < this.weather[0].daily.length; index++) {
                        this.wi2 = this.wi2 + 80
                        this.context.lineTo(this.wi2, (420 - Number(this.weather[0].daily[index].tempMin)*5 ))
                        this.context.fillText(this.weather[0].daily[index].tempMin, this.wi2, (410 - Number(this.weather[0].daily[index].tempMin)*5 ))
                      }
                      this.context.stroke();

                      //构建区域
                    })

                }
                ForEach(this.weather[0].daily,(item : string,Index) => {

                  Column({space : 15}) {
                    Text(this.weather[0].daily[Index].fxDate)
                      .fontSize(10)
                      .fontColor(Color.Black)
                    Image($r(`app.media.${this.weather[0].daily[Index].iconDay}`))
                      .width(20)
                    Text(this.weather[0].daily[Index].textDay)
                  }
                  .position({x:80*Index-10,y:20})
                  .padding(10)

                  Column({space : 15}) {
                    Image($r(`app.media.${this.weather[0].daily[Index].iconDay}`))
                      .width(20)
                    Text(this.weather[0].daily[Index].textDay)
                    Text(this.weather[0].daily[Index].precip)
                      .fontColor(Color.White)
                      .backgroundColor('#7595CE')
                      .borderRadius(5)
                      .padding(5)
                  }
                  .position({x:80*Index,y:370})
                  .padding(10)

                })
              }
            }
            .width(80 * this.weather[0].daily.length+1)
          }
          .scrollable(ScrollDirection.Horizontal)

        }
        .height(500)

      }

    }
  }

  // loadWeatherInfo(){
  //   // 加载数据
  //   WeatherModel.getWeatherList('1')
  //     .then(resp => {
  //       // this.weathers = this.weathers.concat(resp)
  //       // console.log(this.weathers[0].code)
  //       this.weather = this.weather.concat(resp); // 将新获取的天气信息合并到现有数组中
  //       if (this.weather.length > 0) {
  //         // 打印最新添加的 WeatherInfo 的 code（注意索引可能超出范围，但这里假设至少有一个元素）
  //         console.log(this.weather[this.weather.length - 1].code);
  //       }
  //       console.log(this.weather[0].daily[0].fxDate)
  //       console.log('七日', JSON.stringify(this.weather[0].daily));
  //     })
  //     .catch((error:Error) => {
  //       console.error('Failed to load weather list:', error);
  //     });
  // }

}

