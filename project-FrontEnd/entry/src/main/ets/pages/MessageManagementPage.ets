import router from '@ohos.router';
import { CommonConstants } from '../common/constants/CommonConstants';


interface Announcement {
  title: string;
  content: string;
  date: string;
}

@Entry
@Component
struct AnnouncementPage {
  @State currentTabIndex: number = 0;
  @State breakPoint: string = CommonConstants.BREAK_POINT_XS;
  @State announcements: Announcement[] = [
    { title: "公告1", content: "这是公告1的内容。", date: "2024-06-01" },
    { title: "公告2", content: "这是公告2的内容。", date: "2024-06-02" },
    { title: "公告3", content: "这是公告3的内容。", date: "2024-06-03" },
    { title: "公告1", content: "这是公告1的内容。", date: "2024-06-01" },
    { title: "公告2", content: "这是公告2的内容。", date: "2024-06-02" },
    { title: "公告3", content: "这是公告3的内容。", date: "2024-06-03" },
    { title: "公告1", content: "这是公告1的内容。", date: "2024-06-01" },
    { title: "公告2", content: "这是公告2的内容。", date: "2024-06-02" },
    { title: "公告3", content: "这是公告3的内容。", date: "2024-06-03" }
  ];
  @State newAnnouncementTitle: string = "";
  @State newAnnouncementContent: string = "";

  build() {
    Column() {
      // Top bar with title and back button
      Row() {
        /*Image('backicon.png')
          .width($r('app.float.image_size'))
          .height($r('app.float.image_size'))
          .margin({ left: $r('app.float.image_margin_left'), right: $r('app.float.image_margin_right') })*/
        Text("<- ")
          .fontSize($r('app.float.title_text_size'))
          .fontColor($r('app.color.title'))
          .fontWeight(CommonConstants.TITLE_FONT_WEIGHT)
          .onClick(() => {
            router.replaceUrl({url:'pages/AdministratorMainPage'})
          })

        Text("公告页面")
          .fontSize($r('app.float.title_text_size'))
          .fontColor($r('app.color.title'))
          .fontWeight(CommonConstants.TITLE_FONT_WEIGHT)
      }
      .width(CommonConstants.FULL_WIDTH_PERCENT)
      .height($r('app.float.title_height'))
      .backgroundColor('#fff1f1f1')
      .padding({ left: 20, right: 20 })

      // New announcement input fields
      Column() {
        TextInput({text:this.newAnnouncementTitle,placeholder:"公告标题"})
          .onChange((value) => this.newAnnouncementTitle = value)
          .width("100%")
          .margin({ bottom: 10 })

        TextArea({text:this.newAnnouncementContent,placeholder:"公告内容"})
          .onChange((value) => this.newAnnouncementContent = value)
          .width("100%")
          .height(100)
          .margin({ bottom: 10 })

        Button("发布公告")
          .onClick(() => this.publishAnnouncement())
          .width("100%")
          .backgroundColor('#ff852e1f')
          .fontColor('#fff8f3f3')
          .margin({ bottom: 20 })
      }
      .padding(20)
      .backgroundColor('#FFFFFF')

      // Separator line
      Divider()
        .color($r('app.color.divider'))
        .width(CommonConstants.FULL_WIDTH_PERCENT)
        .height(1)
        .margin({ bottom: 20 })

      // Announcement list
      Column() {
        ForEach(this.announcements, (announcement: Announcement) => {
          Column() {
            Text(announcement.title)
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .margin({ bottom: 5 })
            Text(announcement.content)
              .fontSize(16)
              .margin({ bottom: 10 })
            Text(announcement.date)
              .fontSize(14)
              .fontColor('#ff2b2a2a')
              .margin({ bottom: 20 })
          }
          .padding(10)
          .backgroundColor('#F9F9F9')
          .borderRadius(5)
          .margin({ bottom: 10 })
        })
      }
      .padding(20)
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F0F0F0')
  }

  publishAnnouncement() {
    if (this.newAnnouncementTitle && this.newAnnouncementContent) {
      this.announcements.push({
        title: this.newAnnouncementTitle,
        content: this.newAnnouncementContent,
        date: new Date().toISOString().split('T')[0]
      });
      this.newAnnouncementTitle = "";
      this.newAnnouncementContent = "";
    }
  }
}
