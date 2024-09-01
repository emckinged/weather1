@Component
export default struct MyCentre {
  @Prop name : string = '加载中'
  @Prop text : string = '晴'
  @Prop tempMax : string = '35'
  @Prop tempMin : string = '22'
  @Prop aqi : string = '30'
  @Prop level : string = '3'
  @Prop category : string = ""
  @Prop rainfall1 :string = '0.0'
  @Prop rainfall2 :string = '0.0'

  build() {

    Column({space:10}) {
      Row() {
          Text(this.name)
            .fontSize(70)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Medium)

        Text('℃')
          .fontSize(50)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)

      Row({space : 10}) {
        Text(this.text)
          .fontSize(30)
          .fontColor(Color.White)
        Text(`${this.tempMax}°/${this.tempMin}°`)
          .fontSize(30)
          .fontColor(Color.White)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)

      Row({space:20}) {
        Row({space : 5}) {
          Image($r('app.media.airquality'))
            .width(15)
            .fillColor(Color.White)
          if (this.level == '1' || this.level == '2'){
            Text('空气'+this.category+' '+this.aqi)
              .fontSize(15)
              .fontColor(Color.White)
          }
          else {
            Text(this.category+' '+this.aqi)
              .fontSize(15)
              .fontColor(Color.White)
          }

        }
        .justifyContent(FlexAlign.Center)
        // .width('50%')
         .padding(5)
        .backgroundColor('#9AAAC1')
        .borderRadius(20)

        Row({space : 5}) {
          Image($r('app.media.rainfall'))
            .width(15)
            .fillColor(Color.White)
          if (Number(this.rainfall1) + Number(this.rainfall2) == 0){
            Text('2小时内无降水')
              .fontSize(15)
              .fontColor(Color.White)
          }
          else {
            Text('2小时内有降水')
              .fontSize(15)
              .fontColor(Color.White)
          }
        }
        .padding(5)
        .backgroundColor('#9AAAC1')
        .borderRadius(20)
      }
    }
    .width('100%')
    .height(500)
    .justifyContent(FlexAlign.Center)
  }
}