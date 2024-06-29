import {MinePage} from '../view/AdminMinePage';
import {AdminMainPage} from '../view/AdministratorMainPage';
import router from '@ohos.router';

@Entry
@Component
struct MyNewsIndex {
  private controller: TabsController = new TabsController()
  @State SelectPos:number=0;
  @State userid:string=""
  aboutToAppear() {
    let username = router.getParams()['id'] as string;
    this.userid=username;
  }

  public IndexClick(){
    this.SelectPos=0;
    this.controller.changeIndex(0)
  }

  public myClick(){
    this.SelectPos=2;
    this.controller.changeIndex(2)
  }

  build() {
    Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Tabs({ controller: this.controller }) {
        TabContent() {
          AdminMainPage()
        }.tabBar('系统管理')

        TabContent() {
          MinePage()
        }.tabBar('个人主页')
      }
      .scrollable(false)
      .barHeight(0)
      .animationDuration(0)

      Row() {
        Column(){
          Image((this.SelectPos==0?$r('app.media.select_2'):$r('app.media.select_1')))
            .width(40).height(40)
            .margin({top:10})
          Text('系统管理')
            .size({ width: '100%', height: 30 }).textAlign(TextAlign.Center)
            .fontSize(15)
            .fontColor((this.SelectPos==0 ? "#ff3787c6" : Color.Black))
        }
        .layoutWeight(1)
        .backgroundColor('#fff')
        .height("100%")
        .onClick(this.IndexClick.bind(this))


        Column(){
          Image((this.SelectPos==2?$r('app.media.home_2'):$r('app.media.home_1')))
            .width(40).height(40)
            .margin({top:10})
            .onClick(() => {
              router.replaceUrl({ url: 'pages/AdminMinePage', params: { id: this.userid } });
            })
          Text('个人主页')
            .size({ width: '100%', height: 30 }).textAlign(TextAlign.Center)
            .fontSize(15)
            .fontColor((this.SelectPos==2?"#ff3787c6":Color.Black))
        }
        .layoutWeight(1)
        .backgroundColor("#fff")
        .height("100%")
        .onClick(this.myClick.bind(this))
      }.alignItems(VerticalAlign.Bottom).width('100%').height(80).margin({top:0,right:0,bottom:10,left:0})


    }
    .width('100%')
    .height('100%')
  }
}