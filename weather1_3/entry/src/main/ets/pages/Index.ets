//能力
import router from '@ohos.router';
import PreferenceUtil from '../utils/PreferenceUtil'


//ViewModel
import TodayInfo from '../Model/TodayInfo'
import TodayModel from '../ViewModel/todayModel';
import WeatherInfo from '../Model/WeatherInfo'
import WeatherModel from '../ViewModel/weatherModel'
import HourInfo from '../Model/HourInfo'
import HourModel from '../ViewModel/hourModel'
import AqiInfo from '../Model/AqiInfo'
import AqiModel from '../ViewModel/aqiModel'

//Views
import MyCentre from '../views/indexview/MyCentre'
import MyHeader from '../views/indexview/MyHeader'
import List_1_1 from '../views/indexview/List_1_1';
import List_1_2 from '../views/indexview/List_1_2'
import List_2_1 from '../views/indexview/List_2_1'
import List_2_2 from '../views/indexview/List_2_2'
import List_3_1 from '../views/indexview/List_3_1'
import List_3_2 from '../views/indexview/List_3_2'
//主页面
import Ain from '../pages/ain'

let city : string[] = ['长安区','上海市','咸阳市','北京市']
//108.9,34.1
class CityIn {
  cityInfo : string[] = []
}

let city1 :CityIn[] = [{cityInfo : ['西安市','108.9,34.1']},{cityInfo : ['上海','121.9,31.1']}]


@Entry
@Component
struct Index {

  //用于tabs变色
  @State Select : Number = 0
  //用于目录
  @State header : string = '西安市'
  //用来动态获得天气
  @State city2 : CityIn[] = []

  aboutToAppear(): void {
    PreferenceUtil.putPreferenceValue('name1', city1[0])
    PreferenceUtil.putPreferenceValue('name2', city1[1])
    if (city1 && city1[0] && city1[0].cityInfo && city1[0].cityInfo[1]) {
      console.log('城市', city1[0].cityInfo[1]);
    }




      for (let index = 1; index < 10; index++) {
        PreferenceUtil.getPreferenceValue(`name${index}`, null)
          .then((value) => {
            // if (value === null || value === undefined) {
            //   console.log('值未填入');
            // } else if (typeof value === 'object' && value !== null && (value as CityIn).cityInfo) {
            //   let a1 = value as CityIn;
            //   console.log(city1.length.toString());
            //   city1[city1.length] = a1
            //   console.log('CHENGGONG',a1.cityInfo[0]?.toString() ?? 'cityInfo[0] is null or undefined');
            // }

            if (value === null || value === undefined) {
              console.log('值未填入');
            } else if (typeof value === 'object' && value !== null && (value as CityIn).cityInfo) {
              let a1 = value as CityIn;
              console.log(this.city2.length.toString());
              this.city2[this.city2.length] = a1
              console.log('CHENGGONG',a1.cityInfo[0]?.toString() ?? 'cityInfo[0] is null or undefined');
            }

            // else if (value) {
            //   let a1 = value as CityIn;
            //   console.log(city1.length.toString());
            //   city1[city1.length] = a1
            //   console.log('CHENGGONG',a1.cityInfo[0]?.toString() ?? 'cityInfo[0] is null or undefined');
            // }
            else {
              console.log('获取到的值不是有效的 CityIn 对象或缺少 cityInfo 属性1');
            }
          })
          .catch((error: Error) => {
            console.error('获取值时出现错误', error);
          });
      }


  }

  @Builder
  tabBarBuilder(itemIndex : number) {
      Row() {
        Text('•')
          .fontSize(30)
          .fontColor(itemIndex == this.Select ? Color.White : '#D6DFEA')
      }
  }

  build() {
    Column() {
      Column() {
        MyHeader({
          header : this.header
        })

        Tabs() {

          ForEach(this.city2,(item : string,Index) => {
            TabContent() {
              Column() {
                Ain({
                  key1 : this.city2[Index].cityInfo[1]
                })
              }
            }
            .tabBar(this.tabBarBuilder(Index))
          })

        }
        .onChange((Index : number) => {
          this.Select = Index
          this.header = this.city2[Index].cityInfo[0]
          // console.log(city1[Index].cityInfo[1])
        })
        .barWidth('50%')
        .barHeight(30)

        .width('100%')
        .height('100%')

      }
      .width('100%')
    }
    .width('100%')
    .height('110%')
    .backgroundImage($r('app.media.yintian'))
    .backgroundImageSize(ImageSize.Cover)
  }
}