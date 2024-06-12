import router from '@ohos.router';
//import fetch from '@ohos.net.fetch';
import { CommonConstants } from '../common/constants/CommonConstants';

/**
 * ReservationDetailPage displays the details of a specific reservation.
 * It includes the classroom number, occupancy status, reservation date,
 * time period, account, type, and reason for the reservation.
 * At the bottom, there are buttons to approve or reject the reservation.
 */
@Entry
@Component
struct ReservationDetailPage {
  @State cid: string = '110101';
  @State dateTime: string = '2024-06-09';
  @State occuTime: string = '7';
  @State reservation: string = 'S2021110640';
  @State occuStatus: string = '0';
  @State type: string = '课程占用';
  @State reason: string = '有班会，希望借用';

  //@State isLoading: boolean = true;
  @State isLoading: boolean = false;
  @State errorMessage: string = '';

  onInit() {
    const params = router.getParams();
    /*this.cid = params.cid;
    this.dateTime = params.dateTime;
    this.occuTime = params.occuTime;
    this.reservation = params.reservation;*/

    this.fetchReservationDetails();
  }

  async fetchReservationDetails() {
    /*try {
      const response = await fetch(`http://your-springboot-api-url/api/reservation/details?cid=${this.cid}&dateTime=${this.dateTime}&occuTime=${this.occuTime}&reservation=${this.reservation}`);
      const data = await response.json();

      this.occuStatus = data.occuStatus;
      this.type = data.type;
      this.reason = data.reason;
      this.isLoading = false;
    } catch (error) {
      this.errorMessage = '无法获取预约详情，请稍后再试。';
      this.isLoading = false;
    }*/
  }

  /*updateReservationStatus(status: string) {
    fetch(`http://your-springboot-api-url/api/reservation/update`, {
      method: 'POST',
      body: JSON.stringify({
        cid: this.cid,
        dateTime: this.dateTime,
        occuTime: this.occuTime,
        reservation: this.reservation,
        status: status
      }),
      headers: { 'Content-Type': 'application/json' }
    }).then(response => {
      if (response.ok) {
        router.back();
      } else {
        this.errorMessage = '无法更新预约状态，请稍后再试。';
      }
    }).catch(error => {
      this.errorMessage = '无法更新预约状态，请稍后再试。';
    });
  }*/

  build() {
    Column() {
      // Top bar with title and back button
      Row() {
        /*Image('backicon.png')
          .width(24)
          .height(24)
          .margin({ right: 10 })
          .onClick(() => router.back())*/
        Text('<- ')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            router.replaceUrl({url:'pages/ApplyDealingPage'})
          })

        Text('预约审核详情')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
      }
      .padding(16)
      .backgroundColor('#FFFFFF')
      .width('100%')

      if (this.isLoading) {
        Text('加载中...')
          .fontSize(20)
          .padding(16)
      } else if (this.errorMessage !== '') {
        Text(this.errorMessage)
          .fontSize(20)
          .padding(16)
      } else {
        Column() {
          Text(`教室号: ${this.cid}`)
            .fontSize(20)
            .padding({ top: 10, bottom: 10 })
          Text(`占用状态: ${this.occuStatus}`)
            .fontSize(20)
            .padding({ top: 10, bottom: 10 })
          Text(`预约日期: ${this.dateTime}`)
            .fontSize(20)
            .padding({ top: 10, bottom: 10 })
          Text(`预约时间段: ${this.occuTime}`)
            .fontSize(20)
            .padding({ top: 10, bottom: 10 })
          Text(`账号: ${this.reservation}`)
            .fontSize(20)
            .padding({ top: 10, bottom: 10 })
          Text(`预约使用类型: ${this.type}`)
            .fontSize(20)
            .padding({ top: 10, bottom: 10 })
          Text(`预约原因: ${this.reason}`)
            .fontSize(20)
            .padding({ top: 10, bottom: 10 })

          Row() {
            Button('批准')
              //.onClick(() => this.updateReservationStatus('approved'))
              .backgroundColor('#4CAF50')
              .fontColor('#FFFFFF')
              .padding({left:30,right:30})
              .margin({ right: 10 })
              .onClick(() => {
                router.replaceUrl({url:'pages/ApplyDealingPage'})
              })

            Button('驳回')
              //.onClick(() => this.updateReservationStatus('rejected'))
              .backgroundColor('#F44336')
              .fontColor('#FFFFFF')
              .padding({left:30,right:30})
              .onClick(() => {
                router.replaceUrl({url:'pages/ApplyDealingPage'})
              })
          }
          .padding({ top: 20, bottom: 20 })
          .width('100%')
          .justifyContent(FlexAlign.Center)
        }
        .padding(16)
        .backgroundColor('#F0F0F0')
        .width('100%')
        .height('100%')
      }
    }
    .backgroundColor('#F0F0F0')
    .width('100%')
    .height('100%')
  }
}
