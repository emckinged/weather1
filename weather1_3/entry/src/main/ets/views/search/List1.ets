import GeoInfo from '../../Model/GeoInfo'
import GeoModel from '../../ViewModel/geoModel'
import PreferenceUtil from '../../utils/PreferenceUtil'
import { router } from '@kit.ArkUI'

@Component
export default struct List1 {
  @State geo : GeoInfo[] = []
  @Prop imKey :string = ''
  @State space : string = ''
  @State i : number = 0
  aboutToAppear(): void {
    this.loadGeoInfo()
    for (let index = 1; index < 10; index++) {
      PreferenceUtil.getPreferenceValue(`name${index}`, null)
        .then((value) => {
          if ((value === null || value === undefined) && this.i == 0) {
            console.log('值未填入');
            this.space = index.toString()
            this.i = 1
          }
        })
        .catch((error: Error) => {
          console.error('获取值时出现错误', error);
        });
    }
  }



  build() {
    if(this.geo.length) {
      Column() {
        List() {
          ForEach(this.geo[0].location,(item : string,Index) => {
            ListItem() {
              Row() {
                Text(this.geo[0].location[Index].name+'-'+this.geo[0].location[Index].adm1+' '+this.geo[0].location[Index].country)
                  .fontSize(20)
                Button('+')
                  .onClick(() => {
                    PreferenceUtil.putPreferenceValue(`name${this.space}`,{cityInfo : [this.geo[0].location[Index].name,this.geo[0].location[Index].id]})
                    console.log('存进来啦啦啦啦啦啦啦',this.geo[0].location[Index].name)
                    router.replaceUrl({
                      url : 'pages/Index'
                    })
                  })
              }
              .width('100%')
              .height(50)
              .borderRadius(5)
              .justifyContent(FlexAlign.SpaceBetween)
            }

          })
          ListItem() {
            Text(' ')
          }
          .height(150)
        }
      }
      .width('100%')
      .height('100%')
      .padding(10)
    }
  }


  loadGeoInfo(){
    // 加载数据
    GeoModel.getGeoList(this.imKey)
      .then(resp => {

        this.geo = this.geo.concat(resp); // 将新获取的天气信息合并到现有数组中
        if (this.geo.length > 0) {
          // 打印最新添加的 WeatherInfo 的 code（注意索引可能超出范围，但这里假设至少有一个元素）
          console.log('geo code',this.geo[this.geo.length - 1].code);
        }
        console.log('geo',this.geo[0].location[0].id)
      })
      .catch((error:Error) => {
        console.error('Failed to load geo list:', error);
      });
  }
}