/// @Date：2021/1/7 
/// @Author：songdongliang
/// Desc：
abstract class ILifecycle {

  void initState();

  void didChangeDependencies();

  void didUpdateWidgets<W>(W oldWidget);

  void deactivate();

  void dispose();

}