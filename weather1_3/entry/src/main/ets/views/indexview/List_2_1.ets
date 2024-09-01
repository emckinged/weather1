import WeatherInfo from '../../Model/WeatherInfo'
import TodayInfo from '../../Model/TodayInfo'
import List_2_2_2 from '../indexview/List_2_2_2'
@Component
export default struct List_2_1 {
  @Prop weather : WeatherInfo[] = []
  @Prop today : TodayInfo[] = []
  build() {

    Row({ space: 10 }) {
      //左侧
      Column({ space: 10 }) {
        //左侧上半部分
        Row() {
          Column({space:5}) {
            Text(this.today[0].now.windDir)
              .fontColor(Color.White)
              .fontSize(22)
            Text(this.today[0].now.windScale + '级')
              .fontColor(Color.White)
              .fontSize(22)
          }
          .padding(10)
        }
        .width('100%')
        .height(95)
        .backgroundColor('#8296AF')
        .borderRadius(20)

        //左侧下半部分
        Row() {
          Column({space:5}) {
            Row({space:3})
            {
              Text(this.weather[0].daily[0].sunrise)
                .fontSize(15)
                .fontColor(Color.White)
              Text('日出')
                .fontSize(14)
                .fontColor('#D1D9F1')
            }

            Row({space:3})
            {
              Text(this.weather[0].daily[0].sunset)
                .fontSize(15)
                .fontColor(Color.White)
              Text('日落')
                .fontSize(14)
                .fontColor('#D1D9F1')
            }
          }
          .width(70)
          .padding(10)
          Row() {
            List_2_2_2({
              weather : this.weather
            })

          }
          .height(95)
          .padding(10)
        }
        .width('100%')
        .height(95)
        .backgroundColor('#8296AF')
        .borderRadius(20)

      }
      .width('50%')
      .height(200)
      .padding({ right: 5 })

      //右侧
      Column() {
        List() {
          ListItem() {
            Row() {
              Text('湿度')
                .fontColor('#D1D9F1')
              Text(this.today[0].now.humidity+'%')
                .fontSize(20)
                .fontColor(Color.White)
            }
            .width('100%')
            .height('22%')
            .padding(10)
            .justifyContent(FlexAlign.SpaceBetween)
          }

          ListItem() {
            Row() {
              Text('体感')
                .fontColor('#D1D9F1')
              Text(this.today[0].now.feelsLike+'°')
                .fontSize(20)
                .fontColor(Color.White)
            }
            .width('100%')
            .height('22%')
            .padding(10)
            .justifyContent(FlexAlign.SpaceBetween)
          }

          ListItem() {
            Row() {
              Text('紫外线')
                .fontColor('#D1D9F1')
              Text(this.weather[0].daily[0].uvIndex)
                .fontSize(20)
                .fontColor(Color.White)
            }
            .width('100%')
            .height('22%')
            .padding(10)
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Bottom)
          }

          ListItem() {
            Row() {
              Text('气压')
                .fontColor('#D1D9F1')
              Text() {
                Span(this.today[0].now.pressure)
                  .fontSize(20)
                Span('hpa')
                  .fontSize(14)
              }
              .fontColor(Color.White)
            }
            .width('100%')
            .height('22%')
            .padding(10)
            .justifyContent(FlexAlign.SpaceBetween)
          }

          ListItem() {

          }
        }
        .divider({
          strokeWidth: 1,
          color: '#9AA8CB',
          startMargin: 5,
          endMargin: 5
        })
      }
      .width('50%')
      .height(200)
      .backgroundColor('#8296AF')
      .borderRadius(20)
      .padding({ left: 5 })

    }

    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
  }
}