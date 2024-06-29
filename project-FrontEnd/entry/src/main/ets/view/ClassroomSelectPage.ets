import router from '@ohos.router';
import http from '@ohos.net.http';
import { CommonConstants } from '../common/constants/CommonConstants';

// 定义Classroom类型
interface Classroom {
  cid: string;
  content: number;
  building: string;
  campus: string;
  equipment: string;
}

@Component
export struct ClassroomFilterPage {
  @State cid: string = "";
  @State equipment: string = "";
  @State building: string = "";
  @State campus: string = "";
  @State occuTime: string = "";
  @State dateTime: string = "";
  @State occuStatus: string = "";
  @State classrooms: Classroom[] = [];
  @State userid:string="";
  private scroller: Scroller = new Scroller();

  aboutToAppear() {
    let id = router.getParams()['id'] as string;
    this.userid=id;
    this.loadClassrooms();
  }

  loadClassrooms() {
    const apiEndpoint = 'http://60.205.140.106:8080/classroomSelect';
    const httpRequest = http.createHttp();

    const postData = {
      CID: this.cid,
      equipment: this.equipment,
      building: this.building,
      campus: this.campus,
      occuTime: this.occuTime,
      dateTime: this.dateTime,
      occuStatus: this.occuStatus
    };

    console.log('Request Data:', postData); // 调试信息

    httpRequest.request(apiEndpoint, {
      method: http.RequestMethod.POST,
      header: {
        'Content-Type': 'application/json'
      },
      extraData: JSON.stringify(postData)
    }, (err, data) => {
      if (err) {
        console.error('Failed to load classrooms:', err);
        return;
      }
      console.log('Response Data:', data.result); // 调试信息

      if (typeof data.result === 'string') {
        try {
          const response = JSON.parse(data.result);
          console.log('Parsed Response:', response); // 调试信息

          if (response.success) {
            // 去重处理
            const uniqueClassrooms = response.classrooms.reduce((acc: Classroom[], classroom: Classroom) => {
              if (!acc.find(c => c.cid === classroom.cid)) {
                acc.push(classroom);
              }
              return acc;
            }, []);
            this.classrooms = uniqueClassrooms;
            console.log('Classrooms:', this.classrooms); // 调试信息
          } else {
            console.error('Failed to load classrooms: Unsuccessful response');
          }
        } catch (e) {
          console.error('Failed to parse response:', e);
        }
      } else {
        console.error('Unexpected response type:', typeof data.result);
      }
    });
  }

