/**
 * Common Constants for all features.
 */
export class CommonConstants {
  /**
   * The number of columns for SM device.
   */
  static readonly GRID_ROW_SM: number = 4;

  /**
   * The number of columns for MD device.
   */
  static readonly GRID_ROW_MD: number = 8;

  /**
   * The number of columns for LG device.
   */
  static readonly GRID_ROW_LG: number = 12;

  /**
   * Breakpoint xs.
   */
  static readonly BREAK_POINT_XS: string = 'xs';

  /**
   * The gutter of x direction device.
   */
  static readonly GUTTER_X: number = vp2px(12);

  /**
   * The span of page for SM device.
   */
  static readonly SPAN_SM: number = 4;

  /**
   * The span of page for MD device.
   */
  static readonly SPAN_MD: number = 6;

  /**
   * The span of page for MD device.
   */
  static readonly SPAN_LG: number = 8;

  /**
   * The span of privacy statement for SM device.
   */
  static readonly PRIVACY_SPAN_SM: number = 2;

  /**
   * The span of privacy statement for MD device.
   */
  static readonly PRIVACY_SPAN_MD: number = 4;

  /**
   * The span of privacy statement for LG device.
   */
  static readonly PRIVACY_SPAN_LG: number = 4;

  /**
   * The span of mine page for SM device.
   */
  static readonly MINE_SPAN_SM: number = 4;

  /**
   * The span of mine page for MD device.
   */
  static readonly MINE_SPAN_MD: number = 8;

  /**
   * The span of mine for LG device.
   */
  static readonly MINE_SPAN_LG: number = 8;

  /**
   * The span of login component button for SM device.
   */
  static readonly BUTTON_SPAN_SM: number = 4;

  /**
   * The span of login component button for MD device if break point is smaller than 360vp.
   */
  static readonly BUTTON_SPAN_MD_SMALL: number = 3;

  /**
   * The span of login component button for MD device if break point is not smaller than 360vp.
   */
  static readonly BUTTON_SPAN_MD_BIG: number = 6;

  /**
   * The span of login component button for LG device.
   */
  static readonly BUTTON_SPAN_LG: number = 8;

  /**
   * The offset for SM device.
   */
  static readonly OFFSET_SM: number = 1;

  /**
   * The offset for MD device.
   */
  static readonly OFFSET_MD: number = 1;

  /**
   * The offset for LG device.
   */
  static readonly OFFSET_LG: number = 2;

  /**
   * The offset of privacy statement component for SM device.
   */
  static readonly PRIVACY_OFFSET_SM: number = 1;

  /**
   * The offset of privacy statement component for MD device.
   */
  static readonly PRIVACY_OFFSET_MD: number = 2;

  /**
   * The offset of privacy statement component for LG device.
   */
  static readonly PRIVACY_OFFSET_LG: number = 4;

  /**
   * The offset of login component button for SM device.
   */
  static readonly BUTTON_OFFSET_SM: number = 0;

  /**
   * The offset of login component button for MD device.
   */
  static readonly BUTTON_OFFSET_MD: number = 2;

  /**
   * The offset of login component button for LG device.
   */
  static readonly BUTTON_OFFSET_LG: number = 4;

  /**
   * The break point for page.
   */
  static readonly BREAK_POINT: Array<string> = ['320vp', '600vp', '820vp'];

  /**
   * Login scroll layout weight.
   */
  static readonly LOGIN_SCROLL_LAYOUT_WEIGHT: number = 1;

  /**
   * Registration success page scroll layout weight.
   */
  static readonly SCROLL_LAYOUT_WEIGHT: number = 1;

  /**
   * Mine page column layout weight.
   */
  static readonly COLUMN_LAYOUT_WEIGHT: number = 1;

  /**
   * Mine page list size.
   */
  static readonly LIST_SIZE: number = 2;

  /**
   * Title font weight.
   */
  static readonly TITLE_FONT_WEIGHT: number = 500;

  /**
   * Login text font weight.
   */
  static readonly LOGIN_TEXT_FONT_WEIGHT: number = 500;

  /**
   * Button font weight of registration page.
   */
  static readonly BUTTON_FONT_WEIGHT: number = 500;

  /**
   * Text font weight of registration page.
   */
  static readonly TEXT_FONT_WEIGHT: number = 500;

  /**
   * User nickname text font weight.
   */
  static readonly NICKNAME_FONT_WEIGHT: number = 500;

