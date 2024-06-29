import router from '@ohos.router';
import http from '@ohos.net.http';
import Prompt from '@system.prompt';

/**
 * UpdateClassroomStatusPage allows users to update the reservation status of a classroom.
 * The details include classroom number, occupancy time, check status, date, and reservation ID.
 * After submission, the data is sent to the backend and the page navigates back to ClassroomManagementPage.
 */
@Entry
@Component
struct UpdateClassroomStatusPage {
  // State variables to hold form data
  @State classroomNumber: string = '';
  @State dateTime: string = '';
  @State occuTime: string = '';
  @State status: string = '';
  @State loading: boolean = false;

  // Method to handle form submission
  submitClassroom() {
    const classroomData = {
      CID: this.classroomNumber,
      occuTime: this.occuTime,
      dateTime: this.dateTime,
      status: this.status
    };

    const httpRequest = http.createHttp();
    const apiEndpoint = 'http://60.205.140.106:8080/classroomUpdateStatus';

    this.loading = true;
    httpRequest.request(
      apiEndpoint, {
      method: http.RequestMethod.PUT,
      header: {
        'Content-Type': 'application/json'
      },
      extraData: JSON.stringify(classroomData)
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
                message: "更新成功",
                buttons: [{
                  text: "确定",
                  color: '#666666',
                }]
              });
              setTimeout(() => {
                router.replaceUrl({
                  url: 'pages/ClassroomManagementPage',
                });
              }, 2000); // 维持弹窗2秒钟
            } else {
              Prompt.showDialog({
                message: `更新失败：${response.message}`,
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
      // Title
      Row() {
        Text("<- ")
          .fontSize($r('app.float.title_text_size'))
          .fontColor('#ff0c0101')
          .onClick(() => {
            router.replaceUrl({ url: 'pages/ClassroomManagementPage' });
          })

        Text("更改教室状态")
          .fontSize($r('app.float.title_text_size'))
          .fontColor('#ff030000')
          .fontWeight(FontWeight.Bold)

      }
      .width('100%')
      .height($r('app.float.title_height'))
      .backgroundColor('#f5f5f5')
      .padding({ left: 20, right: 20 })

      // Classroom Number
      Text('教室号')
        .fontSize(16)
        .margin({ top: 16, bottom: 8 })
      TextInput({ text: this.classroomNumber, placeholder: '请输入教室号' })
        .onChange((value) => {
          this.classroomNumber = value;
        })

      // Date
      Text('日期')
        .fontSize(16)
        .margin({ top: 16, bottom: 8 })
      TextInput({ text: this.dateTime, placeholder: '请输入YYYY-MM-DD' })
        .onChange((value) => {
          this.dateTime = value;
        })

      // Time Slot
      Text('时间段')
        .fontSize(16)
        .margin({ top: 16, bottom: 8 })
      Select([
        { value: '1' }, { value: '2' }, { value: '3' }, { value: '4' }, { value: '5' }, { value: '6' },
        { value: '7' }, { value: '8' }, { value: '9' }, { value: '10' }, { value: '11' }, { value: '12' }
      ])
        .value(this.occuTime)
        .onSelect((value) => {
          this.occuTime = (value+1).toString();
        })

      // Occupancy Status
      Text('占用状态')
        .fontSize(16)
        .margin({ top: 16, bottom: 8 })
      Select([
        { value: '空闲' },
        { value: '维修中' },
        { value: '考试占用' },
        { value: '个人/团体占用' },
        { value: '课程占用' }
      ])
        .onSelect((index: number) => {
          this.status = (index+1).toString();
        })

      // Submit Button
      Button('提交')
        .onClick(() => {
          this.submitClassroom();
        })
        .backgroundColor('#007bff')
        .fontColor('#ffffff')
        .padding({ top: 12, bottom: 12, left: 40, right: 40 })
        .margin({ top: 32 })
        .borderRadius(8)

      if (this.loading) {
        Text("正在处理...")
          .fontSize(18)
          .margin({ top: 20 })
      }
    }
    .padding(16)
    .backgroundColor('#f5f5f5')
    .height('100%')
  }
}
