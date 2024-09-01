import WeatherInfo from '../../Model/WeatherInfo'

let currentDate = new Date();
let formattedDate = currentDate.toLocaleTimeString();
console.log("当前时间:iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii " + formattedDate);

function timeToMinutes(timeStr: string): number {
  // 使用split方法按":"分割时间字符串
  let parts = timeStr.split(":");


  // 将小时和分钟字符串转换为数字
  let hoursStr = parts[0];
  let minutesStr = parts[1];
  let hours = parseInt(hoursStr, 10); // 第二个参数10表示十进制
  let minutes = parseInt(minutesStr, 10); // 同样，第二个参数10表示十进制

  // 将小时转换为分钟并加上原有的分钟
  let totalMinutes = hours * 60 + minutes;

  return totalMinutes;
}

//获取只保留小时和分钟的时间
function getCurrentTimeHHmm() {
  // 获取当前时间
  const now = new Date();

  // 获取小时和分钟，并使用padStart来确保它们是两位数
  const hours = now.getHours().toString().padStart(2, '0');
  const minutes = now.getMinutes().toString().padStart(2, '0');

  // 拼接小时和分钟并返回
  return `${hours}:${minutes}`;
}
//太阳升降绘图
@Component
export default struct QuadraticCurveTo {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  @State weather : WeatherInfo[] = []
  build() {
    Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Canvas(this.context)
        .width('100%')
        .height('100%')
        .backgroundColor('#8296AF')
        .borderRadius(20)
        .onReady(() =>{
          this.context.strokeStyle = Color.White
          const startX = 0, startY = 90;
          const cpX = 45, cpY = 0;
          const endX = 90, endY = 90;

          this.context.beginPath();

          this.context.moveTo(0,74)
          this.context.lineTo(100,74)
          this.context.stroke();


          // 选择一个t值
          let t = 1; // 例如，在曲线的中点
          if (this.weather[0].daily[0].sunset && this.weather[0].daily[0].sunrise) {
            if ( (Number(timeToMinutes(this.weather[0].daily[0].sunrise))) < (Number(timeToMinutes(getCurrentTimeHHmm()))) &&
              (Number(timeToMinutes(getCurrentTimeHHmm()))) < (Number(timeToMinutes(this.weather[0].daily[0].sunset)))) {
              t =  (Number(timeToMinutes(getCurrentTimeHHmm())))/
                (((Number(timeToMinutes(this.weather[0].daily[0].sunset))) - (Number(timeToMinutes(this.weather[0].daily[0].sunrise)))) * 2)
            }
            else if ((Number(timeToMinutes(this.weather[0].daily[0].sunrise))) >= (Number(timeToMinutes(getCurrentTimeHHmm())))) {
              t = ( (Number(timeToMinutes(getCurrentTimeHHmm()))) / (Number(timeToMinutes(this.weather[0].daily[0].sunrise)))) /10
            }
            else {
              t = 0.9 + ( ((Number(timeToMinutes(getCurrentTimeHHmm()))) - (Number(timeToMinutes(this.weather[0].daily[0].sunset)))) / (2400 - (Number(timeToMinutes(this.weather[0].daily[0].sunset)))) )/10
            }
          }
          if (this.weather[0].daily[0].sunset && this.weather[0].daily[0].sunrise) {
            console.log('t', t, timeToMinutes(this.weather[0].daily[0].sunrise),
              timeToMinutes(this.weather[0].daily[0].sunset),Number(timeToMinutes(getCurrentTimeHHmm())))
          }
          // 计算曲线上的点
          const x = Math.pow(1-t, 2) * startX + 2 * t * (1-t) * cpX + Math.pow(t, 2) * endX;
          const y = Math.pow(1-t, 2) * startY + 2 * t * (1-t) * cpY + Math.pow(t, 2) * endY;

          // 绘制曲线

          this.context.beginPath();
          this.context.moveTo(startX, startY);
          this.context.quadraticCurveTo(cpX, cpY, endX, endY);
          this.context.stroke();


          // 在计算出的点上画圆
          this.context.beginPath();
          this.context.strokeStyle = Color.White
          this.context.fillStyle = Color.White
          let grad = this.context.createLinearGradient(50, 100, 50, 0)
          grad.addColorStop(0.0, '#000000')
          grad.addColorStop(0.15, '#000000')
          grad.addColorStop(0.245, '#FF0000')
          grad.addColorStop(0.3, '#FFFF00')
          grad.addColorStop(1.0, '#FFFF00')
          this.context.fillStyle = grad
          this.context.arc(x, y, 5, 0, 2 * Math.PI); // 半径为5的圆
          this.context.fill();
          this.context.stroke()

          // 假设context是你的CanvasRenderingContext2D实例


        })
    }
    .width(100)
    .height(95)


  }
}