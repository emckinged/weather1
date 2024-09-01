import http from '@ohos.net.http';
import WeatherInfo from '../Model/AqiInfo';

class AqiModel{

  key: string = '108.9,34.1'
  getAqiList(key1 : string): Promise<WeatherInfo[]>{
    return new Promise((resolve, reject) => {
      // 1.创建http的请求对象
      let httpRequest4 = http.createHttp()
      // 2.发送请求
      httpRequest4.request(
        `https://api.qweather.com/v7/air/5d?location=${key1}&key=7cb92d7a26da4290a77e372ae65bced4`,
        {
          method: http.RequestMethod.GET
        }
      )
        .then(resp => {
          if(resp.responseCode === 200){
            // 查询成功
            console.log('查询成功！', resp.result)
            resolve(JSON.parse(resp.result.toString()))
          }else{
            console.log('查询信息失败！error:', JSON.stringify(resp))
            reject('查询失败')
          }
        })
        .catch((error:Error) => {
          console.log('查询信息失败！error:', JSON.stringify(error))
          reject('查询失败')
        })
    })
  }
}

const aqiModel = new AqiModel();

export default aqiModel as AqiModel;