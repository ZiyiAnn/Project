import router from '@ohos.router';
import http from '@ohos.net.http';
import Prompt from '@system.prompt';
import { CommonConstants } from '../common/constants/CommonConstants';

/**
 * Personal Center page, displaying personal information and app-related settings.
 */

interface user {
  name: string;
  gender: string;
  telephone: string;
  email: string;
  id: string;
}

@Entry
@Component
struct ModifyPage {
  @State userid_origin:string = ""
  @State userinfo: user =
  {
    name:"",
    gender: "",
    telephone: "",
    email: "",
    id: ""
  }
  @State currentIndex:number = 0

  aboutToAppear() {
    let userid_origin = router.getParams()['id'] as string;
    this.userid_origin=userid_origin;
    this.ModifyUser(this.userid_origin);
  }

  ModifyUser(userid_origin: string) {
    if (!this.userinfo.id ) {
      Prompt.showDialog({
        message: "请输入账户ID",
      });
      return;
    }

    if (this.userinfo.id != userid_origin.toLowerCase()) {
      Prompt.showDialog({
        message: "请输入您自己的账户ID！",
      });
      return;
    }

    const httpRequest = http.createHttp();
    httpRequest.request(
      'http://60.205.140.106:8080/userUpdate',
      {
        method: http.RequestMethod.POST,
        header: {
          'Content-Type': 'application/json'
        },
        extraData: JSON.stringify({
          name: this.userinfo.name,
          gender: this.userinfo.gender,
          telephone: this.userinfo.telephone,
          email: this.userinfo.email,
          ID: this.userinfo.id
        }),
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
          this.clearInput();
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
            Prompt.showDialog({
              message: "修改成功",
            });
          } else {
            // 登录失败，弹出提示框
            Prompt.showDialog({
              message: "修改失败，请确认账号ID是否正确",
            });
            this.clearInput();
          }
        } catch (parseError) {
          console.error('Response parsing error:', parseError);
          Prompt.showDialog({
            message: "服务器响应解析失败，请稍后再试。",
          });
          this.clearInput();
        }
      }
    );
  }

  clearInput() {
    // 清空输入框
    this.userinfo.id = "";
    this.userinfo.name = "";
    this.userinfo.gender= "";
    this.userinfo.telephone="";
    this.userinfo.email="";
  }

  build() {
    Column() {
      this.Title()

      Scroll() {
        Column() {
          // 用户头像及基本信息
          Image($r('app.media.ic_user_profile'))
            .width(80)
            .height(80)
            .objectFit(ImageFit.Contain)
            .margin({ top: 50,bottom:40 })

          // 性别选择框
          Select([
            { value: '女' },
            { value: '男' },
            { value: '未知' }
          ])
            //.selected(this.userinfo.gender)
            .font({ size: 16, weight: 500 })
            .fontColor('#182431')
            .selectedOptionFont({ size: 16, weight: 400 })
            .optionFont({ size: 16, weight: 400 })
            .onSelect((index: number) => {
              this.userinfo.gender = index.toString();
            })
            .margin({ right: 200, bottom: 25 })
            .backgroundColor('#ffd3d7d3')

          Row() {
            TextInput({ text: this.userinfo.id, placeholder: "请输入账户ID（必填）" })
              .onChange((value: string) => this.userinfo.id = value)
              .type(InputType.Normal)
              .width('80%')
              .height(50)
              .placeholderColor(Color.Black)
              .backgroundColor('#ffd3d7d3')
              .borderRadius(10)
              .margin({ bottom: 10 })
          }

          Row() {
            TextInput({ text: this.userinfo.name, placeholder: "请输入姓名（可选）" })
              .onChange((value: string) => this.userinfo.name = value)
              .type(InputType.Normal)
              .width('80%')
              .height(50)
              .placeholderColor(Color.Black)
              .backgroundColor('#ffd3d7d3')
              .borderRadius(10)
              .margin({ bottom: 10 })
          }

          Row() {
            TextInput({ text: this.userinfo.telephone, placeholder: "请输入联系方式（可选）" })
              .onChange((value: string) => this.userinfo.telephone = value)
              .type(InputType.Normal)
              .width('80%')
              .height(50)
              .placeholderColor(Color.Black)
              .backgroundColor('#ffd3d7d3')
              .borderRadius(10)
              .margin({ bottom: 10 })
          }

          Row() {
            TextInput({ text: this.userinfo.email, placeholder: "请输入邮箱（可选）" })
              .onChange((value: string) => this.userinfo.email = value)
              .type(InputType.Normal)
              .width('80%')
              .height(50)
              .placeholderColor(Color.Black)
              .backgroundColor('#ffd3d7d3')
              .borderRadius(10)
              .margin({ bottom: 10 })
          }

          Button('确认修改')
            .width(200)
            .height(50)
            .fontColor(Color.White)
            .backgroundColor('#ff417996')
            .margin({ top: 20 })
            .onClick(() => {
              this.ModifyUser(this.userid_origin);
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
          router.back();
        })

      Text("个人信息修改")
        .fontSize($r('app.float.title_text_size'))
        .fontColor($r('app.color.title'))
        .fontWeight(CommonConstants.TITLE_FONT_WEIGHT)
    }
    .width(CommonConstants.FULL_WIDTH_PERCENT)
    .height($r('app.float.title_height'))
  }

}
