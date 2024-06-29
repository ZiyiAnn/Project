import router from '@ohos.router';
import http from '@ohos.net.http';
import Prompt from '@system.prompt';

/**
 * DeleteClassroomPage allows users to delete an existing classroom by providing the classroom number.
 * After submission, the data is sent to the backend and the page navigates back to ClassroomManagementPage.
 */
@Entry
@Component
struct DeleteClassroomPage {
  // State variables to hold form data
  @State classroomNumber: string = '';
  @State loading: boolean = false;

  // Method to handle form submission
  submitClassroom() {
    const httpRequest = http.createHttp();
    const apiEndpoint = `http://60.205.140.106:8080/classroomDelete/${this.classroomNumber}`;

    this.loading = true;
    httpRequest.request(
      apiEndpoint, {
      method: http.RequestMethod.DELETE,
      header: {
        'Content-Type': 'application/json'
      }
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
                message: "删除成功",
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
                message: `删除失败：${response.message}`,
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

        Text("删除教室")
          .fontSize($r('app.float.title_text_size'))
          .fontColor('#ff030000')
          .fontWeight(FontWeight.Bold)

      }
      .width('100%')
      .height($r('app.float.title_height'))
      .backgroundColor('#f5f5f5')
      .padding({ left: 20, right: 20 })

      // Classroom Number
      Text('请确认要删除的教室号')
        .fontSize(16)
        .margin({ top: 30, bottom: 20 })
      TextInput({ text: this.classroomNumber, placeholder: '请输入教室号' })
        .onChange((value) => {
          this.classroomNumber = value;
        })

      // Submit Button
      Button('提交')
        .onClick(() => {
          this.submitClassroom();
        })
        .backgroundColor('#ff861522')
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
