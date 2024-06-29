import router from '@ohos.router';
import http from '@ohos.net.http';
import Prompt from '@system.prompt';

@Entry
@Component
struct LoginPage {
  @State username: string = "";
  @State pwd: string = "";
  @State identity: number = 0;
  @State allow: boolean = false; // 声明 allow 属性

  async login() {
    if (!this.username || !this.pwd) {
      Prompt.showDialog({
        message: "请输入用户名和密码",
      });
      return;
    }

    if (!this.allow) {
      Prompt.showDialog({
        message: "请勾选允许登录选项",
      });
      return;
    }

    const httpRequest = http.createHttp();
    httpRequest.request(
      'http://60.205.140.106:8080/login',
      {
        method: http.RequestMethod.POST,
        header: {
          'Content-Type': 'application/json'
        },
        extraData: JSON.stringify({
          identity: this.identity,
          id: this.username,
          password: this.pwd
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
            // 登录成功，跳转到对应的主页
            if (this.identity === 2 || this.identity === 3) {
              router.replaceUrl({ url: 'pages/MinePage', params: { id: this.username } });
            } else {
              router.replaceUrl({ url: 'pages/MainAdminPage', params: { id: this.username } });
            }
          } else {
            // 登录失败，弹出提示框
            Prompt.showDialog({
              message: "账号密码错误",
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
    this.username = "";
    this.pwd = "";
  }

  build() {
    Column() {
      Column() {
        Text("教室管理系统")
          .fontColor('#096789')
          .fontSize(30)
          .margin({bottom:15})
        Text("用户登录")
          .fontColor('#096789')
          .fontSize(25)
      }
      .margin({ bottom: 0 })
      .height('50%')
      .justifyContent(FlexAlign.Center)

      Column() {

        Row() {
          // 身份选择框
          Select([
            { value: '管理员' },
            { value: '老师' },
            { value: '学生' }
          ])
            .selected(this.identity)
            .font({ size: 16, weight: 500 })
            .fontColor('#182431')
            .selectedOptionFont({ size: 16, weight: 400 })
            .optionFont({ size: 16, weight: 400 })
            .onSelect((index: number) => {
              this.identity = index + 1;
            })
            .margin({ right: 200, bottom: 25 })
            .backgroundColor('#ffd3d7d3')
        }

        Row() {
          // 用户名输入框
          TextInput({ text: this.username, placeholder: "请输入您的用户名" })
            .onChange((value: string) => this.username = value)
            .type(InputType.Normal)
            .width('80%')
            .height(50)
            .placeholderColor(Color.Black)
            .backgroundColor('#ffd3d7d3')
            .borderRadius(10)
            .margin({ bottom: 10 })
        }

        Row() {
          // 密码输入框
          TextInput({ text: this.pwd, placeholder: "请输入您的密码" })
            .onChange((value: string) => this.pwd = value)
            .type(InputType.Password)
            .width('80%')
            .height(50)
            .placeholderColor(Color.Black)
            .backgroundColor('#ffd3d7d3')
            .borderRadius(10)
        }

        Row() {
          // 登录按钮
          Button("登录")
            .width(120)
            .height(40)
            .fontColor(Color.White)
            .onClick(() => {
              this.login();
            })
            .backgroundColor('#ff417996')
            .margin({ top: 20, right: 40 })
            .borderStyle(BorderStyle.Dotted)

          // 忘记密码按钮
          Button("忘记密码")
            .width(120)
            .height(40)
            .fontColor(Color.White)
            .onClick(() => {
              router.pushUrl({
                url: "pages/ForgetPage"
              });
            })
            .backgroundColor('#ff3c5060')
            .margin({ top: 20 })
            .borderStyle(BorderStyle.Dotted)
        }
        .justifyContent(FlexAlign.SpaceEvenly)
      }
      .width("100%")
      .height("30%")
      .margin({bottom:30})

      Row() {
        Checkbox().onChange((val: boolean) => {
          this.allow = val;
        })
        Text("隐私声明")
          .onClick(() => {
            router.pushUrl({
              url: "pages/PrivacyPage"
            });
          })
          .margin({ right: 90 })

        Text("联系客服")
          .onClick(() => {
            router.pushUrl({
              url: "pages/CustomerServicePage"
            });
          })
      }
      .width('90%')
      .padding({ left: 30 })
      .height(40)
    }
    .height('100%')
    .width('100%')
    .margin({ bottom: 20 })
    .backgroundColor("#ffe9e9e9")
  }
}
