import WeatherInfo from '../../Model/WeatherInfo'

//七日折线图绘图
@Component
export default struct QuadraticCurveTo {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  @State weather : WeatherInfo[] = []
  build() {
    Row() {
      Scroll() {
        Row() {

          Column() {

            Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
              Canvas(this.context)
                .width('100%')
                .height('100%')
                .backgroundColor(Color.Brown)
                .onReady(() => {

                })
            }

          }
        }
        .width(500)

      }
      .scrollable(ScrollDirection.Horizontal)
      .borderRadius({bottomLeft:20,bottomRight:20})

    }
    .height(220)
    .backgroundColor(Color.Brown)
  }
}