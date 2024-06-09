import router from '@ohos.router';

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
  @State building: string = '正心';
  @State campus: string = '1';
  @State equipment: string = '';

  // Method to handle form submission
  submitClassroom() {
    const classroomData = {
      CID: this.classroomNumber,
      content: this.capacity,
      building: this.building,
      campus: this.campus,
      equipment: this.equipment
    };

    /*fetch('http://your-backend-api/classrooms', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(classroomData)
    })
      .then(response => {
        if (response.ok) {
          router.replaceUrl({url:'pages/AppointmentManagementPage'})
        } else {
          console.error('Failed to add classroom');
        }
      })
      .catch(error => {
        console.error('Error:', error);
      });*/
  }

  build() {
    Column() {
      // Title
      Row() {
        /*Image('backicon.png')
          .width(24)
          .height(24)
          .onClick(() => {
            router.back();
          })*/
        Text("<- ")
          .fontSize($r('app.float.title_text_size'))
          .fontColor('#ff0c0101')
          .onClick(() => {
            router.replaceUrl({url:'pages/ClassroomManagementPage'})
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
      TextInput({text:this.classroomNumber,placeholder:'请输入教室号'})
        /*.onChange((value) => {
          this.classroomNumber = value;
        })*/

      // Classroom Capacity
      Text('教室容量')
        .fontSize(16)
        .margin({ top: 16, bottom: 8 })
      TextInput({text:this.capacity,placeholder:'请输入教室容量'})
        /*.onChange((value) => {
          this.capacity = value;
        })*/

      // Building
      Text('教学楼')
        .fontSize(16)
        .margin({ top: 16, bottom: 8 })
      Select([
        { value: '正心' },
        { value: '致知' }
      ])
        //.value(this.building)
        /*.onSelect((value) => {
          this.building = value;
        })*/

      // Campus
      Text('校区')
        .fontSize(16)
        .margin({ top: 16, bottom: 8 })
      Select([
        { value: '1'},
        { value: '2'}
      ])
        //.value(this.campus)
        /*.onSelect((value) => {
          this.campus = value;
        })*/

      // Equipment
      Text('设备')
        .fontSize(16)
        .margin({ top: 16, bottom: 8 })
      TextInput({text:this.equipment,placeholder:'请输入设备'})
        /*.onChange((value) => {
          this.equipment = value;
        })*/


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
    }
    .padding(16)
    .backgroundColor('#f5f5f5')
    .height('100%')
  }
}
