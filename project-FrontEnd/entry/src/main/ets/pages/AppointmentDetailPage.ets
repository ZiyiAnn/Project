import router from '@ohos.router';
import http from '@ohos.net.http';
import Prompt from '@system.prompt';

/**
 * ReservationDetailPage displays the details of a specific reservation.
 * It includes the classroom number, occupancy status, reservation date,
 * time period, account, type, and reason for the reservation.
 * At the bottom, there are buttons to approve or reject the reservation.
 */
@Entry
@Component
struct ReservationDetailPage {
  @State cid: string = '';
  @State dateTime: string = '';
  @State occuTime: string = '';
  @State reservation: string = '';
  @State checkStatus: string = '';
  @State type: string = '';
  @State reason: string = '';

  @State isLoading: boolean = false;
  @State errorMessage: string = '';
  @State userid:string=""

  aboutToAppear() {
    let username = router.getParams()['id'] as string;
    this.userid=username;
    let CID = router.getParams()['CID'] as string;
    let dateTime = router.getParams()['dateTime'];
    let occu = router.getParams()['occuTime'] as string;
    let reservation = router.getParams()['userid'] as string;
    let type = router.getParams()['type'] as string;
    let reason = router.getParams()['reason'] as string;
    this.cid = CID;
    this.dateTime = "2024-07-01";
    this.occuTime = occu;
    this.reservation = reservation;
    this.type = type;
    this.reason = reason;
  }


  updateChecklistStatus(status: string) {
    const checklistData = {
      CID: this.cid,
      occuTime: this.occuTime,
      checkStatus: status,
      dateTime: this.dateTime,
      reservations: this.reservation
    };

    const httpRequest = http.createHttp();
    const apiEndpoint = 'http://60.205.140.106:8080/updateChecklist';

    this.isLoading = true;
    httpRequest.request(
      apiEndpoint, {
      method: http.RequestMethod.PUT,
      header: {
        'Content-Type': 'application/json'
      },
      extraData: JSON.stringify(checklistData)
    },
      (err, data) => {
        this.isLoading = false;
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
                message: "操作成功",
                buttons: [{
                  text: "确定",
                  color: '#666666',
                }]
              });
              setTimeout(() => {
                router.replaceUrl({
                  url: 'pages/ApplyDealingPage',
                  params:{
                    id:this.userid
                  }
                });
              }, 2000); // 维持弹窗2秒钟
            } else {
              Prompt.showDialog({
                message: `操作失败：${response.message}`,
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
      // Top bar with title and back button
      Row() {
        Text('<- ')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            router.replaceUrl({ url: 'pages/ApplyDealingPage',params:{id:this.userid} });
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
          Text(`占用状态: ${this.occuTime}`)
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
              .backgroundColor('#4CAF50')
              .fontColor('#FFFFFF')
              .padding({ left: 30, right: 30 })
              .margin({ right: 10 })
              .onClick(() => {
                this.updateChecklistStatus('1');
              })

            Button('驳回')
              .backgroundColor('#F44336')
              .fontColor('#FFFFFF')
              .padding({ left: 30, right: 30 })
              .onClick(() => {
                this.updateChecklistStatus('2');
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
