import router from '@ohos.router';
import { CommonConstants } from '../common/constants/CommonConstants';

// 定义Classroom类型
interface Classroom {
  cid: string;
  campus: string;
  building: string;
  capacity: number;
  equipment: string[];
}

// 假设设备列表已经由后端返回
const classroomInfo: Classroom = {
  cid: "101",
  campus: "1校区",
  building: "正心",
  capacity: 50,
  equipment: ["投影仪", "白板", "音响"]
};

@Entry
@Component
struct ClassroomDetailPage {
  build() {
    Column() {
      // 标题栏
      Row() {
        Image($r('app.media.ic_back'))
          .width($r('app.float.image_size'))
          .height($r('app.float.image_size'))
          .margin({ left: $r('app.float.image_margin_left'), right: $r('app.float.image_margin_right') })
          .onClick(() => {
            router.back();
          })

        Text("教室详情")
          .fontSize($r('app.float.title_text_size'))
          .fontColor($r('app.color.title'))
          .fontWeight(CommonConstants.TITLE_FONT_WEIGHT)
      }
      .width(CommonConstants.FULL_WIDTH_PERCENT)
      .height($r('app.float.title_height'))
      .backgroundColor($r('app.color.rect_stroke'))
      .padding({ left: 20, right: 20 })

      // 滚动照片（示例）
      Image($r('app.media.classroom_photo1'))
        .width('100%')
        .height(200)  // 调整高度

      // 教室信息
      Row() {
        Text(`教室号: ${classroomInfo.cid}`)
          .margin({ right: 20 })
        Text(`教学楼: ${classroomInfo.building}`)
          .margin({ right: 20 })
        Text(`校区: ${classroomInfo.campus}`)
      }
      .padding(20)

      // 教室容量
      Text(`教室容量: ${classroomInfo.capacity}人`)
        .padding(20)

      // 设备列表
      Text(`设备列表: ${classroomInfo.equipment.join(', ')}`)
        .padding(20)

      // 时间表
      Column() {
        // 日期选择
        TextInput({ text: "2024-06-07", placeholder: "日期 (格式: YYYY-MM-DD)" })
          .onChange((value: string) => {
            // 在这里发送请求给后端获取教室占用情况
            // 更新时间表
          })
          .margin({ top: 20, bottom: 20 })

        // 时间表
        Flex({
          wrap: FlexWrap.Wrap,
          direction: FlexDirection.Row,
        }) {
          // 循环生成每个时间段的占用情况
          ForEach([...Array(12).keys()], (index: number = 1) => {
            Column() {
              // 根据后端返回的占用情况设置颜色和序号
              //let status = 1;  // 默认全部设为占用状态
              //let color = status ? '#FF0000' : '#00FF00';  // 根据状态设置颜色
              //let number = Text(`${index + 1}`).width(40).textAlign(TextAlign.Center);
              Circle()
                .width(40)
                .height(40)
                  //.backgroundColor(color)
                .fill('#FF0000')
                .fillOpacity(0.7)
                .margin({ top: 10, bottom: 10, right:9, left: 9 })  // 控制每行放置 6 个圆形，左右各留 9 像素间距

              Text((index + 1).toString())
                .fontColor('#000000')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
            }
          })
        }
        Button("立即预约")
          .onClick(() => {
            router.replaceUrl({ url: 'pages/AppointmentPage' });
          }).opacity(0.8).backgroundColor('#d2fa8722').width(200).margin({top:40})
      }
      .padding(20)
      .backgroundColor('#F0F0F0')

    }
  }
}
