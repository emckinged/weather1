import { preferences } from '@kit.ArkData'

class PrefUtil {
  // 首选项实例
  private pref: preferences.Preferences | null = null

  /*
  * 初始化preferences实例
  * @context  应用上下文
  */
  async loadPreference(context: Context) {
    try {
      this.pref = await preferences.getPreferences(context, 'mydata')
      console.log('preferences[mydata]加载成功')
    } catch (err) {
      console.error('preferences[mydata]加载失败')
      console.error('err: ', JSON.stringify(err))
    }
  }

  /*
   * 销毁preferences实例-缓存、持久化文件一并销毁
   * @context应用上下文
  */
  async delPreference(context: Context) {
    try {
      await preferences.deletePreferences(context, 'mydata')
      console.log('preferences[mydata}]销毁成功')
    } catch (err) {
      console.error('preferences[mydata]销毁失败')
      console.error('err: ', JSON.stringify(err))
    }
  }

  /*
   * 从preferences实例中获取键对应的值
   * @key 键
   * @defaultValue 获取失败时，返回的值
  */
  async getPreferenceValue(key: string, defaultValue: preferences.ValueType): Promise<preferences.ValueType> {
    let value = defaultValue
    if (!this.pref) {
      console.error('preferences[mydata]未初始化！')
      return value
    }
    try {
      value = await this.pref.get(key, defaultValue) //读取
      console.log(`preferences[mydata]读取${value}成功！`)
    } catch (err) {
      console.error('preferences[mydata]读取失败')
      console.error('err: ', JSON.stringify(err))
    }
    return value
  }

  /**
   * 获取preferences的值
   */
  async putPreferenceValue(key: string, value: preferences.ValueType): Promise<void> {
    if (!this.pref) {
      console.error('preferences[mydata]未初始化！')
      return
    }
    try {
      await this.pref.put(key, value) //写入
      await this.pref.flush() //刷新
      console.log(`preferences[mydata]写入${value}成功！`)
    } catch (err) {
      console.error('preferences[mydata]写入失败')
      console.error('err: ', JSON.stringify(err))
    }
  }
}

const prefUtil = new PrefUtil()

export default prefUtil as PrefUtil

//export { prefUtil }