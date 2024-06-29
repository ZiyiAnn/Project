import router from '@ohos.router';
import http from '@ohos.net.http';
import Prompt from '@system.prompt';
import { CommonConstants } from '../common/constants/CommonConstants';

/**
 * Personal Center page, displaying personal information and app-related settings.
 */

interface Anno {
  annoContent: string,
  id: number
}

@Entry
@Component
struct AnnouncementPage {
  @State announcements: Anno[] = [];
  @State userid:string="";
  private scroller: Scroller = new Scroller();

  aboutToAppear() {
    let id = router.getParams()['id'] as string;
    this.userid=id;
    this.LoadAnnouncement();
  }

  LoadAnnouncement() {
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
      this.Title()
      Scroll(this.scroller) {
        Column() {
          ForEach(this.announcements, (anno: Anno) => {
            Row() {
              Column() {
                Text(`${anno.annoContent}`)
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .margin({ bottom: 5 });
              }
              .padding(10)
              .backgroundColor('#F8F8F8')
              .borderRadius(5)
              .margin({ bottom: 10 });
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
    .height("100%")
  }

  @Builder Title() {
    Row() {
      Image($r('app.media.ic_back'))
        .width($r('app.float.image_size'))
        .height($r('app.float.image_size'))
        .margin({ left: $r('app.float.image_margin_left'), right: $r('app.float.image_margin_right') })
        .onClick(() => {
          router.pushUrl({
            url: "pages/MinePage",
            params:{id: this.userid}
          });
        })

      Text("系统公告")
        .fontSize($r('app.float.title_text_size'))
        .fontColor($r('app.color.title'))
        .fontWeight(CommonConstants.TITLE_FONT_WEIGHT)
    }
    .width(CommonConstants.FULL_WIDTH_PERCENT)
    .height($r('app.float.title_height'))
  }
}
