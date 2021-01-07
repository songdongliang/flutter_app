import 'package:flutterapp/deer/mvp/base_page_presenter.dart';
import 'package:flutterapp/deer/net/http_api.dart';
import 'package:flutterapp/deer/order/iview/order_search_iview.dart';
import 'package:flutterapp/deer/order/models/search_entity.dart';
import 'package:flutterapp/deer/widget/state_layout.dart';
import 'package:flutterapp/net/dio_util.dart';

/// @Date：2021/1/7
/// @Author：songdongliang
/// Desc：
class OrderSearchPresenter extends BasePagePresenter<OrderSearchIMvpView> {

  Future search(String text, int page, bool isShowDialog) {
    final Map<String, String> params = <String, String>{};
    params['q'] = text;
    params['page'] = page.toString();
    params['l'] = 'Dart';
    return requestNetwork<SearchEntity>(Method.get,
        url: HttpApi.search,
      queryParameters: params,
      isShow: isShowDialog,
      onSuccess: (data) {
        if (data != null) {
          // 一页30条数据，等于30条认为有下一页
          view.provider.setHasMore(data.items.length == 30);
          if (page == 1) {
            /// 刷新
            view.provider.list.clear();
            if (data.items.isEmpty) {
              view.provider.setStateType(StateType.order);
            } else {
              view.provider.addAll(data.items);
            }
          } else {
            view.provider.addAll(data.items);
          }
        } else {
          // 加载失败
          view.provider.setHasMore(false);
          view.provider.setStateType(StateType.network);
        }
      },
      onError: (_, __) {
        // 加载失败
        view.provider.setHasMore(false);
        view.provider.setStateType(StateType.network);
      }
    );
  }

}