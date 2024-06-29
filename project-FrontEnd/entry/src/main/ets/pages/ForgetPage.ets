import router from '@ohos.router';
import Prompt from '@system.prompt';
import http from '@ohos.net.http';

@Entry
@Component
struct ForgotPasswordPage {
  @State userID: string = '';
  @State identity: string = '';
  @State verificationCode: string = '';
  @State newPassword: string = '';
  @State step: number = 1; // Current step in the reset process: 1 = Send Code, 2 = Reset Password
  @State loading: boolean = false;
  @State errorMessage: string = '';

  // Method to handle sending verification code
  sendVerificationCode() {
    if (this.userID === '' || this.identity === '') {
      Prompt.showDialog({
        message: '请输入完整的用户ID和身份信息。',
      });
      return;
    }

    const requestData = {
      ID: this.userID.toUpperCase(),
      identity: this.identity
    };

    const httpRequest = http.createHttp();
    const apiEndpoint = 'http://60.205.140.106:8080/login/forgotPassword';

    this.loading = true;
    httpRequest.request(
      apiEndpoint,
      {
        method: http.RequestMethod.POST,
        header: {
          'Content-Type': 'application/json'
        },
        extraData: JSON.stringify(requestData)
      },
      (err, data) => {
        this.loading = false;
        if (err) {
          console.error('Network request error:', err);
          Prompt.showDialog({
            message: '网络请求失败，请稍后再试。',
          });
          return;
        }

        if (typeof data.result === 'string') {
          try {
            const response = JSON.parse(data.result);
            if (response.success) {
              Prompt.showDialog({
                message: '验证码已发送，请检查您的邮箱。',
              });
              this.step = 2; // Move to the next step
            } else {
              Prompt.showDialog({
                message: `发送验证码失败：${response.message}`,
              });
            }
          } catch (e) {
            console.error('Failed to parse response:', e);
            Prompt.showDialog({
              message: '解析响应失败，请稍后再试。',
            });
          }
        } else {
          console.error('Unexpected response type:', typeof data.result);
          Prompt.showDialog({
            message: '网络请求失败，请稍后再试。',
          });
        }
      }
    );
  }

  // Method to handle resetting the password
  resetPassword() {
    if (this.verificationCode === '' || this.newPassword === '') {
      Prompt.showDialog({
        message: '请输入完整的验证码和新密码。',
      });
      return;
    }

    const requestData = {
      ID: this.userID.toUpperCase(),
      identity: this.identity,
      code: this.verificationCode,
      newPassword: this.newPassword
    };

    const httpRequest = http.createHttp();
    const apiEndpoint = 'http://60.205.140.106:8080/login/resetPassword';

    this.loading = true;
    httpRequest.request(
      apiEndpoint,
      {
        method: http.RequestMethod.POST,
        header: {
          'Content-Type': 'application/json'
        },
        extraData: JSON.stringify(requestData)
      },
      (err, data) => {
        this.loading = false;
        if (err) {
          console.error('Network request error:', err);
          Prompt.showDialog({
            message: '网络请求失败，请稍后再试。',
          });
          return;
        }

        if (typeof data.result === 'string') {
          try {
            const response = JSON.parse(data.result);
            if (response.success) {
              Prompt.showDialog({
                message: '密码重置成功，请重新登录',
              });
              router.replaceUrl({ url: 'pages/SuccessPage' });
            } else {
              Prompt.showDialog({
                message: `密码重置失败：${response.message}`,
              });
            }
          } catch (e) {
            console.error('Failed to parse response:', e);
            Prompt.showDialog({
              message: '解析响应失败，请稍后再试。',
            });
          }
        } else {
          console.error('Unexpected response type:', typeof data.result);
          Prompt.showDialog({
            message: '网络请求失败，请稍后再试。',
          });
        }
      }
    );
  }

  build() {
    Column() {
      // Title
      Row() {
        Text('<- ')
          .fontSize(24)
          .onClick(() => {
            router.replaceUrl({ url: 'pages/LoginPage' });
          });

        Text('忘记密码')
          .fontSize(24)
          .fontWeight(FontWeight.Bold);
      }
      .padding(16)
      .backgroundColor('#FFFFFF')
      .width('100%');

      if (this.step === 1) {
        // Step 1: Send Verification Code
        Column() {
          Text('用户ID:')
            .fontSize(18)
            .margin({ top: 20, bottom: 10 });
          TextInput({ text: this.userID, placeholder: '请输入用户ID' })
            .onChange((value: string) => {
              this.userID = value;
            })
            .height(50);

          Text('身份选择:')
            .fontSize(18)
            .margin({ top: 30, bottom: 10 });
          Select([
            { value: '管理员' },
            { value: '老师' },
            { value: '学生' }
          ])
            .font({ size: 16, weight: 500 })
            .fontColor('#182431')
            .selectedOptionFont({ size: 16, weight: 400 })
            .optionFont({ size: 16, weight: 400 })
            .onSelect((index: number) => {
              this.identity = (index + 1).toString();
            })
            .margin({ top:5 })
            .backgroundColor('#ffdedede')

          Button('发送验证码')
            .onClick(() => this.sendVerificationCode())
            .backgroundColor('#007bff')
            .fontColor('#ffffff')
            .padding({ top: 12, bottom: 12, left: 40, right: 40 })
            .margin({ top: 32 })
            .borderRadius(8);

          if (this.loading) {
            Text('正在处理...')
              .fontSize(18)
              .margin({ top: 20 });
          }
        }
        .padding(16)
        .backgroundColor('#f5f5f5')
        .height('100%');
      } else if (this.step === 2) {
        // Step 2: Reset Password
        Column() {
          Text('验证码:')
            .fontSize(18)
            .margin({ top: 20, bottom: 10 });
          TextInput({ text: this.verificationCode, placeholder: '请输入验证码' })
            .onChange((value: string) => {
              this.verificationCode = value;
            })
            .height(50);

          Text('新密码:')
            .fontSize(18)
            .margin({ top: 20, bottom: 10 });
          TextInput({ text: this.newPassword, placeholder: '请输入新密码' })
            .onChange((value: string) => {
              this.newPassword = value;
            })
            .height(50);

          Button('重置密码')
            .onClick(() => this.resetPassword())
            .backgroundColor('#007bff')
            .fontColor('#ffffff')
            .padding({ top: 12, bottom: 12, left: 40, right: 40 })
            .margin({ top: 32 })
            .borderRadius(8);

          if (this.loading) {
            Text('正在处理...')
              .fontSize(18)
              .margin({ top: 20 });
          }
        }
        .padding(16)
        .backgroundColor('#f5f5f5')
        .height('100%');
      }
    }
  }
}
