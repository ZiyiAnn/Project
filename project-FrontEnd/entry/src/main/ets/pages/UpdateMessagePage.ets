import router from '@ohos.router';
import http from '@ohos.net.http';
import Prompt from '@system.prompt';

/**
 * UpdateClassroomPage allows users to update an existing classroom by providing necessary details.
 * The details include classroom number, capacity, building, campus, and equipment.
 * After submission, the data is sent to the backend and the page navigates back to ClassroomManagementPage.
 */
@Entry
@Component
struct UpdateClassroomPage {
  // State variables to hold form data
  @State classroomNumber: string = '';
  @State capacity: string = '';
  @State building: string = '';  // Not modifiable
  @State campus: string = '';  // Not modifiable
  @State equipment: string = '';
  @State loading: boolean = false;

  // Method to handle form submission
  submitClassroom() {
    const classroomData = {
      CID: this.classroomNumber,
      content: this.capacity,
      building: this.building,
      campus: this.campus,
      equipment: this.equipment
    };

    const httpRequest = http.createHttp();
    const apiEndpoint = 'http://60.205.140.106:8080/classroomUpdate';

    this.loading = true;
    httpRequest.request(
      apiEndpoint, {
      method: http.RequestMethod.POST,
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

        Text("更改教室信息")
          .fontSize($r('app.float.title_text_size'))
          .fontColor('#ff030000')
          .fontWeight(FontWeight.Bold)

      }
      .width('100%')
      .height($r('app.float.title_height'))
      .backgroundColor('#f5f5f5')
      .padding({ left: 20, right: 20 })

      Text('可以选填需要更改的信息，其他空缺')
        .fontSize(16)
        .margin({ top: 16, bottom: 15 })

      // Classroom Number
      Text('教室号（必填）')
        .fontSize(16)
        .margin({ top: 16, bottom: 8 })
      TextInput({ text: this.classroomNumber, placeholder: '请输入教室号' })
        .onChange((value) => {
          this.classroomNumber = value;
        })

      // Classroom Capacity
      Text('教室容量')
        .fontSize(16)
        .margin({ top: 16, bottom: 8 })
      TextInput({ text: this.capacity, placeholder: '请输入教室容量（不更改请留空）' })
        .onChange((value) => {
          this.capacity = value.length > 0 ? value : '1';
        })

      // Equipment
      Text('设备')
        .fontSize(16)
        .margin({ top: 16, bottom: 8 })
      TextInput({ text: this.equipment, placeholder: '请输入设备（不更改请留空）' })
        .onChange((value) => {
          this.equipment = value.length > 0 ? value : '1';
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
