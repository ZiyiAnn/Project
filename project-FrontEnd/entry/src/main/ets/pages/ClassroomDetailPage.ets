import router from '@ohos.router';
import http from '@ohos.net.http';
import { CommonConstants } from '../common/constants/CommonConstants';

// 定义Classroom类型
interface Classroom {
  cid: string;
  campus: string;
  building: string;
  content: number;
  equipment: string;
}

@Entry
@Component
struct ClassroomDetailPage {
  @State classroomInfo: Classroom = {
    cid: "",
    campus: "",
    building: "",
    content: 0,
    equipment: ""
  };
  @State photos: string[] = [];
  @State userid:string="";
  @State date: string = "2024-06-30";
  @State occupancyStatus: number[] = new Array(12).fill(0); // 默认全部设为空闲状态
  private scroller: Scroller = new Scroller();

  aboutToAppear() {
    let id = router.getParams()['id'] as string;
    this.userid=id;
    let pageCID = router.getParams()['cid'] as string;
    let pageCampus = router.getParams()['campus'] as string;
    let pageContent = router.getParams()['content'] as number;
    let pageBuilding = router.getParams()['building'] as string;
    let pageEquip = router.getParams()['equipment'] as string;
    if (pageCID) {
      this.classroomInfo.cid=pageCID;
      this.classroomInfo.content=pageContent;
      this.classroomInfo.campus=pageCampus;
      this.classroomInfo.building=pageBuilding;
      this.classroomInfo.equipment=pageEquip;
      this.loadClassroomPhotos(pageCID);
      this.loadOccupancyStatus(pageCID, this.date);
    }

  }

  loadClassroomPhotos(cid: string) {
    const apiEndpoint = `http://60.205.140.106:8080/getPhoto?CID=${cid}`;
    const httpRequest = http.createHttp();

    httpRequest.request(apiEndpoint, {
      method: http.RequestMethod.GET
    }, (err, data) => {
      if (err) {
        console.error('Failed to load classroom photos:', err);
        return;
      }
      if (typeof data.result === 'string') {
        try {
          const response = JSON.parse(data.result);
          if (response.success) {
            this.photos = response.photos;
          } else {
            console.error('Failed to load classroom photos: Unsuccessful response');
          }
        } catch (e) {
          console.error('Failed to parse response:', e);
        }
      } else {
        console.error('Unexpected response type:', typeof data.result);
      }
    });
  }

  loadOccupancyStatus(cid: string, date: string) {
    const apiEndpoint = `http://60.205.140.106:8080/preReserveClassroom?CID=${cid}&dateTime=${date}`;
    const httpRequest = http.createHttp();

    httpRequest.request(apiEndpoint, {
      method: http.RequestMethod.GET
    }, (err, data) => {
      if (err) {
        console.error('Failed to load occupancy status:', err);
        return;
      }
      if (typeof data.result === 'string') {
        try {
          const response = JSON.parse(data.result);
          if (response.success) {
            const timeSlots = response.timeSlots;
            this.occupancyStatus = Object.values(timeSlots);
          } else {
            console.error('Failed to load occupancy status: Unsuccessful response');
          }
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
      // 标题栏
      Row() {
        Image($r('app.media.ic_back'))
          .width($r('app.float.image_size'))
          .height($r('app.float.image_size'))
          .margin({ left: $r('app.float.image_margin_left'), right: $r('app.float.image_margin_right') })
          .onClick(() => {
            router.back();
          });

        Text("教室详情")
          .fontSize($r('app.float.title_text_size'))
          .fontColor($r('app.color.title'))
          .fontWeight(CommonConstants.TITLE_FONT_WEIGHT);
      }
      .width(CommonConstants.FULL_WIDTH_PERCENT)
      .height($r('app.float.title_height'))
      .backgroundColor($r('app.color.rect_stroke'))
      .padding({ left: 20, right: 20 });

      // 照片轮播
      ForEach(this.photos, (photo: string) => {
        Image($r("app.media.classroom_photo1"))
          .width('100%')
          .height(200)
          .margin({ bottom: 10 });
      });

      // 教室信息
      Column() {
        Row() {
          Text(`教室号: ${this.classroomInfo.cid}`)
            .margin({ right: 20 });
          Text(`教学楼: ${this.classroomInfo.building}`)
            .margin({ right: 20 });
          Text(`校区: ${this.classroomInfo.campus}`);
        }
        .padding(20);

        Text(`教室容量: ${this.classroomInfo.content}人`)
          .padding(20);

        Text(`设备: ${this.classroomInfo.equipment}`)
          .padding(20);
      }

      // 时间表
      Column() {
        // 日期选择
        Row() {
          TextInput({ text: this.date, placeholder: "日期 (格式: YYYY-MM-DD)" })
            .onChange((value: string) => {
              this.date = value;
              this.loadOccupancyStatus(this.classroomInfo.cid, this.date);
            })
            .margin({ top: 20, bottom: 20 });
        }

        // 时间表
        Flex({
          wrap: FlexWrap.Wrap,
          direction: FlexDirection.Row,
        }) {
          ForEach(this.occupancyStatus, (status: number, index: number) => {
            Column() {
              Circle()
                .width(40)
                .height(40)
                .fill(status ? '#FF0000' : '#00FF00')
                .margin({ top: 10, bottom: 10, right: 9, left: 9 });

              Text((index + 1).toString())
                .fontColor('#000000')
                .fontSize(16)
                .fontWeight(FontWeight.Bold);
            }
          });
        }

        Button("立即预约")
          .onClick(() => {
            router.pushUrl({
              url: "pages/AppointmentPage",
              params:{
                cid: this.classroomInfo.cid,
                //campus: this.classroomInfo.campus,
                //building: this.classroomInfo.building,
                id:this.userid
              }
            });
          })
          .opacity(0.8)
          .backgroundColor('#d2fa8722')
          .width(200)
          .margin({ top: 40 });
      }
      .padding(20)
      .backgroundColor('#F0F0F0');
    }
  }
}
