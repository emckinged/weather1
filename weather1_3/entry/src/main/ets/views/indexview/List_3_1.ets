import HourInfo from '../../Model/HourInfo'
let a:Array<string> = ['50','60','45','55','32','34','22','22','23']
let b:Array<string> = ['现在','22:00','23:00','24:00','0:00','1:00','2:00','3:00','4:00']

@Component
export default struct CanvasSimple {
  @State wi : number = 20
  @State wi2 : number = 20
  @Prop hour : HourInfo[] = []
  //用来配置CanvasRenderingContext2D对象的参数，包括是否开启抗锯齿，true表明开启抗锯齿。
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  //用来创建CanvasRenderingContext2D对象，通过在canvas中调用CanvasRenderingContext2D对象来绘制。
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  build() {
    Column() {
      Row({space : 5}) {
        Image($r('app.media.clock'))
          .width(20)
        Text('24小时预报')
          .fontSize(20)
          .fontColor('#B9D1FA')
      }
      .width('100%')
      .height(40)
      .padding(10)
      .backgroundColor('#8397B0')
      .borderRadius({topLeft:20,topRight:20})
      Row() {
        Scroll() {
          Row() {

            Column() {

              Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
                Canvas(this.context)
                  .width('100%')
                  .height('100%')
                  .backgroundColor('#8397B0')
                  .onReady(() => {

                    this.context.strokeStyle = '#FFFF00'; // 线条
                    this.context.lineWidth = 2;         //线条宽度
                    this.context.fillStyle = '#FFFFFF'; // 文本颜色为白色
                    this.context.font = '50px Arial';   //文本大小

                    let grad = this.context.createLinearGradient(0, 0, 0, 300)
                    grad.addColorStop(0.0, '#ff0000')
                    grad.addColorStop(1.0, '#00ff00')
                    this.context.fillStyle = grad
                    //绘制直线
                    this.context.beginPath();
                    this.context.moveTo(this.wi, (185 - Number(this.hour[0].hourly[0].temp)*4.4 ));
                    this.context.fillText(this.hour[0].hourly[0].temp, this.wi, (175 - Number(this.hour[0].hourly[0].temp)*4.4 ))
                    for (let index = 1; index < this.hour[0].hourly.length; index++) {
                      this.wi = this.wi + 50
                      this.context.lineTo(this.wi, (185 - Number(this.hour[0].hourly[index].temp)*4.4 ))
                      this.context.fillText(this.hour[0].hourly[index].temp, this.wi, (175 - Number(this.hour[0].hourly[index].temp)*4.4 ))
                    }
                    this.context.stroke();
                  })
              }

              ForEach(this.hour[0].hourly, (item : string,Index) => {
                Column({space : 5}) {
                  Image($r(`app.media.${this.hour[0].hourly[Index].icon}`))
                    .width(20)
                    .fillColor(Color.White)
                  Text(this.hour[0].hourly[Index].windScale+'级')
                    .fontColor('#B9D1FA')
                  Text(this.hour[0].hourly[Index].precip)
                    .fontColor(Color.White)
                    .backgroundColor('#7595CE')
                    .borderRadius(5)
                    .padding(5)
                  Text(this.hour[0].hourly[Index].fxTime.split('T')[1].split('+')[0])
                    .fontColor('#B9D1FA')
                }
                .position({x:50*Index-5,y:80})
                .padding(10)
              })
            }
          }
          .width(1150)
        }
        .scrollable(ScrollDirection.Horizontal)
        .borderRadius({bottomLeft:20,bottomRight:20})
      }
      .height(220)

    }
    .padding(10)
  }
}