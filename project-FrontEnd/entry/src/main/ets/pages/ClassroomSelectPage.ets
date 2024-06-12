import router from '@ohos.router';
import http from '@ohos.net.http';
import { CommonConstants } from '../common/constants/CommonConstants';

// 定义Classroom类型
interface Classroom {
  cid: string;
  campus: string;
  building: string;
}

@Entry
@Component
struct ClassroomFilterPage {
  @State cid: string = "";
  @State campus: string = "1校区";
  @State building: string = "正心";
  @State dateTime: string = "2024-06-07";
  @State content: string = "";
  @State equipment: string = "多媒体设备";
  @State classrooms: Classroom[] = [
    { cid: "101", campus: "1校区", building: "正心" },
    { cid: "102", campus: "1校区", building: "正心" },
    { cid: "103", campus: "1校区", building: "正心" },
    { cid: "104", campus: "1校区", building: "正心" },
    { cid: "105", campus: "1校区", building: "正心" },
    { cid: "106", campus: "1校区", building: "正心" },
    { cid: "107", campus: "1校区", building: "正心" },
    { cid: "108", campus: "1校区", building: "正心" },
    { cid: "109", campus: "1校区", building: "正心" },
    { cid: "112", campus: "1校区", building: "正心" },
    { cid: "321", campus: "1校区", building: "正心" },
    { cid: "713", campus: "1校区", building: "正心" },
  ];
  private scroller: Scroller = new Scroller();

  aboutToAppear() {
    this.loadClassrooms();
  }

  loadClassrooms() {
    const apiEndpoint = 'http://your-server-address/classrooms';
    const httpRequest = http.createHttp();
    httpRequest.request(apiEndpoint, {
      method: http.RequestMethod.GET,
      header: {
        'Content-Type': 'application/json'
      }
    }, (err, data) => {
      if (err) {
        console.error('Failed to load classrooms:', err);
        return;
      }
      if (typeof data.result === 'string') {
        this.classrooms = JSON.parse(data.result);
      } else {
        console.error('Unexpected response type:', typeof data.result);
      }
    });
  }

  filterClassrooms() {
    const apiEndpoint = 'http://your-server-address/filterClassrooms';
    const httpRequest = http.createHttp();
    const filterData = {
      cid: this.cid,
      campus: this.campus,
      building: this.building,
      dateTime: this.dateTime,
      content: parseInt(this.content),
      equipment: this.equipment
    };

    httpRequest.request(apiEndpoint, {
      method: http.RequestMethod.POST,
      header: {
        'Content-Type': 'application/json'
      },
      extraData: JSON.stringify(filterData)
    }, (err, data) => {
      if (err) {
        console.error('Failed to filter classrooms:', err);
        return;
      }
      if (typeof data.result === 'string') {
        this.classrooms = JSON.parse(data.result);
      } else {
        console.error('Unexpected response type:', typeof data.result);
      }
    });
  }

