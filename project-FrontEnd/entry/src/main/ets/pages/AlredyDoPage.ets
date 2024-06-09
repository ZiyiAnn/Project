import router from '@ohos.router';
import { CommonConstants } from '../common/constants/CommonConstants';


/**
 * UnprocessedMessagesPage displays a list of unprocessed messages.
 * Each item in the list includes reservation details and an arrow icon
 * that navigates to the detail page when clicked.
 */
@Entry
@Component
struct UnprocessedMessagesPage {
  @State messages: { account: string, date: string, type: string }[] = [
    { account: "S2021111230", date: "2024-06-09", type: "课程预约" },
    { account: "S2021128976", date: "2024-06-08", type: "个人/团体预约" },
    { account: "T2024556374", date: "2024-06-07", type: "课程预约" },
  // ... 其他消息
  ];

  build() {
    Column() {
      // Top bar with title
      Row() {
        /*Image('backicon.png')
          .width($r('app.float.image_size'))
          .height($r('app.float.image_size'))
          .margin({ left: $r('app.float.image_margin_left'), right: $r('app.float.image_margin_right') })*/
        Text("<- ")
          .fontSize($r('app.float.title_text_size'))
          .fontColor('#fff')
          .fontWeight(CommonConstants.TITLE_FONT_WEIGHT)
          .onClick(() => {
            router.replaceUrl({url:'pages/AppointmentManagementPage'})
          })

        Text("已处理消息")
          .fontSize($r('app.float.title_text_size'))
          .fontColor('#fff')
          .fontWeight(CommonConstants.TITLE_FONT_WEIGHT)
      }
      .width(CommonConstants.FULL_WIDTH_PERCENT)
      .height($r('app.float.title_height'))
      .backgroundColor('#ff346728')
      .padding({ left: 20, right: 20 })

      // Messages list
      Scroll() {
        Column() {
          ForEach(this.messages, (message, index) => {
            Column() {
              Row() {
                Column() {
                  Text(`预约账号: ${message.account}`)
                    .fontSize(18)
                    .margin({ bottom: 5 })
                  Text(`预约日期: ${message.date}`)
                    .fontSize(16)
                    .margin({ bottom: 5 })
                  Text(`预约类型: ${message.type}`)
                    .fontSize(16)
                    .margin({ bottom: 10 })
                }
                .width('80%')

                Image('arrow_icon.png')
                  .width(24)
                  .height(24)
                  .alignSelf(ItemAlign.Center)
                  .onClick(() => this.navigateToDetail(index))
              }
              .padding(10)
              .backgroundColor('#F9F9F9')
              .borderRadius(5)
              .margin({ bottom: 10 })
            }
            .padding({ left: 20, right: 20 })
          })
        }
        .width(CommonConstants.FULL_WIDTH_PERCENT)
      }
      .scrollable(ScrollDirection.Vertical)  // 滚动方向纵向
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F0F0F0')
  }

  navigateToDetail(index: number) {
    router.replaceUrl({
      url: 'pages/AppointmentDetailPage',
      params: {
        messageIndex: index
      }
    });
  }
}
