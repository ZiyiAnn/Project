import router from '@ohos.router';
import http from '@ohos.net.http';
import MediaQueryModel from '../model/MediaQueryModel';
import { CommonConstants } from '../common/constants/CommonConstants';
import { PrivacyStatementComponent } from '../view/PrivacyStatementComponent';
import { LoginComponent } from '../view/LoginComponent';

/**
 * This template implements the Login function.
 * First register personal details. Log in after entering the username and password.
 * Click the button at the bottom to ask for help and check the privacy statement.
 * Developers can save username and password by Preference or Relational Database.
 */
@Entry
@Component
struct LoginPage {
  @State identity: number = 0; // default to student (0: 学生, 1: 老师, 2: 管理员)
  @State userId: string = "";
  @State password: string = "";
  @State errorMessage: string = "";
  userIdController: TextInputController = new TextInputController();
  passwordController: TextInputController = new TextInputController();

  aboutToAppear() {
    MediaQueryModel.register();
  }

  aboutToDisappear() {
    MediaQueryModel.unRegister();
  }

  login() {
    const httpRequest = http.createHttp();
    httpRequest.request(
      'http://your-server-address/login',
      {
        method: http.RequestMethod.POST,
        header: {
          'Content-Type': 'application/json'
        },
        extraData: JSON.stringify({
          identity: this.identity.toString(),
          id: this.userId,
          password: this.password
        }),
        expectDataType: http.HttpDataType.STRING,
        connectTimeout: 60000,
        readTimeout: 60000
      },
      (err, data) => {
        if (err) {
          this.errorMessage = "网络请求失败，请稍后再试。";
          this.clearInput();
          return;
        }

        let result;
        if (typeof data.result === 'string') {
          result = JSON.parse(data.result);
        } else {
          result = data.result;
        }

        if (result.success) {
          // Login successful, navigate to the corresponding user's home page
          if (this.identity === 0) {
            router.replaceUrl({ url: 'pages/ClassroomSelectPage' });
          } else if (this.identity === 1) {
            router.replaceUrl({ url: 'pages/teacherHome/teacherHome' });
          } else if (this.identity === 2) {
            router.replaceUrl({ url: 'pages/adminHome/adminHome' });
          }
        } else {
          // Login failed, show error message
          this.errorMessage = result.message || "登录失败，请检查您的账号和密码。";
          this.clearInput();
        }
      }
    );
  }

  clearInput() {
    // Reset state to clear input fields
    this.userId = "";
    this.password = "";
  }

  build() {
    Column() {
      this.Title()

      Scroll() {
        Column() {
          this.IdentitySelection()
          //this.InputFields()
          //this.LoginButton()
          //this.ForgetPasswordButton()
          LoginComponent()
          Blank()
          PrivacyStatementComponent()
          Blank()
          Text(this.errorMessage)
            .fontSize(16)
            .fontColor(Color.Red)

          //this.FooterLinks()
        }
        .height(CommonConstants.SCROLL_HEIGHT_PERCENT)
        .constraintSize({ minHeight: $r('app.float.scroll_min_height') })
        .alignItems(HorizontalAlign.Start)
        .padding($r('app.float.login_operation_area_padding'))
      }
      .layoutWeight(CommonConstants.LOGIN_SCROLL_LAYOUT_WEIGHT)
    }
    .width(CommonConstants.LOGIN_PAGE_WIDTH_PERCENT)
    .backgroundColor($r('app.color.login_page_background'))
  }

  @Builder Title() {
    Row() {
      Image($r('app.media.ic_back'))
        .width($r('app.float.image_size'))
        .height($r('app.float.image_size'))
        .margin({
          left: $r('app.float.image_margin_left'),
          right: $r('app.float.image_margin_right')
        })
        .onClick(() => {
          router.back();
        })

      Text($r('app.string.title'))
        .fontSize($r('app.float.title_text_size'))
        .fontColor($r('app.color.title'))
        .fontWeight(CommonConstants.TITLE_FONT_WEIGHT)
    }
    .width(CommonConstants.FULL_WIDTH_PERCENT)
    .height($r('app.float.title_height'))
  }

  @Builder IdentitySelection() {
    Select([
      { value: '学生' },
      { value: '老师' },
      { value: '管理员' }
    ])
      .selected(this.identity)
      .font({ size: 16, weight: 500 })
      .fontColor('#182431')
      .selectedOptionFont({ size: 16, weight: 400 })
      .optionFont({ size: 16, weight: 400 })
      .onSelect((index: number) => {
        this.identity = index;
      })
      .margin({ top: 16, bottom: 16 })

  }
}