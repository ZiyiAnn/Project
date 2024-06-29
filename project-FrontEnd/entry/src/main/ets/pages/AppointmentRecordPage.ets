import router from '@ohos.router';
import http from '@ohos.net.http';
import Prompt from '@system.prompt';
import { CommonConstants } from '../common/constants/CommonConstants';

/**
 * Reservation List Page, displaying user reservation records.
 */

interface Reservation {
  occuStatus: number,
  occuTime: number,
  reservations: string,
  reason: string,
  type: number,
  dateTime: string,
  checkStatus: number,
  cid: number
}

@Entry
@Component
struct ReservationListPage {
  @State reservations: Reservation[] = [];
  @State userId: string = "";
  private scroller: Scroller = new Scroller();

  aboutToAppear() {
    const userId = router.getParams()['id'] as string;
    this.userId = userId;
    this.loadReservations();
  }

  loadReservations() {
    const httpRequest = http.createHttp();
    const apiEndpoint = `http://60.205.140.106:8080/checkUserReservations?ID=${this.userId}`;

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
            console.log('Parsed Response:', response); // 调试信息

            if (response.success) {
              this.reservations = response.reservations;
              console.log('reservations:', this.reservations); // 调试信息
            } else {
              console.error('Failed to load reservations: Unsuccessful response');
            }
          } catch (e) {
            console.error('Failed to parse response:', e);
          }
        } else {
          console.error('Unexpected response type:', typeof data.result);
        }
      });
  }

  navigateToDelPage(reservation: Reservation) {
    router.replaceUrl({
      url: 'pages/DeleteReservationPage',
      params: {
        reservations: this.userId,
        dateTime: reservation.dateTime,
        occuTime: reservation.occuTime,
        CID: reservation.cid
      }
    });
  }

  build() {
    Column() {
      this.Title()
      Scroll(this.scroller) {
        Column() {
          ForEach(this.reservations, (reservation: Reservation) => {
            Row() {
              Column() {
                Text(`预约ID: ${reservation.cid}`)
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .margin({ bottom: 5 });
                Text(`占用状态: ${reservation.occuStatus}`)
                  .margin({ bottom: 5 });
                Text(`占用时间: ${reservation.occuTime}`)
                  .margin({ bottom: 5 });
                Text(`预约人: ${reservation.reservations}`)
                  .margin({ bottom: 5 });
                Text(`原因: ${reservation.reason}`)
                  .margin({ bottom: 5 });
                Text(`类型: ${reservation.type}`)
                  .margin({ bottom: 5 });
                Text(`日期: ${reservation.dateTime}`)
                  .margin({ bottom: 5 });
                /*Text(`审核状态: ${reservation.checkStatus}`)
                  .margin({ bottom: 5 });*/
              }
              .padding(10)
              .backgroundColor('#F8F8F8')
              .borderRadius(5)
              .margin({ bottom: 10 })
              .width('75%');

              Button("撤销")
                .onClick(() => {
                  this.navigateToDelPage(reservation);
                })
                .padding(10)
                .backgroundColor('#007AFF')
                .fontColor('#FFFFFF')
                .borderRadius(5)
                .height(200)
                .width('20%')
                .margin({ left: 10 })
                .type(ButtonType.Capsule)
            }
            .width('100%');
          });
        }
        .width('100%')
        .padding(10)
        .backgroundColor('#FFFFFF');
      }
      .width('100%')
      .scrollBar(BarState.On)
      .scrollable(ScrollDirection.Vertical);
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
          router.back()
        })

      Text("预约记录")
        .fontSize($r('app.float.title_text_size'))
        .fontColor($r('app.color.title'))
        .fontWeight(CommonConstants.TITLE_FONT_WEIGHT)
    }
    .width(CommonConstants.FULL_WIDTH_PERCENT)
    .height($r('app.float.title_height'))
  }
}
