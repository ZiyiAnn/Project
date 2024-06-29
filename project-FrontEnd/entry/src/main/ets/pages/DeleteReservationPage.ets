import router from '@ohos.router';
import http from '@ohos.net.http';
import Prompt from '@system.prompt';
import { CommonConstants } from '../common/constants/CommonConstants';

/**
 * Delete Reservation Page, for canceling a specific reservation.
 */

@Entry
@Component
struct DeleteReservationPage {
  @State userId: string = "";
  @State dateTime: string = "";
  @State occuTime: number = 0;
  @State CID: number = 0;
  @State loading: boolean = false;

  aboutToAppear() {
    const params = router.getParams();
    this.userId = params['reservations'];
    this.dateTime = params['dateTime'];
    this.occuTime = params['occuTime'];
    this.CID = params['CID'];
  }

  cancelReservation() {
    const httpRequest = http.createHttp();
    const apiEndpoint = 'http://60.205.140.106:8080/deleteUserReservations';

    const postData = JSON.stringify({
      reservations: this.userId,
      dateTime: this.dateTime,
      occuTime: this.occuTime,
      CID: this.CID
    });

    this.loading = true;
    httpRequest.request(
      apiEndpoint, {
      method: http.RequestMethod.POST,
      header: {
        'Content-Type': 'application/json'
      },
      extraData: postData
    },
      (err, data) => {
        this.loading = false;
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
                message: "撤销成功",
                buttons: [{
                  text: "确定",
                  color: '#666666',
                }]
              });
              router.replaceUrl({
                url: 'pages/AppointmentRecordPage',
                params: {
                  id: this.userId
                }
              });
            } else {
              Prompt.showDialog({
                message: "撤销失败，请稍后再试。",
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
      this.Title()
      Column() {
        Text("是否确定要撤销此预约？")
          .fontSize(18)
          .margin({ top: 30, bottom: 20 })

        // Display the reservation details
        Text(`预约 ID: ${this.userId}`)
          .fontSize(16)
          .margin({ top: 10, bottom: 10 })

        Text(`预约日期: ${this.dateTime}`)
          .fontSize(16)
          .margin({ top: 10, bottom: 10 })

        Text(`预约时间: ${this.occuTime}`)
          .fontSize(16)
          .margin({ top: 10, bottom: 10 })

        Text(`CID: ${this.CID}`)
          .fontSize(16)
          .margin({ top: 10, bottom: 30 })

        Row() {
          Button("确定")
            .onClick(() => {
              this.cancelReservation();
            })
            .padding(10)
            .backgroundColor('#007AFF')
            .fontColor('#FFFFFF')
            .borderRadius(5)
            .width(100)
            .margin({ left:65,right: 30 });

          Button("取消")
            .onClick(() => {
              router.back();
            })
            .padding(10)
            .backgroundColor('#D3D3D3')
            .fontColor('#000000')
            .width(100)
            .borderRadius(5);
        }
        .width('100%')
      }
      .width('100%')
      .padding({top:20,bottom:40})
      .backgroundColor('#FFFFFF')
      .alignItems(HorizontalAlign.Center);

      if (this.loading) {
        Text("正在处理...")
          .fontSize(18)
          .margin({ top: 20 })
      }
    }
    .backgroundColor($r('app.color.login_page_background'))
    .height("100%")
  }

  @Builder Title() {
    Row() {
      Image($r('app.media.ic_back'))
        .width($r('app.float.image_size'))
        .height($r('app.float.image_size'))
        .margin({ left: $r('app.float.image_margin_left'), right: $r('app.float.image_margin_right') })
        .onClick(() => {
          router.pushUrl({
            url: "pages/AppointmentRecordPage",
            params:{
              id:this.userId
            }
          });
        })

      Text("撤销预约")
        .fontSize($r('app.float.title_text_size'))
        .fontColor($r('app.color.title'))
        .fontWeight(CommonConstants.TITLE_FONT_WEIGHT)
    }
    .width(CommonConstants.FULL_WIDTH_PERCENT)
    .height($r('app.float.title_height'))
  }
}
