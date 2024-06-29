import router from '@ohos.router';
import http from '@ohos.net.http';
import Prompt from '@system.prompt';
import { CommonConstants } from '../common/constants/CommonConstants';

@Entry
@Component
struct SendMessagePage {
  @State messageContent: string = '';
  @State senderId: string = '';

  aboutToAppear() {
    let id = router.getParams()['id'] as string;
    this.senderId=id;
    }

  sendMessage() {
    const messageData = {
      content: this.messageContent,
      sender: this.senderId
    };

    const httpRequest = http.createHttp();
    const apiEndpoint = 'http://60.205.140.106:8080/addMessage';

    httpRequest.request(
      apiEndpoint, {
      method: http.RequestMethod.POST,
      header: {
        'Content-Type': 'application/json'
      },
      extraData: JSON.stringify(messageData)
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
              Prompt.showDialog({
                message: "消息发送成功，请等待管理员处理",
                buttons: [{
                  text: "确定",
                  color: '#666666',
                }]
              });
            } else {
              Prompt.showDialog({
                message: `消息发送失败：${response.message}`,
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

  build() {
    Column() {
      Row() {
        Image($r('app.media.ic_back'))
          .width($r('app.float.image_size'))
          .height($r('app.float.image_size'))
          .margin({ left: $r('app.float.image_margin_left'), right: $r('app.float.image_margin_right') })
          .onClick(() => {
            router.back()
          })

        Text("消息反馈")
          .fontSize($r('app.float.title_text_size'))
          .fontColor($r('app.color.title'))
          .fontWeight(CommonConstants.TITLE_FONT_WEIGHT)
      }
      .width(CommonConstants.FULL_WIDTH_PERCENT)
      .height($r('app.float.title_height'))
      .backgroundColor($r('app.color.rect_stroke'))
      .padding({ left: 20, right: 20 })

      // 输入框
      Text("请输入消息内容:")
        .fontSize(18)
        .margin({ top: 50, bottom: 10, left: 20, right: 20 })
      TextInput({ text: this.messageContent, placeholder: "消息内容" })
        .onChange((value: string) => {
          this.messageContent = value;
        })
        .height(100)
        .margin({ top:10,bottom: 30, left: 20, right: 20 })

      // 提交按钮
      Button("发送消息")
        .onClick(() => {
          this.sendMessage();
        })
        .fontSize(20)
        .height(50)
        .margin({ bottom: 20, left: 20, right: 20 })
        .opacity(0.8)
        .backgroundColor('#007bff')
        .width(200)
    }
    .padding(16)
    .backgroundColor('#f5f5f5')
    .height('100%')
  }
}