  build() {
    Column() {
      // 顶部栏，包含标题和返回按钮
      Row() {
        Image($r('app.media.ic_back'))
          .width($r('app.float.image_size'))
          .height($r('app.float.image_size'))
          .margin({ left: $r('app.float.image_margin_left'), right: $r('app.float.image_margin_right') })
          .onClick(() => {
            router.back();
          })

        Text('教室列表')
          .fontSize($r('app.float.title_text_size'))
          .fontColor($r('app.color.title'))
          .fontWeight(CommonConstants.TITLE_FONT_WEIGHT)
      }
      .width(CommonConstants.FULL_WIDTH_PERCENT)
      .height($r('app.float.title_height'))
      .backgroundColor($r('app.color.rect_stroke'))
      .padding({ left: 20, right: 20 })

      // 主内容区域，左侧为筛选条件，右侧为结果列表
      Row() {
        // 筛选条件列
        Column() {
          Text("   筛选")
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: 10 })

          TextInput({ text: this.cid, placeholder: "CID" })
            .onChange((value: string) => this.cid = value)
            .margin({ bottom: 10 })

          Select([{ value: '1校区', icon: "" }, { value: '2校区', icon: "" }])
            .selected(this.campus === '1校区' ? 0 : 1)
            .value(this.campus)
            .font({ size: 16, weight: 500 })
            .fontColor('#182431')
            .selectedOptionFont({ size: 16, weight: 400 })
            .optionFont({ size: 16, weight: 400 })
            .onSelect((index: number) => {
              this.campus = index === 0 ? '1校区' : '2校区';
            })
            .margin({ bottom: 10 })

          Select([{ value: '正心', icon: "" }, { value: '致知', icon: "" }])
            .selected(this.building === '正心' ? 0 : 1)
            .value(this.building)
            .font({ size: 16, weight: 500 })
            .fontColor('#182431')
            .selectedOptionFont({ size: 16, weight: 400 })
            .optionFont({ size: 16, weight: 400 })
            .onSelect((index: number) => {
              this.building = index === 0 ? '正心' : '致知';
            })
            .margin({ bottom: 10 })

          TextInput({ text: this.dateTime, placeholder: "日期 (格式: YYYY-MM-DD)" })
            .onChange((value: string) => this.dateTime = value)
            .margin({ bottom: 10 })

          TextInput({ text: this.content, placeholder: "容量" })
            .onChange((value: string) => this.content = value)
            .margin({ bottom: 10 })

          Select([{ value: '多媒体设备', icon: "" }, { value: '空调', icon: "" }])
            .selected(this.equipment === '多媒体设备' ? 0 : 1)
            .value(this.equipment)
            .font({ size: 16, weight: 500 })
            .fontColor('#182431')
            .selectedOptionFont({ size: 16, weight: 400 })
            .optionFont({ size: 16, weight: 400 })
            .onSelect((index: number) => {
              this.equipment = index === 0 ? '多媒体设备' : '空调';
            })
            .margin({ bottom: 20 })

          Button("筛选")
            .onClick(() => this.filterClassrooms())
            .backgroundColor('#007BFF')
            .fontColor('#FFFFFF')
            .padding({ top: 10, bottom: 10, left: 20, right: 20 })
            .margin({ bottom: 10 })
        }
        .width('30%')
        .height('100%')
        .padding(10)
        .backgroundColor('#F0F0F0')
        .alignItems(HorizontalAlign.Start)

        // 结果列表列
        Column() {
          Scroll(this.scroller) {
            Column() {
              ForEach(this.classrooms, (classroom: Classroom) => {
                Row() {
                  Column() {
                    Text(`教室号: ${classroom.cid}`)
                      .fontSize(16)
                      .fontWeight(FontWeight.Bold)
                      .margin({ bottom: 5 })
                    Text(`校区: ${classroom.campus}`)
                      .fontSize(14)
                      .margin({ bottom: 5 })
                    Text(`教学楼: ${classroom.building}`)
                      .fontSize(14)
                      .margin({ bottom: 5 })
                  }
                  .padding(10)
                  .backgroundColor('#F8F8F8')
                  .borderRadius(5)
                  .margin({ bottom: 10 })

                  Button("详情")
                    .onClick(() => {
                      router.replaceUrl({
                        //url: `pages/ClassroomDetailPage?cid=${classroom.cid}`
                        url: 'pages/ClassroomDetailPage'
                      });
                    })
                    .backgroundColor('#007BFF')
                    .fontColor('#FFFFFF')
                    .padding({ top: 10, bottom: 10, left: 20, right: 20 })
                }
                .width('100%')
              })
            }
            .width('100%')
            .padding(10)
            .backgroundColor('#FFFFFF')
          }
          .width('100%')
          .scrollBar(BarState.On)
          .scrollable(ScrollDirection.Vertical)
        }
        .width('70%')
        .height('100%')
        .padding(10)
        .backgroundColor('#FFFFFF')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor('#FFFFFF')
  }
}
