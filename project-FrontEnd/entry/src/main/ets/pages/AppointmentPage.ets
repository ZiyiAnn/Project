import router from '@ohos.router';
import { CommonConstants } from '../common/constants/CommonConstants';

@Entry
@Component
struct ReservationFormPage {
  // 定义预约表单的数据结构
  data: {
    CID: string,
    occuTime: string,
    reservations: string,
    reason: string,
    date: string,
    type: string
  } = {
    CID: "",
    occuTime: "",
    reservations: "",
    reason: "",
    date: "",
    type: ""
  };

  build() {
    Column() {
      // 标题栏
      Row() {
        Image($r('app.media.ic_back'))
          .width($r('app.float.image_size'))
          .height($r('app.float.image_size'))
          .margin({ left: $r('app.float.image_margin_left'), right: $r('app.float.image_margin_right') })
          .onClick(() => {
            router.back();
          })

        Text("预约教室")
          .fontSize($r('app.float.title_text_size'))
          .fontColor($r('app.color.title'))
          .fontWeight(CommonConstants.TITLE_FONT_WEIGHT)
      }
      .width(CommonConstants.FULL_WIDTH_PERCENT)
      .height($r('app.float.title_height'))
      .backgroundColor($r('app.color.rect_stroke'))
      .padding({ left: 20, right: 20 })

      // 账号输入框
      Text("账号:")
        .fontSize(18)
        .margin({ top: 35,bottom: 10, left: 20, right: 20 })
      TextInput({ text: this.data.reservations, placeholder: "账号" })
        .onChange((value: string) => {
          this.data.reservations = value;
        })
        .height(50)
        .margin({ bottom: 30, left: 20, right: 20 })

      // 教室号输入框
      Text("教室号:")
        .fontSize(18)
        .margin({  bottom: 10, left: 20, right: 20 })
      TextInput({ text: this.data.CID, placeholder: "教室号" })
        .onChange((value: string) => {
          this.data.CID = value;
        })
        .height(50)
        .margin({ bottom: 30, left: 20, right: 20 })

      // 日期输入框
      Text("日期:")
        .fontSize(18)
        .margin({bottom: 10, left: 20, right: 20 })
      TextInput({ text: this.data.date, placeholder: "日期 (格式: YYYY-MM-DD)" })
        .onChange((value: string) => {
          this.data.date = value;
        })
        .height(50)
        .margin({ bottom: 30, left: 20, right: 20 })

      // 占用时间段下拉列表
      Text("占用时间段:")
        .fontSize(18)
        .margin({  top:10,left: 20, right: 20 })
      Select([
        { value: '1' }, { value: '2' }, { value: '3' }, { value: '4' },
        { value: '5' }, { value: '6' }, { value: '7' }, { value: '8' },
        { value: '9' }, { value: '10' }, { value: '11' }, { value: '12' }
      ])
        .height(50)
        .margin({ bottom: 10, left: 20, right: 20 })

      // 预约原因下拉列表
      Text("占用类型:")
        .fontSize(18)
        .margin({ left: 20, right: 20 })
      Select([
        { value: "课程占用"},
        { value: "个人/团体占用"}
      ])
        .height(50)
        .margin({ bottom: 10, left: 20, right: 20 })

      // 预约原因输入框
      Text("原因:")
        .fontSize(18)
        .margin({ bottom: 10, left: 20, right: 20 })
      TextInput({ text: this.data.reason, placeholder: "原因" })
        .onChange((value: string) => {
          this.data.reason = value;
        })
        .height(50)
        .margin({ bottom: 20, left: 20, right: 20 })

      // 提交按钮
      Button("提交")
        .onClick(() => {
          router.replaceUrl({ url: 'pages/AppointmentSuccessPage' });
        })
        .fontSize(20)
        .height(50)
        .margin({ bottom: 20, left: 20, right: 20 })
        .opacity(0.8).backgroundColor('#ff173c08').width(200)
    }
  }
}