  filterClassrooms() {
    this.loadClassrooms();
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
            router.pushUrl({url:"pages/LoginPage"})
          });

        Text('教室列表')
          .fontSize($r('app.float.title_text_size'))
          .fontColor($r('app.color.title'))
          .fontWeight(CommonConstants.TITLE_FONT_WEIGHT);
      }
      .width(CommonConstants.FULL_WIDTH_PERCENT)
      .height($r('app.float.title_height'))
      .backgroundColor($r('app.color.rect_stroke'))
      .padding({ left: 20, right: 20 });

      // 主内容区域，左侧为筛选条件，右侧为结果列表
      Row() {
        // 筛选条件列
        Column() {
          Text("   筛选")
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: 10 });

          TextInput({ text: this.cid, placeholder: "CID" })
            .onChange((value: string) => this.cid = value)
            .margin({ bottom: 10 });

          Select([{ value: '清空', icon: "" }, { value: '1校区', icon: "" }, { value: '2校区', icon: "" }])
            .selected(this.campus === '' ? 0 : (this.campus === '1校区' ? 1 : 2))
            .value(this.campus)
            .font({ size: 16, weight: 500 })
            .fontColor('#182431')
            .selectedOptionFont({ size: 16, weight: 400 })
            .optionFont({ size: 16, weight: 400 })
            .onSelect((index: number) => {
              this.campus = index === 0 ? '' : (index === 1 ? '1校区' : '2校区');
            })
            .margin({ bottom: 10 });

          Select([
            { value: '清空', icon: "" },
            { value: '正心', icon: "" },
            { value: '格物', icon: "" },
            { value: '致知', icon: "" },
            { value: '理学楼', icon: "" },
            { value: '管理楼', icon: "" },
            { value: '诚意', icon: "" },
            { value: '西配楼', icon: "" },
            { value: '主楼', icon: "" },
            { value: '东配楼', icon: "" }
          ])
            .selected(this.building === '' ? 0 : (
                                                     this.building === '正心' ? 1 : (
                                                                                        this.building === '格物' ? 2 : (
                                                                                                                           this.building === '致知' ? 3 : (
                                                                                                                                                              this.building === '理学楼' ? 4 : (
                                                                                                                                                                                                   this.building === '管理楼' ? 5 : (
                                                                                                                                                                                                                                        this.building === '诚意' ? 6 : (
                                                                                                                                                                                                                                                                           this.building === '西配楼' ? 7 : (
                                                                                                                                                                                                                                                                                                                this.building === '主楼' ? 8 : 9
                                                                                                                                                                                                                                                                                                            )
                                                                                                                                                                                                                                                                       )
                                                                                                                                                                                                                                    )
                                                                                                                                                                                               )
                                                                                                                                                          )
                                                                                                                       )
                                                                                    )
                                                 ))
            .value(this.building)
            .font({ size: 16, weight: 500 })
            .fontColor('#182431')
            .selectedOptionFont({ size: 16, weight: 400 })
            .optionFont({ size: 16, weight: 400 })
            .onSelect((index: number) => {
              this.building = index === 0 ? '' : (
                                                     index === 1 ? '正心' : (
                                                                                index === 2 ? '格物' : (
                                                                                                           index === 3 ? '致知' : (
                                                                                                                                      index === 4 ? '理学楼' : (
                                                                                                                                                                   index === 5 ? '管理楼' : (
                                                                                                                                                                                                index === 6 ? '诚意' : (
                                                                                                                                                                                                                           index === 7 ? '西配楼' : (
                                                                                                                                                                                                                                                        index === 8 ? '主楼' : '东配楼'
                                                                                                                                                                                                                                                    )
                                                                                                                                                                                                                       )
                                                                                                                                                                                            )
                                                                                                                                                               )
                                                                                                                                  )
                                                                                                       )
                                                                            )
                                                 );
            })
            .margin({ bottom: 10 });


          Select([{ value: '清空', icon: "" }, { value: '多媒体设备', icon: "" }, { value: '空调', icon: "" }])
            .selected(this.equipment === '' ? 0 : (this.equipment === '多媒体设备' ? 1 : 2))
            .value(this.equipment)
            .font({ size: 16, weight: 500 })
            .fontColor('#182431')
            .selectedOptionFont({ size: 16, weight: 400 })
            .optionFont({ size: 16, weight: 400 })
            .onSelect((index: number) => {
              this.equipment = index === 0 ? '' : (index === 1 ? '多媒体设备' : '空调');
            })
            .margin({ bottom: 20 });

          Button("筛选")
            .onClick(() => this.filterClassrooms())
            .backgroundColor('#007BFF')
            .fontColor('#FFFFFF')
            .padding({ top: 10, bottom: 10, left: 20, right: 20 })
            .margin({ bottom: 10 });

        }
        .width('30%')
        .height('100%')
        .padding(10)
        .backgroundColor('#F0F0F0')
        .alignItems(HorizontalAlign.Start);

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
                      .margin({ bottom: 5 });
                    Text(`校区: ${classroom.campus}`)
                      .fontSize(14)
                      .margin({ bottom: 5 });
                    Text(`教学楼: ${classroom.building}`)
                      .fontSize(14)
                      .margin({ bottom: 5 });
                    /*Text(`设备: ${classroom.equipment}`)
                      .fontSize(14)
                      .margin({ bottom: 5 });*/
                    /*Text(`容量: ${classroom.content}`)
                      .fontSize(14)
                      .margin({ bottom: 5 });*/
                  }
                  .padding(10)
                  .backgroundColor('#F8F8F8')
                  .borderRadius(5)
                  .margin({ bottom: 10 });

                  Button("详情")
                    .onClick(() => {
                      router.pushUrl({
                        url: "pages/ClassroomDetailPage",
                        params: {
                          cid: classroom.cid,
                          equipment: classroom.equipment,
                          building: classroom.building,
                          campus: classroom.campus,
                          content:classroom.content,
                          id:this.userid
                        }
                      });
                    })
                    .backgroundColor('#007BFF')
                    .fontColor('#FFFFFF')
                    .padding({ top: 10, bottom: 10, left: 20, right: 20 });
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
        .width('70%')
        .height('100%')
        .padding(10)
        .backgroundColor('#FFFFFF');
      }
      .width('100%')
      .height('100%');
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor('#FFFFFF');
  }
}
