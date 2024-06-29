import router from '@ohos.router';
import http from '@ohos.net.http';
import Prompt from '@system.prompt';
import { CommonConstants } from '../common/constants/CommonConstants';

interface Anno {
  annoContent: string;
  id: number;
}

@Entry
@Component
struct AnnouncementPage {
  @State announcements: Anno[] = [];
  @State newAnnouncementContent: string = "";
  @State userid: string="";

  private scroller: Scroller = new Scroller();

  aboutToAppear() {
    let id = router.getParams()['id'] as string;
    this.userid=id;
    this.loadAnnouncements();
  }

  loadAnnouncements() {
    const httpRequest = http.createHttp();
    const apiEndpoint = 'http://60.205.140.106:8080/getAllAnno';

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

            // 直接将response作为公告数组
            this.announcements = response;
            console.log('announcements:', this.announcements); // 调试信息
          } catch (e) {
            console.error('Failed to parse response:', e);
          }
        } else {
          console.error('Unexpected response type:', typeof data.result);
        }
      });
  }

  build() {
    Column() {
      Row() {
        Image($r('app.media.ic_back'))
          .width($r('app.float.image_size'))
          .height($r('app.float.image_size'))
          .margin({ left: $r('app.float.image_margin_left'), right: $r('app.float.image_margin_right') })
          .onClick(() => {
            router.pushUrl({url:"pages/MainAdminPage",params:{id:this.userid}})
          });

        Text("公告管理")
          .fontSize($r('app.float.title_text_size'))
          .fontColor($r('app.color.title'))
          .fontWeight(CommonConstants.TITLE_FONT_WEIGHT);
      }
      .width(CommonConstants.FULL_WIDTH_PERCENT)
      .height($r('app.float.title_height'));

      Column() {
        TextArea({
          text: this.newAnnouncementContent,
          placeholder: "输入要发布的公告内容",
        })
          .onChange((value) => this.newAnnouncementContent = value)
          .width("100%")
          .height(100)
          .margin({ bottom: 10 });

        Button("发布公告")
          .onClick(() => this.publishAnnouncement())
          .width("100%")
          .backgroundColor('#ff852e1f')
          .fontColor('#fff8f3f3')
          .margin({ bottom: 20 });
      }
      .padding(20)
      .backgroundColor('#FFFFFF');

      Scroll(this.scroller) {
        Column() {
          ForEach(this.announcements, (anno: Anno) => {
            Column() {
              Column() {
                /*Text(`${anno.id}`)
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .margin({ bottom: 5 });*/
                Text(`${anno.annoContent}`)
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .margin({ bottom: 5 });
              }
              .padding(10)
              .backgroundColor('#F8F8F8')
              .borderRadius(5)
              .margin({ bottom: 10 });

              Button("删除")
                .onClick(() => this.deleteAnnouncement(anno.id))
                .width(200)
                .height(40)
                .backgroundColor('#ff813434')
                .fontColor('#ffffff')
                .margin({ top:10,bottom:20 });
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
    .height("100%");
  }

  publishAnnouncement() {
    if (this.newAnnouncementContent) {
      const apiEndpoint = 'http://60.205.140.106:8080/AddAnno';
      const httpRequest = http.createHttp();

      const requestData = {
        annoContent: this.newAnnouncementContent
      };

      httpRequest.request(
        apiEndpoint, {
        method: http.RequestMethod.POST,
        header: {
          'Content-Type': 'application/json'
        },
        extraData: JSON.stringify(requestData)
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
              if (response.success) {
                Prompt.showToast({
                  message: "发布公告成功！"
                });
                this.loadAnnouncements(); // 刷新公告列表
                this.newAnnouncementContent = ""; // 清空输入框
              } else {
                Prompt.showDialog({
                  message: "发布公告失败，请稍后再试。",
                });
              }
            } catch (e) {
              console.error('Failed to parse response:', e);
            }
          } else {
            console.error('Unexpected response type:', typeof data.result);
          }
        });
    } else {
      Prompt.showToast({
        message: "请输入公告内容！"
      });
    }
  }


  deleteAnnouncement(announcementId: number) {
    const httpRequest = http.createHttp();
    const apiEndpoint = `http://60.205.140.106:8080/DeleteAnno/${announcementId}`;

    httpRequest.request(
      apiEndpoint, {
      method: http.RequestMethod.DELETE,
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
            if (response.success) {
              Prompt.showToast({
                message: "删除公告成功！"
              });
              this.loadAnnouncements(); // 刷新公告列表
            } else {
              Prompt.showDialog({
                message: "删除公告失败，请稍后再试。",
              });
            }
          } catch (e) {
            console.error('Failed to parse response:', e);
          }
        } else {
          console.error('Unexpected response type:', typeof data.result);
        }
      });
  }
}
