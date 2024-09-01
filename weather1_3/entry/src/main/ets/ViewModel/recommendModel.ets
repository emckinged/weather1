
import http from '@ohos.net.http';
import RecommendInfo from '../Model/RecommendInfo';

class RecommendModel{

  key: string = '108.9,34.1'

  getRecommendList(key1 : string): Promise<RecommendInfo[]>{
    return new Promise((resolve, reject) => {
      // 1.创建http的请求对象
      let httpRequest5 = http.createHttp()
      // 2.发送请求
      httpRequest5.request(
        `https://api.qweather.com/v7/indices/1d?type=1,2,3,4,5,6&location=${key1}&key=7cb92d7a26da4290a77e372ae65bced4`,
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

const recommendModel = new RecommendModel();

export default recommendModel as RecommendModel;