  /**
   * Mine page url.
   */
  static readonly MINE_PAGE_URL: string = 'pages/MinePage';

  /**
   * Login page url.
   */
  static readonly LOGIN_PAGE_URL: string = 'pages/LoginPage';

  /**
   * Registration success page url.
   */
  static readonly Forget_PAGE_URL: string = 'pages/ForgetPage';

  /**
   * Privacy page url.
   */
  static readonly PRIVACY_PAGE_URL: string = 'pages/PrivacyPage';

  /**
   * Customer service page url.
   */
  static readonly CUSTOMER_SERVICE_PAGE_URL: string = 'pages/CustomerServicePage';

  /**
   * Percent of the text input.
   */
  static readonly TEXT_INPUT_WIDTH_PERCENT: string = '100%';

  /**
   * Percent of divider width.
   */
  static readonly DIVIDER_WIDTH_PERCENT: string = '100%';

  /**
   * Percent of the button width.
   */
  static readonly BUTTON_WIDTH_PERCENT: string = '100%';

  /**
   * Percent of the flex width.
   */
  static readonly FLEX_WIDTH_PERCENT: string = '100%';

  /**
   * Percent of the login page width.
   */
  static readonly LOGIN_PAGE_WIDTH_PERCENT: string = '100%';

  /**
   * Full percent of the width.
   */
  static readonly FULL_WIDTH_PERCENT: string = '100%';

  /**
   * Percent of the registration success page width.
   */
  static readonly REGISTRATION_PAGE_WIDTH_PERCENT: string = '100%';

  /**
   * Percent of the registration success page height.
   */
  static readonly REGISTRATION_PAGE_HEIGHT_PERCENT: string = '100%';

  /**
   * Percent of text width in mine page.
   */
  static readonly MINE_PAGE_TEXT_WIDTH_PERCENT: string = '100%';

  /**
   * Percent of the mine page width.
   */
  static readonly MINE_PAGE_WIDTH_PERCENT: string = '100%';

  /**
   * Percent of column width in customer service page.
   */
  static readonly CUSTOMER_COLUMN_WIDTH_PERCENT: string = '100%';

  /**
   * Percent of column height in customer service page.
   */
  static readonly CUSTOMER_COLUMN_HEIGHT_PERCENT: string = '100%';

  /**
   * Percent of column height in mine page.
   */
  static readonly MINE_PAGE_HEIGHT_PERCENT: string = '100%';

  /**
   * Percent of the row width.
   */
  static readonly ROW_WIDTH_PERCENT: string = '100%';

  /**
   * Scroll height percentage setting.
   */
  static readonly SCROLL_HEIGHT_PERCENT: string = '100%';

  /**
   * Percent of the column width in detail page.
   */
  static readonly DETAIL_COLUMN_WIDTH_PERCENT: string = '93%';


  /**
   * Time default value.
   */
  static readonly TIME_DEFAULT_VALUE: number = 0;

  /**
   * Delay seconds.
   */
  static readonly DELAY_SECONDS: number = 3;

  /**
   * Incremental value.
   */
  static readonly INCREMENT_VALUE: number = 1;

  /**
   * Interval delay.
   */
  static readonly INTERVAL_DELAY: number = 1000;

  /**
   * Interval id default value.
   */
  static readonly INTERVAL_ID_DEFAULT: number = 0;

  /**
   * Splash page stack layout weight.
   */
  static readonly STACK_LAYOUT_WEIGHT: number = 1;

  /**
   * Border width of skip text.
   */
  static readonly SKIP_TEXT_BORDER_WIDTH: number = 1;

  /**
   * Skip button radius.
   */
  static readonly SKIP_BUTTON_RADIUS: number = 14;

  /**
   * Main page url.
   */
  static readonly MAIN_PAGE_URL: string = 'pages/MainPage';

  /**
   * Copyright area column width.
   */
  static readonly COPYRIGHT_AREA_COLUMN_WIDTH: string = '100%';

  /**
   * Main page row width.
   */
  static readonly MAIN_PAGE_ROW_WIDTH: string = '100%';

  /**
   * Main page column width.
   */
  static readonly MAIN_PAGE_COLUMN_WIDTH: string = '100%';

  /**
   * Stack width of splash screen page.
   */
  static readonly STACK_WIDTH: string = '100%';

  /**
   * Column width of splash screen page.
   */
  static readonly COLUMN_WIDTH: string = '100%';

  /**
   * Column height of splash screen page.
   */
  static readonly COLUMN_HEIGHT: string = '100%';

