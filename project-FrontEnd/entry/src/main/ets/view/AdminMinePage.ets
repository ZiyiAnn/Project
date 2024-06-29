import router from '@ohos.router';
import http from '@ohos.net.http';
import Prompt from '@system.prompt';
import { CommonConstants } from '../common/constants/CommonConstants';

/**
 * Personal Center page, displaying personal information and app-related settings.
 */
@Preview
@Component
export struct MinePage {
  @State userInfo: any = {};
  @State currentIndex:number = 0

  aboutToAppear() {
    let id = router.getParams()['id'] as string;
    this.queryUser(id);
  }

  queryUser(id: string) {
    const httpRequest = http.createHttp();
    httpRequest.request(
      `http://60.205.140.106:8080/queryUser?ID=${id}`,
      {
        method: http.RequestMethod.GET,
        header: {
          'Content-Type': 'application/json'
        },
        expectDataType: http.HttpDataType.STRING,
        connectTimeout: 60000,
        readTimeout: 60000
      },
      (err, data) => {
        if (err) {
          console.error('Network request error:', err);
          Prompt.showDialog({
            message: "网络请求失败，请稍后再试。",
          });
          return;
        }

        try {
          let result;
          if (typeof data.result === 'string') {
            result = JSON.parse(data.result);
          } else {
            result = data.result;
          }

          if (result.success) {
            this.userInfo = result.user;
          } else {
            Prompt.showDialog({
              //message: "用户信息查询失败，请稍后再试。",
            });
          }
        } catch (parseError) {
          console.error('Response parsing error:', parseError);
          Prompt.showDialog({
            message: "服务器响应解析失败，请稍后再试。",
          });
        }
      }
    );
  }

  getGenderText(gender: number): string {
    switch (gender) {
      case 0:
        return "女";
      case 1:
        return "男";
      case 2:
        return "未知";
      default:
        return "未知";
    }
  }

  build() {
    Column() {
      this.Title()

      Scroll() {
        Column() {
          // 用户头像及基本信息
          Image($r('app.media.ic_user_profile'))
            .width($r('app.float.user_profile_image_width'))
            .height($r('app.float.user_profile_image_height'))
            .objectFit(ImageFit.Contain)
            .margin({ top: 50,bottom:5 })

          Text(this.userInfo.name || "用户名")
            .textAlign(TextAlign.Center)
            .fontWeight(CommonConstants.NICKNAME_FONT_WEIGHT)
            .fontSize($r('app.float.nickname_font_size'))
            .margin({ top: 15 })

          Text(`性别: ${this.getGenderText(this.userInfo.gender)}`)
            .textAlign(TextAlign.Center)
            .fontSize(15)
            .margin({ top: 20 })

          Text(`电话: ${this.userInfo.telephone || ''}`)
            .textAlign(TextAlign.Center)
            .fontSize(15)
            .margin({ top: 5 })

          Text(`邮箱: ${this.userInfo.email || ''}`)
            .textAlign(TextAlign.Center)
            .fontSize(15)
            .margin({ top: 5 })

          Text(`ID: ${this.userInfo.id || ''}`)
            .textAlign(TextAlign.Center)
            .fontSize(15)
            .margin({ top: 5, bottom:40 })

          Button('反馈消息')
            .width(200)
            .height(50)
            .fontColor(Color.White)
            .backgroundColor('#ff417996')
            .margin({ top: 20 })
            .onClick(() => {
              if(this.userInfo.name === "repair"){
                router.pushUrl({ url: 'pages/AdminMessagePage', params: { id: this.userInfo.id } });
              }else{
                Prompt.showDialog({
                  message: "无查看权限",
                });
                return;
              }
            })

          Button('个人信息修改')
            .width(200)
            .height(50)
            .fontColor(Color.White)
            .backgroundColor('#ff417996')
            .margin({ top: 20 })
            .onClick(() => {
              router.pushUrl({ url: 'pages/ModifyPersonalInfoPage', params: { id: this.userInfo.id } });
            })
        }
        .margin({ left: 20, right: 20, top: 20 })
        .alignItems(HorizontalAlign.Center)
      }
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
          router.pushUrl({url:"pages/LoginPage"});
        })

      Text("个人主页")
        .fontSize($r('app.float.title_text_size'))
        .fontColor($r('app.color.title'))
        .fontWeight(CommonConstants.TITLE_FONT_WEIGHT)
    }
    .width(CommonConstants.FULL_WIDTH_PERCENT)
    .height($r('app.float.title_height'))
  }

}
