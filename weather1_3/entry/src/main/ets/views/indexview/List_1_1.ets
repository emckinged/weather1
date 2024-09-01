import WeatherInfo from '../../Model/WeatherInfo'
import AqiInfo from '../../Model/AqiInfo'
import router from '@ohos.router';
let i : Array<string> = ['今天','明天','后天']

@Component
export default struct List_1 {
  @Prop weather: WeatherInfo[] = []
  @Prop category: AqiInfo[] = []
  build() {
    Column() {
      Column() {
        ForEach(i, (item: string, Index) => {
          Row({space : 5}) {
            Row({space:9}) {
              Image($r(`app.media.${this.weather[0].daily[Index].iconDay}`))
                .width(18)
                .fillColor(Color.White)
              Text(i[Index])
                .fontSize(18)
                .fontColor(Color.White)
              if (this.weather[0].daily[Index].textDay === this.weather[0].daily[Index].textNight) {
                Text(this.weather[0].daily[Index].textDay)
                  .fontSize(18)
                  .fontColor(Color.White)
              }
              else {
                Text(this.weather[0].daily[Index].textDay + '转' + this.weather[0].daily[Index].textNight)
                  .fontSize(18)
                  .fontColor(Color.White)
              }
            }
            .width('50%')
            .padding({left:10})
            .justifyContent(FlexAlign.Start)


            Row({space:10}) {
              Row() {
                Text(this.category[0].daily[Index].category)
                  .backgroundColor('#90A2B6')
                  .fontColor(Color.White)
                  .fontSize(15)

                  .borderRadius(7)
                  .padding(5)
              }
              .width('50%')

              Text(this.weather[0].daily[Index].tempMax+'°/'+this.weather[0].daily[Index].tempMin+'°')
                .fontSize(18)
                .fontColor(Color.White)
            }
            .width('50%')
            .padding({right:10})
            .justifyContent(FlexAlign.End)

          }
          .padding(10)
        })


          if (this.weather.length) {
            Button('查看近七天的天气')
              .width('80%')
              .margin(15)
              .onClick(() => {
                router.pushUrl({
                  url:'pages/sevenday',
                  params : {
                    weather : this.weather
                  }
                })
              })
          }

      }
      .backgroundColor('#8296AF')
      .width('100%')
      .height(220)
      .padding({bottom:10})
      .borderRadius(20)
    }
    .width('100%')
    .padding(10)

    // .opacity(0.9)
    .borderRadius(20)

    // .justifyContent(FlexAlign.End)
  }
}