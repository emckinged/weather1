import WeatherInfo from '../../Model/WeatherInfo'
let i : Array<string> = ['今天','明天','后天']
@Preview
@Component
export default struct List_1 {
  @State weather: WeatherInfo[] = []

  build() {
    Column() {
      Column() {
        ForEach(i, (item: string, Index) => {
          Row({space : 5}) {
            Row({space:9}) {
              Image($r('app.media.sunny'))
                .width(20)
                .fillColor(Color.White)
              Text(i[Index])
                .fontSize(20)
                .fontColor(Color.White)
              Text('晴')
                .fontSize(20)
                .fontColor(Color.White)
            }
            .width('50%')
            .padding({left:10})
            .justifyContent(FlexAlign.Start)

            Row({space:20}) {
              Column() {
                Text('优')
                  .fontColor(Color.White)
                  .fontSize(20)
                  .backgroundColor('#90A2B6')
                  .borderRadius(5)
                  .padding(5)
              }
              Text('36°/19°')
                .fontSize(20)
                .fontColor(Color.White)
            }
            .width('50%')
            .padding({right:10})
            .justifyContent(FlexAlign.End)

          }
          .padding(10)
        })
        // Text('查看近七日的天气')
        //   .fontColor(Color.White)
        //   .fontSize(25)
        //   .padding({top:5})
        Button('查看近七天的天气')
          .width('80%')
          .margin({bottom:10})
      }
      .backgroundColor('#8296AF')
      .width('100%')
      .height(220)
      .padding({bottom:10})
      .borderRadius(20)
    }
    .width('100%')
    .padding(10)

    .backgroundColor('#')
    // .opacity(0.9)
    .borderRadius(20)

    // .justifyContent(FlexAlign.End)
  }
}