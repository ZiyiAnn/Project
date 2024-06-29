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
struct UnprocessedReservationsPage {
  @State reservations: { occuStatus: number, occuTime: number, reservations: string, reason: string, type: number, dateTime: string, cid: number }[] = [];
  @State userid: string="";

  // Fetch unprocessed reservations from the backend
  fetchUnprocessedReservations() {
    const httpRequest = http.createHttp();
    const apiEndpoint = 'http://60.205.140.106:8080/checkReservationsNo';

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
              this.reservations = response.reservations;
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

  // Navigate to detail page
  navigateToDetail(index: number) {
    router.replaceUrl({
      url: 'pages/AppointmentDetailPage',
      params: {
        reservationIndex: index,
        id:this.userid
      }
    });
  }

  aboutToAppear() {
    let id = router.getParams()['id'] as string;
    this.userid=id;
    this.fetchUnprocessedReservations();
  }

  build() {
    Column() {
      // Top bar with title
      Row() {
        Text("<- ")
          .fontSize($r('app.float.title_text_size'))
          .fontColor('#fff')
          .onClick(() => {
            router.replaceUrl({ url: 'pages/AppointmentManagementPage',params:{id:this.userid}});
          })

        Text("未处理预约")
          .fontSize($r('app.float.title_text_size'))
          .fontColor('#fff')
          .fontWeight(CommonConstants.TITLE_FONT_WEIGHT)
      }
      .width(CommonConstants.FULL_WIDTH_PERCENT)
      .height($r('app.float.title_height'))
      .backgroundColor('#ff913b3b')
      .padding({ left: 20, right: 20 })

      // Reservations list
      Scroll() {
        Column() {
          ForEach(this.reservations, (reservation, index) => {
            Column() {
              Row() {
                Column() {
                  Text(`教室号: ${reservation.cid}`)
                    .fontSize(18)
                    .margin({ bottom: 5 })
                  Text(`日期: ${reservation.dateTime}`)
                    .fontSize(16)
                    .margin({ bottom: 5 })
                  Text(`时间段: ${reservation.occuTime}`)
                    .fontSize(16)
                    .margin({ bottom: 5 })
                  Text(`预约账号: ${reservation.reservations}`)
                    .fontSize(16)
                    .margin({ bottom: 5 })
                  Text(`预约原因: ${reservation.reason}`)
                    .fontSize(16)
                    .margin({ bottom: 5 })
                  Text(`类型: ${reservation.type}`)
                    .fontSize(16)
                    .margin({ bottom: 10 })
                }
                .width('80%')

                Image('arrow_icon.png')
                  .width(24)
                  .height(24)
                  .alignSelf(ItemAlign.Center)
                  .onClick(() => {
                    router.pushUrl({
                      url: "pages/AppointmentDetailPage",
                      params:{
                        CID:reservation.cid,
                        dataTime:reservation.dateTime,
                        occuTime:reservation.occuTime,
                        userid:reservation.reservations,
                        reason:reservation.reason,
                        type: reservation.type,
                        id:this.userid
                      }
                    });
                  })
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
}
