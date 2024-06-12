import router from '@ohos.router';
import { CommonConstants } from '../common/constants/CommonConstants';

@Entry
@Component
struct AdminMainPage {
  // 定义按钮是否被点击的状态
  @State clickedButton: string = "";
  build() {
    Column() {
      // 标题栏
      Row() {
        Image($r('app.media.ic_back'))
          .width($r('app.float.image_size'))
          .height($r('app.float.image_size'))
          .margin({ left: $r('app.float.image_margin_left'), right: $r('app.float.image_margin_right') })
          .onClick(() => {
            router.replaceUrl({ url: 'pages/LoginPage' });
          })

        Text("系统管理")
          .fontSize($r('app.float.title_text_size'))
          .fontColor($r('app.color.title'))
          .fontWeight(CommonConstants.TITLE_FONT_WEIGHT)
      }
      .width(CommonConstants.FULL_WIDTH_PERCENT)
      .height($r('app.float.title_height'))
      .backgroundColor($r('app.color.rect_stroke'))
      .padding({ left: 20, right: 20 })

      // 内容区域
      Column() {
        // 按钮1 - 教室管理
        Button("教室管理",{type: ButtonType.Normal})
          .width(this.clickedButton === "classroom" ? "90%" : "80%")
          .height(this.clickedButton === "classroom" ? 70 : 60)
          .onClick(() => {
            this.clickedButton = "message";
            router.replaceUrl({ url: 'pages/ClassroomManagementPage' });
          })
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .backgroundColor('#ff4370c8')
          .fontColor('#fff')
          .height(60)
          .borderRadius(10)
          .margin({ top: 40, bottom: 30, left: 20, right: 20 })
          .padding({ left: 20, right: 20 })
          .width(300)

        // 按钮2 - 预约管理
        Button("预约管理",{type: ButtonType.Normal})
          .width(this.clickedButton === "classroom" ? "90%" : "80%")
          .height(this.clickedButton === "classroom" ? 70 : 60)
          .onClick(() => {
            this.clickedButton = "message";
            router.replaceUrl({ url: 'pages/AppointmentManagementPage' });
          })
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .backgroundColor('#ff4370c8')
          .fontColor('#fff')
          .height(60)
          .borderRadius(10)
          .margin({ bottom: 30, left: 20, right: 20 })
          .padding({ left: 20, right: 20 })
          .width(300)

        // 按钮3 - 公告管理
        Button("公告管理",{type: ButtonType.Normal})
          .width(this.clickedButton === "classroom" ? "90%" : "80%")
          .height(this.clickedButton === "classroom" ? 70 : 60)
          .onClick(() => {
            this.clickedButton = "message";
            router.replaceUrl({ url: 'pages/MessageManagementPage' });
          })
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .backgroundColor('#ff4370c8')
          .fontColor('#fff')
          .height(60)
          .borderRadius(10)
          .margin({ bottom: 20, left: 20, right: 20 })
          .padding({ left: 20, right: 20 })
          .width(300)
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ top: 30, bottom: 30 })
    }
    .width(CommonConstants.FULL_WIDTH_PERCENT)
    .height(CommonConstants.FULL_HEIGHT_PERCENT)
    .backgroundColor('#fff3f3f3')
  }
}
