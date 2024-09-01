import router from '@ohos.router';
@Component
export default struct MyHeader {
  @Prop header : string = '长安区'

  build() {
      //顶部
    Row() {
      // Image($r('app.media.plus'))
      //   .width(30)
      //   .fillColor(Color.White)
       Button() {
         Image($r('app.media.plus'))
           .width(30)
           .fillColor(Color.White)
       }
       .backgroundColor(Color.Transparent)
      .onClick(() => {
        router.replaceUrl({
          url:'pages/search',
        })
      })
      Text(this.header)
        .fontSize(30)
        .fontWeight(FontWeight.Bolder)
        .fontColor(Color.White)
      Image($r('app.media.gearshape'))
        .width(30)
        .fillColor(Color.White)
    }
    .width('100%')
    .padding({top:20,left:20,right:20})
    .justifyContent(FlexAlign.SpaceBetween)
    // .backgroundColor('#8296AF')
  }
}