import WeatherInfo from '../../Model/WeatherInfo'
import TodayInfo from '../../Model/TodayInfo'
@Component
export default struct List_2_1 {
  @State weather : WeatherInfo[] = []
  @State today : TodayInfo[] = []
  build() {

    Row({ space: 10 }) {
      //左侧
      Column({ space: 10 }) {
        //左侧上半部分
        Row() {
          Column() {
            Text('东风')
              .fontColor(Color.White)
            Text('2级')
              .fontColor(Color.White)
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
              Text('05:55')
                .fontSize(19)
                .fontColor(Color.White)
              Text('日出')
                .fontSize(17)
                .fontColor('#D1D9F1')
            }

            Row({space:3})
            {
              Text('19:45')
                .fontSize(19)
                .fontColor(Color.White)
              Text('日落')
                .fontSize(17)
                .fontColor('#D1D9F1')
            }
          }
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
              Text('66%')
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
              Text('39°')
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
              Text('1')
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
                Span('946')
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

    .width
    ('100%'
    )
    .justifyContent
    (FlexAlign
      .SpaceBetween
    )
  }
}