abstract class ViewModelListener {
  void startLoader();
  void stopLoader();
  void setPageListener(PageListener listener);
}

abstract class PageListener {
  void showSnackBar(String message);
}
abstract class PageEditingListener {
  void updateEditingController ();
}