import router from '@ohos.router';
import { CommonConstants } from '../common/constants/CommonConstants';

@Entry
@Component
struct AdminMainPage {
  // 定义按钮是否被点击的状态
  @State clickedButton: string = "";
  @State userid: string="";
  aboutToAppear() {
    let id = router.getParams()['id'] as string;
    this.userid=id;
  }

  build() {
    Column() {
      // 标题栏
      Row() {
        Image($r('app.media.ic_back'))
          .width($r('app.float.image_size'))
          .height($r('app.float.image_size'))
          .margin({ left: $r('app.float.image_margin_left'), right: $r('app.float.image_margin_right') })
          .onClick(() => {
            router.replaceUrl({ url: 'pages/MainAdminPage',params:{id:this.userid} });
          })

        Text("预约管理")
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
        Button("未处理申请列表", { type: ButtonType.Normal })
          .width(this.clickedButton === "classroom" ? "90%" : "80%")
          .height(this.clickedButton === "classroom" ? 70 : 60)
          .onClick(() => {
            this.clickedButton = "message";
            router.replaceUrl({ url: 'pages/ApplyDealingPage',params:{id:this.userid} });
          })
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .backgroundColor('#ff7e1414')
          .fontColor('#fff')
          .height(80)
          .borderRadius(10)
          .margin({ top: 40, bottom: 30, left: 20, right: 20 })
          .padding({ left: 20, right: 20 })
          .width(300)


        Button("已处理申请列表", { type: ButtonType.Normal })
          .width(this.clickedButton === "classroom" ? "90%" : "80%")
          .height(this.clickedButton === "classroom" ? 70 : 60)
          .onClick(() => {
            this.clickedButton = "message";
            router.replaceUrl({ url: 'pages/AlredyDoPage',params:{id:this.userid} });
          })
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .backgroundColor('#ff297e45')
          .fontColor('#fff')
          .height(80)
          .borderRadius(10)
          .margin({ bottom: 30, left: 20, right: 20 })
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
