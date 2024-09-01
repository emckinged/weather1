import router from '@ohos.router';
import PreferenceUtil from '../utils/PreferenceUtil'
import Load from '../pages/load'
import load from '../pages/load';
import GeoInfo from '../Model/GeoInfo'
import GeoModel from '../ViewModel/geoModel'
import List1 from '../views/search/List1'

class CityIn {
  cityInfo : string[] = []
}



@Entry
@Component
struct search {
  @State city1: CityIn[] = []
  @State geo: GeoInfo[] = []
  @State key2: string = ''
  @State imKey: string = 'beij'
  @State i: number = 0

  aboutToAppear(): void {

    if (this.city1 && this.city1[0] && this.city1[0].cityInfo && this.city1[0].cityInfo[1]) {
      console.log('城市', this.city1[0].cityInfo[1]);
    }

    //找出给定的十个首选项位置中存储值了的，并存入city1[]
    for (let index = 1; index < 10; index++) {
      PreferenceUtil.getPreferenceValue(`name${index}`, null)
        .then((value) => {
          if (value === null || value === undefined) {
            console.log('值未填入');
          } else if (typeof value === 'object' && value !== null && (value as CityIn).cityInfo) {
            let a1 = value as CityIn;
            console.log(this.city1.length.toString());
            this.city1[this.city1.length] = a1
            console.log('有没有', this.city1.length)
            console.log('CHENGGONG', a1.cityInfo[0]?.toString() ?? 'cityInfo[0] is null or undefined');
          } else {
            console.log('获取到的值不是有效的 CityIn 对象或缺少 cityInfo 属性2');
          }
        })
        .catch((error: Error) => {
          console.error('获取值时出现错误', error);
        });
    }


  }

  build() {
    Column({ space: 20 }) {

      Column({ space: 20 }) {
        Row() {
          Button() {
            Image($r('app.media.arrow_left'))
              .width(35)
          }
          .backgroundColor(Color.White)
          .onClick(() => {
            router.replaceUrl({
              url: 'pages/Index'
            })
          })
        }
        .width('100%')

        Row() {
          Text('城市管理')
            .fontSize(42)
        }
        .width('100%')

      }

      Column() {
        Row() {
          TextInput({

            placeholder: '请输入内容'
          })
            .onChange((value) => this.key2 = value)
            .width('60%')
            .backgroundColor(Color.Transparent)
          Button('搜索')
            .onClick(() => {
              console.log(this.key2)
              this.imKey = this.key2
              this.i++
            })
            .fontColor(Color.Blue)
            .backgroundColor(Color.Transparent)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .borderRadius(20)
        .backgroundColor('#F4F6F5')
      }

      if (this.i) {
        List1({
          imKey: this.imKey
        })
      }


      Column() {
        List({ space: 10 }) {
          ForEach(this.city1, (item: string, Index) => {
            ListItem() {
              load({
                cityName: this.city1[Index].cityInfo[0],
                key1: this.city1[Index].cityInfo[1]
              })

            }
            .width('100%')
            .borderRadius(30)
            .backgroundColor('#8296AF')
          })

          ListItem() {
            Text('')
              .width('100%')
              .height(160)
              .borderRadius(30)

          }
          .width('100%')

        }

      }
      .padding(10)
    }

  }
}