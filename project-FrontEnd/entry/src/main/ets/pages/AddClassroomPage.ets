import router from '@ohos.router';
import http from '@ohos.net.http';
import Prompt from '@system.prompt';

/**
 * AddClassroomPage allows users to add a new classroom by providing necessary details.
 * The details include classroom number, capacity, building, campus, and equipment.
 * After submission, the data is sent to the backend and the page navigates back to ClassroomManagementPage.
 */
@Entry
@Component
struct AddClassroomPage {
  // State variables to hold form data
  @State classroomNumber: string = '';
  @State capacity: string = '';
  @State building: string = '';
  @State campus: string = '1';
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
    const apiEndpoint = 'http://60.205.140.106:8080/classroomAdd';

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
                message: "添加成功",
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
                message: `添加失败：${response.message}`,
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

        Text("添加教室")
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

      // Classroom Capacity
      Text('教室容量')
        .fontSize(16)
        .margin({ top: 16, bottom: 8 })
      TextInput({ text: this.capacity, placeholder: '请输入教室容量' })
        .onChange((value) => {
          this.capacity = value;
        })

      // Campus
      Text('校区')
        .fontSize(16)
        .margin({ top: 16, bottom: 8 })
      Select([
        { value: '1' },
        { value: '2' }
      ])
        .value(this.campus)
        .onSelect((index: number) => {
          this.campus = (index+1).toString();
        })

      Text('教学楼')
        .fontSize(16)
        .margin({ top: 16, bottom: 8 })
      Select([
        { value: '清空', icon: "" },
        { value: '正心', icon: "" },
        { value: '格物', icon: "" },
        { value: '致知', icon: "" },
        { value: '理学楼', icon: "" },
        { value: '管理楼', icon: "" },
        { value: '诚意', icon: "" },
        { value: '西配楼', icon: "" },
        { value: '主楼', icon: "" },
        { value: '东配楼', icon: "" }
      ])
        .selected(this.building === '' ? 0 : (
                                                 this.building === '正心' ? 1 : (
                                                                                    this.building === '格物' ? 2 : (
                                                                                                                       this.building === '致知' ? 3 : (
                                                                                                                                                          this.building === '理学楼' ? 4 : (
                                                                                                                                                                                               this.building === '管理楼' ? 5 : (
                                                                                                                                                                                                                                    this.building === '诚意' ? 6 : (
                                                                                                                                                                                                                                                                       this.building === '西配楼' ? 7 : (
                                                                                                                                                                                                                                                                                                            this.building === '主楼' ? 8 : 9
                                                                                                                                                                                                                                                                                                        )
                                                                                                                                                                                                                                                                   )
                                                                                                                                                                                                                                )
                                                                                                                                                                                           )
                                                                                                                                                      )
                                                                                                                   )
                                                                                )
                                             ))
        .value(this.building)
        .font({ size: 16, weight: 500 })
        .fontColor('#182431')
        .selectedOptionFont({ size: 16, weight: 400 })
        .optionFont({ size: 16, weight: 400 })
        .onSelect((index: number) => {
          this.building = index === 0 ? '' : (
                                                 index === 1 ? '正心' : (
                                                                            index === 2 ? '格物' : (
                                                                                                       index === 3 ? '致知' : (
                                                                                                                                  index === 4 ? '理学楼' : (
                                                                                                                                                               index === 5 ? '管理楼' : (
                                                                                                                                                                                            index === 6 ? '诚意' : (
                                                                                                                                                                                                                       index === 7 ? '西配楼' : (
                                                                                                                                                                                                                                                    index === 8 ? '主楼' : '东配楼'
                                                                                                                                                                                                                                                )
                                                                                                                                                                                                                   )
                                                                                                                                                                                        )
                                                                                                                                                           )
                                                                                                                              )
                                                                                                   )
                                                                        )
                                             );
        })


      Text('设备')
        .fontSize(16)
        .margin({ top: 16, bottom: 8 })
      Select([{ value: '清空', icon: "" }, { value: '多媒体设备', icon: "" }, { value: '空调', icon: "" }])
        .selected(this.equipment === '' ? 0 : (this.equipment === '多媒体设备' ? 1 : 2))
        .value(this.equipment)
        .font({ size: 16, weight: 500 })
        .fontColor('#182431')
        .selectedOptionFont({ size: 16, weight: 400 })
        .optionFont({ size: 16, weight: 400 })
        .onSelect((index: number) => {
          this.equipment = index === 0 ? '' : (index === 1 ? '多媒体设备' : '空调');
        })
        .margin({ bottom: 20 });

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