  /**
   * Image width of splash screen page.
   */
  static readonly IMAGE_WIDTH: string = '100%';

  /**
   * Image height of splash screen page.
   */
  static readonly IMAGE_HEIGHT: string = '100%';

  /**
   * Search weight.
   */
  static readonly SEARCH_WEIGHT: number = 10;

  /**
   * The divider stroke width.
   */
  static readonly DIVIDER_STROKE_WIDTH: number = 1;

  /**
   * The offset of detail list for LG device.
   */
  static readonly DETAIL_LIST_OFFSET_LG: number = 1;

  /**
   * The offset of detail list for MD device.
   */
  static readonly DETAIL_LIST_OFFSET_MD: number = 1;

  /**
   * The span of detail list for LG device.
   */
  static readonly DETAIL_LIST_SPAN_LG: number = 9;

  /**
   * The span of detail list for MD device.
   */
  static readonly DETAIL_LIST_SPAN_MD: number = 6;

  /**
   * The span of detail list for SM device.
   */
  static readonly DETAIL_LIST_SPAN_SM: number = 3;

  /**
   * The span of side list for SM device.
   */
  static readonly SIDE_LIST_SPAN_SM: number = 1;

  /**
   * The span of side list for MD device.
   */
  static readonly SIDE_LIST_SPAN_MD: number = 2;

  /**
   * The span of side list for LG device.
   */
  static readonly SIDE_LIST_SPAN_LG: number = 2;

  /**
   * The span of top component for LG device.
   */
  static readonly TOP_SPAN_LG: number = 12;

  /**
   * The span of top component for MD device.
   */
  static readonly TOP_SPAN_MD: number = 8;

  /**
   * The span of top component for SM device.
   */
  static readonly TOP_SPAN_SM: number = 4;

  /**
   * The columns for LG device.
   */
  static readonly COLUMN_LG: number = 12;

  /**
   * The columns for MD device.
   */
  static readonly COLUMN_MD: number = 8;

  /**
   * The columns for SM device.
   */
  static readonly COLUMN_SM: number = 4;

  /**
   * The columns of grid columns gap except SM device.
   */
  static readonly GRID_COLUMNS_GAP_NORMAL: number = 24;

  /**
   * The columns of grid columns gap for SM device.
   */
  static readonly GRID_COLUMNS_GAP_SM: number = 12;

  /**

  /**
   * The break point value.
   */
  static readonly BREAK_POINTS_VALUE: Array<string> = ['320vp', '600vp', '840vp'];

  /**
   * Three item template of Grid.
   */
  static readonly GRID_TEMPLATE_THREE: string = '1fr 1fr 1fr';

  /**
   * Two item template of Grid.
   */
  static readonly GRID_TEMPLATE_TWO: string = '1fr 1fr';

  /**
   * Break point is sm.
   */
  static readonly BREAK_POINT_SM: string = 'sm';

  /**
   * Break point is lg.
   */
  static readonly BREAK_POINT_LG: string = 'lg';

  /**
   * The placeholder of search component.Currently, component interfaces do not support the Resource type.
   * Therefore, you need to define constants. The default prompt in the search box does not support
   * internationalization.
   */
  static readonly SEARCH_PLACEHOLDER: string = 'Search...';

  /**
   * Search font family.
   */
  static readonly SEARCH_FONT_FAMILY: string = 'serif';

  /**
   * The font weight of text in the index list.
   */
  static readonly INDEX_LIST_FONT_WEIGHT: number = 400;

  /**
   * The font weight of text in the detail list.
   */
  static readonly DETAIL_LIST_FONT_WEIGHT: number = 500;

  /**
   * The font weight of text in the tab.
   */
  static readonly TAB_ITEM_FONT_WEIGHT: number = 500;

  /**
   * Size of tab bar.
   */
  static readonly TAB_BAR_SIZE: number = 5;

  /**
   * Tab layout weight.
   */
  static readonly TAB_LAYOUT_WEIGHT: number = 1;

  /**
   * The font weight of subtitle.
   */
  static readonly SUBTITLE_FONT_WEIGHT: number = 400;

  /**
   * Size of detail item.
   */
  static readonly DETAIL_ITEM_SIZE: number = 6;

  /**
   * The percentage of the full height.
   */
  static readonly FULL_HEIGHT_PERCENT: string = '100%';

  /**
   * The percentage of the half height.
   */
  static readonly HALF_HEIGHT_PERCENT: string = '50%';

}