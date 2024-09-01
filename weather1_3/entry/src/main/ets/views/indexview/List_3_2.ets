let a:Array<string> = ['50','60','45','55','32','34','22','22','23']
let b:Array<string> = ['现在','22:00','23:00','24:00','0:00','1:00','2:00','3:00','4:00']

@Component

export default struct CanvasSimple {
  @State wi : number = 20
  @State wi2 : number = 20
  //用来配置CanvasRenderingContext2D对象的参数，包括是否开启抗锯齿，true表明开启抗锯齿。
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  //用来创建CanvasRenderingContext2D对象，通过在canvas中调用CanvasRenderingContext2D对象来绘制。
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  build() {
    Column() {
      Row() {
        Text('标题')
      }
      .width('100%')
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
                    this.context.moveTo(this.wi, 120 - Number(a[0]));
                    this.context.fillText(a[0], this.wi, 110 - Number(a[0]))
                    for (let index = 1; index < a.length; index++) {
                      this.wi = this.wi + 50
                      this.context.lineTo(this.wi,120 - Number(a[index]))
                      this.context.fillText(a[index], this.wi, 110 - Number(a[index]))
                    }
                    this.context.stroke();
                  })
              }
              ForEach(b, (item : string,Index) => {
                Column({space : 5}) {
                  Image($r('app.media.100'))
                    .width(20)
                  Text('1'+'级')
                    .fontColor('#B9D1FA')
                  Text('良')
                    .fontColor(Color.White)
                    .backgroundColor('#7595CE')
                    .borderRadius(5)
                    .padding(5)
                  Text(item)
                    .fontColor('#B9D1FA')
                }
                .position({x:50*Index-5,y:100})
                .padding(10)
              })
            }
          }
          .width(1000)
        }
        .scrollable(ScrollDirection.Horizontal)
        .borderRadius(20)
      }
      .height(240)
    }
    .padding(10)
  }
}