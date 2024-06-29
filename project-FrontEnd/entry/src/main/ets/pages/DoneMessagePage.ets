import router from '@ohos.router';
import http from '@ohos.net.http';
import Prompt from '@system.prompt';
import { CommonConstants } from '../common/constants/CommonConstants';

/**
 * UnprocessedReservationsPage displays a list of unprocessed reservation requests.
 * Each item in the list includes reservation details and an arrow icon
 * that navigates to the detail page when clicked.
 */
@Entry
@Component
struct messagePage {
  @State messages: {
    content: string,
    sender:string,
    receiver: string,
    dateTime: string,
    status: number,
    id: number }[] = [];
  @State userid: string="";

  // Fetch unprocessed reservations from the backend
  fetchProcessedMessages() {
    const httpRequest = http.createHttp();
    const apiEndpoint = 'http://60.205.140.106:8080/getMessageYes';

    httpRequest.request(
      apiEndpoint, {
      method: http.RequestMethod.GET,
      header: {
        'Content-Type': 'application/json'
      }
    },
      (err, data) => {
        if (err) {
          console.error('Network request error:', err);
          Prompt.showDialog({
            message: "网络请求失败，请稍后再试。",
          });
          return;
        }

        if (typeof data.result === 'string') {
          try {
            const response = JSON.parse(data.result);
            if (response.success) {
              this.messages = response.message;
            } else {
              Prompt.showDialog({
                message: "获取数据失败，请稍后再试。",
              });
            }
          } catch (e) {
            console.error('Failed to parse response:', e);
            Prompt.showDialog({
              message: "解析响应失败，请稍后再试。",
            });
          }
        } else {
          console.error('Unexpected response type:', typeof data.result);
          Prompt.showDialog({
            message: "网络请求失败，请稍后再试。",
          });
        }
      });
  }

  aboutToAppear() {
    let id = router.getParams()['id'] as string;
    this.userid=id;
    this.fetchProcessedMessages();
  }

  build() {
    Column() {
      // Top bar with title
      Row() {
        Text("<- ")
          .fontSize($r('app.float.title_text_size'))
          .fontColor('#fff')
          .onClick(() => {
            router.pushUrl({url:"pages/AdminMessagePage",params:{id:this.userid}})
          })

        Text("已处理反馈")
          .fontSize($r('app.float.title_text_size'))
          .fontColor('#fff')
          .fontWeight(CommonConstants.TITLE_FONT_WEIGHT)
      }
      .width(CommonConstants.FULL_WIDTH_PERCENT)
      .height($r('app.float.title_height'))
      .backgroundColor('#ff476b36')
      .padding({ left: 20, right: 20 })

      // Reservations list
      Scroll() {
        Column() {
          ForEach(this.messages, (message, index) => {
            Column() {
              Row() {
                Column() {
                  Text(`${message.content}`)
                    .fontSize(18)
                    .margin({ bottom: 5 })
                    .padding(10)
                  Text(`发送者: ${message.sender}`)
                    .fontSize(16)
                    .margin({ bottom: 5 })
                  Text(`发送时间: ${message.dateTime}`)
                    .fontSize(16)
                    .margin({ bottom: 5 })
                }
                .width('80%')
                .margin({bottom:10})
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
      .padding({top:20})
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F0F0F0')
  }
}
